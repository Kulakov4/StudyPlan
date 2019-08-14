unit SpecSessGroup;

interface

uses
  System.Classes, SpecSessQry, SessTypeQry;


type
  TSpecSessGroup = class(TComponent)
  private
    FqSessType: TQrySessType;
    FqSpecSess: TQrySpecSess;
  public
    constructor Create(AOwner: TComponent; AIDSpecEd: Integer); reintroduce;
    property qSessType: TQrySessType read FqSessType;
    property qSpecSess: TQrySpecSess read FqSpecSess;
  end;

implementation

constructor TSpecSessGroup.Create(AOwner: TComponent; AIDSpecEd: Integer);
begin
  Assert(AIDSpecEd > 0);
  inherited Create(AOwner);
  FqSessType := TQrySessType.Create(Self);
  FqSessType.W.RefreshQuery;

  FqSpecSess := TQrySpecSess.Create(Self);
  FqSpecSess.FDQuery.CachedUpdates := False;
  FqSpecSess.SearchBySpecEd(AIDSpecEd);
end;

end.
