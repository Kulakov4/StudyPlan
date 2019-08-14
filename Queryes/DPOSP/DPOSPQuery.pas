unit DPOSPQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap,
  CycleSpecialityEducationQuery, SpecialitySessionsQuery, StudyPlansQuery,
  LessonTypeQuery, System.Generics.Collections;

type
  TLTInfo = record
    IDType: Integer;
    Data: Integer;
    KeyFieldName: String;
  public
    constructor Create(AIDType, AData: Integer; const AKeyFieldName: String);
  end;

  TLTInfo2 = record
    PK: TField;
    IDType: Integer;
    DataField: TField;
  public
    constructor Create(APK: TField; AIDType: Integer; ADataField: TField);
  end;

  TDPOSPW = class;

  TQueryDPOSP = class(TQueryBase)
    procedure FDQueryUpdateRecord(ASender: TDataSet; ARequest: TFDUpdateRequest;
      var AAction: TFDErrorAction; AOptions: TFDUpdateRowOptions);
  private
    FqCSE: TQueryCycleSpecialityEducations;
    FqLT: TQueryLessonType;
    FqSP: TQueryStudyPlans;
    FqSS: TQuerySpecialitySessions;
    FW: TDPOSPW;
    function GetqCSE: TQueryCycleSpecialityEducations;
    function GetqLT: TQueryLessonType;
    function GetqSP: TQueryStudyPlans;
    function GetqSS: TQuerySpecialitySessions;
    { Private declarations }
  protected
    procedure ApplyInsert;
    procedure ApplyUpdate;
    procedure ApplyDelete;
    property qCSE: TQueryCycleSpecialityEducations read GetqCSE;
    property qLT: TQueryLessonType read GetqLT;
    property qSP: TQueryStudyPlans read GetqSP;
    property qSS: TQuerySpecialitySessions read GetqSS;
  public
    constructor Create(AOwner: TComponent); override;
    function Search(AIDEducationLevel, AYear: Integer): Integer;
    property W: TDPOSPW read FW;
    { Public declarations }
  end;

  TDPOSPW = class(TDSWrap)
  private
    FIDSPECIALITYEDUCATION: TFieldWrap;
    FIDDisciplineName: TFieldWrap;
    FID_StudyPlan: TFieldWrap;
    FLecID: TFieldWrap;
    FLecData: TFieldWrap;
    FLabID: TFieldWrap;
    FLabData: TFieldWrap;
    FExamID: TFieldWrap;
    FExamData: TFieldWrap;
    FIDChair: TFieldWrap;
    FIDEducationLevel: TFieldWrap;
    FYear: TFieldWrap;
    FZachID: TFieldWrap;
    FSemData: TFieldWrap;
    FZachData: TFieldWrap;
    FSemID: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property IDSPECIALITYEDUCATION: TFieldWrap read FIDSPECIALITYEDUCATION;
    property IDDisciplineName: TFieldWrap read FIDDisciplineName;
    property ID_StudyPlan: TFieldWrap read FID_StudyPlan;
    property LecID: TFieldWrap read FLecID;
    property LecData: TFieldWrap read FLecData;
    property LabID: TFieldWrap read FLabID;
    property LabData: TFieldWrap read FLabData;
    property ExamID: TFieldWrap read FExamID;
    property ExamData: TFieldWrap read FExamData;
    property IDChair: TFieldWrap read FIDChair;
    property IDEducationLevel: TFieldWrap read FIDEducationLevel;
    property Year: TFieldWrap read FYear;
    property ZachID: TFieldWrap read FZachID;
    property SemData: TFieldWrap read FSemData;
    property ZachData: TFieldWrap read FZachData;
    property SemID: TFieldWrap read FSemID;
  end;

implementation

constructor TQueryDPOSP.Create(AOwner: TComponent);
begin
  inherited;
  FW := TDPOSPW.Create(FDQuery);
end;

procedure TQueryDPOSP.FDQueryUpdateRecord(ASender: TDataSet;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
  AOptions: TFDUpdateRowOptions);
begin
  inherited;

  Assert(ASender = FDQuery);

  case ARequest of
    arInsert:
      ApplyInsert;
    arUpdate:
      ApplyUpdate;
    arDelete:
      ApplyDelete;
    arFetchRow:
      ;
  end;

  AAction := eaApplied;
end;

constructor TDPOSPW.Create(AOwner: TComponent);
begin
  inherited;
  FID_StudyPlan := TFieldWrap.Create(Self, 'ID_StudyPlan');
  PKFieldName := FID_StudyPlan.FieldName;

  FIDSPECIALITYEDUCATION := TFieldWrap.Create(Self, 'IDSPECIALITYEDUCATION');
  FIDDisciplineName := TFieldWrap.Create(Self, 'IDDisciplineName',
    'Дисциплина');
  FIDChair := TFieldWrap.Create(Self, 'IDChair');
  FLecID := TFieldWrap.Create(Self, 'LecID');
  FLecData := TFieldWrap.Create(Self, 'LecData', 'Лекций');
  FLabID := TFieldWrap.Create(Self, 'LabID');
  FLabData := TFieldWrap.Create(Self, 'LabData', 'Лабораторных');
  FSemID := TFieldWrap.Create(Self, 'SemID');
  FSemData := TFieldWrap.Create(Self, 'SemData', 'Семинаров');
  FZachID := TFieldWrap.Create(Self, 'ZachID');
  FZachData := TFieldWrap.Create(Self, 'ZachData', 'Зачёт');
  FExamID := TFieldWrap.Create(Self, 'ExamID');
  FExamData := TFieldWrap.Create(Self, 'ExamData', 'Экзамен');

  // Этих полей нет в списке выбираемых полей, но по ним есть поиск!
  FIDEducationLevel := TFieldWrap.Create(Self, 'IDEducationLevel');
  FYear := TFieldWrap.Create(Self, 'Year');
end;

{$R *.dfm}

procedure TQueryDPOSP.ApplyInsert;
Var
  AL: TList<TLTInfo>;
  ALTI: TLTInfo;
begin
  Assert(W.IDSPECIALITYEDUCATION.F.AsInteger > 0);
  Assert(W.IDChair.F.AsInteger > 0);

  if W.DataSet.State = dsBrowse then
    W.TryEdit;

  // *********************************************
  // Добавляем новый цикл, если его ещё нет
  // *********************************************
  qCSE.SearchBySpecialityEducation(W.IDSPECIALITYEDUCATION.F.AsInteger);
  if qCSE.FDQuery.RecordCount = 0 then
    qCSE.W.AppendEmptyCycle(W.IDSPECIALITYEDUCATION.F.AsInteger);
  Assert(qCSE.FDQuery.RecordCount = 1);
  Assert(qCSE.W.PK.AsInteger > 0);

  // *********************************************
  // Проверяем, что существует ровно одна сессия
  // *********************************************
  qSS.SearchBySpecialityEducation(W.IDSPECIALITYEDUCATION.F.AsInteger);
  if qSS.FDQuery.RecordCount = 0 then
  begin
    qSS.W.TryAppend;
    qSS.W.IDSPECIALITYEDUCATION.F.AsInteger :=
      W.IDSPECIALITYEDUCATION.F.AsInteger;
    qSS.W.Level.F.AsInteger := 1;
    qSS.W.Level_Year.F.AsInteger := W.Year.DefaultValue;
    qSS.W.Session_in_level.F.AsInteger := 1;
    qSS.W.Session.F.AsInteger := 25;
    qSS.W.TryPost;
  end;

  Assert(qSS.FDQuery.RecordCount = 1);
  Assert(qSS.W.PK.AsInteger > 0);

  // *********************************************
  // Добавляем новую запись в уч. план
  // *********************************************
  qSP.SearchByIDStudyPlan(0);
  with qSP.W do
  begin
    TryAppend;
    IDCycleSpecialityEducation.F.AsInteger := qCSE.W.PK.AsInteger;
    IDDisciplineName.F.AsInteger := W.IDDisciplineName.F.AsInteger;
    Total.F.AsInteger := W.LecData.F.AsInteger + W.SemData.F.AsInteger +
      W.LabData.F.AsInteger;
    Lectures.F.AsInteger := W.LecData.F.AsInteger;
    Labworks.F.AsInteger := W.LabData.F.AsInteger;
    Seminars.F.AsInteger := W.SemData.F.AsInteger;
    IDChair.F.AsInteger := W.IDChair.F.AsInteger;
    TryPost;
  end;
  Assert(qSP.W.PK.AsInteger > 0);
  W.ID_StudyPlan.F.AsInteger := qSP.W.PK.AsInteger;

  // *********************************************
  // Добавляем новую запись в план по сессиям
  // *********************************************

  AL := TList<TLTInfo>.Create;
  try
    // Если есть часы по лекциям
    if W.LecData.F.AsInteger > 0 then
      AL.Add(TLTInfo.Create(1, W.LecData.F.AsInteger, W.LecID.FieldName));
    // Если есть часы по лабораторным
    if W.LabData.F.AsInteger > 0 then
      AL.Add(TLTInfo.Create(2, W.LabData.F.AsInteger, W.LabID.FieldName));
    // Если есть часы по семинарам
    if W.SemData.F.AsInteger > 0 then
      AL.Add(TLTInfo.Create(3, W.SemData.F.AsInteger, W.SemID.FieldName));
    // Если есть часы по зачётам
    if W.ZachData.F.AsInteger > 0 then
      AL.Add(TLTInfo.Create(6, W.ZachData.F.AsInteger, W.ZachID.FieldName));
    // Если есть часы по экзаменам
    if W.ExamData.F.AsInteger > 0 then
      AL.Add(TLTInfo.Create(5, W.ExamData.F.AsInteger, W.ExamID.FieldName));

    qLT.SearchBy(qSP.W.PK.AsInteger, qSS.W.PK.AsInteger, 0);
    // Начинаем добавление часов в таблицу
    for ALTI in AL do
    begin
      with qLT.W do
      begin
        TryAppend;
        IDStudyPlan.F.AsInteger := qSP.W.PK.AsInteger;
        IDType.F.AsInteger := ALTI.IDType;
        Data.F.AsInteger := ALTI.Data;
        IDSpecialitySession.F.AsInteger := qSS.W.PK.AsInteger;
        TryPost;
      end;
      Assert(qLT.W.PK.AsInteger > 0);
      W.Field(ALTI.KeyFieldName).AsInteger := qLT.W.PK.AsInteger;
    end;
  finally
    FreeAndNil(AL);
  end;
end;

procedure TQueryDPOSP.ApplyUpdate;
var
  AL: TList<TLTInfo2>;
  ALTI: TLTInfo2;
begin
  Assert(W.IDSPECIALITYEDUCATION.F.AsInteger > 0);
  Assert(W.ID_StudyPlan.F.AsInteger > 0);
  Assert(W.IDChair.F.AsInteger > 0);

  // *********************************************
  // Добавляем новый цикл, если его ещё нет
  // *********************************************
  qCSE.SearchBySpecialityEducation(W.IDSPECIALITYEDUCATION.F.AsInteger);
  if qCSE.FDQuery.RecordCount = 0 then
    qCSE.W.AppendEmptyCycle(W.IDSPECIALITYEDUCATION.F.AsInteger);
  Assert(qCSE.FDQuery.RecordCount = 1);
  Assert(qCSE.W.PK.AsInteger > 0);

  // *********************************************
  // Проверяем, что существует ровно одна сессия
  // *********************************************
  qSS.SearchBySpecialityEducation(W.IDSPECIALITYEDUCATION.F.AsInteger);
  Assert(qSS.FDQuery.RecordCount = 1);
  Assert(qSS.W.PK.AsInteger > 0);

  // *********************************************
  // Обновляем учебный план
  // *********************************************
  qSP.SearchByIDStudyPlan(W.ID_StudyPlan.F.AsInteger, 1);
  with qSP.W do
  begin
    TryEdit;
    IDCycleSpecialityEducation.F.AsInteger := qCSE.W.PK.AsInteger;
    IDDisciplineName.F.AsInteger := W.IDDisciplineName.F.AsInteger;
    Total.F.AsInteger := W.LecData.F.AsInteger + W.SemData.F.AsInteger +
      W.LabData.F.AsInteger;
    Lectures.F.AsInteger := W.LecData.F.AsInteger;
    Labworks.F.AsInteger := W.LabData.F.AsInteger;
    Seminars.F.AsInteger := W.SemData.F.AsInteger;
    IDChair.F.AsInteger := W.IDChair.F.AsInteger;
    TryPost;
  end;

  // *********************************************
  // Обновляем план по сессиям
  // *********************************************
  AL := TList<TLTInfo2>.Create;
  try
    AL.Add(TLTInfo2.Create(W.LecID.F, 1, W.LecData.F));
    AL.Add(TLTInfo2.Create(W.LabID.F, 2, W.LabData.F));
    AL.Add(TLTInfo2.Create(W.SemID.F, 3, W.SemData.F));
    AL.Add(TLTInfo2.Create(W.ZachID.F, 6, W.ZachData.F));
    AL.Add(TLTInfo2.Create(W.ExamID.F, 5, W.ExamData.F));

    for ALTI in AL do
    begin
      // Если часы были
      if ALTI.PK.AsInteger > 0 then
      begin
        qLT.SearchByPK(ALTI.PK.AsInteger, 1);
        if ALTI.DataField.AsInteger > 0 then
        begin
          // если часы изменились
          with qLT.W do
          begin
            TryEdit;
            Assert(IDStudyPlan.F.AsInteger = qSP.W.PK.AsInteger);
            Assert(IDType.F.AsInteger = ALTI.IDType);
            Data.F.AsInteger := ALTI.DataField.AsInteger;
            Assert(IDSpecialitySession.F.AsInteger = qSS.W.PK.AsInteger);
            TryPost;
          end;
        end
        else
        begin
          // Если часы удалили
          qLT.FDQuery.Delete;
          Assert(qLT.FDQuery.RecordCount = 0);
          ALTI.PK.Value := NULL;
          ALTI.DataField.Value := NULL;
        end;
      end
      else
      begin
        // если часов раньше не было а сейчас часы появились
        if ALTI.DataField.AsInteger > 0 then
        begin
          qLT.SearchByPK(0, 0);
          with qLT.W do
          begin
            TryAppend;
            IDStudyPlan.F.AsInteger := qSP.W.PK.AsInteger;
            IDType.F.AsInteger := ALTI.IDType;
            Data.F.AsInteger := ALTI.DataField.AsInteger;
            IDSpecialitySession.F.AsInteger := qSS.W.PK.AsInteger;
            TryPost;
          end;
          Assert(qLT.W.PK.AsInteger > 0);
          ALTI.PK.AsInteger := qLT.W.PK.AsInteger;
        end
      end;
    end;
  finally
    FreeAndNil(AL);
  end;
end;

procedure TQueryDPOSP.ApplyDelete;
begin
  Assert(W.IDSPECIALITYEDUCATION.F.AsInteger > 0);
  Assert(W.ID_StudyPlan.F.AsInteger > 0);

  // *********************************************
  // Проверяем, что существует ровно одна сессия
  // *********************************************
  qSS.SearchBySpecialityEducation(W.IDSPECIALITYEDUCATION.F.AsInteger);
  Assert(qSS.FDQuery.RecordCount = 1);
  Assert(qSS.W.PK.AsInteger > 0);

  // *********************************************
  // Удаляем из планов по сессиям
  // *********************************************
  qLT.SearchBy(W.ID_StudyPlan.F.AsInteger, qSS.W.PK.AsInteger);
  Assert(qLT.FDQuery.RecordCount <= 5);
  while not qLT.FDQuery.Eof do
  begin
    qLT.FDQuery.Delete;
  end;

  // *********************************************
  // Ищем цикл
  // *********************************************
  qCSE.SearchBySpecialityEducation(W.IDSPECIALITYEDUCATION.F.AsInteger, 1);

  // *********************************************
  // Удаляем из учебного плана всё, что относится к этому циклу
  // *********************************************
  qSP.SearchByCycleSpecialityEducation(qCSE.W.PK.AsInteger);
  while not qSP.FDQuery.Eof do
    qSP.FDQuery.Delete;

  // *********************************************
  // Удаляем цикл
  // *********************************************
  qCSE.FDQuery.Delete;
end;

function TQueryDPOSP.GetqCSE: TQueryCycleSpecialityEducations;
begin
  if FqCSE = nil then
    FqCSE := TQueryCycleSpecialityEducations.Create(Self);

  Result := FqCSE;
end;

function TQueryDPOSP.GetqLT: TQueryLessonType;
begin
  if FqLT = nil then
    FqLT := TQueryLessonType.Create(Self);

  Result := FqLT;
end;

function TQueryDPOSP.GetqSP: TQueryStudyPlans;
begin
  if FqSP = nil then
    FqSP := TQueryStudyPlans.Create(Self);

  Result := FqSP;
end;

function TQueryDPOSP.GetqSS: TQuerySpecialitySessions;
begin
  if FqSS = nil then
    FqSS := TQuerySpecialitySessions.Create(Self);

  Result := FqSS;
end;

function TQueryDPOSP.Search(AIDEducationLevel, AYear: Integer): Integer;
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

  W.Year.DefaultValue := AYear;

  Result := W.Load([W.IDEducationLevel.FieldName, W.Year.FieldName],
    [AIDEducationLevel, AYear]);
end;

constructor TLTInfo.Create(AIDType, AData: Integer;
  const AKeyFieldName: String);
begin
  Assert(AIDType > 0);
  Assert(AData > 0);
  Assert(not AKeyFieldName.IsEmpty);

  IDType := AIDType;
  Data := AData;
  KeyFieldName := AKeyFieldName;
end;

{ TLTInfo2 }

constructor TLTInfo2.Create(APK: TField; AIDType: Integer; ADataField: TField);
begin
  Assert(APK <> nil);
  Assert(ADataField <> nil);

  Assert(AIDType > 0);

  PK := APK;
  IDType := AIDType;
  DataField := ADataField;
end;

end.
