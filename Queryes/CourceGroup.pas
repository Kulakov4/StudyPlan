unit CourceGroup;

interface

uses
  System.Classes, Admissions, DPOStudyPlan, Years, AdmissionsQuery, DPOSPQuery,
  ChairsQuery, CourceNameQuery, DisciplineNameQuery, System.Contnrs,
  NotifyEvents, StudentGroupsQuery, CourceEdTypesQuery, FDDumbQuery, YearsQry,
  EdLvlQry;

type
  TCourceGroup = class(TComponent)
  private
    FAfterLoadData: TNotifyEventsEx;
    FEventList: TObjectList;
    FIDEducationLevel: Integer;
    FOnYearChange: TNotifyEventsEx;
    FqDPOSP: TQueryDPOSP;
    FqAdmissions: TQueryAdmissions;
    FqChairs: TQueryChairs;
    FqCourceName: TQueryCourceName;
    FqDisciplineName: TQueryDisciplineName;
    FqEdLvl: TQryEdLvl;
    FqStudentGroups: TQueryStudentGroups;
    FqYears: TQryYears;
    FYearDumb: TQueryFDDumb;
    function GetqDisciplineName: TQueryDisciplineName;
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
    function GetCurrSPW: TDPOSPW;
    procedure Refresh;
    property AfterLoadData: TNotifyEventsEx read FAfterLoadData;
    property qDPOSP: TQueryDPOSP read FqDPOSP;
    property qAdmissions: TQueryAdmissions read FqAdmissions;
    property qChairs: TQueryChairs read FqChairs;
    property qCourceName: TQueryCourceName read FqCourceName;
    property qDisciplineName: TQueryDisciplineName read GetqDisciplineName;
    property qEdLvl: TQryEdLvl read GetqEdLvl;
    property qStudentGroups: TQueryStudentGroups read GetqStudentGroups;
    property qYears: TQryYears read FqYears;
    property Year: Integer read GetYear write SetYear;
    property YearDumb: TQueryFDDumb read FYearDumb;
    property OnYearChange: TNotifyEventsEx read FOnYearChange;
  end;

implementation

uses
  System.SysUtils, CopyStudyPlanQuery;

constructor TCourceGroup.Create(AOwner: TComponent; AYear, AIDEducationLevel:
    Integer);
begin
  inherited Create(AOwner);

  Assert(AYear > 0);
  Assert(AIDEducationLevel > 0);

  FIDEducationLevel := AIDEducationLevel;

  FEventList := TObjectList.Create;
  FAfterLoadData := TNotifyEventsEx.Create(Self);
  FOnYearChange := TNotifyEventsEx.Create(Self);

  // Года
  FqYears := TQryYears.Create(Self);
  FqYears.W.RefreshQuery;
  FqYears.W.LocateByPK(AYear, True);

  // Текущий год
  FYearDumb := TQueryFDDumb.Create(Self);
  FYearDumb.Name := 'YearDumb';
  // Подписываемся на изменение текущего года
  TNotifyEventWrap.Create( FYearDumb.W.AfterPost, DoAfterYearPost, FEventList);
  FYearDumb.W.RefreshQuery;

  // Сами наборы на курсы
  FqAdmissions := TQueryAdmissions.Create(Self);

  // Для каскадного удаления
  // TNotifyEventWrap.Create(FqAdmissions.W.BeforeDelete, DoBeforeDelete,
  // FEventList);

  // Дисциплины по курсам
  FqDPOSP := TQueryDPOSP.Create(Self);

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
  FqDPOSP.Search(FIDEducationLevel, Year);

  // Сами наборы на курсы
  FqAdmissions.Search(FIDEducationLevel, Year);

  FAfterLoadData.CallEventHandlers(Self);
  FOnYearChange.CallEventHandlers(Self);
end;

function TCourceGroup.GetqDisciplineName: TQueryDisciplineName;
begin
  if FqDisciplineName = nil then
  begin
    FqDisciplineName := TQueryDisciplineName.Create(Self);
    FqDisciplineName.W.TryOpen;
  end;
  Result := FqDisciplineName;
end;

function TCourceGroup.GetqStudentGroups: TQueryStudentGroups;
begin
  if FqStudentGroups = nil then
    FqStudentGroups := TQueryStudentGroups.Create(Self);

  Result := FqStudentGroups;
end;

function TCourceGroup.GetCurrSPW: TDPOSPW;
begin
  Assert(qAdmissions.W.PK.AsInteger > 0);
  Result := TDPOSPW.Create(
    qDPOSP.W.AddClone(Format('%s=%d', [qDPOSP.W.IDSPECIALITYEDUCATION.FieldName,
    qAdmissions.W.PK.AsInteger])));
end;

function TCourceGroup.GetqEdLvl: TQryEdLvl;
begin
  if FqEdLvl = nil then
    FqEdLvl := TQryEdLvl.Create(Self);

  Result := FqEdLvl;
end;

function TCourceGroup.GetYear: Integer;
begin
  Result := FYearDumb.W.ID.F.AsInteger;
end;

procedure TCourceGroup.Refresh;
begin
  qDPOSP.W.RefreshQuery;
  qAdmissions.W.RefreshQuery;
end;

procedure TCourceGroup.SetYear(const Value: Integer);
begin
  if Year = Value then  Exit;

  // Выбираем нужный нам год
  FYearDumb.W.UpdateID(Value);
end;

end.
