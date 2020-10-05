unit SPRetrainingEditInterface;

interface

uses
  SPEditInterface, AreasQry;

type
  ISPRetrainingEdit = interface(ISPEdit)
    function GetAreasW: TAreasW; stdcall;
    property AreasW: TAreasW read GetAreasW;
  end;

implementation

end.
