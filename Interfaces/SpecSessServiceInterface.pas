unit SpecSessServiceInterface;

interface

uses
  SessTypeQry, SpecSessQry;

type
  ISpecSessService = interface(IInterface)
    function GetSessTypeW: TSessTypeW;
    function GetSpecSessW: TSpecSessW;
    property SessTypeW: TSessTypeW read GetSessTypeW;
    property SpecSessW: TSpecSessW read GetSpecSessW;
  end;

implementation

end.
