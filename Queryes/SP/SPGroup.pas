unit SPGroup;

interface

uses
  System.Classes, ChairsQuery, CourceNameQuery, SpecEdQuery, SpecEdSimpleQuery,
  SPQry, SpecialitySessionsQuery, SPUnit, YearsQry, SpecEdBaseFormQry,
  NotifyEvents, FDDumbQuery, System.Contnrs, EdQuery, SpecByChairQry,
  QualificationQuery, AreasQry, SPStandartQuery, SpecEdSimpleInt,
  InsertEditMode;

type
  TSPType = (sptVO, sptSPO, sptRetraining);

  TSPGroup = class(TComponent)
  private
    FActivePlansOnly: Boolean;
    FEvents: TObjectList;
    FIDSpecialityEducation: Integer;
    FOnYearChange: TNotifyEventsEx;
    FOnSpecEdChange: TNotifyEventsEx;
    FqAreas: TQryAreas;
    FqEnabledChairs: TQueryChairs;
    FqAllChairs: TQueryChairs;
    FqCourceName: TQueryCourceName;
    FqEd: TQueryEd;
    FqQualifications: TQryQualifications;
    FqSP: TQrySP;
    FqSpecByChair: TQrySpecByChair;
    FqSpecEd: TQuerySpecEd;
    FqSpecEdBaseForm: TQrySpecEdBaseForm;
    FqSpecEdSimple: TQuerySpecEdSimple;
    FqSPStandart: TQuerySPStandart;
    FqSS: TQuerySpecialitySessions;
    FqYears: TQryYears;
    FSP: TStudyPlan;
    FSpecEdDumb: TQueryFDDumb;
    FSPType: TSPType;
    FYearDumb: TQueryFDDumb;
    procedure DoAfterSpecEdPost(Sender: TObject);
    procedure DoAfterYearPost(Sender: TObject);
    procedure DoOnSpecialityEducationChange;
    procedure DoOnYearChange;
    function GetqEd: TQueryEd;
    function GetIDSpecialityEducation: Integer;
    function GetqAreas: TQryAreas;
    function GetqQualifications: TQryQualifications;
    function GetqSpecByChair: TQrySpecByChair;
    function GetqSpecEdBaseForm: TQrySpecEdBaseForm;
    function GetqSPStandart: TQuerySPStandart;
    function GetYear: Integer;
    procedure SetActivePlansOnly(const Value: Boolean);
    procedure SetYear(const Value: Integer);
  public
    constructor Create(AOwner: TComponent;
      AYear, AIDSpecialityEducation: Integer; ASPType: TSPType); reintroduce;
    destructor Destroy; override;
    procedure Cancel(AIDSpecArr: TArray<Integer>);
    procedure CopyStudyPlan(AYear: Integer);
    procedure DeleteStudyPlan;
    procedure DoOnReportPlanGraphBySpecExec;
    procedure Save(ASpecEdSimple: ISpecEdSimple; AMode: TMode);
    property OnYearChange: TNotifyEventsEx read FOnYearChange;
    property OnSpecEdChange: TNotifyEventsEx read FOnSpecEdChange;
    property ActivePlansOnly: Boolean read FActivePlansOnly write
        SetActivePlansOnly;
    property qEd: TQueryEd read GetqEd;
    property IDSpecialityEducation: Integer read GetIDSpecialityEducation;
    property qAreas: TQryAreas read GetqAreas;
    property qEnabledChairs: TQueryChairs read FqEnabledChairs;
    property qAllChairs: TQueryChairs read FqAllChairs;
    property qCourceName: TQueryCourceName read FqCourceName;
    property qQualifications: TQryQualifications read GetqQualifications;
    property qSP: TQrySP read FqSP;
    property qSpecByChair: TQrySpecByChair read GetqSpecByChair;
    property qSpecEd: TQuerySpecEd read FqSpecEd;
    property qSpecEdBaseForm: TQrySpecEdBaseForm read GetqSpecEdBaseForm;
    property qSpecEdSimple: TQuerySpecEdSimple read FqSpecEdSimple;
    property qSPStandart: TQuerySPStandart read GetqSPStandart;
    property qSS: TQuerySpecialitySessions read FqSS;
    property qYears: TQryYears read FqYears;
    property SP: TStudyPlan read FSP;
    property SpecEdDumb: TQueryFDDumb read FSpecEdDumb;
    property Year: Integer read GetYear write SetYear;
    property YearDumb: TQueryFDDumb read FYearDumb;
  end;

implementation

uses
  MyFR, System.SysUtils, CopyStudyPlanQuery;

constructor TSPGroup.Create(AOwner: TComponent;
  AYear, AIDSpecialityEducation: Integer; ASPType: TSPType);
begin
  inherited Create(AOwner);

  FActivePlansOnly := True;

  Assert(AYear > 0);
  FIDSpecialityEducation := AIDSpecialityEducation;
  FSPType := ASPType;

  FEvents := TObjectList.Create;

  // Текущий план
  FSpecEdDumb := TQueryFDDumb.Create(Self);
  FSpecEdDumb.Name := 'SpecEdDumb';
  TNotifyEventWrap.Create(FSpecEdDumb.W.AfterPost, DoAfterSpecEdPost, FEvents);

  // Года
  FqYears := TQryYears.Create(Self);
  FqYears.W.RefreshQuery;

  // Текущий год
  FYearDumb := TQueryFDDumb.Create(Self);
  FYearDumb.Name := 'YearDumb';
  TNotifyEventWrap.Create(FYearDumb.W.AfterPost, DoAfterYearPost, FEvents);
  FYearDumb.W.RefreshQuery;

  // Учебные планы (наборы)
  FqSpecEd := TQuerySpecEd.Create(Self);
  FSpecEdDumb.W.RefreshQuery;

  // Кафедры
  FqEnabledChairs := TQueryChairs.Create(Self);
  FqEnabledChairs.Name := 'qEnabledChairs';
  FqEnabledChairs.Search(True);

  FqAllChairs := TQueryChairs.Create(Self);
  FqAllChairs.Name := 'qAllChairs';
  FqAllChairs.W.TryOpen;

  // Названия специальностей все!!
  FqCourceName := TQueryCourceName.Create(Self);
  FqCourceName.W.TryOpen;

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

destructor TSPGroup.Destroy;
begin
  FreeAndNil(FEvents);
  FreeAndNil(FOnYearChange);
  FreeAndNil(FOnSpecEdChange);
  inherited;
end;

procedure TSPGroup.Cancel(AIDSpecArr: TArray<Integer>);
var
  ASpecID: Integer;
begin
  // Если были добавлены новые специальности в справочник то удаляем их
  if Length(AIDSpecArr) > 0 then
  begin
    for ASpecID in AIDSpecArr do
    begin
      qSpecByChair.W.LocateByPK(ASpecID, True);
      qSpecByChair.FDQuery.Delete;
    end;
  end;

  // Отменяем сделанные изменения в стандартах учебного плана
  Assert(qSPStandart.FDQuery.CachedUpdates);
  qSPStandart.FDQuery.CancelUpdates;

  // Отменяем сделанные изменения в сферах учебного плана
  Assert(qAreas.FDQuery.CachedUpdates);
  qAreas.FDQuery.CancelUpdates;
end;

procedure TSPGroup.CopyStudyPlan(AYear: Integer);
begin
  Assert(AYear > 0);
  Assert(qSpecEd.FDQuery.RecordCount > 0);

  TQueryCopyStudyPlan.Copy([FSpecEdDumb.W.ID.F.AsInteger], AYear);
end;

procedure TSPGroup.DeleteStudyPlan;
begin
  Assert(FSpecEdDumb.W.ID.F.AsInteger > 0);
  Assert(qSpecEdSimple.W.PK.AsInteger > 0);

  qSpecEdSimple.FDQuery.Delete;
  qSpecEd.W.LocateByPK(FSpecEdDumb.W.ID.F.AsInteger);
  qSpecEd.DeleteFromClient;
  FSpecEdDumb.W.UpdateID(qSpecEd.W.PK.AsInteger);
end;

procedure TSPGroup.DoOnReportPlanGraphBySpecExec;
begin
  TMyFR.Create(Self).Show('study_plan\plan_graph_by_spec2.fr3',
    ['year_', 'id_specialityeducation'], [qSpecEdSimple.W.Year.F.AsInteger,
    qSpecEdSimple.W.ID_SPECIALITYEDUCATION.F.AsInteger]);
end;

procedure TSPGroup.DoOnSpecialityEducationChange;
begin
  // Ищем именно эту запись об уч. плане
  qSpecEdSimple.SearchByPK(IDSpecialityEducation);

  // Ищем базовую форму обучения
  qSpecEdBaseForm.SearchByPK(IDSpecialityEducation);

  // Выбираем дисциплины этого учебного плана
  SP.DoOnMasterChange(qSpecEdSimple.W.ID_SPECIALITYEDUCATION.F.AsInteger,
    qSpecEdSimple.W.IDEDUCATION2.F.AsInteger,
    qSpecEdSimple.W.IDEducationLevel.F.AsInteger);

  FOnSpecEdChange.CallEventHandlers(Self);
end;

procedure TSPGroup.DoOnYearChange;
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
  FSpecEdDumb.W.UpdateID(qSpecEd.W.PK.AsInteger);

  FOnYearChange.CallEventHandlers(Self);
end;

procedure TSPGroup.DoAfterSpecEdPost(Sender: TObject);
begin
  DoOnSpecialityEducationChange;
end;

procedure TSPGroup.DoAfterYearPost(Sender: TObject);
begin
  DoOnYearChange;
end;

function TSPGroup.GetqEd: TQueryEd;
begin
  if FqEd = nil then
  begin
    FqEd := TQueryEd.Create(Self);
    FqEd.W.RefreshQuery;
  end;

  Result := FqEd;
end;

function TSPGroup.GetIDSpecialityEducation: Integer;
begin
  Result := FSpecEdDumb.W.ID.F.AsInteger;
end;

function TSPGroup.GetqAreas: TQryAreas;
begin
  if FqAreas = nil then
  begin
    FqAreas := TQryAreas.Create(Self);
    FqAreas.W.TryOpen;
  end;
  Result := FqAreas;
end;

function TSPGroup.GetqQualifications: TQryQualifications;
begin
  if FqQualifications = nil then
  begin
    FqQualifications := TQryQualifications.Create(Self);
    FqQualifications.W.TryOpen;
  end;
  Result := FqQualifications;
end;

function TSPGroup.GetqSpecByChair: TQrySpecByChair;
begin
  if FqSpecByChair = nil then
    FqSpecByChair := TQrySpecByChair.Create(Self);

  Result := FqSpecByChair;
end;

function TSPGroup.GetqSpecEdBaseForm: TQrySpecEdBaseForm;
begin
  if FqSpecEdBaseForm = nil then
    FqSpecEdBaseForm := TQrySpecEdBaseForm.Create(Self);

  Result := FqSpecEdBaseForm;
end;

function TSPGroup.GetqSPStandart: TQuerySPStandart;
begin
  if FqSPStandart = nil then
  begin
    FqSPStandart := TQuerySPStandart.Create(Self);
    FqSPStandart.W.TryOpen;
  end;
  Result := FqSPStandart;
end;

function TSPGroup.GetYear: Integer;
begin
  Result := FYearDumb.W.ID.F.AsInteger;
end;

procedure TSPGroup.Save(ASpecEdSimple: ISpecEdSimple; AMode: TMode);
var
  ASpecEdSimpleEx: ISpecEdSimpleEx;
begin
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

  // Ищем выбранную специальность
  qSpecByChair.W.LocateByPK(ASpecEdSimple.IDSpeciality, True);

  qSpecEdSimple.W.Save(ASpecEdSimple, AMode,
    qSpecByChair.W.QUALIFICATION_ID.F.AsInteger);

  qSpecEd.FDQuery.RefreshRecord();
  // Если после обновления, запись исчезла (план деактивировался)
  if qSpecEd.W.PK.AsInteger <> FSpecEdDumb.W.ID.F.AsInteger then
  begin
    // Выбираем другой активный план
    FSpecEdDumb.W.UpdateID(qSpecEd.W.PK.AsInteger);
  end;

end;

procedure TSPGroup.SetActivePlansOnly(const Value: Boolean);
begin
  FActivePlansOnly := Value;
  qSpecEd.W.ApplyEnabledFilter(FActivePlansOnly);
end;

procedure TSPGroup.SetYear(const Value: Integer);
begin
  if Year = Value then
    Exit;

  // Выбираем нужный нам год
  FYearDumb.W.UpdateID(Value);
end;

end.
