unit CSEService;

interface

uses
  System.Classes, CSEQry, CyclesQry, CycleTypesQuery,
  CycleServiceInterface, CSEServiceInterface;

type
  TCSEService = class(TComponent, ICycleService, ICSEService)
  private
    FqryCSE: TQueryCSE;
    FqryCycles: TQueryCycles;
    FqryCycleTypes: TQueryCycleTypes;
    function GetCSEWrap: TCSEWrap;
    function GetCycleService: ICycleService;
    function GetCycleTypeW: TCycleTypeW;
    function GetCycleW: TCycleW;
  public
    constructor Create(AOwner: TComponent); override;
    function SearchByIDSpecEd(AIDSpecEd: Integer): Integer;
    property CSEWrap: TCSEWrap read GetCSEWrap;
    property CycleService: ICycleService read GetCycleService;
    property CycleTypeW: TCycleTypeW read GetCycleTypeW;
    property CycleW: TCycleW read GetCycleW;
  end;

implementation

constructor TCSEService.Create(AOwner: TComponent);
begin
  inherited;
  FqryCSE := TQueryCSE.Create(Self);
end;

function TCSEService.GetCSEWrap: TCSEWrap;
begin
  Result := FqryCSE.W
end;

function TCSEService.GetCycleService: ICycleService;
begin
  Result := Self;
end;

function TCSEService.GetCycleTypeW: TCycleTypeW;
begin
  if FqryCycleTypes = nil then
  begin
    FqryCycleTypes := TQueryCycleTypes.Create(Self);
    FqryCycleTypes.FDQuery.Open;
  end;
  Result := FqryCycleTypes.W;
end;

function TCSEService.GetCycleW: TCycleW;
begin
  if FqryCycles = nil then
  begin
    FqryCycles := TQueryCycles.Create(Self);
    FqryCycles.FDQuery.Open;
  end;

  Result := FqryCycles.W;
end;

function TCSEService.SearchByIDSpecEd(AIDSpecEd: Integer): Integer;
begin
  Result := FqryCSE.SearchByIDSpecEd(AIDSpecEd);
end;

end.
