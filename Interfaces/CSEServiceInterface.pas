
unit CSEServiceInterface;

interface

uses
  CSEQry, CycleServiceInterface;

type
  ICSEService = interface(IInterface)
    function GetCSEWrap: TCSEWrap;
    function GetCycleService: ICycleService;
    function SearchByIDSpecEd(AIDSpecEd: Integer): Integer;
    property CSEWrap: TCSEWrap read GetCSEWrap;
    property CycleService: ICycleService read GetCycleService;
  end;

implementation

end.
