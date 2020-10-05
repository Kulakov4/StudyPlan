unit SpecEditInterface;

interface

uses
  SpecChiperUniqueQry, SpecNameUniqueQry, SpecQry, SpecByChairQry;

type
  ISpecEdit = interface(IInterface)
    function GetSpecByChairW: TSpecByChairW; stdcall;
    function GetSpecChiperW: TSpecChiperW; stdcall;
    function GetSpecNameUniqueW: TSpecNameUniqueW; stdcall;
    function GetSpecW: TSpecW; stdcall;
    function SpecSearchByChiperAndName(const AChiper, ASpeciality: string): Integer;
    function SpecSearchByChiper(const AChiper: string): Integer;
    property SpecByChairW: TSpecByChairW read GetSpecByChairW;
    property SpecChiperW: TSpecChiperW read GetSpecChiperW;
    property SpecNameUniqueW: TSpecNameUniqueW read GetSpecNameUniqueW;
    property SpecW: TSpecW read GetSpecW;
  end;

implementation

end.
