unit ThemeUnionIndependentWork;

interface

uses
  EssenceEx, System.Classes, K_Params, Datasnap.DBClient, ThemeUnionDetails,
  Data.DB;

type
  TThemeUnionIndependentWork = class(TThemeUnionDetails)
  private
  protected
    procedure CreateIndex; override;
    function GetValue: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    function ToString(AIDThemeUnion: Integer): string; reintroduce;
  end;

implementation

uses System.SysUtils, KDBClient;

constructor TThemeUnionIndependentWork.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'ThemeUnionIndependentWorkField.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'thuiw.ID_ThemeUnionIndependentWork';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.THEMEUNIONINDEPENDENTWORK_SEQ';

  with FSQLSelectOperator do
  begin
    Distinct := True;

    Fields.Add('thuiw.*');
    Fields.Add('iw.IndependentWork');

    Tables.Add('disciplines d');

    Joins.Add('join LessonThemeHours lthh');
    Joins.WhereCondition.Add('lthh.IDDiscipline = d.id_discipline');

    Joins.Add('join lessonThemes lth');
    Joins.WhereCondition.Add('lthh.IDLessonTheme = lth.ID_LessonTheme');

    Joins.Add('join ThemeUnions thu');
    Joins.WhereCondition.Add('LTH.IDTHEMEUNION = THU.ID_THEMEUNION');

    Joins.Add('JOIN ThemeUnionIndependentWork thuiw');
    Joins.WhereCondition.Add('thuiw.IDThemeUnion = THU.ID_THEMEUNION');

    Joins.Add('JOIN IndependentWork iw');
    Joins.WhereCondition.Add('thuiw.IDIndependentWork = iw.ID_IndependentWork');
  end;

  FIDDisciplineParam := T_KParam.Create(Params, 'd.ID_Discipline');
  FIDDisciplineParam.ParamName := 'ID_Discipline';

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;
  UpdatingTableName := 'ThemeUnionIndependentWork';
  UpdatingFieldNames.Add('IDThemeUnion');
  UpdatingFieldNames.Add('IDIndependentWork');
end;

procedure TThemeUnionIndependentWork.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1', 'IDTHEMEUNION;ID_THEMEUNIONINDEPENDENTWORK', []);
  ClientDataSet.IndexName := 'idx1';
end;

function TThemeUnionIndependentWork.GetValue: TField;
begin
  Result := Field('IDIndependentWork');
end;

function TThemeUnionIndependentWork.ToString(AIDThemeUnion: Integer): string;
var
  AClone: TKClientDataSet;
begin
  AClone := TKClientDataSet.Create(Self);
  try
    AClone.CloneCursor(ClientDataSet, True);
    AClone.Filter := GetFilterExpression(AIDThemeUnion);
    AClone.Filtered := True;
    Result := AClone.Wrap.GetColumnValues('IndependentWork').ToLower;
  finally
    AClone.Free;
  end;
end;

end.
