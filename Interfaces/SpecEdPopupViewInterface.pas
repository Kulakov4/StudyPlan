unit SpecEdPopupViewInterface;

interface

uses
  SpecEdQuery, CourceNameQuery, ChairsQuery;

type
  ISpecEdPopupView = interface(IInterface)
    function GetAllChairsW: TChairsW; stdcall;
    function GetCourceNameW: TCourceNameW; stdcall;
    function GetSpecEdW: TSpecEdW; stdcall;
    property AllChairsW: TChairsW read GetAllChairsW;
    property CourceNameW: TCourceNameW read GetCourceNameW;
    property SpecEdW: TSpecEdW read GetSpecEdW;
  end;

implementation

end.
