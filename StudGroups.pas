unit StudGroups;

interface

uses EssenceEx, classes, K_Params, DB;

type
  TStudGroups = class(TEssenceEx2)
  private
    FAdmissionParam: T_KParam;
    procedure OnGetTableName(Sender: TObject; DataSet: TDataSet;
    var TableName: {$ifdef VER230}WideString{$else}String{$endif});
  protected
    procedure AfterInsert(Sender: TObject);
    procedure AfterPost(Sender: TObject);
    procedure AfterQueryOpen(Sender: TObject);
    procedure BeforeDelete(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property AdmissionParam: T_KParam read FAdmissionParam;
  end;

implementation

uses NotifyEvents, Admissions, MydataAccess, DataSetWrap, SysUtils;

constructor TStudGroups.Create(AOwner: TComponent);
begin
  inherited;

  Wrap.ImmediateCommit := True;
  SequenceName := 'cdb_com_directories.SEC_STUDENT_GROUPS_ID';

  FSynonymFileName := 'StudGroupFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'sg.ID';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  with FSQLSelectOperator do
  begin
    Distinct := True;
    
    Fields.Add('sg.*');

    Tables.Add('STUDENTS_GROUPS sg');

    OrderClause.Add('sg.name');
  end;
  // Создаём параметр "Код набора"
  FAdmissionParam := T_KParam.Create(Params, 'st.Admission_ID');
  FAdmissionParam.Joins.Add('join CDB_DAT_STUDENTS.t_students st');
  FAdmissionParam.Joins.WhereCondition.Add('ST.GROUP_ID = SG.ID');

  Provider.OnGetTableName := OnGetTableName;

  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
  TNotifyEventWrap.Create(DataSetWrap.AfterInsert, AfterInsert);
  TNotifyEventWrap.Create(DataSetWrap.AfterPost, AfterPost);
  TNotifyEventWrap.Create(DataSetWrap.BeforeDelete, BeforeDelete);    
end;

procedure TStudGroups.AfterInsert(Sender: TObject);
var
  AAdmissions: TAdmissions;
begin
  if FAdmissionParam.Master <> nil then
  begin
    // Заполняем поле год поступления

    AAdmissions := FAdmissionParam.Master as TAdmissions;

//    DataSetWrap.DataSet.FieldByName('Spec').Value := AAdmissions.PKValue;

    DataSetWrap.DataSet.FieldByName('Start_year').AsInteger := AAdmissions.CurrYear;
  end;
end;

procedure TStudGroups.AfterPost(Sender: TObject);
var
  ASQLQuery: TMySQLQuery;
begin
  // Если была добавлена новая группа, то нужно добавить в неё одного виртуального студента
  if DataSetWrap.LastDataSetOperation = ldsoInsert then
  begin
    Assert(FAdmissionParam.Master <> nil);
  
    ASQLQuery := TMySQLQuery.Create(Self, 0);
    try
      ASQLQuery.SQL.Text := Format('begin CDB_DAT_STUDENTS.CREATEVIRTUALCOURSIST ( %d, %d ); end;',
        [Integer(PKValue), Integer(FAdmissionParam.Master.PKValue)]);
      ASQLQuery.ExecSQL();
    finally
      FreeAndNil(ASQLQuery);
    end;

  end;
end;

procedure TStudGroups.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([pfInUpdate]);
    FieldByName(KeyFieldName).ProviderFlags := [pfInKey, pfInUpdate];
  end;
end;

procedure TStudGroups.BeforeDelete(Sender: TObject);
var
  ASQLQuery: TMySQLQuery;
begin
    ASQLQuery := TMySQLQuery.Create(Self, 0);
    try
      ASQLQuery.SQL.Text := Format('begin CDB_DAT_STUDENTS.DROPVIRTUALCOURSIST( %d ); end;', [Integer(PKValue)]);
      ASQLQuery.ExecSQL();
    finally
      FreeAndNil(ASQLQuery);
    end;
end;

procedure TStudGroups.OnGetTableName(Sender: TObject; DataSet: TDataSet; var
    TableName: {$ifdef VER230}WideString{$else}String{$endif});
begin
  TableName := 'STUDENTS_GROUPS';
end;

end.

