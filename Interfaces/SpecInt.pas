unit SpecInt;

interface

type
  ISpec = interface(IInterface)
    function GetChiperSpeciality: string; stdcall;
    function GetIDChair: Integer; stdcall;
    function GetShortSpeciality: string; stdcall;
    function GetSpeciality: string; stdcall;
    procedure SetIDChair(const Value: Integer); stdcall;
    property ChiperSpeciality: string read GetChiperSpeciality;
    property IDChair: Integer read GetIDChair write SetIDChair;
    property ShortSpeciality: string read GetShortSpeciality;
    property Speciality: string read GetSpeciality;
  end;

implementation

end.
