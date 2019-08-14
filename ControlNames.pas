unit ControlNames;

interface

uses
  EssenceEx, System.Classes, Data.DB, ETPCatalog;

type
  TControlNames = class(TETPCatalog)
  private
    function GetControlName: TField;
  protected
    function GetValue: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DropUnused; override;
    property ControlName: TField read GetControlName;
  end;

implementation

uses MyDataAccess;

constructor TControlNames.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'ControlNameFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName :=
    'cn.ID_ControlName';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.CONTROLNAMES_SEQ';

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;

  with FSQLSelectOperator do
  begin
    Fields.Add('cn.*');

    Tables.Add('ControlNames cn');

    OrderClause.Add('cn.ControlName');
  end;

  KeyFieldProviderFlags := [pfInKey, pfInUpdate];
end;

procedure TControlNames.DropUnused;
var
  AMySQLQuery: TMySQLQuery;
begin
  AMySQLQuery := TMySQLQuery.Create(Self, 0);
  try
    AMySQLQuery.SQL.Add('DELETE FROM ControlNames');
    AMySQLQuery.SQL.Add('WHERE ID_ControlName IN');
    AMySQLQuery.SQL.Add('(');
    AMySQLQuery.SQL.Add('	   SELECT cn.ID_ControlName');
    AMySQLQuery.SQL.Add('    FROM ControlNames cn');
    AMySQLQuery.SQL.Add('    WHERE');
    AMySQLQuery.SQL.Add('		   NVL (cn.ISDefault, 0) <> 1');
    AMySQLQuery.SQL.Add('      AND NOT EXISTS');
    AMySQLQuery.SQL.Add('      (');
    AMySQLQuery.SQL.Add('		       SELECT thucn.*');
    AMySQLQuery.SQL.Add('          FROM THEMEUNIONCONTROLS thucn');
    AMySQLQuery.SQL.Add('          WHERE thucn.IDControlName =');
    AMySQLQuery.SQL.Add('          cn.ID_ControlName');
    AMySQLQuery.SQL.Add('		   )');
    AMySQLQuery.SQL.Add(')');

    AMySQLQuery.ExecSQL();
  finally
    AMySQLQuery.Free;
  end;
end;

function TControlNames.GetControlName: TField;
begin
  Result := Field('ControlName');
end;

function TControlNames.GetValue: TField;
begin
  Result := ControlName;
end;

end.
