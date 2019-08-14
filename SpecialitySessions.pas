unit SpecialitySessions;

interface

uses EssenceEx, classes, K_Params, DBRecordHolder;

type
  TSessionTypes = class;

  TCustomSpecialitySessions = class(TEssenceEx2)
  private
    FIDAdmissionParam: T_KParam;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    property IDAdmissionParam: T_KParam read FIDAdmissionParam;
  end;

  TSessionTypes = class(TEssenceEx)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TMaxSpecialitySessions = class(TCustomSpecialitySessions)
  private
    FLevelParam: T_KParam;
  protected
    property LevelParam: T_KParam read FLevelParam;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSpecialitySessions = class(TCustomSpecialitySessions)
  private
    FRecordHolder: TRecordHolder;
    FSessionTypes: TSessionTypes;
    procedure AfterInsert(Sender: TObject);
    procedure BeforeInsert(Sender: TObject);
    procedure ChangeLevelOrYear(AUp, ALevel: Boolean);
    function GetAdmissionYear: Integer;
    function GetMaxSessionInLevel(ALevel: Integer): Integer;
  protected
    procedure AfterQueryOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddLevel;
    procedure DownLevel;
    procedure DownLevelYear;
    procedure UpLevel;
    procedure UpLevelYear;
  end;

implementation

uses SQLTools, Essence, DB, NotifyEvents, SpecEducation, MyDataAccess, SysUtils,
  Variants, DateUtils;

constructor TCustomSpecialitySessions.Create(AOwner: TComponent);
begin
  inherited;
  FSynonymFileName := 'SpecialitySessionsFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'ss.ID_specialitySession';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;
  SequenceName := 'cdb_dat_study_process.S_SPECIALITYSESSIONS_ID';

  with FSQLSelectOperator do
  begin
    Fields.Add('ss.ID_specialitySession');
    Fields.Add('ss.level_');
    Fields.Add('ss.level_year');
    Fields.Add('ss.session_in_level');
    Fields.Add('ss.session_');
    Fields.Add('ss.IDSpecialityEducation');

    Tables.Add('SPECIALITYSESSIONS ss');

    OrderClause.Add('ss.level_');
    OrderClause.Add('ss.session_in_level');
  end;

  FIDAdmissionParam := T_KParam.Create(Params, 'ss.idspecialityeducation');
end;

constructor TSessionTypes.Create(AOwner: TComponent);
begin
  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'st.ID_SessionType';

  with FSQLSelectOperator do
  begin
    Fields.Add('st.*');

    Tables.Add('SessionTypes st');

//    OrderClause.Add('st.ideducation');
    OrderClause.Add('st.semestr');
    OrderClause.Add('st.sessiontype');
  end;
end;

constructor TMaxSpecialitySessions.Create(AOwner: TComponent);
begin
  inherited;

  with FSQLSelectOperator do
  begin
    Fields.Clear;
    Fields.Add('max(level_) Max_level');
    Fields.Add('max(level_year) max_level_year');
    Fields.Add('max(session_in_level) Max_session_in_level');
  end;

  FLevelParam := T_KParam.Create(Params, 'ss.level_');
end;

constructor TSpecialitySessions.Create(AOwner: TComponent);
var
  Field: TField;
begin
  inherited;
  FRecordHolder := TRecordHolder.Create();

  with FSQLSelectOperator do
  begin
    WhereClause.Add('ss.idspecialityeducation = 1749'); // Искусственное условие
  end;
  Wrap.ImmediateCommit := True;
  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
  TNotifyEventWrap.Create(Wrap.BeforeInsert, BeforeInsert);
  TNotifyEventWrap.Create(Wrap.AfterInsert, AfterInsert);

  FSessionTypes := TSessionTypes.Create(Self); // Запрос выбирающий типы сессий

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию
  FSQLSelectOperator.WhereClause.Clear; // Убираем искусственное условие

  { Добавляем дополнительное, подстановочное поле }
  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'SessionType';
    Size := 100;
    FieldKind := fkLookup;
    Name := DataSetWrap.DataSet.Name + FieldName;
    KeyFields := 'SESSION_';
    LookUpDataset := FSessionTypes.DataSetWrap.DataSet;
    LookUpKeyFields := 'ID_SESSIONTYPE';
    LookUpResultField := 'SessionType';
    DataSet := DataSetWrap.DataSet;
  end;
end;

destructor TSpecialitySessions.Destroy;
begin
  inherited;
  FreeAndNil(FRecordHolder);
end;

procedure TSpecialitySessions.AddLevel;
var
  AMaxSpecialitySessions: TMaxSpecialitySessions;
  ALevel: Integer;
  ALevelYear: Integer;
begin
  ALevel := 1;
  ALevelYear := GetAdmissionYear;

  AMaxSpecialitySessions := TMaxSpecialitySessions.Create(Self);
  try
    AMaxSpecialitySessions.IDAdmissionParam.ParamValue := IDAdmissionParam.ParamValue;
    AMaxSpecialitySessions.Refresh;
    if AMaxSpecialitySessions.Wrap.DataSet.RecordCount > 0 then
    begin
      ALevel := AMaxSpecialitySessions.Field('Max_level').AsInteger + 1;
      ALevelYear := AMaxSpecialitySessions.Field('Max_level_year').AsInteger + 1;
    end;
  finally
    FreeAndNil(AMaxSpecialitySessions);
  end;

  with Wrap.DataSet do
  begin
    Append;
    FieldByName('Level_').AsInteger := ALevel;
    FieldByName('Level_year').AsInteger := ALevelYear;
    FieldByName('Session_in_level').AsInteger := 1;
  end;

end;

procedure TSpecialitySessions.AfterInsert(Sender: TObject);
begin
  Field('IDSpecialityEducation').AsInteger := IDAdmissionParam.ParamValue;
  // Если раньше не было ни одной записи
  if FRecordHolder.Count = 0 then
  begin
    Field('Level_').AsInteger := 1;
    Field('session_in_level').AsInteger := 1;
    Field('level_year').AsInteger := GetAdmissionYear;
  end
  else
  begin
    Field('Level_').AsInteger := FRecordHolder.Field['Level_'];
    Field('session_in_level').AsInteger := GetMaxSessionInLevel(FRecordHolder.Field['level_']) + 1;
    Field('level_year').AsInteger := FRecordHolder.Field['level_year'];
  end;
end;

procedure TSpecialitySessions.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([pfInUpdate]); // Все поля будут обновляться

    // Обозначаем ключевое поле
    FieldByName(KeyFieldName).ProviderFlags := [pfInKey, pfInUpdate];
  end;
end;

procedure TSpecialitySessions.BeforeInsert(Sender: TObject);
begin
  if Wrap.DataSet.RecordCount > 0 then
    FRecordHolder.Attach(Wrap.DataSet)
  else
    FRecordHolder.Clear;
end;

procedure TSpecialitySessions.ChangeLevelOrYear(AUp, ALevel: Boolean);
var
  AMySQLQuery: TMySQLQuery;
  Sign: string;
  AFieldName: string;
begin
  if AUp then
    Sign := '+'
  else
    Sign := '-';

  if ALevel then
    AFieldName := 'Level_'
  else
    AFieldName := 'Level_year';

  AMySQLQuery := TMySQLQuery.Create(nil, 0);
  try
    AMySQLQuery.SQL.Text :=
      Format(
      'update SpecialitySessions ' +
      'set %s = %s %s 1 ' +
      'where idspecialityeducation = %s ' +
      'and level_ = %d',
      [AFieldName, AFieldName, Sign,
      VarToStr(IDAdmissionParam.ParamValue), Field('level_').AsInteger]);

    AMySQLQuery.ExecSQL();
  finally
    FreeAndNil(AMySQLQuery);
  end;

  UseBookmark := True;
  Refresh;
end;

procedure TSpecialitySessions.DownLevel;
begin
  ChangeLevelOrYear(False, True);
end;

procedure TSpecialitySessions.DownLevelYear;
begin
  ChangeLevelOrYear(False, False);
end;

function TSpecialitySessions.GetAdmissionYear: Integer;
var
  ASpecEducation: TSpecEducation;
begin
  ASpecEducation := TSpecEducation.Create(Self);
  try
    ASpecEducation.IDSpecEducationParam.ParamValue := IDAdmissionParam.ParamValue;
    ASpecEducation.Refresh;
    Result := ASpecEducation.Field('year').AsInteger;
  finally
    FreeAndNil(ASpecEducation);
  end;
end;

function TSpecialitySessions.GetMaxSessionInLevel(ALevel: Integer): Integer;
var
  AMaxSpecialitySessions: TMaxSpecialitySessions;
begin
  AMaxSpecialitySessions := TMaxSpecialitySessions.Create(Self);
  try
    AMaxSpecialitySessions.IDAdmissionParam.ParamValue := IDAdmissionParam.ParamValue;
    AMaxSpecialitySessions.LevelParam.ParamValue := ALevel;
    AMaxSpecialitySessions.Refresh;

    Result := AMaxSpecialitySessions.Field('Max_session_in_level').AsInteger;
  finally
    FreeAndNil(AMaxSpecialitySessions);
  end;


end;

procedure TSpecialitySessions.UpLevel;
begin
  ChangeLevelOrYear(True, True);
end;

procedure TSpecialitySessions.UpLevelYear;
begin
  ChangeLevelOrYear(True, False);
end;

end.

