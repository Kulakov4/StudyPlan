unit DiscNameViewInterface;

interface

uses
  DiscNameQry, ChairsQuery;

type
  IDiscNameEdit = interface;

  IDiscNameView = interface(IInterface)
    function GetChairsW: TChairsW;
    function GetDiscNameEditI(AID_DisciplineName: Integer): IDiscNameEdit;
    function GetDiscNameW: TDiscNameW;
    property ChairsW: TChairsW read GetChairsW;
    property DiscNameW: TDiscNameW read GetDiscNameW;
  end;

  IDiscNameEdit = interface(IDiscNameView)
    function GetID_DisciplineName: Integer;
    property ID_DisciplineName: Integer read GetID_DisciplineName;
  end;

implementation

end.
