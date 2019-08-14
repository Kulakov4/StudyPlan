unit ThemeUnionEducationalWorks;

interface

uses
  EssenceEx, System.Classes, K_Params, Datasnap.DBClient, ThemeUnionDetails,
  Data.DB;

type
  TThemeUnionEducationalWorks = class(TThemeUnionDetails)
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
  System.Sysutils, KDBClient;

constructor TThemeUnionEducationalWorks.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'ThemeUnionEducationalWorkField.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'thuew.ID_ThemeUnionEducationalWork';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.THEMEUNIONEDUCATIONALWORKS_SEQ';

  with FSQLSelectOperator do
  begin
    Distinct := True;

    Fields.Add('thuew.*');
    Fields.Add('ew.EducationalWork');

    Tables.Add('disciplines d');

    Joins.Add('join LessonThemeHours lthh');
    Joins.WhereCondition.Add('lthh.IDDiscipline = d.id_discipline');

    Joins.Add('join lessonThemes lth');
    Joins.WhereCondition.Add('lthh.IDLessonTheme = lth.ID_LessonTheme');

    Joins.Add('join ThemeUnions thu');
    Joins.WhereCondition.Add('LTH.IDTHEMEUNION = THU.ID_THEMEUNION');

    Joins.Add('JOIN ThemeUnionEducationalWorks thuew');
    Joins.WhereCondition.Add('thuew.IDThemeUnion = THU.ID_THEMEUNION');

    Joins.Add('JOIN EducationalWorks ew');
    Joins.WhereCondition.Add('thuew.IDEducationalWork = ew.ID_EducationalWork');
  end;

  FIDDisciplineParam := T_KParam.Create(Params, 'd.ID_Discipline');
  FIDDisciplineParam.ParamName := 'ID_Discipline';

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;
  UpdatingTableName := 'ThemeUnionEducationalWorks';
  UpdatingFieldNames.Add('IDThemeUnion');
  UpdatingFieldNames.Add('IDEducationalWork');
end;

procedure TThemeUnionEducationalWorks.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1', 'IDTHEMEUNION;ID_THEMEUNIONEDUCATIONALWORK', []);
  ClientDataSet.IndexName := 'idx1';
end;

function TThemeUnionEducationalWorks.GetValue: TField;
begin
  Result := Field('IDEducationalWork');
end;

function TThemeUnionEducationalWorks.ToString(AIDThemeUnion: Integer): string;
var
  AClone: TKClientDataSet;
begin
  AClone := TKClientDataSet.Create(Self);
  try
    AClone.CloneCursor(ClientDataSet, True);
    AClone.Filter := GetFilterExpression(AIDThemeUnion);
    AClone.Filtered := True;
    Result := AClone.Wrap.GetColumnValues('EducationalWork').ToLower;
  finally
    AClone.Free;
  end;
end;

end.
