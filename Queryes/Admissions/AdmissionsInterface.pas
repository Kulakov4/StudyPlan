unit AdmissionsInterface;

interface

type
  IAdmission = interface(IInterface)
    function GetData: Integer; stdcall;
    function GetIDChair: Integer; stdcall;
    function GetIDSpeciality: Integer; stdcall;
    property Data: Integer read GetData;
    property IDChair: Integer read GetIDChair;
    property IDSpeciality: Integer read GetIDSpeciality;
  end;

implementation

end.
