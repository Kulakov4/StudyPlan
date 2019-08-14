unit ThemeUnionLessonFeatures;

interface

uses
  EssenceEx, Datasnap.DBClient, K_Params, System.Classes, ThemeUnionDetails,
  Data.DB;

type
  TThemeUnionLessonTheatures = class(TThemeUnionDetails)
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

constructor TThemeUnionLessonTheatures.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'ThemeUnionLessonFeatureField.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'thulf.ID_ThemeUnionLessonFeature';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.THEMEUNIONLESSONFEATURES_SEQ';

  with FSQLSelectOperator do
  begin
    Distinct := True;

    Fields.Add('thulf.*');
    Fields.Add('lf.LessonFeature');

    Tables.Add('disciplines d');

    Joins.Add('join LessonThemeHours lthh');
    Joins.WhereCondition.Add('lthh.IDDiscipline = d.id_discipline');

    Joins.Add('join lessonThemes lth');
    Joins.WhereCondition.Add('lthh.IDLessonTheme = lth.ID_LessonTheme');

    Joins.Add('join ThemeUnions thu');
    Joins.WhereCondition.Add('LTH.IDTHEMEUNION = THU.ID_THEMEUNION');

    Joins.Add('JOIN themeunionlessonfeatures thulf');
    Joins.WhereCondition.Add('thulf.IDThemeUnion = THU.ID_THEMEUNION');

    Joins.Add('JOIN LessonFeatures lf');
    Joins.WhereCondition.Add('thulf.IDLessonFeature = lf.ID_LessonFeature');
  end;

  FIDDisciplineParam := T_KParam.Create(Params, 'd.ID_Discipline');
  FIDDisciplineParam.ParamName := 'ID_Discipline';

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;
  UpdatingTableName := 'themeunionlessonfeatures';
  UpdatingFieldNames.Add('IDThemeUnion');
  UpdatingFieldNames.Add('IDLessonFeature');
end;

procedure TThemeUnionLessonTheatures.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1', 'IDTHEMEUNION;ID_THEMEUNIONLESSONFEATURE', []);
  ClientDataSet.IndexName := 'idx1';
end;

function TThemeUnionLessonTheatures.GetValue: TField;
begin
  Result := Field('IDLessonFeature');
end;

function TThemeUnionLessonTheatures.ToString(AIDThemeUnion: Integer): string;
var
  AClone: TKClientDataSet;
begin
  AClone := TKClientDataSet.Create(Self);
  try
    AClone.CloneCursor(ClientDataSet, True);
    AClone.Filter := GetFilterExpression(AIDThemeUnion);
    AClone.Filtered := True;
    Result := AClone.Wrap.GetColumnValues('LessonFeature').ToLower;
  finally
    AClone.Free;
  end;
end;

end.
