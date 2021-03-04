unit CycleServiceInterface;

interface

uses
  CycleTypesQuery, CyclesQry;

type
  ICycleService = interface(IInterface)
    function GetCycleTypeW: TCycleTypeW;
    function GetCycleW: TCycleW;
    property CycleTypeW: TCycleTypeW read GetCycleTypeW;
    property CycleW: TCycleW read GetCycleW;
  end;

implementation

end.
