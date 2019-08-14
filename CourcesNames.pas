unit CourcesNames;

interface

uses EssenceEx, classes, Sequence, Chairs;

type
  TCourceNames = class(TEssenceEx2)
  private
    FChairs: TChairs;
  protected
    procedure AfterQueryOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;
implementation

uses PersistentSequence, DB, SQLTools, NotifyEvents;

constructor TCourceNames.Create(AOwner: TComponent);
var
  Field: TStringField;
begin
  inherited;

  Wrap.ImmediateCommit := True;
  SequenceName := 'cdb_com_directories.s_specialitys_id';

  FSynonymFileName := 'CourceFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 's.ID_Speciality';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  with FSQLSelectOperator do
  begin
    Fields.Add('s.*');

    Tables.Add('SPECIALITYS s');

    WhereClause.Add('CHIPER_SPECIALITY is null');

    OrderClause.Add('s.Speciality');
  end;

  FChairs := TChairs.Create(Self);
  FChairs.Refresh;

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию

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

  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);  
end;

procedure TCourceNames.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([]);

    FieldByName(KeyFieldName).ProviderFlags := [pfInKey, pfInUpdate];
    FieldByName('Speciality').ProviderFlags := [pfInUpdate];
    FieldByName('SHORT_SPECIALITY').ProviderFlags := [pfInUpdate];
    FieldByName('SPECIALITY_ACCESS').ProviderFlags := [pfInUpdate];
//    FieldByName('mount_of_year').ProviderFlags := [pfInUpdate];
  end;
end;

end.

