unit DiscNameInt;

interface

type
  IDiscName = interface(IInterface)
    function GetDisciplineName: string; stdcall;
    function GetIDChair: Integer; stdcall;
    function GetShortDisciplineName: String; stdcall;
    property DisciplineName: string read GetDisciplineName;
    property IDChair: Integer read GetIDChair;
    property ShortDisciplineName: String read GetShortDisciplineName;
  end;

implementation

end.
