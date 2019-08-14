unit THEMEUNIONTECHNOLOGIES;

interface

uses
  EssenceEx, Datasnap.DBClient, K_Params, System.Classes, ThemeUnionDetails,
  Data.DB;

type
  TTHEMEUNIONTECHNOLOGIES = class(TThemeUnionDetails)
  private
  protected
    procedure CreateIndex; override;
    function GetValue: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    function ToString(AIDThemeUnion: Integer): string; reintroduce;
  end;

implementation

uses
  System.Sysutils, KDBClient, DBRecordHolder;

constructor TTHEMEUNIONTECHNOLOGIES.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'ThemeUnionTechnologyField.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName :=
    'thut.ID_ThemeUnionTechnology';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.THEMEUNIONTECHNOLOGIES_SEQ';

  with FSQLSelectOperator do
  begin
    Distinct := True;

    Fields.Add('thut.*');
    Fields.Add('t.Technology');

    Tables.Add('disciplines d');

    Joins.Add('join LessonThemeHours lthh');
    Joins.WhereCondition.Add('lthh.IDDiscipline = d.id_discipline');

    Joins.Add('join lessonThemes lth');
    Joins.WhereCondition.Add('lthh.IDLessonTheme = lth.ID_LessonTheme');

    Joins.Add('join ThemeUnions thu');
    Joins.WhereCondition.Add('LTH.IDTHEMEUNION = THU.ID_THEMEUNION');

    Joins.Add('JOIN themeunionTechnologies thut');
    Joins.WhereCondition.Add('thut.IDThemeUnion = THU.ID_THEMEUNION');

    Joins.Add('JOIN technologies t');
    Joins.WhereCondition.Add('thut.IDTechnology = t.ID_Technology');
  end;

  FIDDisciplineParam := T_KParam.Create(Params, 'd.ID_Discipline');
  FIDDisciplineParam.ParamName := 'ID_Discipline';

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;
  UpdatingTableName := 'themeunionTechnologies';
  UpdatingFieldNames.Add('IDThemeUnion');
  UpdatingFieldNames.Add('IDTechnology');
end;

procedure TTHEMEUNIONTECHNOLOGIES.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1', 'IDTHEMEUNION;ID_THEMEUNIONTECHNOLOGY', []);
  ClientDataSet.IndexName := 'idx1';
end;

function TTHEMEUNIONTECHNOLOGIES.GetValue: TField;
begin
  Result := Field('IDTechnology');
end;

function TTHEMEUNIONTECHNOLOGIES.ToString(AIDThemeUnion: Integer): string;
var
  AClone: TKClientDataSet;
begin
  AClone := TKClientDataSet.Create(Self);
  try
    AClone.CloneCursor(ClientDataSet, True);
    AClone.Filter := GetFilterExpression(AIDThemeUnion);
    AClone.Filtered := True;
    Result := AClone.Wrap.GetColumnValues('Technology').ToLower;
  finally
    AClone.Free;
  end;
end;

end.
