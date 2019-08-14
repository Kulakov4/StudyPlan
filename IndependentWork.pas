unit IndependentWork;

interface

uses
  EssenceEx, System.Classes, Data.DB, ETPCatalog;

type
  TIndependentWork = class(TETPCatalog)
  private
    function GetIndependentWork: TField;
  protected
    function GetValue: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DropUnused; override;
    property IndependentWork: TField read GetIndependentWork;
  end;

implementation

uses MyDataAccess;

constructor TIndependentWork.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'IndependentWorkFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'iw.ID_IndependentWork';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.INDEPENDENTWORK_SEQ';

  with FSQLSelectOperator do
  begin
    Fields.Add('iw.*');

    Tables.Add('independentWork iw');

    OrderClause.Add('iw.independentWork');
  end;

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;
  UpdatingTableName := 'independentWork';
end;

procedure TIndependentWork.DropUnused;
var
  AMySQLQuery: TMySQLQuery;
begin
  AMySQLQuery := TMySQLQuery.Create(Self, 0);
  try
    AMySQLQuery.SQL.Add('DELETE FROM IndependentWork');
    AMySQLQuery.SQL.Add('WHERE ID_IndependentWork IN');
    AMySQLQuery.SQL.Add('(');
    AMySQLQuery.SQL.Add('	   SELECT iw.ID_IndependentWork');
    AMySQLQuery.SQL.Add('    FROM IndependentWork iw');
    AMySQLQuery.SQL.Add('    WHERE');
    AMySQLQuery.SQL.Add('		   NVL (iw.ISDefault, 0) <> 1');
    AMySQLQuery.SQL.Add('      AND NOT EXISTS');
    AMySQLQuery.SQL.Add('      (');
    AMySQLQuery.SQL.Add('		       SELECT thuiw.*');
    AMySQLQuery.SQL.Add('          FROM ThemeUnionIndependentWork thuiw');
    AMySQLQuery.SQL.Add('          WHERE thuiw.IDIndependentWork =');
    AMySQLQuery.SQL.Add('          iw.ID_IndependentWork');
    AMySQLQuery.SQL.Add('		   )');
    AMySQLQuery.SQL.Add(')');

    AMySQLQuery.ExecSQL();
  finally
    AMySQLQuery.Free;
  end;
end;

function TIndependentWork.GetIndependentWork: TField;
begin
  Result := Field('IndependentWork');
end;

function TIndependentWork.GetValue: TField;
begin
  Result := IndependentWork;
end;

end.
