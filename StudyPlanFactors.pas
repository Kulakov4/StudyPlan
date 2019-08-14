unit StudyPlanFactors;

interface

uses
  EssenceEx, System.Classes, K_Params, Data.DB, Datasnap.DBClient,
  CutCopyPaste, SQLTools, KParamsCollection, DBRecordHolder;

type
  TRules = class(TEssenceEx2)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TFactorRules = class(TEssenceEx2)
  private
    FIDFactorParam: T_KParam;
    FRules: TRules;
  protected
    procedure AfterQueryOpen(Sender: TObject);
    procedure BeforeQueryParameterPost(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property IDFactorParam: T_KParam read FIDFactorParam;
  end;

  TFactors = class(TEssenceEx2)
  private
    FFactorRules: TFactorRules;
    FRecordHolder: TRecordHolder;
  protected
    procedure AfterQueryOpen(Sender: TObject);
    procedure DoBeforeInsert(Sender: TObject);
    procedure DoAfterInsert(Sender: TObject);
    procedure DoAfterPost(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddLevel(ASubLevel: boolean);
    procedure Refresh; override;
    property FactorRules: TFactorRules read FFactorRules;
  end;

  TParameters = class(TEssenceEx2)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TParameterValues = class(TEssenceEx2)
  private
    FIDParam: T_KParam;
    FIDParameterParam: T_KParam;
    FIDSpecialityEducation: T_KParam;
    FParameterValueParam: T_KParam;
  protected
    property IDParam: T_KParam read FIDParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDParameterParam: T_KParam read FIDParameterParam;
    property IDSpecialityEducation: T_KParam read FIDSpecialityEducation;
    property ParameterValueParam: T_KParam read FParameterValueParam;
  end;

  TQueryParameters = class(TEssenceEx2)
  private
    FIDQueryParam: T_KParam;
  protected
    procedure AfterQueryOpen(Sender: TObject);
    procedure BeforeQueryParameterPost(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property IDQueryParam: T_KParam read FIDQueryParam;
  end;

  TQuerys = class(TEssenceEx2)
  private
    FQueryParameters: TQueryParameters;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Refresh; override;
    property QueryParameters: TQueryParameters read FQueryParameters;
  end;

  TStudyPlanFactorParameters = class(TEssenceEx2)
  private
    FIDStudyPlanFactorParam: T_KParam;
    FIDStudyPlanFactorParam2: T_KParam;
    FSQLSelectOperator2: TSQLSelectOperator;
    FParams2: TSQLParamCollection;
    property IDStudyPlanFactorParam: T_KParam read FIDStudyPlanFactorParam;
  protected
    procedure BeforeFactorParameterUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: boolean);
    procedure SetSQLText; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSPFCutCopyPaste = class;

  TStudyPlanFactors = class(TEssenceEx2)
  private
    FCutCopyPaste: TSPFCutCopyPaste;
    FIDAdmissionParam: T_KParam;
    FParameters: TStudyPlanFactorParameters;
  protected
    procedure BeforePost(Sender: TObject);
    procedure AfterDelete(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    function AddCriterionTree(IDFactor, IDSpecialityEducation: Integer;
      AOverride: boolean): Integer;
    function CopyStudyPlanFactor(ID_StudyPlanFactor: Integer;
      IDParentStudyPlanFactor: Variant; IDSpecialityEducation: Integer;
      DeleteSource, AOverride: boolean): Integer;
    procedure Refresh; override;
    procedure Verify;
    procedure VerifyAll;
    property CutCopyPaste: TSPFCutCopyPaste read FCutCopyPaste;
    property IDAdmissionParam: T_KParam read FIDAdmissionParam;
    property Parameters: TStudyPlanFactorParameters read FParameters;
  end;

  TSPFCutCopyPaste = class(TDataSetCutCopyPaste)
  private
    FStudyPlanFactors: TStudyPlanFactors;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paste; override;
  end;

  TAdmissionParameters = class(TEssenceEx2)
  private
    FIDAdmissionParam: T_KParam;
  protected
    procedure BeforeFactorParameterUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property IDAdmissionParam: T_KParam read FIDAdmissionParam;
  end;

implementation

uses
  NotifyEvents, MyDataAccess, SysUtils, Datasnap.Provider, Variants, Forms,
  Windows;

constructor TStudyPlanFactors.Create(AOwner: TComponent);
begin
  inherited;

  Wrap.MultiSelectDSWrap.FullKeyFieldName := 'spf.id_studyplanfactor';
  FSynonymFileName := 'StudyPlanFactorFields.txt';
  with FSQLSelectOperator do
  begin
    Fields.Add('spf.id_studyplanfactor');
    Fields.Add('spf.idupstudyplanfactor');
    Fields.Add('spf.idspecialityeducation');
    Fields.Add('spf.idfactor');
    Fields.Add('f.factorname');
    Fields.Add('f.Description');
    Fields.Add('spf.verifyDate');
    Fields.Add('spf.QueryResult');
    Fields.Add('spf.verifyResult');

    Tables.Add('studyplanfactors spf');

    Joins.Add('join factors f');
    Joins.WhereCondition.Add('spf.idfactor = f.id_factor');

    OrderClause.Add('spf.idspecialityeducation');
    OrderClause.Add('f.factorname');
  end;
  FIDAdmissionParam := T_KParam.Create(Params, 'spf.idspecialityeducation');
  FIDAdmissionParam.ParamName := 'idspecialityeducation';

  Wrap.ImmediateCommit := True;
  KeyFieldProviderFlags := [pfInKey, pfInUpdate];
  SequenceName := 'CDB_DAT_QUALITY.STUDYPLANFACTORS_SEQ';
  RefreshRecordAfterPost := True;

  TNotifyEventWrap.Create(Wrap.BeforePost, BeforePost);
  TNotifyEventWrap.Create(Wrap.AfterDelete, AfterDelete);

  // Создаём дочерний запрос - параметры фактора
  FParameters := TStudyPlanFactorParameters.Create(Self);
  FParameters.IDStudyPlanFactorParam.Master := Self;

  FCutCopyPaste := TSPFCutCopyPaste.Create(Self);
end;

function TStudyPlanFactors.AddCriterionTree(IDFactor, IDSpecialityEducation
  : Integer; AOverride: boolean): Integer;
var
  AMySQLQuery: TMySQLQuery;
begin
  AMySQLQuery := TMySQLQuery.Create(Self, 0);
  try
    AMySQLQuery.SQL.Text :=
      Format('select CDB_DAT_QUALITY.CriterionPack.AddCriterionTree(%d, %d, %d) as ID_StudyPlanFactor from dual',
      [IDFactor, IDSpecialityEducation, Abs(StrToInt(BoolToStr(AOverride)))]);
    AMySQLQuery.Open;
    if AMySQLQuery.FieldByName('ID_StudyPlanFactor').IsNull then
      Result := 0
    else
    begin
      Result := AMySQLQuery.FieldByName('ID_StudyPlanFactor').Value;

      DS.DisableControls;
      try
        Refresh;
        DataSetWrap.LocateAndCheck(KeyFieldName, Result, []);
      finally
        DS.EnableControls;
      end;
    end;

  finally
    AMySQLQuery.Free;
  end;

end;

procedure TStudyPlanFactors.BeforePost(Sender: TObject);
begin
  (Sender as TDataSet).FieldByName('idspecialityeducation').Value :=
    FIDAdmissionParam.ParamValue;
end;

procedure TStudyPlanFactors.AfterDelete(Sender: TObject);
begin
  UseBookmark := True;
  Refresh;
end;

function TStudyPlanFactors.CopyStudyPlanFactor(ID_StudyPlanFactor: Integer;
  IDParentStudyPlanFactor: Variant; IDSpecialityEducation: Integer;
  DeleteSource, AOverride: boolean): Integer;
var
  AMySQLQuery: TMySQLQuery;
  IDUpStudyPlanfactor: string;
begin
  if VarIsNull(IDParentStudyPlanFactor) then
    IDUpStudyPlanfactor := 'NULL'
  else
    IDUpStudyPlanfactor := VarToStr(IDParentStudyPlanFactor);

  AMySQLQuery := TMySQLQuery.Create(Self, 0);
  try
    AMySQLQuery.SQL.Text :=
      Format('select CDB_DAT_QUALITY.CriterionPack.CopyStudyPlanFactorEx(%d, %s, %d, %d, %d) as ID_StudyPlanFactor from dual',
      [ID_StudyPlanFactor, IDUpStudyPlanfactor, IDSpecialityEducation,
      Abs(StrToInt(BoolToStr(DeleteSource))),
      Abs(StrToInt(BoolToStr(AOverride)))]);
    AMySQLQuery.Open;
    if AMySQLQuery.FieldByName('ID_StudyPlanFactor').IsNull then
      Result := 0
    else
      Result := AMySQLQuery.FieldByName('ID_StudyPlanFactor').Value;

  finally
    AMySQLQuery.Free;
  end;
end;

procedure TStudyPlanFactors.Refresh;
begin
  // Обновляемся сами
  inherited;

  // Дополнительно обновляем дочерний запрос
  if DS.RecordCount > 0 then
    FParameters.Refresh;
end;

procedure TStudyPlanFactors.Verify;
var
  MySQLQuery: TMySQLQuery;
  ID: Integer;
begin

  ID := PKValue;
  MySQLQuery := TMySQLQuery.Create(Self, 0);
  try
    with MySQLQuery.SQL do
    begin
      Add('DECLARE');
      Add('  RetVal NUMBER;');
      Add('BEGIN');

      Add(Format
        ('  RetVal := CDB_DAT_QUALITY.CriterionPack.VERIFY ( %d );', [ID]));
      Add('  COMMIT;');
      Add('END;');
    end;

    MySQLQuery.ExecSQL(True);
  finally
    MySQLQuery.Free;
  end;

  RefreshRecord; // Обновляем одну запись
end;

procedure TStudyPlanFactors.VerifyAll;
begin
  DataSetWrap.MyBookmark.Save(KeyFieldName, True, True);
  try
    DS.First;
    while not DS.Eof do
    begin
      Verify;
      DS.Next;
    end;
  finally
    DataSetWrap.MyBookmark.Restore;
  end;
end;

constructor TFactors.Create(AOwner: TComponent);
begin
  inherited;

  Wrap.MultiSelectDSWrap.FullKeyFieldName := 'f.id_factor';
  FSynonymFileName := 'FactorFields.txt';
  with FSQLSelectOperator do
  begin
    Fields.Add('f.id_factor');
    Fields.Add('f.FactorName');
    Fields.Add('f.Description');
    Fields.Add('f.IDQuery');
    Fields.Add('f.IDParentFactor');

    Tables.Add('FACTORS F');

    OrderClause.Add('f.IDParentFactor');
  end;

  Wrap.ImmediateCommit := True;
  Wrap.Name := 'FactorWrap';

  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
  TNotifyEventWrap.Create(Wrap.BeforeInsert, DoBeforeInsert);

  FFactorRules := TFactorRules.Create(Self);
  FFactorRules.IDFactorParam.Master := Self;
  FFactorRules.Wrap.ImmediateCommit := False;
  FFactorRules.RefreshRecordAfterPost := False;
  TNotifyEventWrap.Create(Wrap.AfterPost, DoAfterPost);

  SequenceName := 'CDB_DAT_QUALITY.FACTORS_SEQ';
  TNotifyEventWrap.Create(Wrap.AfterInsert, DoAfterInsert);
  RefreshRecordAfterPost := True;

  FRecordHolder := TRecordHolder.Create;
end;

destructor TFactors.Destroy;
begin
  FreeAndNil(FRecordHolder);
  inherited;
end;

procedure TFactors.AddLevel(ASubLevel: boolean);
var
  IDParent: Variant;
begin
  with DS do
  begin
    Assert(State in [dsEdit, dsInsert]);

    if RecordCount > 0 then
      if ASubLevel THEN
        IDParent := FRecordHolder.Field[KeyFieldName]
      else
        IDParent := FRecordHolder.Field['IDParentFactor']
    else
      IDParent := vaNull;

    // Insert;
    FieldByName('IDParentFactor').Value := IDParent;

    // Во время Post DBTreeView вызывает какой-то скроллинг что приводит к тому что FactorRules пытаются сохраниться прежде чем сохранился Factor
    try
      Wrap.Post(True);
    except
      Wrap.Cancel(True);
      raise;
    end;
  end;
end;

procedure TFactors.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([pfInUpdate]); // Все поля будут обновляться

    // Обозначаем ключевое поле
    FieldByName(KeyFieldName).ProviderFlags := [pfInKey, pfInUpdate];

    // Обозначаем НЕ обновляемые поля
    // FieldByName('factorgroupname').ProviderFlags := [];
  end;
end;

procedure TFactors.DoBeforeInsert(Sender: TObject);
begin
  FRecordHolder.Attach(DS);
end;

procedure TFactors.DoAfterInsert(Sender: TObject);
begin
  GeneratePKValue; // Генерируем значение для первичного ключа
end;

procedure TFactors.DoAfterPost(Sender: TObject);
begin
  FFactorRules.Wrap.ClientDataSet.ApplyUpdates(0);
  FFactorRules.RefreshRecord;
end;

procedure TFactors.Refresh;
begin
  // Обновляемся сами
  inherited;

  // Дополнительно обновляем дочерний запрос
  FFactorRules.Refresh;
end;

constructor TParameters.Create(AOwner: TComponent);
begin
  inherited;

  Wrap.MultiSelectDSWrap.FullKeyFieldName := 'p.id_parameter';
  FSynonymFileName := 'ParametersFields.txt';
  with FSQLSelectOperator do
  begin
    Fields.Add('p.id_parameter');
    Fields.Add('p.parametername');
    Fields.Add('p.DefaultValue');

    Tables.Add('PARAMETERS P');

    OrderClause.Add('p.parametername');
  end;
  Wrap.ImmediateCommit := True;
  SequenceName := 'CDB_DAT_QUALITY.PARAMETERS_SEQ';
  KeyFieldProviderFlags := [pfInKey, pfInUpdate];

  // TNotifyEventWrap.Create( MySQLQuery.Wrap.AfterOpen, AfterQueryOpen );

  // Provider.OnGetTableName := OnGetTableName;
end;

constructor TParameterValues.Create(AOwner: TComponent);
begin
  inherited;

  Wrap.MultiSelectDSWrap.FullKeyFieldName := 'pv.id_parametervalue';
  with FSQLSelectOperator do
  begin
    Fields.Add('pv.id_parametervalue');
    Fields.Add('pv.idparameter');
    Fields.Add('pv.idStudyPlanFactor');
    Fields.Add('pv.parametervalue');

    Tables.Add('ParameterValues PV');

    OrderClause.Add('pv.idStudyPlanFactor');
    OrderClause.Add('pv.idparameter');
  end;
  FIDParam := T_KParam.Create(Params, 'pv.id_parametervalue');

  FIDParameterParam := T_KParam.Create(Params, 'pv.idparameter');
  FParameterValueParam := T_KParam.Create(Params, 'pv.ParameterValue');

  FIDSpecialityEducation := T_KParam.Create(Params,
    'spf.idspecialityeducation');
  FIDSpecialityEducation.Joins.Add('join StudyPlanFactors spf');
  FIDSpecialityEducation.Joins.WhereCondition.Add
    ('pv.idstudyplanfactor = spf.id_studyplanfactor');

  Wrap.ImmediateCommit := True;
  KeyFieldProviderFlags := [pfInKey];
  SequenceName := 'CDB_DAT_QUALITY.PARAMETERVALUES_SEQ';

  // TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
end;

constructor TQuerys.Create(AOwner: TComponent);
begin
  inherited;

  Wrap.MultiSelectDSWrap.FullKeyFieldName := 'q.id_query';
  FSynonymFileName := 'QueryFields.txt';
  with FSQLSelectOperator do
  begin
    Fields.Add('q.id_query');
    Fields.Add('q.QueryName');
    Fields.Add('q.QueryText');

    Tables.Add('QUERYS Q');

    OrderClause.Add('Q.QueryName');
  end;
  Wrap.ImmediateCommit := True;
  SequenceName := 'CDB_DAT_QUALITY.QUERYS_SEQ';
  KeyFieldProviderFlags := [pfInKey, pfInUpdate];

  FQueryParameters := TQueryParameters.Create(Self);
  FQueryParameters.IDQueryParam.Master := Self;
end;

procedure TQuerys.Refresh;
begin
  // Обновляемся сами
  inherited;

  if DS.RecordCount > 0 then
    // Дополнительно обновляем дочерний запрос
    if not FQueryParameters.DS.Active then
      FQueryParameters.Refresh;
end;

constructor TQueryParameters.Create(AOwner: TComponent);
begin
  inherited;

  Wrap.MultiSelectDSWrap.FullKeyFieldName := 'qp.id_queryparameter';
  FSynonymFileName := 'QueryParameterFields.txt';
  with FSQLSelectOperator do
  begin
    Fields.Add('qp.id_queryparameter');
    Fields.Add('qp.IDQUERY');
    Fields.Add('qp.QUERYPARAMETERNAME');
    Fields.Add('qp.IDParameter');
    Fields.Add('p.ParameterName');

    Tables.Add('QUERYPARAMETERS QP');

    Joins.Add('join Parameters p');
    Joins.WhereCondition.Add('qp.IDParameter = p.id_parameter');

    OrderClause.Add('QP.IDQUERY');
    OrderClause.Add('QP.QUERYPARAMETERNAME');
  end;
//  AutoOpen := False;
  Wrap.ImmediateCommit := True;
  SequenceName := 'CDB_DAT_QUALITY.QUERYPARAMETERS_SEQ';
  KeyFieldProviderFlags := [pfInKey, pfInUpdate];

  FIDQueryParam := T_KParam.Create(Params, 'qp.IDQuery');
  FIDQueryParam.ParamName := 'IDQuery2';

  TNotifyEventWrap.Create(Wrap.BeforePost, BeforeQueryParameterPost);
  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
end;

procedure TQueryParameters.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([pfInUpdate]); // Все поля будут обновляться

    // Обозначаем ключевое поле
    FieldByName(KeyFieldName).ProviderFlags := [pfInKey, pfInUpdate];

    // Обозначаем НЕ обновляемые поля
    FieldByName('ParameterName').ProviderFlags := [];
  end;
end;

procedure TQueryParameters.BeforeQueryParameterPost(Sender: TObject);
begin
  Field('IDQuery').Value := IDQueryParam.ParamValue;
end;

constructor TStudyPlanFactorParameters.Create(AOwner: TComponent);
begin
  inherited;

  Wrap.MultiSelectDSWrap.FullKeyFieldName := 'p.id_parameter';
  FSynonymFileName := 'StudyPlanFactorParameterFields.txt';
  with FSQLSelectOperator do
  begin
    Fields.Add('P.ID_PARAMETER');
    Fields.Add('P.PARAMETERNAME');
    Fields.Add('pv.id_parametervalue');
    Fields.Add('pv.parametervalue');

    Tables.Add('studyplanfactors spf');

    Joins.Add('join factors f');
    Joins.WhereCondition.Add('SPF.IDFACTOR = F.ID_FACTOR');

    Joins.Add('join queryparameters qp');
    Joins.WhereCondition.Add('qp.IDQUERY = F.IDQUERY');

    Joins.Add('join parameters p');
    Joins.WhereCondition.Add('QP.IDPARAMETER = P.ID_PARAMETER');

    Joins.Add('left join parametervalues pv');
    Joins.WhereCondition.Add('PV.IDPARAMETER = P.ID_PARAMETER');
    Joins.WhereCondition.Add('PV.IDStudyPlanFactor = SPF.ID_StudyPlanFactor');

    OrderClause.Add('ParameterName');
  end;

  FIDStudyPlanFactorParam := T_KParam.Create(Params, 'spf.ID_StudyPlanFactor');
  FIDStudyPlanFactorParam.ParamName := 'ID_StudyPlanFactor';

  // Создаём второй SELECT - запрос
  FSQLSelectOperator2 := TSQLSelectOperator.Create();
  with FSQLSelectOperator2 do
  begin
    Fields.Add('P.ID_PARAMETER');
    Fields.Add('P.PARAMETERNAME');
    Fields.Add('pv.id_parametervalue');
    Fields.Add('pv.parametervalue');

    Tables.Add('studyplanfactors spf');

    Joins.Add('join factors f');
    Joins.WhereCondition.Add('SPF.IDFACTOR = F.ID_FACTOR');

    Joins.Add('join FactorRules fr  ');
    Joins.WhereCondition.Add('fr.IDFactor = F.ID_Factor');

    Joins.Add('join parameters p');
    Joins.WhereCondition.Add('FR.IDPARAMETER = P.ID_PARAMETER');

    Joins.Add('left join parametervalues pv');
    Joins.WhereCondition.Add('PV.IDPARAMETER = P.ID_PARAMETER');
    Joins.WhereCondition.Add('PV.IDStudyPlanFactor = SPF.ID_StudyPlanFactor');
  end;

  FParams2 := TSQLParamCollection.Create(Self, FSQLSelectOperator2);
  FParams2.UpdateSourceSQL;

  FIDStudyPlanFactorParam2 := T_KParam.Create(FParams2,
    'spf.ID_StudyPlanFactor');
  FIDStudyPlanFactorParam2.ParamName := 'ID_StudyPlanFactor';

  // Оба параметра обоих запросов будут иметь одинаковое значение
  FIDStudyPlanFactorParam2.SameParam := FIDStudyPlanFactorParam;

  Wrap.ImmediateCommit := True;
  KeyFieldProviderFlags := [pfInKey]; // Обозначаем ключевое поле
  // RefreshRecordAfterPost := True;

  // TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);

  // Provider.OnGetTableName := OnGetTableName;
  Provider.BeforeUpdateRecord := BeforeFactorParameterUpdateRecord;
end;

procedure TStudyPlanFactorParameters.BeforeFactorParameterUpdateRecord
  (Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: boolean);
var
  AParameterValues: TParameterValues;
  AParameterValue: Variant;
begin
  Assert(UpdateKind = ukModify);

  // Перехватываем обновление
  if UpdateKind = ukModify then
  begin
    AParameterValue := DeltaDS.FieldByName('ParameterValue').Value;
    DeltaDS.First;

    AParameterValues := TParameterValues.Create(Self);
    try
      if not DeltaDS.FieldByName('ID_ParameterValue').IsNull then
      begin
        AParameterValues.IDParam.ParamValue :=
          DeltaDS.FieldByName('ID_ParameterValue').Value;
        AParameterValues.Refresh;
        Assert(AParameterValues.DS.RecordCount = 1);
        // Будем изменять запись в таблице FactorParameters
        AParameterValues.DS.Edit;
      end
      else // если такой записи в таблице ParameterValues вообще нет
      begin
        AParameterValues.IDParam.ParamValue := 0;
        AParameterValues.Refresh;
        Assert(AParameterValues.DS.RecordCount = 0);
        // Будем добавлять новую запись в таблицу ParameterValues
        AParameterValues.DS.Insert;
      end;

      try
        AParameterValues.Field('IDParameter').Value :=
          DeltaDS.FieldByName('ID_Parameter').Value;
        AParameterValues.Field('IDStudyPlanFactor').Value :=
          IDStudyPlanFactorParam.ParamValue;
        AParameterValues.Field('ParameterValue').Value := AParameterValue;

        AParameterValues.DS.Post; // Пытаемся изменить запись
      except
        AParameterValues.DS.Cancel;
        raise;
      end;

    finally
      AParameterValues.Free;
    end;

    Applied := True;
  end;
end;

procedure TStudyPlanFactorParameters.SetSQLText;
begin
  if (FSQLSelectOperator.Tables.Count = 0) then
  begin
    Exit;
  end;

  // устанавливаем новый текст SQL запроса
  DataSetWrap.SQL := FSQLSelectOperator2.SQL + #13#10'UNION'#13#10 +
    FSQLSelectOperator.SQL;
end;

constructor TRules.Create(AOwner: TComponent);
begin
  inherited;

  Wrap.MultiSelectDSWrap.FullKeyFieldName := 'r.id_rule';
  FSynonymFileName := 'RuleFields.txt';
  with FSQLSelectOperator do
  begin
    Fields.Add('r.id_rule');
    Fields.Add('r.RuleDescription');

    Tables.Add('Rules r');

    OrderClause.Add('r.ord');
  end;
  KeyFieldProviderFlags := [pfInKey];
  Provider.Options := Provider.Options + [poReadOnly];
end;

constructor TSPFCutCopyPaste.Create(AOwner: TComponent);
begin
  if not(AOwner is TStudyPlanFactors) then
    raise Exception.Create
      ('Владелец TSPFCutCopyPaste должен быть класса TStudyPlanFactors');

  FStudyPlanFactors := AOwner as TStudyPlanFactors;

  inherited Create(FStudyPlanFactors.DataSetWrap.DataSet);
  PKFieldName := FStudyPlanFactors.KeyFieldName;
end;

procedure TSPFCutCopyPaste.Paste;
var
  //AMySQLQuery: TMySQLQuery;
  DeleteSource: boolean;
  IDStudyPlanFactor: Variant;
  IDSpecialityEducation: Integer;
  IDUpStudyPlanfactor: string;
  SourceID: Integer;
begin
  if not IsPasteEnabled then
    Exit;

  SourceID := CopyOrCutID;
  if FStudyPlanFactors.Field('IDUpStudyPlanfactor').IsNull then
    IDUpStudyPlanfactor := 'NULL'
  else
    IDUpStudyPlanfactor := FStudyPlanFactors.Field
      ('IDUpStudyPlanfactor').AsString;

  IDSpecialityEducation := FStudyPlanFactors.IDAdmissionParam.ParamValue;
  DeleteSource := VarType(FCutID) <> varEmpty;

  // Вызываем копирование критерия
  IDStudyPlanFactor := FStudyPlanFactors.CopyStudyPlanFactor(SourceID,
    IDUpStudyPlanfactor, IDSpecialityEducation, DeleteSource, False);
  // Если копирование не удалось из-за ошибки уникальности
  if IDStudyPlanFactor = 0 then
    if Application.MessageBox
      ('Такой критерий уже существует. Перезаписать его?',
      'Перезаписать критерий', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      IDStudyPlanFactor := FStudyPlanFactors.CopyStudyPlanFactor(SourceID,
        IDUpStudyPlanfactor, IDSpecialityEducation, DeleteSource, True);
    end;

  FStudyPlanFactors.DataSetWrap.DataSet.DisableControls;
  try
    FStudyPlanFactors.Refresh;
    FStudyPlanFactors.DataSetWrap.LocateAndCheck(FStudyPlanFactors.KeyFieldName,
      IDStudyPlanFactor, []);
  finally
    FStudyPlanFactors.DataSetWrap.DataSet.EnableControls;
  end;
end;

constructor TFactorRules.Create(AOwner: TComponent);
var
  Field: TStringField;
begin
  inherited;

  FSynonymFileName := 'FactorRuleFields.txt';
  with FSQLSelectOperator do
  begin
    Fields.Add('fr.IDFACTOR');
    Fields.Add('fr.IDRULE');
    Fields.Add('fr.IDPARAMETER');
    Fields.Add('p.ParameterName');

    Tables.Add('FactorRules FR');

    Joins.Add('join Rules r');
    Joins.WhereCondition.Add('fr.IDRule = r.ID_Rule');

    Joins.Add('join parameters p');
    Joins.WhereCondition.Add('FR.IDPARAMETER = P.ID_PARAMETER');

    WhereClause.Add('fr.IDFACTOR = 0');

    OrderClause.Add('fr.IDFactor');
    OrderClause.Add('p.ParameterName');
  end;

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию
  FSQLSelectOperator.WhereClause.Clear; // Убираем искусственное условие

  FRules := TRules.Create(Self);

  { Добавляем дополнительное, подстановочное поле }
  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'RuleDescription';
    Size := 100;
    FieldKind := fkLookup;
    Name := DataSetWrap.DataSet.Name + FieldName;
    KeyFields := 'IDRule';
    LookUpDataset := FRules.DS;
    LookUpKeyFields := 'ID_Rule';
    LookUpResultField := 'RuleDescription';
    DataSet := DataSetWrap.DataSet;
  end;

  FIDFactorParam := T_KParam.Create(Params, 'fr.IDFACTOR');
  FIDFactorParam.ParamName := 'IDFACTOR2';

  Wrap.ImmediateCommit := True;
  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
  TNotifyEventWrap.Create(Wrap.BeforePost, BeforeQueryParameterPost);
end;

procedure TFactorRules.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([pfInKey, pfInUpdate]);
    // Все поля будут ключевыми и обновляемыми

    // Обозначаем НЕ обновляемые поля
    FieldByName('ParameterName').ProviderFlags := [];
  end;
end;

procedure TFactorRules.BeforeQueryParameterPost(Sender: TObject);
begin
  Field('IDFactor').Value := IDFactorParam.ParamValue;
end;

constructor TAdmissionParameters.Create(AOwner: TComponent);
begin
  inherited;

  FSynonymFileName := 'StudyPlanFactorParameterFields.txt';
  with FSQLSelectOperator do
  begin
    Fields.Add('spfp.idspecialityeducation');
    Fields.Add('spfp.id_parameter');
    Fields.Add('spfp.ParameterName');
    Fields.Add('t.parameterValue');

    Tables.Add('STUDYPLANFACTORSPARAMETERS spfp');

    Joins.Add('join ( '#13#10 +
      'select SPF.IDSPECIALITYEDUCATION, p.id_parameter, pv.parameterValue'#13#10
      + 'from'#13#10 + 'StudyPlanFactors spf'#13#10 +
      'join ParameterValues pv on PV.IDSTUDYPLANFACTOR = SPF.ID_STUDYPLANFACTOR'#13#10
      + 'join parameters p on PV.IDPARAMETER = P.ID_PARAMETER'#13#10 +
      'group by SPF.IDSPECIALITYEDUCATION, p.id_parameter, pv.parameterValue'#13#10
      + ') t');
    Joins.WhereCondition.Add
      ('t.IDSPECIALITYEDUCATION = spfp.IDSPECIALITYEDUCATION');
    Joins.WhereCondition.Add('t.ID_PARAMETER = spfp.id_parameter');
    OrderClause.Add('spfp.parametername');
    OrderClause.Add('t.parametervalue');
  end;

  FIDAdmissionParam := T_KParam.Create(Params, 'spfp.idspecialityeducation');
  FIDAdmissionParam.ParamName := 'idspecialityeducation';

  Wrap.ImmediateCommit := True;
  Provider.BeforeUpdateRecord := BeforeFactorParameterUpdateRecord;
  Provider.Options := Provider.Options - [poDisableInserts, poDisableDeletes];
end;

procedure TAdmissionParameters.BeforeFactorParameterUpdateRecord
  (Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: boolean);
var
  AParameterValues: TParameterValues;
  AParameterValue: Variant;
begin
  Assert(UpdateKind = ukModify);

  // Перехватываем обновление
  if UpdateKind = ukModify then
  begin
    AParameterValue := DeltaDS.FieldByName('ParameterValue').Value;
    DeltaDS.First;

    AParameterValues := TParameterValues.Create(Self);
    try
      AParameterValues.IDSpecialityEducation.ParamValue :=
        DeltaDS.FieldByName('IDSpecialityEducation').Value;
      AParameterValues.IDParameterParam.ParamValue :=
        DeltaDS.FieldByName('ID_Parameter').Value;
      AParameterValues.FParameterValueParam.ParamValue :=
        DeltaDS.FieldByName('ParameterValue').Value;

      AParameterValues.Refresh;
      while not AParameterValues.DS.Eof do
      begin
        AParameterValues.DS.Edit;
        AParameterValues.Field('ParameterValue').Value := AParameterValue;
        AParameterValues.DS.Post;
        AParameterValues.DS.Next;
      end

    finally
      AParameterValues.Free;
    end;

    Applied := True;
  end;
end;

end.
