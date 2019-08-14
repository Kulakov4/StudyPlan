unit Technologies;

interface

uses
  EssenceEx, Data.DB, System.Classes, ETPCatalog;

type
  TTechnologies = class(TETPCatalog)
  private
    function GetTechnology: TField;
  protected
    function GetValue: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DropUnused; override;
    property Technology: TField read GetTechnology;
  end;

implementation

uses MyDataAccess;

constructor TTechnologies.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'TechnologyFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 't.ID_Technology';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.TECHNOLOGIES_SEQ';

  with FSQLSelectOperator do
  begin
    Fields.Add('t.*');

    Tables.Add('TECHNOLOGIES t');

    OrderClause.Add('T.TECHNOLOGY');
  end;

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;
  UpdatingTableName := 'TECHNOLOGIES';
end;

procedure TTechnologies.DropUnused;
var
  AMySQLQuery: TMySQLQuery;
begin
  AMySQLQuery := TMySQLQuery.Create(Self, 0);
  try
    AMySQLQuery.SQL.Add('DELETE FROM TECHNOLOGIES');
    AMySQLQuery.SQL.Add('WHERE ID_TECHNOLOGY IN');
    AMySQLQuery.SQL.Add('(');
    AMySQLQuery.SQL.Add('	   SELECT t.ID_TECHNOLOGY');
    AMySQLQuery.SQL.Add('    FROM TECHNOLOGIES t');
    AMySQLQuery.SQL.Add('    WHERE');
    AMySQLQuery.SQL.Add('		   NVL (t.ISDefault, 0) <> 1');
    AMySQLQuery.SQL.Add('      AND NOT EXISTS');
    AMySQLQuery.SQL.Add('      (');
    AMySQLQuery.SQL.Add('		       SELECT thut.*');
    AMySQLQuery.SQL.Add('          FROM ThemeUnionTECHNOLOGIES thut');
    AMySQLQuery.SQL.Add('          WHERE thut.IDTECHNOLOGY =');
    AMySQLQuery.SQL.Add('          t.ID_TECHNOLOGY');
    AMySQLQuery.SQL.Add('		   )');
    AMySQLQuery.SQL.Add(')');

    AMySQLQuery.ExecSQL();
  finally
    AMySQLQuery.Free;
  end;
end;

function TTechnologies.GetTechnology: TField;
begin
  Result := Field('Technology');
end;

function TTechnologies.GetValue: TField;
begin
  Result := Technology;
end;

end.
