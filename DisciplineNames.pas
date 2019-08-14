unit DisciplineNames;

interface

uses EssenceEx, Chairs, System.Classes;

type
  TDisciplineNames = class(TEssenceEx2)
  private
    FChairs: TChairs;
  protected
    procedure AfterQueryOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TDisciplineNamesForStudyPlans = class(TDisciplineNames)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Essence, SQLTools, NotifyEvents, DB;

constructor TDisciplineNames.Create(AOwner: TComponent);
var
  Field: TField;
begin
  inherited;

  FSynonymFileName := 'DisciplineNamesFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'dn.ID_DISCIPLINENAME';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;
  SequenceName := 'cdb_com_directories.S_DISCIPLINES_ID';

  with FSQLSelectOperator do
  begin
    Fields.Add('dn.ID_DISCIPLINENAME');
    Fields.Add('dn.DISCIPLINENAME');
    Fields.Add('dn.SHORTDISCIPLINENAME');
    Fields.Add('dn.IDCHAR');
    Fields.Add('dn.type_discipline');
//    Fields.Add('round(dn.rate, 6) rate');

    Tables.Add('DISCIPLINENAMES DN');

    WhereClause.Add('TYPE_DISCIPLINE in (1, 2, 4)');

    OrderClause.Add('dn.disciplinename');
  end;
  Wrap.ImmediateCommit := True;
  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);

  FChairs := TChairs.Create(Self);  // Запрос выбирающий кафедры

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
    KeyFields := 'IDChar';
    LookUpDataset := FChairs.DataSetWrap.DataSet;
    LookUpKeyFields := 'ID_Chair';
    LookUpResultField := 'Department';
    DataSet := DataSetWrap.DataSet;
  end;
end;

procedure TDisciplineNames.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([pfInUpdate]);  // Все поля будут обновляться

    // Обозначаем ключевое поле
    FieldByName(KeyFieldName).ProviderFlags := [pfInKey, pfInUpdate];
  end;
end;

constructor TDisciplineNamesForStudyPlans.Create(AOwner: TComponent);
begin
  inherited;

  with FSQLSelectOperator do
  begin
    WhereClause.Add('(dn.idparent = DN.ID_DISCIPLINENAME or DN.IDPARENT is null)');
  end;
end;

end.
