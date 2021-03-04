unit CourseService;

interface

uses
  System.Classes, Admissions, DPOStudyPlan, Years, AdmissionsQuery, ChairsQuery,
  CourseNameQuery, System.Contnrs, NotifyEvents, StudentGroupsQuery,
  CourseEdTypesQuery, YearsQry, EdLvlQry, Data.DB, FireDAC.Comp.DataSet,
  DiscNameQry, CourseStudyPlanQry, FDDumb, CourseViewInterface,
  CourseEditInterface, CourseStudyPlanViewInterface, CourseNameInterface,
  InsertEditMode, CourseStudyPlanEditInterface, DiscNameInt;

type
  TCourseService = class(TComponent, ICourseView, ICourseEdit,
      ICourseStudyPlanView, ICourseStudyPlanEdit)
  strict private
    procedure AdmissionMove(AIDArr: TArray<Integer>;
      AIDEducationLevel: Integer);
    procedure ApplyStudGroups;
    procedure CancelCourceEdit;
    function ApplyCourseName(ACourseNameI: ICourseName): Integer;
    procedure ApplyCourseStudyPlan;
    function ApplyDisciplines(ADiscNameI: IDiscName; AMode: TMode): Integer;
    procedure CancelCourseStudyPlan;
    procedure DeleteCourse(AIDSpecialityEducationArr: TArray<Integer>);
    function GetAdmissionsW: TAdmissionsW;
    function GetAfterLoadData: TNotifyEventsEx;
    function GetAllCourseStudyPlanW: TCourseStudyPlanW;
    function GetChairsW: TChairsW;
    function GetCourseEditI(AIDSpecialityEducation: Integer): ICourseEdit;
    function GetCourseNameW: TCourseNameW;
    function GetCourseStudyPlanEditI(AIDStudyPlan: Integer)
      : ICourseStudyPlanEdit;
    function GetCourseStudyPlanViewI: ICourseStudyPlanView;
    function GetCourseStudyPlanW: TCourseStudyPlanW;
    function GetDiscNameW: TDiscNameW;
    function GetEdLvlW: TEdLvlW;
    function GetIDChair: Integer;
    function GetIDSpecialityEducation: Integer;
    function GetIDYearW: TDumbW;
    function GetID_SpecialityEducation: Integer; stdcall;
    function GetID_StudyPlan: Integer; stdcall;
    function GetStudentGroupsW: TStudentGroupsW;
    function GetYearsW: TYearsW;
    procedure SearchStudGroups(AIDSpecialityEducation: Integer);
    procedure SetID_SpecialityEducation(const Value: Integer); stdcall;
  private
    FAfterLoadData: TNotifyEventsEx;
    FEventList: TObjectList;
    FIDEducationLevel: Integer;
    FID_SpecialityEducation: Integer;
    FID_StudyPlan: Integer;
    FOnYearChange: TNotifyEventsEx;
    FqAllCourseStudyPlan: TQryCourseStudyPlan;
    FqAdmissions: TQueryAdmissions;
    FqChairs: TQueryChairs;
    FqCourseName: TQueryCourseName;
    FqCourseStudyPlan: TQryCourseStudyPlan;
    FqDiscName: TQryDiscName;
    FqEdLvl: TQryEdLvl;
    FqStudentGroups: TQueryStudentGroups;
    FqYears: TQryYears;
    FYearDumb: TFDDumb;
    procedure DoAfterDisciplinesApplyUpdates(ADataSet: TFDDataSet;
      AErrorCount: Integer);
    function GetqCourseStudyPlan: TQryCourseStudyPlan;
    function GetqDiscName: TQryDiscName;
    function GetqEdLvl: TQryEdLvl;
    function GetqStudentGroups: TQueryStudentGroups;
    function GetYear: Integer;
    procedure SetYear(const Value: Integer);
    property qEdLvl: TQryEdLvl read GetqEdLvl;
    property qStudentGroups: TQueryStudentGroups read GetqStudentGroups;
  protected
    procedure DoAfterYearPost(Sender: TObject);
    property qCourseStudyPlan: TQryCourseStudyPlan read GetqCourseStudyPlan;
    property qDiscName: TQryDiscName read GetqDiscName;
  public
    constructor Create(AOwner: TComponent; AYear, AIDEducationLevel: Integer);
      reintroduce;
    destructor Destroy; override;
    procedure Copy(AIDArray: TArray<Integer>; AYear: Integer);
    procedure Refresh;
    property Year: Integer read GetYear write SetYear;
    property OnYearChange: TNotifyEventsEx read FOnYearChange;
  end;

implementation

uses
  System.SysUtils, CopyStudyPlanQuery;

constructor TCourseService.Create(AOwner: TComponent;
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
  FqAllCourseStudyPlan := TQryCourseStudyPlan.Create(Self);
  FqAllCourseStudyPlan.Name := 'FqDPOSP_Main';

  // Кафедры
  FqChairs := TQueryChairs.Create(Self);
  FqChairs.W.RefreshQuery;

  // Названия курсов
  FqCourseName := TQueryCourseName.Create(Self);
  FqCourseName.SearchCourceName;

  // Ищем все формы обучения "Курсы" кроме нашего
  qEdLvl.Search([4, 6], AIDEducationLevel);

  // Имитируем смену года
  Year := AYear;
end;

destructor TCourseService.Destroy;
begin
  FreeAndNil(FEventList);
  FreeAndNil(FAfterLoadData);
  FreeAndNil(FOnYearChange);
  inherited;
end;

procedure TCourseService.AdmissionMove(AIDArr: TArray<Integer>;
  AIDEducationLevel: Integer);
begin
  FqAdmissions.Move(AIDArr, AIDEducationLevel);
end;

procedure TCourseService.ApplyStudGroups;
begin
  if not qStudentGroups.FDQuery.Active then
    Exit;

  // Наконец-то сохраняем сделанные изменения в БД
  qStudentGroups.FDQuery.ApplyUpdates(0);
  qStudentGroups.FDQuery.CommitUpdates;
  Assert(qStudentGroups.FDQuery.ChangeCount = 0);

  // Обновляем кол-во групп учебного плана
  FqAdmissions.W.ID_SpecialityEducation.Locate(FID_SpecialityEducation,
    [], True);
  FqAdmissions.SetGroupCount(qStudentGroups.FDQuery.RecordCount);
end;

procedure TCourseService.CancelCourceEdit;
begin
  // НЕ сохраняем сделанные изменения в БД
  FqCourseName.FDQuery.CancelUpdates;

  // Отменяем сделанные изменения в группах
  if qStudentGroups.FDQuery.Active then
    qStudentGroups.FDQuery.CancelUpdates;
end;

procedure TCourseService.Copy(AIDArray: TArray<Integer>; AYear: Integer);
begin
  Assert(Length(AIDArray) > 0);
  Assert(AYear > 0);

  TQueryCopyStudyPlan.Copy(AIDArray, AYear);
end;

function TCourseService.ApplyCourseName(ACourseNameI: ICourseName): Integer;
begin
  FqCourseName.W.Save(ACourseNameI, EditMode);
  Result := FqCourseName.ApplyUpdates;
end;

procedure TCourseService.ApplyCourseStudyPlan;
begin
  FqCourseStudyPlan.W.TryPost;

  if FqCourseStudyPlan.FDQuery.ChangeCount = 0 then
    Exit;

  FqCourseStudyPlan.FDQuery.ApplyUpdates(0);
  FqCourseStudyPlan.FDQuery.CommitUpdates;
  Assert(FqCourseStudyPlan.FDQuery.ChangeCount = 0);
end;

function TCourseService.ApplyDisciplines(ADiscNameI: IDiscName; AMode: TMode):
    Integer;
begin
  // Тут у нас пока может ID = NULL если InsertMode
  qDiscName.W.Save(ADiscNameI, AMode);

  // Наконец-то сохраняем сделанные изменения в БД
  qDiscName.FDQuery.ApplyUpdates(0);
  qDiscName.FDQuery.CommitUpdates;

  // Тут должен появиться положительный ID
  Assert(qDiscName.W.PK.AsInteger > 0);
  Result := qDiscName.W.PK.AsInteger;
end;

procedure TCourseService.CancelCourseStudyPlan;
begin
  FqCourseStudyPlan.W.TryCancel;
  if FqCourseStudyPlan.FDQuery.ChangeCount = 0 then
    Exit;

  FqCourseStudyPlan.FDQuery.CancelUpdates;
  Assert(FqCourseStudyPlan.FDQuery.ChangeCount = 0);
end;

procedure TCourseService.DeleteCourse(AIDSpecialityEducationArr: TArray<Integer>);
var
  AIDSpecialityEducation: Integer;
begin
  Assert(Length(AIDSpecialityEducationArr) > 0);
  for AIDSpecialityEducation in AIDSpecialityEducationArr do
  begin
    FqAdmissions.W.ID_SpecialityEducation.Locate(AIDSpecialityEducation,
      [], True);
    FqAdmissions.W.DataSet.Delete;
  end;
end;

procedure TCourseService.DoAfterDisciplinesApplyUpdates(ADataSet: TFDDataSet;
  AErrorCount: Integer);
var
  AW: TCourseStudyPlanW;
  I: Integer;
begin
  // Создаём курсор дисциплин учебного плана курсов
  // Всё, что запишем в этот курсор, отобразится и в qAllCourseStudyPlan
  // даже если qAllCourseStudyPlan использует CahedUpdates
  AW := TCourseStudyPlanW.Create(FqAllCourseStudyPlan.W.AddClone(''));

  FqCourseStudyPlan.FDQuery.FilterChanges := [FireDAC.Comp.DataSet.rtModified,
    FireDAC.Comp.DataSet.rtInserted];
  FqCourseStudyPlan.FDQuery.First;
  while not FqCourseStudyPlan.FDQuery.Eof do
  begin
    case FqCourseStudyPlan.FDQuery.UpdateStatus of
      usModified:
        begin
          // Ищем эту запись у курсора мастера
          AW.LocateByPK(FqCourseStudyPlan.W.ID_StudyPlan.F.AsInteger, True);
          AW.TryEdit;
        end;
      usInserted:
        // Добавляем эту запись в курсор мастера
        AW.TryAppend;
    end;

    for I := 0 to FqCourseStudyPlan.FDQuery.FieldCount - 1 do
      AW.DataSet.Fields[I].Value := FqCourseStudyPlan.FDQuery.Fields[I].Value;

    AW.TryPost;

    FqCourseStudyPlan.FDQuery.Next;
  end;

  FqCourseStudyPlan.FDQuery.FilterChanges := [FireDAC.Comp.DataSet.rtDeleted];
  FqCourseStudyPlan.FDQuery.First;
  while not FqCourseStudyPlan.FDQuery.Eof do
  begin
    // Ищем эту запись у курсора мастера
    AW.LocateByPK(FqCourseStudyPlan.W.ID_StudyPlan.F.AsInteger, True);
    AW.DataSet.Delete;

    FqCourseStudyPlan.FDQuery.Next;
  end;

  FqCourseStudyPlan.FDQuery.FilterChanges := [FireDAC.Comp.DataSet.rtModified,
    FireDAC.Comp.DataSet.rtInserted, FireDAC.Comp.DataSet.rtUnModified];

end;

procedure TCourseService.DoAfterYearPost(Sender: TObject);
begin
  Assert(FIDEducationLevel > 0);

  // Дисциплины по курсам
  FqAllCourseStudyPlan.Search(FIDEducationLevel, Year);

  // Сами наборы на курсы
  FqAdmissions.Search(FIDEducationLevel, Year);

  if FAfterLoadData <> nil then
    FAfterLoadData.CallEventHandlers(Self);

  FOnYearChange.CallEventHandlers(Self);
end;

function TCourseService.GetAdmissionsW: TAdmissionsW;
begin
  Result := FqAdmissions.W;
end;

function TCourseService.GetAfterLoadData: TNotifyEventsEx;
begin
  if FAfterLoadData = nil then
    FAfterLoadData := TNotifyEventsEx.Create(Self);

  Result := FAfterLoadData;
end;

function TCourseService.GetAllCourseStudyPlanW: TCourseStudyPlanW;
begin
  Result := FqAllCourseStudyPlan.W;
end;

function TCourseService.GetChairsW: TChairsW;
begin
  Result := FqChairs.W;
end;

function TCourseService.GetCourseEditI(AIDSpecialityEducation: Integer)
  : ICourseEdit;
begin
  // Запоминаем код записи набора курсов, которую мы редактируем
  FID_SpecialityEducation := AIDSpecialityEducation;
  Result := Self;
end;

function TCourseService.GetCourseNameW: TCourseNameW;
begin
  Result := FqCourseName.W;
end;

function TCourseService.GetCourseStudyPlanEditI(AIDStudyPlan: Integer)
  : ICourseStudyPlanEdit;
begin
//  Assert(AIDStudyPlan > 0);

  // Возможно мы будем добавлять запись в учебный план курсов!!!
  // тогда AIDStudyPlan = 0!!!

  // Запоминаем, какую запись учебного плана мы будем редактировать
  FID_StudyPlan := AIDStudyPlan;

  Result := Self;
  // Создаём модель для представления
  (*
    AModel := TCourceDiscNameVM.Create(Self, CourceGroup.qAllCourseStudyPlan.W,
    CourceGroup.qDiscName, CourceGroup.qAdmissions.W.IDChair.F.AsInteger,
    CourceGroup.qAdmissions.W.ID_SpecialityEducation.F.AsInteger);
  *)
end;

function TCourseService.GetCourseStudyPlanViewI: ICourseStudyPlanView;
begin
  // Ищем дисциплиные учебного плана по идентификатору набора
  qCourseStudyPlan.Search(FID_SpecialityEducation);
  qCourseStudyPlan.FDQuery.CachedUpdates := True;
  qCourseStudyPlan.FDQuery.AfterApplyUpdates := DoAfterDisciplinesApplyUpdates;

  Result := Self;
end;

function TCourseService.GetCourseStudyPlanW: TCourseStudyPlanW;
begin
  // Реализация ICourseStudyPlanView
  // Возвращаем список дисциплин одного набора на курсы

  Result := qCourseStudyPlan.W;
end;

function TCourseService.GetDiscNameW: TDiscNameW;
begin
  Result := qDiscName.W;
end;

function TCourseService.GetEdLvlW: TEdLvlW;
begin
  Result := qEdLvl.W;
end;

function TCourseService.GetIDChair: Integer;
begin
  // Код кафедры - используется при редактировании дисциплины
  // ICourseStudyPlanEdit

  // Мы должны знать, какой набор на курсы мы редактируем
  Assert(FID_SpecialityEducation > 0);
  FqAdmissions.W.ID_SpecialityEducation.Locate(FID_SpecialityEducation,
    [], True);
  Result := FqAdmissions.W.IDChair.F.AsInteger;
end;

function TCourseService.GetIDSpecialityEducation: Integer;
begin
  // Реализация ICourseStudyPlanEdit
  Assert(FID_SpecialityEducation > 0);
  Result := FID_SpecialityEducation;
end;

function TCourseService.GetIDYearW: TDumbW;
begin
  Result := FYearDumb.W;
end;

function TCourseService.GetID_SpecialityEducation: Integer;
begin
  Result := FID_SpecialityEducation;
end;

function TCourseService.GetID_StudyPlan: Integer;
begin
  // Реализация ICourseStudyPlanEdit
  Assert(FID_StudyPlan > 0);
  Result := FID_StudyPlan;
end;

function TCourseService.GetqCourseStudyPlan: TQryCourseStudyPlan;
begin
  if FqCourseStudyPlan = nil then
    FqCourseStudyPlan := TQryCourseStudyPlan.Create(Self);

  Result := FqCourseStudyPlan;
end;

function TCourseService.GetqDiscName: TQryDiscName;
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

function TCourseService.GetqStudentGroups: TQueryStudentGroups;
begin
  if FqStudentGroups = nil then
    FqStudentGroups := TQueryStudentGroups.Create(Self);

  Result := FqStudentGroups;
end;

function TCourseService.GetqEdLvl: TQryEdLvl;
begin
  if FqEdLvl = nil then
    FqEdLvl := TQryEdLvl.Create(Self);

  Result := FqEdLvl;
end;

function TCourseService.GetStudentGroupsW: TStudentGroupsW;
begin
  Result := qStudentGroups.W;
end;

function TCourseService.GetYear: Integer;
begin
  Result := FYearDumb.W.ID.F.AsInteger;
end;

function TCourseService.GetYearsW: TYearsW;
begin
  Result := FqYears.W;
end;

procedure TCourseService.Refresh;
begin
  FqAllCourseStudyPlan.W.RefreshQuery;
  FqAdmissions.W.RefreshQuery;
end;

procedure TCourseService.SearchStudGroups(AIDSpecialityEducation: Integer);
begin
  FqAdmissions.W.ID_SpecialityEducation.Locate(AIDSpecialityEducation, [], True);
  qStudentGroups.Search(AIDSpecialityEducation, True);

  // Значение по умолчанию для поля Start_Year!
  qStudentGroups.W.Start_Year_DefaultValue := FqAdmissions.W.Year.F.AsInteger;
end;

procedure TCourseService.SetID_SpecialityEducation(const Value: Integer);
begin
  if FID_SpecialityEducation = Value then
    Exit;

//  Assert(FID_SpecialityEducation = 0);
  Assert(Value > 0);
  FID_SpecialityEducation := Value;
end;

procedure TCourseService.SetYear(const Value: Integer);
begin
  if Year = Value then
    Exit;

  // Выбираем нужный нам год
  FYearDumb.W.UpdateID(Value);
end;

end.
