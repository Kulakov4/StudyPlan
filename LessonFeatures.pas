unit LessonFeatures;

interface

uses
  EssenceEx, Data.DB, System.Classes, ETPCatalog;

type
  TLessonFeatures = class(TETPCatalog)
  private
    function GetLessonFeature: TField;
  protected
    function GetValue: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DropUnused; override;
    property LessonFeature: TField read GetLessonFeature;
  end;

implementation

uses MyDataAccess;

constructor TLessonFeatures.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'LessonFeatureFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'lf.ID_LessonFeature';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.LESSONFEATURE_SEQ';

  with FSQLSelectOperator do
  begin
    Fields.Add('lf.*');

    Tables.Add('LessonFeatures lf');

    OrderClause.Add('lf.LessonFeature');
  end;

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;
  UpdatingTableName := 'LessonFeatures';
end;

procedure TLessonFeatures.DropUnused;
var
  AMySQLQuery: TMySQLQuery;
begin
  AMySQLQuery := TMySQLQuery.Create(Self, 0);
  try
    AMySQLQuery.SQL.Add('DELETE FROM LessonFeatures');
    AMySQLQuery.SQL.Add('WHERE ID_LessonFeature IN');
    AMySQLQuery.SQL.Add('(');
    AMySQLQuery.SQL.Add('	   SELECT lf.ID_LessonFeature');
    AMySQLQuery.SQL.Add('    FROM LessonFeatures lf');
    AMySQLQuery.SQL.Add('    WHERE');
    AMySQLQuery.SQL.Add('		   NVL (lf.ISDefault, 0) <> 1');
    AMySQLQuery.SQL.Add('      AND NOT EXISTS');
    AMySQLQuery.SQL.Add('      (');
    AMySQLQuery.SQL.Add('		       SELECT thulf.*');
    AMySQLQuery.SQL.Add('          FROM ThemeUnionLessonFeatures thulf');
    AMySQLQuery.SQL.Add('          WHERE thulf.IDLessonFeature =');
    AMySQLQuery.SQL.Add('          lf.ID_LessonFeature');
    AMySQLQuery.SQL.Add('		   )');
    AMySQLQuery.SQL.Add(')');

    AMySQLQuery.ExecSQL();
  finally
    AMySQLQuery.Free;
  end;
end;

function TLessonFeatures.GetLessonFeature: TField;
begin
  Result := Field('LessonFeature');
end;

function TLessonFeatures.GetValue: TField;
begin
  Result := LessonFeature;
end;

end.
