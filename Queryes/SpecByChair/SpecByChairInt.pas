unit SpecByChairInt;

interface

type
  ISpecByChair = interface(IInterface)
    function GetChiperSpeciality: string; stdcall;
    function GetShortSpeciality: string; stdcall;
    function GetSpeciality: string; stdcall;
    property ChiperSpeciality: string read GetChiperSpeciality;
    property ShortSpeciality: string read GetShortSpeciality;
    property Speciality: string read GetSpeciality;
  end;

implementation

end.
