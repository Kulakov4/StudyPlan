unit CSE;

interface

uses EssenceEx, Classes, K_Params, OrderEssence, Datasnap.DBClient,
  DBRecordHolder, Data.DB;

type
  TCycleTypes = class(TEssenceEx2)
  private
    FIDCycleType: T_KInParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDCycleType: T_KInParam read FIDCycleType;
  end;

  TCycles = class(TEssenceEx2)
  private
    FCycleType: T_KParam;
  protected
    procedure BeforePost(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property CycleType: T_KParam read FCycleType;
  end;

  TCSE = class(TOrderEssence)
  private
    FRecordHolder: TRecordHolder;
    FParentParam: T_KInParam;
    FSpecialityEducationParam: T_KParam;
    procedure BeforeInsert(Sender: TObject);
    function GetIDCycleSpecialityEducation: TField;
  protected
    procedure AfterQueryOpen(Sender: TObject);
    procedure BeforePost(Sender: TObject);
    function CreateCloneForOrder(AID: Integer): TClientDataSet; override;
    procedure CreateIndex; override;
    procedure DoPrepareUpdateOrderBeforeInsert; override;
    function GetOrderField: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddLevel(IDCycle: Variant; ASubLevel: boolean);
    procedure EditLevel(IDCycle: Variant);
    property IDCycleSpecialityEducation: TField
      read GetIDCycleSpecialityEducation;
    property ParentParam: T_KInParam read FParentParam;
    property SpecialityEducationParam: T_KParam read FSpecialityEducationParam;
  end;

implementation

uses SQLTools, NotifyEvents, Essence, SysUtils, System.Variants;

constructor TCSE.Create(AOwner: TComponent);
begin
  inherited;
  FRecordHolder := TRecordHolder.Create();
  FSynonymFileName := 'CSEFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName :=
    'cse.id_cyclespecialityeducation';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;
  SequenceName := 'cdb_dat_study_process.S_CYCLESPECIALITYEDUCATIONS_ID';
  Wrap.ImmediateCommit := True;
  RefreshRecordAfterPost := True;

  with FSQLSelectOperator do
  begin
    Pragma := ' /*+ LEADING(cse) INDEX(cse) ' + ' USE_NL(cse, cy) INDEX(cy) ' +
      ' USE_NL(cy, ct) INDEX(ct) */ ';

    Fields.Add('cse.id_cyclespecialityeducation');
    Fields.Add('cse.order_');
    Fields.Add('cy.cycle');
    Fields.Add('cy.short_cycle');
    Fields.Add('ct.cycletype');
    Fields.Add('ct.shortcycletype');
    Fields.Add('ct.ord cycletype_ord');
    Fields.Add('cse.idcycle');
    Fields.Add('cse.IDSpecialityEducation');
    Fields.Add('cse.idcyclespecialityeducation');
    Fields.Add('cy.idcycle_type');

    Tables.Add('CYCLESPECIALITYEDUCATIONS cse');

    Joins.Add('join cycles cy');
    Joins.WhereCondition.Add('cse.idcycle = cy.id_cycle');

    Joins.Add('join cycle_types ct');
    Joins.WhereCondition.Add('cy.idcycle_type = ct.id_cycle_type');

    OrderClause.Add('cse.IDSpecialityEducation');
    OrderClause.Add('cse.IDCycleSpecialityEducation');
    OrderClause.Add('cse.Order_');
  end;
  FSpecialityEducationParam := T_KParam.Create(Params,
    'cse.idspecialityeducation');
  FParentParam := T_KInParam.Create(Params, 'cse.idcyclespecialityeducation');

  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
  TNotifyEventWrap.Create(Wrap.BeforePost, BeforePost);
  TNotifyEventWrap.Create(Wrap.BeforeInsert, BeforeInsert);
end;

procedure TCSE.AddLevel(IDCycle: Variant; ASubLevel: boolean);
var
  IDParent: Variant;
begin
  with DS do
  begin
    if (State in [dsBrowse]) and (DS.RecordCount > 0) then
      FRecordHolder.Attach(DS);

    // if State in [dsEdit, dsInsert] then
    // Cancel;

    if RecordCount > 0 then
    begin
      // Мы должны были запомнить поля перед вставкой
      Assert(FRecordHolder.Count > 0);
      if ASubLevel THEN
        IDParent := FRecordHolder.Field[KeyFieldName]
      else
        IDParent := FRecordHolder.Field['idcyclespecialityeducation'];
    end
    else
      IDParent := vaNull;

    DisableControls;
    try
      // Мы уже в состоянии вставки
      if (State in [dsBrowse]) then
        Insert;

      FieldByName('IDCycle').Value := IDCycle;
      FieldByName('idcyclespecialityeducation').Value := IDParent;
      try
        Post;
      except
        Cancel;
        raise;
      end;
    finally
      EnableControls;
    end;

  end;
end;

procedure TCSE.EditLevel(IDCycle: Variant);
begin
  with DS do
  begin
    if RecordCount > 0 then
      Edit
    else
      Insert;

    FieldByName('IDCycle').Value := IDCycle;
    try
      Post;
    except
      Cancel;
      raise;
    end;
  end;
end;

procedure TCSE.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([]);

    FieldByName('IDCycle').ProviderFlags := [pfInUpdate];
    FieldByName('order_').ProviderFlags := [pfInUpdate];
    FieldByName('IDSpecialityEducation').ProviderFlags := [pfInUpdate];
    FieldByName('idcyclespecialityeducation').ProviderFlags := [pfInUpdate];

    // Обозначаем ключевое поле
    FieldByName(KeyFieldName).ProviderFlags := [pfInKey, pfInUpdate];
  end;
end;

procedure TCSE.BeforeInsert(Sender: TObject);
begin
  if DS.RecordCount > 0 then
    FRecordHolder.Attach(DS);
end;

procedure TCSE.BeforePost(Sender: TObject);
begin
  // Field('Cycle').Value := Field('Cycle2').Value;
  Field('IDSpecialityEducation').Value := SpecialityEducationParam.ParamValue;

  // if Field('order_').IsNull then
  // Field('order_').Value := PKValue;
end;

function TCSE.CreateCloneForOrder(AID: Integer): TClientDataSet;
var
  V: Variant;
  AIDCYCLESPECIALITYEDUCATION: Integer;
  AOrder: Integer;
begin
  // Создаём клон
  Result := inherited;
  // Фильтруем клон чтобы он стал пустым
  Result.Filter := Format('%s=%d', [KeyFieldName, AID]);
  Result.Filtered := True;
  AOrder := Result.FieldByName(OrderField.FieldName).AsInteger;

  V := Result.FieldByName(IDCycleSpecialityEducation.FieldName).Value;
  if VarIsNull(V) then
  begin
    Result.Filter := Format('(%s is null) and (%s>=%d)',
      [IDCycleSpecialityEducation.FieldName, OrderField.FieldName, AOrder]);
  end
  else
  begin
    AIDCYCLESPECIALITYEDUCATION := V;
    Result.Filter := Format('(%s=%d) and (%s>=%d)',
      [IDCycleSpecialityEducation.FieldName, AIDCYCLESPECIALITYEDUCATION,
      OrderField.FieldName, AOrder]);
  end;

  // Переходим на ту-же запись в клоне
  if not Result.Locate(KeyFieldName, AID, []) then
    raise Exception.CreateFmt
      ('Ошибка 2 при поиске записи с кодом %d при создании клона', [AID]);

end;

procedure TCSE.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1',
    'IDSpecialityEducation;IDCycleSpecialityEducation;Order_', []);
  ClientDataSet.IndexName := 'idx1';
end;

procedure TCSE.DoPrepareUpdateOrderBeforeInsert;
begin
  // Никак вычислять порядковый номер новой записи не будем. Её заполнит тригер.
end;

function TCSE.GetIDCycleSpecialityEducation: TField;
begin
  Result := Field('IDCYCLESPECIALITYEDUCATION');
end;

function TCSE.GetOrderField: TField;
begin
  Result := Field('order_');
end;

constructor TCycles.Create(AOwner: TComponent);
begin
  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'cy.id_cycle';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;
  SequenceName := 'CDB_COM_DIRECTORIES.S_CYCLES_ID';
  FSynonymFileName := 'CyclesFields.txt';
  Wrap.ImmediateCommit := True;

  with FSQLSelectOperator do
  begin
    Pragma := ' /*+ LEADING(cy) INDEX(cy) */ ';

    Fields.Add('cy.id_cycle');
    Fields.Add('cy.cycle');
    Fields.Add('cy.short_cycle');
    Fields.Add('cy.idcycle_type');

    Tables.Add('CYCLES cy');

    WhereClause.Add('CY.ENABLE_CYCLE = 1');

    OrderClause.Add('cy.cycle');
  end;

  FCycleType := T_KParam.Create(Params, 'cy.IDCycle_Type');
  TNotifyEventWrap.Create(Wrap.BeforePost, BeforePost);
  KeyFieldProviderFlags := [pfInUpdate, pfInKey];
end;

procedure TCycles.BeforePost(Sender: TObject);
begin
  Field('IDCycle_Type').Value := CycleType.ParamValue;
end;

constructor TCycleTypes.Create(AOwner: TComponent);
begin
  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'ct.id_cycle_type';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;
  FSynonymFileName := 'CycleTypesFields.txt';

  with FSQLSelectOperator do
  begin
    Pragma := ' /*+ LEADING(ct) INDEX(ct) */ ';

    Fields.Add('ct.*');

    Tables.Add('CYCLE_TYPES ct');

    OrderClause.Add('ct.ord');
  end;
  FIDCycleType := T_KInParam.Create(Params, 'ct.id_cycle_type');
end;

end.
