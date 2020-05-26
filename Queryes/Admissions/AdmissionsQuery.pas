unit AdmissionsQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap,
  SpecialitySessionsQuery, LessonTypeQuery, CycleSpecialityEducationQuery,
  StudyPlansQuery, InsertEditMode, AdmissionsInterface;

type
  TAdmissionsW = class;

  TQueryAdmissions = class(TQueryBase)
    procedure FDQueryUpdateRecord(ASender: TDataSet; ARequest: TFDUpdateRequest;
      var AAction: TFDErrorAction; AOptions: TFDUpdateRowOptions);
  private
    FqCSE: TQueryCycleSpecialityEducations;
    FqLT: TQueryLessonType;
    FqSP: TQueryStudyPlans;
    FqSS: TQuerySpecialitySessions;
    FW: TAdmissionsW;
    procedure ApplyDelete;
    function GetqCSE: TQueryCycleSpecialityEducations;
    function GetqLT: TQueryLessonType;
    function GetqSP: TQueryStudyPlans;
    function GetqSS: TQuerySpecialitySessions;
    { Private declarations }
  protected
    property qCSE: TQueryCycleSpecialityEducations read GetqCSE;
    property qLT: TQueryLessonType read GetqLT;
    property qSP: TQueryStudyPlans read GetqSP;
    property qSS: TQuerySpecialitySessions read GetqSS;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Move(AIDArr: TArray<Integer>; AIDEducationLevel: Integer);
    function Search(AIDEducationLevel, AYear: Integer): Integer;
    procedure SetGroupCount(AGroupCount: Integer);
    property W: TAdmissionsW read FW;
    { Public declarations }
  end;

  TAdmissionsW = class(TDSWrap)
  private
    FData: TFieldWrap;
    FGroupCount: TFieldWrap;
    FIDChair: TFieldWrap;
    FIDEDUCATION2: TFieldWrap;
    FIDShortSpeciality: TFieldWrap;
    FIDEducationLevel: TFieldWrap;
    FIDStudyPlanStandart: TFieldWrap;
    FYear: TFieldWrap;
    FIDSpeciality: TFieldWrap;
    FID_SpecialityEducation: TFieldWrap;
    FMount_of_year: TFieldWrap;
    procedure DoBeforePost(Sender: TObject);
    function GetYearParam: TFDParam;
  protected
    procedure DoAfterInsert(Sender: TObject);
    procedure DoAfterOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Save(AdmissionInt: IAdmission; AMode: TMode);
    property Data: TFieldWrap read FData;
    property GroupCount: TFieldWrap read FGroupCount;
    property IDChair: TFieldWrap read FIDChair;
    property IDEDUCATION2: TFieldWrap read FIDEDUCATION2;
    property IDShortSpeciality: TFieldWrap read FIDShortSpeciality;
    property IDEducationLevel: TFieldWrap read FIDEducationLevel;
    property IDStudyPlanStandart: TFieldWrap read FIDStudyPlanStandart;
    property Year: TFieldWrap read FYear;
    property IDSpeciality: TFieldWrap read FIDSpeciality;
    property ID_SpecialityEducation: TFieldWrap read FID_SpecialityEducation;
    property Mount_of_year: TFieldWrap read FMount_of_year;
    property YearParam: TFDParam read GetYearParam;
  end;

implementation

uses
  NotifyEvents;

constructor TQueryAdmissions.Create(AOwner: TComponent);
begin
  inherited;
  FW := TAdmissionsW.Create(FDQuery);
//  TNotifyEventWrap.Create(FW.BeforeScrollM, DoBeforeScroll, FW.EventList);
end;

procedure TQueryAdmissions.FDQueryUpdateRecord(ASender: TDataSet;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
  AOptions: TFDUpdateRowOptions);
begin
  inherited;
  // Каскадно удалим всё, что зависит от SpecialityEducation
  if ARequest = arDelete then
    ApplyDelete;
end;

function TQueryAdmissions.Search(AIDEducationLevel, AYear: Integer): Integer;
begin
  Assert(AIDEducationLevel > 0);
  Assert(AYear > 0);

  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.IDEducationLevel.FieldName,
    W.IDEducationLevel.FieldName]));
  SetParamType(W.IDEducationLevel.FieldName);

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('1=1',
    Format('%s=:%s', [W.Year.FieldName, W.Year.FieldName]));
  SetParamType(W.Year.FieldName);

  Result := W.Load([W.IDEducationLevel.FieldName, W.Year.FieldName],
    [AIDEducationLevel, AYear]);

  // Запоминаем эти значения как значения "по умолчанию"
  W.IDEducationLevel.DefaultValue := AIDEducationLevel;
  W.Year.DefaultValue := AYear;
end;

constructor TAdmissionsW.Create(AOwner: TComponent);
begin
  inherited;
  FID_SpecialityEducation := TFieldWrap.Create(Self, 'ID_SpecialityEducation',
    '', True);

  FIDSpeciality := TFieldWrap.Create(Self, 'IDSpeciality', 'Наименование');
  FData := TFieldWrap.Create(Self, 'DATA_', 'Часов');
  FIDChair := TFieldWrap.Create(Self, 'IDChair', 'Кафедра');
  FIDShortSpeciality := TFieldWrap.Create(Self, 'IDShortSpeciality',
    'Сокращение');
  FIDEducationLevel := TFieldWrap.Create(Self, 'IDEducationLevel');
  FYear := TFieldWrap.Create(Self, 'Year');
  FMount_of_year := TFieldWrap.Create(Self, 'Mount_of_year');
  FIDStudyPlanStandart := TFieldWrap.Create(Self, 'IDStudyPlanStandart');
  FIDEDUCATION2 := TFieldWrap.Create(Self, 'IDEDucation2');

  FGroupCount := TFieldWrap.Create(Self, 'GroupCount', 'Кол-во групп');

  TNotifyEventWrap.Create(BeforePost, DoBeforePost, EventList);
  TNotifyEventWrap.Create(AfterOpen, DoAfterOpen, EventList);
  TNotifyEventWrap.Create(AfterInsert, DoAfterInsert, EventList);
end;

procedure TAdmissionsW.DoAfterInsert(Sender: TObject);
begin
  if not VarIsNull(FIDEducationLevel.DefaultValue ) then
    IDEducationLevel.F.AsInteger := FIDEducationLevel.DefaultValue;

  if not VarIsNull( Year.DefaultValue ) then
    Year.F.AsInteger := Year.DefaultValue;

  IDEDUCATION2.F.AsInteger := 1;  // Очная форма обучения

  Mount_of_year.F.AsInteger := 1;

  { TODO -oKulakov -cnew_category : Надо чтобы это делал триггер !!! }
  IDStudyPlanStandart.F.AsInteger := 3; // Без стандарта
end;

procedure TAdmissionsW.DoAfterOpen(Sender: TObject);
begin
  inherited;
  IDShortSpeciality.F.ProviderFlags := [];
  GroupCount.F.ProviderFlags := [];
end;

function TAdmissionsW.GetYearParam: TFDParam;
begin
  Result := FDDataSet.ParamByName('Year');
end;

{$R *.dfm}

procedure TAdmissionsW.DoBeforePost(Sender: TObject);
begin
  // Это одно и то-же поле!
  IDShortSpeciality.F.AsInteger := IDSpeciality.F.AsInteger;
end;

procedure TAdmissionsW.Save(AdmissionInt: IAdmission; AMode: TMode);
begin
  Assert(AdmissionInt <> nil);

  if AMode = EditMode then
    TryEdit
  else
    TryAppend;
  try
    IDSpeciality.F.AsInteger := AdmissionInt.IDSpeciality;
    IDChair.F.AsInteger := AdmissionInt.IDChair;
    Data.F.AsInteger := AdmissionInt.Data;
    TryPost;
  except
    TryCancel;
    raise;
  end;
end;

procedure TQueryAdmissions.ApplyDelete;
begin
  Assert(W.ID_SpecialityEducation.F.AsInteger > 0);

  // *********************************************
  // Ищем цикл
  // *********************************************
  if qCSE.SearchBySpecialityEducation(W.ID_SpecialityEducation.F.AsInteger) = 0
  then
    Exit;

  Assert(qCSE.FDQuery.RecordCount = 1);

  // *********************************************
  // Ищем учебные планы цикла
  // *********************************************
  if qSP.SearchByCycleSpecialityEducation(qCSE.W.PK.AsInteger) > 0 then
  begin

    Assert(qSP.FDQuery.RecordCount <= 30);

    // *********************************************
    // Проверяем, что существует ровно одна сессия
    // *********************************************
    qSS.SearchBySpecialityEducation(W.ID_SpecialityEducation.F.AsInteger);
    Assert(qSS.FDQuery.RecordCount = 1);
    Assert(qSS.W.PK.AsInteger > 0);

    while not qSP.FDQuery.Eof do
    begin
      // *********************************************
      // Удаляем из планов по сессиям
      // *********************************************
      if qLT.SearchBy(qSP.W.PK.AsInteger, qSS.W.PK.AsInteger) > 0 then
      begin
        Assert(qLT.FDQuery.RecordCount <= 5);
        while not qLT.FDQuery.Eof do
        begin
          qLT.FDQuery.Delete;
        end;
      end;

      // *********************************************
      // Удаляем из учебного плана
      // *********************************************
      qSP.FDQuery.Delete;
    end;
  end;

  // *********************************************
  // Удаляем цикл
  // *********************************************
  qCSE.FDQuery.Delete;
end;

function TQueryAdmissions.GetqCSE: TQueryCycleSpecialityEducations;
begin
  if FqCSE = nil then
    FqCSE := TQueryCycleSpecialityEducations.Create(Self);

  Result := FqCSE;
end;

function TQueryAdmissions.GetqLT: TQueryLessonType;
begin
  if FqLT = nil then
    FqLT := TQueryLessonType.Create(Self);

  Result := FqLT;
end;

function TQueryAdmissions.GetqSP: TQueryStudyPlans;
begin
  if FqSP = nil then
    FqSP := TQueryStudyPlans.Create(Self);

  Result := FqSP;
end;

function TQueryAdmissions.GetqSS: TQuerySpecialitySessions;
begin
  if FqSS = nil then
    FqSS := TQuerySpecialitySessions.Create(Self);

  Result := FqSS;
end;

procedure TQueryAdmissions.Move(AIDArr: TArray<Integer>; AIDEducationLevel:
    Integer);
var
  AID: Integer;
begin
  Assert(Length(AIDArr) > 0);
  Assert(AIDEducationLevel > 0);

  for AID in AIDArr do
  begin
    // Переносим учебный план на ДПО или на ДО
    Assert(AID > 0);
    W.LocateByPK(AID, True);
    Assert(AIDEducationLevel <> W.IDEducationLevel.F.AsInteger);

    W.TryEdit;
    W.IDEducationLevel.F.AsInteger := AIDEducationLevel;
    W.TryPost;

    DeleteFromClient;
  end;
end;

procedure TQueryAdmissions.SetGroupCount(AGroupCount: Integer);
begin
  FDQuery.OnUpdateRecord := FDQueryUpdateRecordOnClient;
  try
    W.TryEdit;
    W.GroupCount.F.AsInteger := AGroupCount;
    W.TryPost;
  finally
    FDQuery.OnUpdateRecord := FDQueryUpdateRecord;
  end;
end;

end.
