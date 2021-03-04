unit SPService;

interface

uses
  System.Classes, ChairsQuery, CourseNameQuery, SpecEdQuery, SpecEdSimpleQuery,
  SPQry, SpecialitySessionsQuery, SPUnit, YearsQry, SpecEdBaseFormQry,
  NotifyEvents, System.Contnrs, EdQuery, SpecByChairQry, QualificationQuery,
  AreasQry, SPStandartQuery, SpecEdSimpleInt, InsertEditMode, SpecQry,
  SpecChiperUniqueQry, SpecNameUniqueQry, SpecInt, FDDumb, SPViewInterface,
  SpecEdSimpleWrap, SPEditInterface, SpecEditInterface,
  SPRetrainingViewInterface, SPRetrainingEditInterface;

type
  TSPType = (sptVO, sptSPO, sptRetraining);

  TSPService = class(TComponent, ISPView, ISPEdit, ISpecEdit, ISPRetView,
      ISPRetrainingEdit)
  strict private
    function GetAllChairsW: TChairsW;
    function GetAreasW: TAreasW; stdcall;
    function GetCourseNameW: TCourseNameW;
    function GetEdW: TEdW; stdcall;
    function GetEnabledChairsW: TChairsW; stdcall;
    function GetIDSpecEdW: TDumbW;
    function GetIDYearW: TDumbW;
    function GetQualificationsW: TQualificationsW; stdcall;
    function GetSpecByChairW: TSpecByChairW; stdcall;
    function GetSpecChiperW: TSpecChiperW; stdcall;
    function GetSpecEditI: ISpecEdit;
    function GetSpecEdSimpleW: TSpecEdSimpleW;
    function GetSpecEdW: TSpecEdW;
    function GetSpecNameUniqueW: TSpecNameUniqueW; stdcall;
    function GetSpecW: TSpecW; stdcall;
    function GetSPEditInterface: ISPEdit;
    function GetSPRetrainingEditI: ISPRetrainingEdit; stdcall;
    function GetSPStandartW: TSPStandartW; stdcall;
    function GetYearsW: TYearsW;
    function SearchSpecByChair(AIDEducationLevel, AIDChair: Integer): Integer;
    function SpecSearchByChiper(const AChiper: string): Integer;
    function SpecSearchByChiperAndName(const AChiper,
      ASpeciality: string): Integer;
  private
    FActivePlansOnly: Boolean;
    FEvents: TObjectList;
    FIDSpecialityEducation: Integer;
    FOnYearChange: TNotifyEventsEx;
    FOnSpecEdChange: TNotifyEventsEx;
    FqAreas: TQryAreas;
    FqEnabledChairs: TQueryChairs;
    FqAllChairs: TQueryChairs;
    FqCourseName: TQueryCourseName;
    FqEd: TQueryEd;
    FqQualifications: TQryQualifications;
    FqSP: TQrySP;
    FqSpec: TQrySpec;
    FqSpecChiper: TQrySpecChiper;
    FqSpecName: TQrySpecName;
    FqSpecByChair: TQrySpecByChair;
    FqSpecEd: TQuerySpecEd;
    FqSpecEdBaseForm: TQrySpecEdBaseForm;
    FqSpecEdSimple: TQuerySpecEdSimple;
    FqSPStandart: TQuerySPStandart;
    FqSS: TQuerySpecialitySessions;
    FqYears: TQryYears;
    FSP: TStudyPlan;
    FIDSpecEd: TFDDumb;
    FSPType: TSPType;
    FIDYear: TFDDumb;
    procedure Cancel;
    procedure CopyStudyPlan(AYear: Integer);
    procedure DeleteStudyPlan;
    procedure DoAfterSpecEdPost(Sender: TObject);
    procedure DoAfterYearPost(Sender: TObject);
    procedure DoOnReportPlanGraphBySpecExec;
    procedure DoOnSpecialityEducationChange;
    procedure DoOnYearChange;
    function GetActivePlansOnly: Boolean;
    function GetqEd: TQueryEd;
    function GetIDSpecialityEducation: Integer;
    function GetqAreas: TQryAreas;
    function GetqQualifications: TQryQualifications;
    function GetqSpec: TQrySpec;
    function GetqSpecChiper: TQrySpecChiper;
    function GetqSpecName: TQrySpecName;
    function GetqSpecByChair: TQrySpecByChair;
    function GetqSpecEdBaseForm: TQrySpecEdBaseForm;
    function GetqSPStandart: TQuerySPStandart;
    function GetSP: TStudyPlan;
    function GetYear: Integer;
    procedure LockAllStudyPlans;
    procedure Save(ASpecEdSimple: ISpecEdSimple; AMode: TMode; ASpec: ISpec);
    procedure SetActivePlansOnly(const Value: Boolean);
    procedure SetYear(const Value: Integer);
    property ActivePlansOnly: Boolean read GetActivePlansOnly write
        SetActivePlansOnly;
    property qAllChairs: TQueryChairs read FqAllChairs;
    property qAreas: TQryAreas read GetqAreas;
    property qCourseName: TQueryCourseName read FqCourseName;
    property qEd: TQueryEd read GetqEd;
    property qEnabledChairs: TQueryChairs read FqEnabledChairs;
    property qQualifications: TQryQualifications read GetqQualifications;
    property qSpec: TQrySpec read GetqSpec;
    property qSpecByChair: TQrySpecByChair read GetqSpecByChair;
    property qSpecChiper: TQrySpecChiper read GetqSpecChiper;
    property qSpecEdBaseForm: TQrySpecEdBaseForm read GetqSpecEdBaseForm;
    property qSpecName: TQrySpecName read GetqSpecName;
    property qSPStandart: TQuerySPStandart read GetqSPStandart;
    property SP: TStudyPlan read GetSP;
  public
    constructor Create(AOwner: TComponent;
      AYear, AIDSpecialityEducation: Integer; ASPType: TSPType); reintroduce;
    destructor Destroy; override;
    property OnYearChange: TNotifyEventsEx read FOnYearChange;
    property OnSpecEdChange: TNotifyEventsEx read FOnSpecEdChange;
    property IDSpecialityEducation: Integer read GetIDSpecialityEducation;
    property Year: Integer read GetYear write SetYear;
  end;

implementation

uses
  MyFR, System.SysUtils, CopyStudyPlanQuery, FR3, ReportFilesUpdater, LockSPQry;

constructor TSPService.Create(AOwner: TComponent;
  AYear, AIDSpecialityEducation: Integer; ASPType: TSPType);
begin
  inherited Create(AOwner);

  FActivePlansOnly := True;

  Assert(AYear > 0);
  FIDSpecialityEducation := AIDSpecialityEducation;
  FSPType := ASPType;

  FEvents := TObjectList.Create;

  // Текущий план
  FIDSpecEd := TFDDumb.Create(Self);
  TNotifyEventWrap.Create(FIDSpecEd.W.AfterPost, DoAfterSpecEdPost, FEvents);

  // Года
  FqYears := TQryYears.Create(Self);
  FqYears.W.RefreshQuery;

  // Текущий год
  FIDYear := TFDDumb.Create(Self);
  TNotifyEventWrap.Create(FIDYear.W.AfterPost, DoAfterYearPost, FEvents);
  FIDYear.W.RefreshQuery;

  // Учебные планы (наборы)
  FqSpecEd := TQuerySpecEd.Create(Self);
  FIDSpecEd.W.RefreshQuery;

  // Кафедры
  FqEnabledChairs := TQueryChairs.Create(Self);
  FqEnabledChairs.Name := 'qEnabledChairs';
  FqEnabledChairs.Search(True);

  FqAllChairs := TQueryChairs.Create(Self);
  FqAllChairs.Name := 'qAllChairs';
  FqAllChairs.W.TryOpen;

  // Названия специальностей все!!
  FqCourseName := TQueryCourseName.Create(Self);
  FqCourseName.W.TryOpen;

  // Учебный план
  FqSP := TQrySP.Create(Self);

  // Сессии уч. плана
  FqSS := TQuerySpecialitySessions.Create(Self);

  // "Старый" учебный план
  FSP := TStudyPlan.Create(Self);

  FOnYearChange := TNotifyEventsEx.Create(Self);
  FOnSpecEdChange := TNotifyEventsEx.Create(Self);

  // Один учебный план
  FqSpecEdSimple := TQuerySpecEdSimple.Create(Self);

  // Если требуется перейти на конкретный учебный план
  if FIDSpecialityEducation > 0 then
  begin
    // Если этот учебный план нам доступен
    if FqSpecEdSimple.SearchByPK(FIDSpecialityEducation) = 1 then
      Assert(AYear = FqSpecEdSimple.W.Year.F.AsInteger)
    else
      FIDSpecialityEducation := 0;
  end;

  // Выбираем в выпадающем списке нужный нам год!!!
  Year := AYear;
end;

destructor TSPService.Destroy;
begin
  FreeAndNil(FEvents);
  FreeAndNil(FOnYearChange);
  FreeAndNil(FOnSpecEdChange);
  inherited;
end;

procedure TSPService.Cancel;
begin
  // Отменяем сделанные изменения в специальностях кафедры
  Assert(qSpecByChair.FDQuery.CachedUpdates);
  qSpecByChair.FDQuery.CancelUpdates;

  // Отменяем сделанные изменения в стандартах учебного плана
  Assert(qSPStandart.FDQuery.CachedUpdates);
  qSPStandart.FDQuery.CancelUpdates;

  // Отменяем сделанные изменения в сферах учебного плана
  Assert(qAreas.FDQuery.CachedUpdates);
  qAreas.FDQuery.CancelUpdates;
end;

procedure TSPService.CopyStudyPlan(AYear: Integer);
begin
  Assert(AYear > 0);
  Assert(FqSpecEd.FDQuery.RecordCount > 0);

  TQueryCopyStudyPlan.Copy([FIDSpecEd.W.ID.F.AsInteger], AYear);
end;

procedure TSPService.DeleteStudyPlan;
begin
  Assert(FIDSpecEd.W.ID.F.AsInteger > 0);
  Assert(FqSpecEdSimple.W.PK.AsInteger > 0);

  FqSpecEdSimple.FDQuery.Delete;
  FqSpecEd.W.LocateByPK(FIDSpecEd.W.ID.F.AsInteger);
  FqSpecEd.DeleteFromClient;
  FIDSpecEd.W.UpdateID(FqSpecEd.W.PK.AsInteger);
end;

procedure TSPService.DoOnReportPlanGraphBySpecExec;
begin
  TFR3.Create.Show(TReportFilesUpdater.TryUpdate
    ('study_plan\plan_graph_by_spec2.fr3'), ['year_', 'id_specialityeducation'],
    [FqSpecEdSimple.W.Year.F.AsInteger,
    FqSpecEdSimple.W.ID_SPECIALITYEDUCATION.F.AsInteger]);
end;

procedure TSPService.DoOnSpecialityEducationChange;
begin
  // Ищем именно эту запись об уч. плане
  FqSpecEdSimple.SearchByPK(IDSpecialityEducation);

  // Ищем базовую форму обучения
  qSpecEdBaseForm.SearchByPK(IDSpecialityEducation);

  // Выбираем дисциплины этого учебного плана
  SP.DoOnMasterChange(FqSpecEdSimple.W.ID_SPECIALITYEDUCATION.F.AsInteger,
    FqSpecEdSimple.W.IDEDUCATION2.F.AsInteger,
    FqSpecEdSimple.W.IDEducationLevel.F.AsInteger);

  FOnSpecEdChange.CallEventHandlers(Self);
end;

procedure TSPService.DoOnYearChange;
var
  OK: Boolean;
begin
  OK := FqSpecEd.W.SaveBookmark;;

  case FSPType of
    sptVO:
      FqSpecEd.Search(Year, 1, FActivePlansOnly); // ВО;
    sptSPO:
      FqSpecEd.Search(Year, 2, FActivePlansOnly); // СПО;
    sptRetraining:
      FqSpecEd.SearchRetraining(Year, FActivePlansOnly);
  end;

  if OK then
    FqSpecEd.W.RestoreBookmark
  else if FIDSpecialityEducation > 0 then
    FqSpecEd.W.LocateByPK(FIDSpecialityEducation);

  // Выбираем в выпадающем списке план
  FIDSpecEd.W.UpdateID(FqSpecEd.W.PK.AsInteger);

  FOnYearChange.CallEventHandlers(Self);
end;

procedure TSPService.DoAfterSpecEdPost(Sender: TObject);
begin
  DoOnSpecialityEducationChange;
end;

procedure TSPService.DoAfterYearPost(Sender: TObject);
begin
  DoOnYearChange;
end;

function TSPService.GetActivePlansOnly: Boolean;
begin
  Result := FActivePlansOnly;
end;

function TSPService.GetAllChairsW: TChairsW;
begin
  Result := qAllChairs.W;
end;

function TSPService.GetAreasW: TAreasW;
begin
  Result := qAreas.W;
end;

function TSPService.GetCourseNameW: TCourseNameW;
begin
  Result := qCourseName.W;
end;

function TSPService.GetEdW: TEdW;
begin
  Result := qEd.W;
end;

function TSPService.GetEnabledChairsW: TChairsW;
begin
  Result := qEnabledChairs.W;
end;

function TSPService.GetIDSpecEdW: TDumbW;
begin
  Result := FIDSpecEd.W;
end;

function TSPService.GetqEd: TQueryEd;
begin
  if FqEd = nil then
  begin
    FqEd := TQueryEd.Create(Self);
    FqEd.W.RefreshQuery;
  end;

  Result := FqEd;
end;

function TSPService.GetIDSpecialityEducation: Integer;
begin
  Result := FIDSpecEd.W.ID.F.AsInteger;
end;

function TSPService.GetIDYearW: TDumbW;
begin
  Result := FIDYear.W;
end;

function TSPService.GetqAreas: TQryAreas;
begin
  if FqAreas = nil then
  begin
    FqAreas := TQryAreas.Create(Self);
    FqAreas.W.TryOpen;
  end;
  Result := FqAreas;
end;

function TSPService.GetqQualifications: TQryQualifications;
begin
  if FqQualifications = nil then
  begin
    FqQualifications := TQryQualifications.Create(Self);
    FqQualifications.W.TryOpen;
  end;
  Result := FqQualifications;
end;

function TSPService.GetqSpec: TQrySpec;
begin
  if FqSpec = nil then
  begin
    FqSpec := TQrySpec.Create(Self);
  end;

  Result := FqSpec;
end;

function TSPService.GetqSpecChiper: TQrySpecChiper;
begin
  if FqSpecChiper = nil then
  begin
    // Уникальный список кодов специальностей
    FqSpecChiper := TQrySpecChiper.Create(Self, FSPType = sptRetraining);
    FqSpecChiper.FDQuery.Open;
  end;

  Result := FqSpecChiper;
end;

function TSPService.GetqSpecName: TQrySpecName;
begin
  if FqSpecName = nil then
  begin
    // Уникальный список наименований специальностей с кодом или без
    FqSpecName := TQrySpecName.Create(Self, FSPType = sptRetraining);
    FqSpecName.FDQuery.Open;
  end;

  Result := FqSpecName;
end;

function TSPService.GetqSpecByChair: TQrySpecByChair;
begin
  if FqSpecByChair = nil then
  begin
    FqSpecByChair := TQrySpecByChair.Create(Self);
    FqSpecByChair.FDQuery.CachedUpdates := True;
  end;

  Result := FqSpecByChair;
end;

function TSPService.GetqSpecEdBaseForm: TQrySpecEdBaseForm;
begin
  if FqSpecEdBaseForm = nil then
    FqSpecEdBaseForm := TQrySpecEdBaseForm.Create(Self);

  Result := FqSpecEdBaseForm;
end;

function TSPService.GetqSPStandart: TQuerySPStandart;
begin
  if FqSPStandart = nil then
  begin
    FqSPStandart := TQuerySPStandart.Create(Self);
    FqSPStandart.W.TryOpen;
  end;
  Result := FqSPStandart;
end;

function TSPService.GetQualificationsW: TQualificationsW;
begin
  Result := qQualifications.W;
end;

function TSPService.GetSP: TStudyPlan;
begin
  Result := FSP;
end;

function TSPService.GetSpecByChairW: TSpecByChairW;
begin
  Result := qSpecByChair.W;
end;

function TSPService.GetSpecChiperW: TSpecChiperW;
begin
  Result := qSpecChiper.W;
end;

function TSPService.GetSpecEditI: ISpecEdit;
begin
  Result := Self;
end;

function TSPService.GetSpecEdSimpleW: TSpecEdSimpleW;
begin
  Result := FqSpecEdSimple.W;
end;

function TSPService.GetSpecEdW: TSpecEdW;
begin
  Result := FqSpecEd.W;
end;

function TSPService.GetSpecNameUniqueW: TSpecNameUniqueW;
begin
  Result := qSpecName.W;
end;

function TSPService.GetSpecW: TSpecW;
begin
  Result := qSpec.W;
end;

function TSPService.GetSPEditInterface: ISPEdit;
begin
  Result := Self;
end;

function TSPService.GetSPRetrainingEditI: ISPRetrainingEdit;
begin
  Result := Self;
end;

function TSPService.GetSPStandartW: TSPStandartW;
begin
  Result := qSPStandart.W;
end;

function TSPService.GetYear: Integer;
begin
  Result := FIDYear.W.ID.F.AsInteger;
end;

function TSPService.GetYearsW: TYearsW;
begin
  Result := FqYears.W;
end;

procedure TSPService.LockAllStudyPlans;
begin
  case FSPType of
    sptVO:
      TQryLockSP.Lock_All([1, 2]); // ВО;
    sptSPO:
      TQryLockSP.Lock_All([3]); // СПО;
    sptRetraining:
      TQryLockSP.Lock_All([5]); // Переподготовка;
  end;

  FqSpecEd.LockAllOnClient;
end;

procedure TSPService.Save(ASpecEdSimple: ISpecEdSimple; AMode: TMode; ASpec:
    ISpec);
var
  ASpecEdSimpleEx: ISpecEdSimpleEx;
begin
  // Если в ДБ нужно поробовать добавить новую специальность
  if ASpec <> nil then
  begin
    ASpec.IDChair := ASpecEdSimple.IDChair;
    // Если такой специальности точно нет
    if qSpec.SearchByChiperAndName(ASpec.ChiperSpeciality, ASpec.Speciality) = 0
    then
    begin
      qSpec.W.Save(ASpec, InsertMode); // Добавляем специальность в базу
    end
    else
    begin
      Assert(qSpec.FDQuery.RecordCount = 1);
      // Обновляем сокращённое наименование
      qSpec.W.UpdateShortSpeciality(ASpec.ShortSpeciality);
      // qSpec.W.Save(ASpec, EditMode);
    end;
    // Сохраняем код найденной или добавленной специальности
    Assert(qSpec.W.ID_Speciality.F.AsInteger > 0);
    ASpecEdSimple.IDSpeciality := qSpec.W.ID_Speciality.F.AsInteger;
  end
  else
  begin
    // Мы выбрали специальность из списка, а не добавляли её
    Assert(ASpecEdSimple.IDSpeciality > 0);
    // Ищем выбранную специальность. Нужно узнать её квалификацию
    qSpec.SearchByID(ASpecEdSimple.IDSpeciality);
    Assert(qSpec.FDQuery.RecordCount = 1);
  end;

  ASpecEdSimpleEx := nil;

  ASpecEdSimple.QueryInterface(ISpecEdSimpleEx, ASpecEdSimpleEx);

  if ASpecEdSimpleEx <> nil then
  begin
    // Сохраняем новую сферу
    if qAreas.FDQuery.ChangeCount > 0 then
    begin
      qAreas.FDQuery.ApplyUpdates();
      qAreas.FDQuery.CommitUpdates;
      ASpecEdSimpleEx.IDArea := qAreas.W.PK.AsInteger;
    end;
  end;

  // Сохраняем учебный план
  FqSpecEdSimple.W.Save(ASpecEdSimple, AMode,
    qSpec.W.QUALIFICATION_ID.F.AsInteger);

  if AMode = EditMode then
  begin
    FqSpecEd.FDQuery.RefreshRecord();
    // Если после обновления, запись исчезла (план деактивировался)
    if FqSpecEd.W.PK.AsInteger <> FIDSpecEd.W.ID.F.AsInteger then
    begin
      // Выбираем другой активный план
      FIDSpecEd.W.UpdateID(FqSpecEd.W.PK.AsInteger);
    end;
  end
  else
  begin
    // Чтобы созданный план появился в выпадающем списке
    FqSpecEd.W.RefreshQuery;
    // Выбираем созданный план
    FIDSpecEd.W.UpdateID(FqSpecEdSimple.W.PK.AsInteger);
  end;
end;

function TSPService.SearchSpecByChair(AIDEducationLevel,
  AIDChair: Integer): Integer;
begin
  Result := qSpecByChair.Search(AIDEducationLevel, AIDChair);
end;

procedure TSPService.SetActivePlansOnly(const Value: Boolean);
begin
  FActivePlansOnly := Value;
  FqSpecEd.W.ApplyEnabledFilter(FActivePlansOnly);
end;

procedure TSPService.SetYear(const Value: Integer);
begin
  if Year = Value then
    Exit;

  // Выбираем нужный нам год
  FIDYear.W.UpdateID(Value);
end;

function TSPService.SpecSearchByChiper(const AChiper: string): Integer;
begin
  Result := qSpec.SearchByChiper(AChiper);
end;

function TSPService.SpecSearchByChiperAndName(const AChiper,
  ASpeciality: string): Integer;
begin
  Result := qSpec.SearchByChiperAndName(AChiper, ASpeciality);
end;

end.
