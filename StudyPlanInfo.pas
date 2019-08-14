unit StudyPlanInfo;

interface

uses
  Data.DB, EssenceEx, K_Params, System.Classes, System.Generics.Collections;

type
  TStudyPlanInfo = class(TEssenceEx2)
  private
    FFieldNames: TList<String>;
    FIDDisciplineParam: T_KParam;
    FTableName: string;
    function GetDisciplineName: TField;
    function GetShortDisciplineName: TField;
    function GetIDChair: TField;
    function GetIDDisciplineName: TField;
    function GetIDSpeciality: TField;
    function GetSPIDDisciplineName: TField;
    procedure GetTableName(Sender: TObject; DataSet: TDataSet; var TableName:
        string);
    function GetYear: TField;
  protected
    procedure AfterMySQLQueryOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DisciplineName: TField read GetDisciplineName;
    property ShortDisciplineName: TField read GetShortDisciplineName;
    property IDChair: TField read GetIDChair;
    property IDDisciplineName: TField read GetIDDisciplineName;
    property IDDisciplineParam: T_KParam read FIDDisciplineParam;
    property IDSpeciality: TField read GetIDSpeciality;
    property SPIDDisciplineName: TField read GetSPIDDisciplineName;
    property Year: TField read GetYear;
  end;

  TStudyPlanInfo2 = class(TEssenceEx2)
  private
    FIDDisciplineParam: T_KParam;
    function GetUMK: TField;
  public
    constructor Create(AOwner: TComponent); override;
    property IDDisciplineParam: T_KParam read FIDDisciplineParam;
    property UMK: TField read GetUMK;
  end;


implementation

uses NotifyEvents, Sysutils;

constructor TStudyPlanInfo.Create(AOwner: TComponent);
begin
  inherited;
  FFieldNames := TList<String>.Create;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'D.ID_Discipline';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('D.ID_Discipline');
    Fields.Add('SP.ID_STUDYPLAN');
    Fields.Add('SE.YEAR');
    Fields.Add('SE.IDSPECIALITY');
    Fields.Add('d.iddisciplinename');
    Fields.Add('sp.iddisciplinename spiddisciplinename');
    Fields.Add('d.Purpose');
    Fields.Add('d.Task');
    Fields.Add('DN.DISCIPLINENAME');
    Fields.Add('nvl(shortdisciplinename, disciplinename) shortdisciplinename');
    Fields.Add('sp.idchair');

    Tables.Add('disciplines d');

    Joins.Add('join studyplans sp');
    Joins.WhereCondition.Add('D.IDSTUDYPLAN = SP.ID_STUDYPLAN');

    Joins.Add('join cyclespecialityeducations cse');
    Joins.WhereCondition.Add
      ('SP.IDCYCLESPECIALITYEDUCATION = CSE.ID_CYCLESPECIALITYEDUCATION');

    Joins.Add('join specialityeducations se');
    Joins.WhereCondition.Add
      ('cse.idspecialityeducation = SE.ID_SPECIALITYEDUCATION');

    Joins.Add('join disciplinenames dn');
    Joins.WhereCondition.Add('D.IDDisciplineName = dn.ID_DisciplineName');

    // OrderClause.Add('ss.level_');
    // OrderClause.Add('ss.session_in_level');
  end;
  FIDDisciplineParam := T_KParam.Create(Params, 'd.ID_Discipline');
  FIDDisciplineParam.ParamName := 'ID_Discipline';

  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterMySQLQueryOpen);

  Wrap.ImmediateCommit := True;
  KeyFieldProviderFlags := [pfInKey, pfInUpdate];
  Provider.OnGetTableName := GetTableName;

  // “аблица, котора€ будет редактироватьс€
  FTableName := 'disciplines'.ToUpper;
  FFieldNames.Add('Purpose'.ToUpper);
  FFieldNames.Add('Task'.ToUpper);
  // Ѕудем сразу-же сохран€ть
  Wrap.ImmediateCommit := True;
end;

destructor TStudyPlanInfo.Destroy;
begin
  FreeAndNil(FFieldNames);
  inherited;
end;

procedure TStudyPlanInfo.AfterMySQLQueryOpen(Sender: TObject);
var
  I: Integer;
begin

  for I := 0 to MySQLQuery.FieldCount - 1 do
  begin
    if FFieldNames.IndexOf(MySQLQuery.Fields[I].FieldName.ToUpper) >= 0 then
      // Ёто поле будем обновл€ть
      MySQLQuery.Fields[I].ProviderFlags := [pfInUpdate]
    else if MySQLQuery.Fields[I].FieldName.ToUpper = Wrap.MultiSelectDSWrap.
      KeyFieldName.ToUpper then
      // Ёто поле ключевое, его тоже будем обновл€ть
      MySQLQuery.Fields[I].ProviderFlags := [pfInKey, pfInUpdate]
    else
    begin
      MySQLQuery.Fields[I].ProviderFlags := []; // Ёто поле не будем обновл€ть
    end;
  end;

end;

function TStudyPlanInfo.GetDisciplineName: TField;
begin
  Result := Field('DisciplineName');
end;

function TStudyPlanInfo.GetShortDisciplineName: TField;
begin
  Result := Field('ShortDisciplineName');
end;

function TStudyPlanInfo.GetIDChair: TField;
begin
  Result := Field('IDChair');
end;

function TStudyPlanInfo.GetIDDisciplineName: TField;
begin
  Result := Field('IDDisciplineName');
end;

function TStudyPlanInfo.GetIDSpeciality: TField;
begin
  Result := Field('IDSpeciality');
end;

function TStudyPlanInfo.GetSPIDDisciplineName: TField;
begin
  Result := Field('SPIDDisciplineName');
end;

procedure TStudyPlanInfo.GetTableName(Sender: TObject; DataSet: TDataSet; var
    TableName: string);
begin
  Assert(FTableName <> '');
  TableName := FTableName;
end;

function TStudyPlanInfo.GetYear: TField;
begin
  Result := Field('Year');
end;

constructor TStudyPlanInfo2.Create(AOwner: TComponent);
begin
  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'D.ID_Discipline';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('D.ID_Discipline');
    Fields.Add('nvl(ed.UMK, ed.Short_department) UMK');

    Tables.Add('disciplines d');

    Joins.Add('join studyplans sp');
    Joins.WhereCondition.Add('D.IDSTUDYPLAN = SP.ID_STUDYPLAN');

    Joins.Add('join cyclespecialityeducations cse');
    Joins.WhereCondition.Add
      ('SP.IDCYCLESPECIALITYEDUCATION = CSE.ID_CYCLESPECIALITYEDUCATION');

    Joins.Add('join specialityeducations se');
    Joins.WhereCondition.Add
      ('cse.idspecialityeducation = SE.ID_SPECIALITYEDUCATION');

    Joins.Add('join educations ed');
    Joins.WhereCondition.Add
      ('se.ideducation = ed.id_education');

  end;
  FIDDisciplineParam := T_KParam.Create(Params, 'd.ID_Discipline');
  FIDDisciplineParam.ParamName := 'ID_Discipline';
end;

function TStudyPlanInfo2.GetUMK: TField;
begin
  Result := Field('UMK');
end;

end.
