unit Admissions;

interface

uses classes, EssenceEx, Contnrs, DB, KDBClient, Chairs, K_Params;

type
  TAdmissions = class(TEssenceEx2)
  private
    FChairs: TChairs;
    FCourceIDEducation: Integer;
    FYearParam: T_KParam;
    function GetCurrIDChair: Integer;
    function GetCurrIDCycle: Integer;
    function GetCurrIDSpecialitySession: Integer;
    function GetCurrYear: Integer;
  protected
    procedure AfterOpen(Sender: TObject);
    procedure AfterQueryOpen(Sender: TObject);
    procedure BeforeDelete(Sender: TObject);
    function CreateClientDataSet: TKClientDataSetEx; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Copy(ToYear: Integer);
    procedure Drop;
    procedure New(AIDSpeciality: Integer);
    property CurrIDChair: Integer read GetCurrIDChair;
    property CurrIDCycle: Integer read GetCurrIDCycle;
    property CurrIDSpecialitySession: Integer read GetCurrIDSpecialitySession;
    property CurrYear: Integer read GetCurrYear;
    property YearParam: T_KParam read FYearParam;
  end;

  TAdmissionClientDataSetEx = class(TKClientDataSetEx)
  protected
    function PSExecuteStatement(const ASQL: string; AParams: TParams; ResultSet:
      Pointer = nil): Integer; override;
  end;

implementation

uses Essence, NotifyEvents, SysUtils, Provider, MyDataAccess,
  DBExpressDataAccess;

constructor TAdmissions.Create(AOwner: TComponent);
var
  Field: TStringField;
begin
  inherited;
  Provider.Options := Provider.Options + [poAutoRefresh];
  FCourceIDEducation := 8;
  Wrap.ImmediateCommit := True;
  SequenceName := 'cdb_dat_study_process.s_SPECIALITYEDUCATIONS_id';
  FSynonymFileName := 'AdmissionFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'se.ID_SpecialityEducation';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  with FSQLSelectOperator do
  begin
    Fields.Add('s.Speciality');
    Fields.Add('se.*');
    Fields.Add('s.*');
    Fields.Add('cse.*');
    Fields.Add('ss.*');    

    Tables.Add('SPECIALITYEDUCATIONS se');

    Joins.Add('JOIN specialitys s');
    Joins.WhereCondition.Add('se.IDSPECIALITY = s.id_speciality');

    Joins.Add('LEFT JOIN cyclespecialityeducations cse');
    Joins.WhereCondition.Add('cse.idspecialityeducation = se.id_specialityeducation');

    Joins.Add('LEFT JOIN specialitysessions ss');
    Joins.WhereCondition.Add('ss.idspecialityeducation = se.id_specialityeducation');

    WhereClause.Add(Format('IDEducation = %d', [FCourceIDEducation]));
    WhereClause.Add('se.year = 1990');  // искусственное условие

    OrderClause.Add('s.Speciality');
  end;

  FChairs := TChairs.Create(Self);
  FChairs.Refresh;

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию

  FSQLSelectOperator.WhereClause.Delete(1); // Удаляем искусственное условие

  { Добавляем дополнительное, подстановочное поле }
  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'Department';
    Size := 100;
    FieldKind := fkLookup;
    Name := DataSetWrap.DataSet.Name + FieldName;
    KeyFields := 'SPECIALITY_ACCESS';
    LookUpDataset := FChairs.DataSetWrap.DataSet;
    LookUpKeyFields := 'ID_Chair';
    LookUpResultField := 'Department';
    DataSet := DataSetWrap.DataSet;
  end;

  // Создаём параметр "год плана курсов"
  FYearParam := T_KParam.Create(Params, 'se.year');

  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
  TNotifyEventWrap.Create(DataSetWrap.AfterOpen, AfterOpen);  
  TNotifyEventWrap.Create(DataSetWrap.BeforeDelete , BeforeDelete);  
end;

destructor TAdmissions.Destroy;
begin
  inherited;
end;

procedure TAdmissions.AfterOpen(Sender: TObject);
begin
  DataSetWrap.SetFieldsRequired(False);
end;

procedure TAdmissions.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([]);

    FieldByName(KeyFieldName).ProviderFlags := [pfInKey, pfInUpdate];
    FieldByName('IDSpeciality').ProviderFlags := [pfInUpdate];
    FieldByName('IDEducation').ProviderFlags := [pfInUpdate];
    FieldByName('year').ProviderFlags := [pfInUpdate];
    FieldByName('mount_of_year').ProviderFlags := [pfInUpdate];
    FieldByName('data_').ProviderFlags := [pfInUpdate];
    FieldByName('IDStudyPlanStandart').ProviderFlags := [pfInUpdate];
  end;
end;

procedure TAdmissions.BeforeDelete(Sender: TObject);
var
  AMySQLQuery: TMySQLQuery;
begin
  // Перед удалением набора нужно попытаться удалить цикл дисциплин
  AMySQLQuery := TMySQLQuery.Create(Self, 0);
  try
    AMySQLQuery.SQL.Text :=
      Format('delete from CYCLESPECIALITYEDUCATIONS where IDSPECIALITYEDUCATION = %d', [Integer(PKValue)]);
    AMySQLQuery.ExecSQL();
  finally
    FreeAndNil(AMySQLQuery);
  end;
end;

procedure TAdmissions.Copy(ToYear: Integer);
var
  ASQLQuery: TMySQLQuery;
begin
  ASQLQuery := TMySQLQuery.Create(nil, 0);
  try
    // Копируем
    ASQLQuery.SQL.Text :=
      Format('BEGIN CDB_DAT_STUDY_PROCESS.StudyPlanPack.CopyStudyPlan(%d, %d); END;',
      [Field('ID_SpecialityEducation').AsInteger, ToYear]);
    ASQLQuery.ExecSQL(False);

    UseBookmark := True;
    RefreshDataSet;
  finally
    FreeAndNil(ASQLQuery);
  end;
end;

function TAdmissions.CreateClientDataSet: TKClientDataSetEx;
begin
  Result := TAdmissionClientDataSetEx.Create(Self, Provider);
end;

procedure TAdmissions.Drop;
begin
  DataSetWrap.DataSet.Delete;
end;

function TAdmissions.GetCurrIDChair: Integer;
begin
  Assert(DataSetWrap.DataSet.RecordCount > 0);
  Result := DataSetWrap.DataSet.FieldByName('IDChair').AsInteger;
end;

function TAdmissions.GetCurrIDCycle: Integer;
begin
  Assert(DataSetWrap.DataSet.RecordCount > 0);
  Result := DataSetWrap.DataSet.FieldByName('ID_CycleSpecialityEducation').AsInteger;
end;

function TAdmissions.GetCurrIDSpecialitySession: Integer;
begin
  Assert(DataSetWrap.DataSet.RecordCount > 0);
  Result := DataSetWrap.DataSet.FieldByName('ID_SpecialitySession').AsInteger;
end;

function TAdmissions.GetCurrYear: Integer;
begin
  Assert(DataSetWrap.DataSet.RecordCount > 0);
  Result := DataSetWrap.DataSet.FieldByName('year').AsInteger;
end;

procedure TAdmissions.New(AIDSpeciality: Integer);
var
  AMySQLQuery: TMySQLQuery;
begin
  with DataSetWrap.DataSet do
  begin
    if not (DataSetWrap.DataSet.State in [dsInsert, dsEdit]) then
      Insert;
    FieldByName('IDSpeciality').AsInteger := AIDSpeciality;
    FieldByName('IDEducation').AsInteger := FCourceIDEducation;
    FieldByName('year').AsInteger := YearParam.ParamValue;//(YearParam.CustomParam as TKParam).ParamValue;
    FieldByName('mount_of_year').AsInteger := 1;
    FieldByName('IDStudyPlanStandart').AsInteger := 3;
    try
      Post;
    except
      Cancel;
      raise;
    end;

    if FieldByName('ID_CYCLESPECIALITYEDUCATION').IsNull then
    begin
      // Если цикл не был добавлен в триггере, то добавляем цикл сами

      AMySQLQuery := TMySQLQuery.Create(Self, 0);
      try
        AMySQLQuery.SQL.Add(Format(
          'insert into cyclespecialityeducations (IDCycle, IDSpecialityeducation) ' +
          'values (0, %d)', [FieldByName('ID_SpecialityEducation').AsInteger]));
        AMySQLQuery.ExecSQL();
        
      finally
        FreeAndNil(AMySQLQuery);
      end;
    end;
  end;
  RefreshRecord;
end;

function TAdmissionClientDataSetEx.PSExecuteStatement(const ASQL: string;
  AParams: TParams; ResultSet: Pointer = nil): Integer;
begin
  Result := inherited PSExecuteStatement(ASQL, AParams, ResultSet);
end;


end.

