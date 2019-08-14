unit PreviousDisciplines;

interface

uses
  EssenceEx, System.Classes, K_Params, Data.DB;

type
  TCustomDisciplines = class(TEssenceEx2)
  private
    FIDDisciplineNameParam: T_KParam;
    FIDSpecialityParam: T_KParam;
    FTablePrefix: string;
    FYearParam: T_KParam;
    function GetDisciplineName: TField;
    function GetIDDisciplineName: TField;
    function GetIDCustomDisciplineName: TField; virtual; abstract;
    function GetIDSpeciality: TField;
    function GetYear: TField;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddDiscipline(AIDDisciplineNameList: TStringList);
    property DisciplineName: TField read GetDisciplineName;
    property IDDisciplineName: TField read GetIDDisciplineName;
    property IDDisciplineNameParam: T_KParam read FIDDisciplineNameParam;
    property IDCustomDisciplineName: TField read GetIDCustomDisciplineName;
    property IDSpeciality: TField read GetIDSpeciality;
    property IDSpecialityParam: T_KParam read FIDSpecialityParam;
    property Year: TField read GetYear;
    property YearParam: T_KParam read FYearParam;
  end;

  TSubsequentDisciplines = class(TCustomDisciplines)
  private
    function GetIDCustomDisciplineName: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TPreviousDisciplines = class(TCustomDisciplines)
  private
    function GetIDCustomDisciplineName: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses System.Variants, System.SysUtils;

constructor TCustomDisciplines.Create(AOwner: TComponent);
begin
  inherited;

  Assert(not FTablePrefix.IsEmpty);

  Wrap.ImmediateCommit := True;
  RefreshRecordAfterPost := True;


  FIDDisciplineNameParam := T_KParam.Create(Params,  Format('%s.IDDISCIPLINENAME', [FTablePrefix]) );
  FIDDisciplineNameParam.ParamName := 'IDDisciplineName';

  FYearParam := T_KParam.Create(Params, Format('%s.Year', [FTablePrefix]));
  FYearParam.ParamName := 'Year';

  FIDSpecialityParam := T_KParam.Create(Params, Format('%s.IDSpeciality', [FTablePrefix]));
  FIDSpecialityParam.ParamName := 'IDSpeciality';
end;

procedure TCustomDisciplines.AddDiscipline(AIDDisciplineNameList:
    TStringList);
var
  AIDDisciplineName: Integer;
  I: Integer;
  V: Variant;
begin
  Assert(not VarIsNull(YearParam.ParamValue));
  Assert(not VarIsNull(IDSpecialityParam.ParamValue));
  Assert(not VarIsNull(IDDisciplineNameParam.ParamValue));

  for I := 0 to AIDDisciplineNameList.Count - 1 do
  begin
    AIDDisciplineName := StrToIntDef(AIDDisciplineNameList[i], 0);
    if AIDDisciplineName = 0 then
      Continue;

    // Ищем такой софт
    V := DS.Lookup(IDCustomDisciplineName.FieldName, AIDDisciplineName, KeyFieldName);
    // если такого софта ещё нет
    if VarIsNull(V) then
    begin
      DS.Append;
      Year.AsInteger := YearParam.ParamValue;
      IDSpeciality.AsInteger := IDSpecialityParam.ParamValue;
      IDDisciplineName.AsInteger := IDDisciplineNameParam.ParamValue;
      IDCustomDisciplineName.AsInteger := AIDDisciplineName;
      DS.Post;
    end;
  end;
end;

function TCustomDisciplines.GetDisciplineName: TField;
begin
  Result := Field('DisciplineName');
end;

function TCustomDisciplines.GetIDDisciplineName: TField;
begin
  Result := Field('IDDisciplineName');
end;

function TCustomDisciplines.GetIDSpeciality: TField;
begin
  Result := Field('IDSpeciality');
end;

function TCustomDisciplines.GetYear: TField;
begin
  Result := Field('Year');
end;

constructor TSubsequentDisciplines.Create(AOwner: TComponent);
begin
  FTablePrefix := 'sd';
  inherited;

  FSynonymFileName := 'SubsequentDisciplineFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'sd.ID_SubsequentDiscipline';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;


  SequenceName := 'cdb_dat_study_process.SubsequentDISCIPLINES_SEQ';

  with FSQLSelectOperator do
  begin
    Fields.Add('sd.*');
    Fields.Add('DN.DISCIPLINENAME');

    Tables.Add('SUBSEQUENTDISCIPLINES sd');

    Joins.Add('join disciplinenames dn');
    Joins.WhereCondition.Add('sd.idsubsequentdisciplinename = DN.ID_DISCIPLINENAME');

    OrderClause.Add('DN.DISCIPLINENAME');
  end;

  UpdatingTableName := 'SUBSEQUENTDISCIPLINES';
  UpdatingFieldNames.Add('Year');
  UpdatingFieldNames.Add('IDSpeciality');
  UpdatingFieldNames.Add('IDDisciplineName');
  UpdatingFieldNames.Add('IDSubsequentDisciplineName');
end;

function TSubsequentDisciplines.GetIDCustomDisciplineName: TField;
begin
  Result := Field('IDSubsequentDisciplineName');
end;

constructor TPreviousDisciplines.Create(AOwner: TComponent);
begin
  FTablePrefix := 'pd';

  inherited;

  FSynonymFileName := 'PreviousDisciplineFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'pd.ID_PreviousDisciplines';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  SequenceName := 'cdb_dat_study_process.PREVIOUSDISCIPLINES_SEQ';

  Wrap.ImmediateCommit := True;
  RefreshRecordAfterPost := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('pd.*');
    Fields.Add('DN.DISCIPLINENAME');

    Tables.Add('PREVIOUSDISCIPLINES pd');

    Joins.Add('join disciplinenames dn');
    Joins.WhereCondition.Add('pd.idpreviousdisciplinename = DN.ID_DISCIPLINENAME');

    OrderClause.Add('DN.DISCIPLINENAME');

  end;

  UpdatingTableName := 'PREVIOUSDISCIPLINES';
  UpdatingFieldNames.Add('Year');
  UpdatingFieldNames.Add('IDSpeciality');
  UpdatingFieldNames.Add('IDDisciplineName');
  UpdatingFieldNames.Add('IDPreviousDisciplineName');
end;

function TPreviousDisciplines.GetIDCustomDisciplineName: TField;
begin
  Result := Field('IDPreviousDisciplineName');
end;

end.
