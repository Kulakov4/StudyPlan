unit SPViewInterface;

interface

uses
  FDDumb, YearsQry, SpecEdPopupViewInterface;

type
  ISPView = interface(ISpecEdPopupView)
    function GetIDYearW: TDumbW; stdcall;
    function GetYearsW: TYearsW; stdcall;
    property IDYearW: TDumbW read GetIDYearW;
    property YearsW: TYearsW read GetYearsW;
  end;

implementation

end.
