unit SPRetrainingViewInterface;

interface

uses
  SPViewInterface, AreasQry, SPRetrainingEditInterface;

type
  ISPRetView = interface(ISPView)
    function GetAreasW: TAreasW; stdcall;
    function GetSPRetrainingEditI: ISPRetrainingEdit; stdcall;
    property AreasW: TAreasW read GetAreasW;
  end;

implementation

end.
