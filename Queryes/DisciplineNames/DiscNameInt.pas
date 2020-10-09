unit DiscNameInt;

interface

type
  IDiscName = interface(IInterface)
    function GetDisciplineName: string;
    function GetIDChair: Integer;
    function GetID_DisciplineName: Integer;
    function GetShortDisciplineName: String;
    function GetType_Discipline: Integer;
    property DisciplineName: string read GetDisciplineName;
    property IDChair: Integer read GetIDChair;
    property ID_DisciplineName: Integer read GetID_DisciplineName;
    property ShortDisciplineName: String read GetShortDisciplineName;
    property Type_Discipline: Integer read GetType_Discipline;
  end;

implementation

end.
