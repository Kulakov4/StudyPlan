unit AdmissionsInterface;

interface

type
  IAdmission = interface(IInterface)
    function GetData: Integer;
    function GetIDChair: Integer;
    function GetIDSpeciality: Integer;
    function GetID_SpecialityEducation: Integer; stdcall;
    property Data: Integer read GetData;
    property IDChair: Integer read GetIDChair;
    property IDSpeciality: Integer read GetIDSpeciality;
    property ID_SpecialityEducation: Integer read GetID_SpecialityEducation;
  end;

implementation

end.
