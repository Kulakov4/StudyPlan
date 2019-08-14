unit EducationalWorks;

interface

uses
  EssenceEx, System.Classes, Data.DB, ETPCatalog;

type
  TEducationalWorks = class(TETPCatalog)

  private
    function GetEducationalWork: TField;
  protected
    function GetValue: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DropUnused; override;
    property EducationalWork: TField read GetEducationalWork;
  end;

implementation

uses MyDataAccess;

constructor TEducationalWorks.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'EducationalWorkFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'ew.ID_EducationalWork';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.EDUCATIONALWORKS_SEQ';

  with FSQLSelectOperator do
  begin
    Fields.Add('ew.*');

    Tables.Add('EDUCATIONALWORKS ew');

    OrderClause.Add('ew.EducationalWork');
  end;

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;
  UpdatingTableName := 'EDUCATIONALWORKS';
end;

procedure TEducationalWorks.DropUnused;
var
  AMySQLQuery: TMySQLQuery;
begin
  AMySQLQuery := TMySQLQuery.Create(Self, 0);
  try
    AMySQLQuery.SQL.Add('DELETE FROM EducationalWorks');
    AMySQLQuery.SQL.Add('WHERE ID_EducationalWork IN');
    AMySQLQuery.SQL.Add('(');
    AMySQLQuery.SQL.Add('	   SELECT ew.ID_EducationalWork');
    AMySQLQuery.SQL.Add('    FROM EducationalWorks ew');
    AMySQLQuery.SQL.Add('    WHERE');
    AMySQLQuery.SQL.Add('		   NVL (ew.ISDefault, 0) <> 1');
    AMySQLQuery.SQL.Add('      AND NOT EXISTS');
    AMySQLQuery.SQL.Add('      (');
    AMySQLQuery.SQL.Add('		       SELECT thuew.*');
    AMySQLQuery.SQL.Add('          FROM THEMEUNIONEDUCATIONALWORKS thuew');
    AMySQLQuery.SQL.Add('          WHERE thuew.IDEducationalWork =');
    AMySQLQuery.SQL.Add('          ew.ID_EducationalWork');
    AMySQLQuery.SQL.Add('		   )');
    AMySQLQuery.SQL.Add(')');

    AMySQLQuery.ExecSQL();
  finally
    AMySQLQuery.Free;
  end;
end;

function TEducationalWorks.GetEducationalWork: TField;
begin
  Result := Field('EducationalWork');
end;

function TEducationalWorks.GetValue: TField;
begin
  Result := EducationalWork;
end;

end.
