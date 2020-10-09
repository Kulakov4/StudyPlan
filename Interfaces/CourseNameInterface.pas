unit CourseNameInterface;

interface

type
  ICourseName = interface(IInterface)
    function GetIDChair: Integer;
    function GetID_Speciality: Integer;
    function GetShortSpeciality: string;
    function GetSpeciality: string;
    property IDChair: Integer read GetIDChair;
    property ID_Speciality: Integer read GetID_Speciality;
    property ShortSpeciality: string read GetShortSpeciality;
    property Speciality: string read GetSpeciality;
  end;

implementation

end.
