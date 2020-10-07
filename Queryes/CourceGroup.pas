unit CourceGroup;

interface

uses
  System.Classes, Admissions, DPOStudyPlan, Years, AdmissionsQuery, ChairsQuery,
  CourceNameQuery, System.Contnrs, NotifyEvents, StudentGroupsQuery,
  CourceEdTypesQuery, YearsQry, EdLvlQry, Data.DB, FireDAC.Comp.DataSet,
  DiscNameQry, CourseStudyPlanQry, FDDumb, CourceViewInterface,
  CourceEditInterface, CourceStudyPlanViewInterface;

type
  TCourceGroup = class(TComponent, ICourceView, ICourceEdit)
  strict private
    procedure AdmissionMove(AIDArr: TArray<Integer>;
      AIDEducationLevel: Integer);
    procedure CancelCourceEdit;
    function GetAdmissionsW: TAdmissionsW;
    function GetAfterLoadData: TNotifyEventsEx;
    function GetChairsW: TChairsW;
    function GetCourceEditI: ICourceEdit;
    function GetCourceNameW: TCourceNameW;
    function GetCourceStudyPlanViewI: ICourceStudyPlanView;
    function GetCourseStudyPlanW: TCourseStudyPlanW;
    function GetDiscNameW: TDiscNameW;
    function GetEdLvlW: TEdLvlW;
    function GetIDYearW: TDumbW;
    function GetStudentGroupsW: TStudentGroupsW;
    function GetYearsW: TYearsW;
    procedure SearchStudGroups;
  private
    FAfterLoadData: TNotifyEventsEx;
    FEventList: TObjectList;
    FIDEducationLevel: Integer;
    FOnYearChange: TNotifyEventsEx;
    FqCourseStudyPlan: TQryCourseStudyPlan;
    FqAdmissions: TQueryAdmissions;
    FqChairs: TQueryChairs;
    FqCourceName: TQueryCourceName;
    FqDiscName: TQryDiscName;
    FqEdLvl: TQryEdLvl;
    FqStudentGroups: TQueryStudentGroups;
    FqYears: TQryYears;
    FYearDumb: TFDDumb;
    function GetqDiscName: TQryDiscName;
    function GetqEdLvl: TQryEdLvl;
    function GetqStudentGroups: TQueryStudentGroups;
    function GetYear: Integer;
    procedure SetYear(const Value: Integer);
  protected
    procedure DoAfterYearPost(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; AYear, AIDEducationLevel: Integer);
      reintroduce;
    destructor Destroy; override;
    procedure Copy(AIDArray: TArray<Integer>; AYear: Integer);
    procedure Refresh;
    property AfterLoadData: TNotifyEventsEx read FAfterLoadData;
    property qCourseStudyPlan: TQryCourseStudyPlan read FqCourseStudyPlan;
    property qAdmissions: TQueryAdmissions read FqAdmissions;
    property qChairs: TQueryChairs read FqChairs;
    property qCourceName: TQueryCourceName read FqCourceName;
    property qDiscName: TQryDiscName read GetqDiscName;
    property qEdLvl: TQryEdLvl read GetqEdLvl;
    property qStudentGroups: TQueryStudentGroups read GetqStudentGroups;
    property qYears: TQryYears read FqYears;
    property Year: Integer read GetYear write SetYear;
    property YearDumb: TFDDumb read FYearDumb;
    property OnYearChange: TNotifyEventsEx read FOnYearChange;
  end;

implementation

uses
  System.SysUtils, CopyStudyPlanQuery;

constructor TCourceGroup.Create(AOwner: TComponent;
  AYear, AIDEducationLevel: Integer);
begin
  inherited Create(AOwner);

  Assert(AYear > 0);
  Assert(AIDEducationLevel > 0);

  FIDEducationLevel := AIDEducationLevel;

  FEventList := TObjectList.Create;
  FOnYearChange := TNotifyEventsEx.Create(Self);

  // Года
  FqYears := TQryYears.Create(Self);
  FqYears.W.RefreshQuery;
  FqYears.W.LocateByPK(AYear, True);

  // Текущий год
  FYearDumb := TFDDumb.Create(Self);
  // Подписываемся на изменение текущего года
  TNotifyEventWrap.Create(FYearDumb.W.AfterPost, DoAfterYearPost, FEventList);
  FYearDumb.W.RefreshQuery;

  // Сами наборы на курсы
  FqAdmissions := TQueryAdmissions.Create(Self);

  // Для каскадного удаления
  // TNotifyEventWrap.Create(FqAdmissions.W.BeforeDelete, DoBeforeDelete,
  // FEventList);

  // Дисциплины по курсам
  FqCourseStudyPlan := TQryCourseStudyPlan.Create(Self);
  FqCourseStudyPlan.Name := 'FqDPOSP_Main';

  // Кафедры
  FqChairs := TQueryChairs.Create(Self);
  FqChairs.W.RefreshQuery;

  // Названия курсов
  FqCourceName := TQueryCourceName.Create(Self);
  FqCourceName.SearchCourceName;

  // Ищем все формы обучения "Курсы" кроме нашего
  qEdLvl.Search([4, 6], AIDEducationLevel);

  // Имитируем смену года
  Year := AYear;
end;

destructor TCourceGroup.Destroy;
begin
  FreeAndNil(FEventList);
  FreeAndNil(FAfterLoadData);
  FreeAndNil(FOnYearChange);
  inherited;
end;

procedure TCourceGroup.AdmissionMove(AIDArr: TArray<Integer>;
  AIDEducationLevel: Integer);
begin
  qAdmissions.Move(AIDArr, AIDEducationLevel);
end;

procedure TCourceGroup.CancelCourceEdit;
begin
  // НЕ сохраняем сделанные изменения в БД
  qCourceName.FDQuery.CancelUpdates;

  // Отменяем сделанные изменения в группах
  if qStudentGroups.FDQuery.Active then
    qStudentGroups.FDQuery.CancelUpdates;
end;

procedure TCourceGroup.Copy(AIDArray: TArray<Integer>; AYear: Integer);
begin
  Assert(Length(AIDArray) > 0);
  Assert(AYear > 0);

  TQueryCopyStudyPlan.Copy(AIDArray, AYear);
end;

procedure TCourceGroup.DoAfterYearPost(Sender: TObject);
begin
  Assert(FIDEducationLevel > 0);

  // Дисциплины по курсам
  FqCourseStudyPlan.Search(FIDEducationLevel, Year);

  // Сами наборы на курсы
  FqAdmissions.Search(FIDEducationLevel, Year);

  FAfterLoadData.CallEventHandlers(Self);
  FOnYearChange.CallEventHandlers(Self);
end;

function TCourceGroup.GetAdmissionsW: TAdmissionsW;
begin
  Result := qAdmissions.W;
end;

function TCourceGroup.GetAfterLoadData: TNotifyEventsEx;
begin
  if FAfterLoadData = nil then
    FAfterLoadData := TNotifyEventsEx.Create(Self);

  Result := FAfterLoadData;
end;

function TCourceGroup.GetChairsW: TChairsW;
begin
  Result := qChairs.W;
end;

function TCourceGroup.GetCourceEditI: ICourceEdit;
begin
  Result := Self;
end;

function TCourceGroup.GetCourceNameW: TCourceNameW;
begin
  Result := qCourceName.W;
end;

function TCourceGroup.GetCourceStudyPlanViewI: ICourceStudyPlanView;
begin
  // TODO -cMM: TCourceGroup.GetCourceStudyPlanViewI default body inserted
end;

function TCourceGroup.GetCourseStudyPlanW: TCourseStudyPlanW;
begin
  Result := qCourseStudyPlan.W;
end;

function TCourceGroup.GetDiscNameW: TDiscNameW;
begin
  Result := qDiscName.W;
end;

function TCourceGroup.GetEdLvlW: TEdLvlW;
begin
  Result := qEdLvl.W;
end;

function TCourceGroup.GetIDYearW: TDumbW;
begin
  Result := YearDumb.W;
end;

function TCourceGroup.GetqDiscName: TQryDiscName;
begin
  if FqDiscName = nil then
  begin
    // Создаём набор дисциплин курсов
    FqDiscName := TQryDiscName.Create(Self);
    FqDiscName.FDQuery.CachedUpdates := True;
    FqDiscName.SearchByType([3]); // Дисциплины курсов;
  end;

  Result := FqDiscName;
end;

function TCourceGroup.GetqStudentGroups: TQueryStudentGroups;
begin
  if FqStudentGroups = nil then
    FqStudentGroups := TQueryStudentGroups.Create(Self);

  Result := FqStudentGroups;
end;

function TCourceGroup.GetqEdLvl: TQryEdLvl;
begin
  if FqEdLvl = nil then
    FqEdLvl := TQryEdLvl.Create(Self);

  Result := FqEdLvl;
end;

function TCourceGroup.GetStudentGroupsW: TStudentGroupsW;
begin
  Result := qStudentGroups.W;
end;

function TCourceGroup.GetYear: Integer;
begin
  Result := FYearDumb.W.ID.F.AsInteger;
end;

function TCourceGroup.GetYearsW: TYearsW;
begin
  Result := qYears.W;
end;

procedure TCourceGroup.Refresh;
begin
  qCourseStudyPlan.W.RefreshQuery;
  qAdmissions.W.RefreshQuery;
end;

procedure TCourceGroup.SearchStudGroups;
begin
  qStudentGroups.Search(qAdmissions.W.PK.AsInteger, True);

  // Значение по умолчанию для поля Start_Year!
  qStudentGroups.W.Start_Year_DefaultValue := qAdmissions.W.Year.F.AsInteger;
end;

procedure TCourceGroup.SetYear(const Value: Integer);
begin
  if Year = Value then
    Exit;

  // Выбираем нужный нам год
  FYearDumb.W.UpdateID(Value);
end;

end.
