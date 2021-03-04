unit SpecSessService;

interface

uses
  System.Classes, SpecSessServiceInterface, SpecSessQry, SessTypeQry;

type
  TSpecSessService = class(TComponent, ISpecSessService)
  private
    FqrySessType: TQrySessType;
    FqrySpecSess: TQrySpecSess;
    function GetSessTypeW: TSessTypeW;
    function GetSpecSessW: TSpecSessW;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SearchBySpecEd(AIDSpecEd: Integer);
    property SessTypeW: TSessTypeW read GetSessTypeW;
    property SpecSessW: TSpecSessW read GetSpecSessW;
  end;

implementation

constructor TSpecSessService.Create(AOwner: TComponent);
begin
  inherited;
  FqrySpecSess := TQrySpecSess.Create(Self);
  FqrySpecSess.FDQuery.CachedUpdates := False;
end;

function TSpecSessService.GetSessTypeW: TSessTypeW;
begin
  if FqrySessType = nil then
  begin
    FqrySessType := TQrySessType.Create(Self);
    FqrySessType.W.RefreshQuery;
  end;
  Result := FqrySessType.W;
end;

function TSpecSessService.GetSpecSessW: TSpecSessW;
begin
  Assert(FqrySpecSess.FDQuery.Active);
  Result := FqrySpecSess.W;
end;

procedure TSpecSessService.SearchBySpecEd(AIDSpecEd: Integer);
begin
  FqrySpecSess.SearchBySpecEd(AIDSpecEd);
end;

end.
