unit DPODisciplineNames;

interface

uses classes, CourcesNames, EssenceEx, Chairs, Contnrs;

type
  TDPODisciplineNames = class(TEssenceEx2)
  private
    FChairs: TChairs;
    FIDChar: Integer;
    FTypeDiscipline: Integer;
  protected
    procedure AfterInsert(Sender: TObject);
    procedure AfterQueryOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; AIDChar: Integer); reintroduce;
    destructor Destroy; override;
  end;

implementation

uses Essence, SysUtils, DB, NotifyEvents;

constructor TDPODisciplineNames.Create(AOwner: TComponent; AIDChar: Integer);
var
  Field: TStringField;
begin
  inherited Create(AOwner);

  Assert(AIDChar > 0);
  FIDChar := AIDChar;

  FTypeDiscipline := 3; // Все дисциплины курсов имеют код 3

  Wrap.ImmediateCommit := True;
  SequenceName := 'cdb_com_directories.S_DISCIPLINES_ID';

  FSynonymFileName := 'DisciplineNameFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'dn.ID_DISCIPLINENAME';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  with FSQLSelectOperator do
  begin
    Fields.Add('dn.id_disciplinename');
    Fields.Add('dn.idparent');
    Fields.Add('dn.disciplinename');
    Fields.Add('dn.shortdisciplinename');
    Fields.Add('dn.idchar');
    Fields.Add('dn.Type_Discipline');

    Tables.Add('DISCIPLINENAMES dn');

    WhereClause.Add(Format('dn.Type_Discipline = %d', [FTypeDiscipline]));

    OrderClause.Add('dn.DisciplineName');
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
    KeyFields := 'IDChar';
    LookUpDataset := FChairs.DataSetWrap.DataSet;
    LookUpKeyFields := 'ID_Chair';
    LookUpResultField := 'Department';
    DataSet := DataSetWrap.DataSet;
  end;

  // Подписываемся на событие после добавления записи
  TNotifyEventWrap.Create(DataSetWrap.AfterInsert, AfterInsert);
  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
end;

destructor TDPODisciplineNames.Destroy;
begin
  inherited;
end;

procedure TDPODisciplineNames.AfterInsert(Sender: TObject);
begin
  // Заполняем код кафедры значением по умолчанию
  DataSetWrap.DataSet.FieldByName('IDChar').AsInteger := FIDChar;
  // Заполняем поле тип дисциплины
  DataSetWrap.DataSet.FieldByName('Type_discipline').AsInteger := FTypeDiscipline;
end;

procedure TDPODisciplineNames.AfterQueryOpen(Sender: TObject);
var
  i: Integer;
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([]);

    for i := 0 to FieldCount - 1 do
    begin
      if AnsiSameText(Fields[i].FieldName, KeyFieldName) then
        Fields[i].ProviderFlags := [pfInKey, pfInUpdate]
      else
        Fields[i].ProviderFlags := [pfInUpdate];
    end;
  end;
end;


end.

