unit SpecEdSimpleInt;

interface

type
  ISpecEdSimple = interface(IInterface)
  ['{EE0DE1AF-B442-4406-8803-C6DBEB49A8F4}']
    function GetAnnotation: string;
    function GetIDChair: Integer;
    function GetIDEducation2: Integer;
    function GetIDEducationLevel: Integer;
    function GetIDQualification: Integer;
    function GetIDSpeciality: Integer;
    function GetIDStandart: Integer;
    function GetLocked: Boolean;
    function GetMonths: Integer;
    function GetPortal: Boolean;
    function GetYears: Integer;
    function GetYear: Integer;
    property Annotation: string read GetAnnotation;
    property IDChair: Integer read GetIDChair;
    property IDEducation2: Integer read GetIDEducation2;
    property IDEducationLevel: Integer read GetIDEducationLevel;
    property IDQualification: Integer read GetIDQualification;
    property IDSpeciality: Integer read GetIDSpeciality;
    property IDStandart: Integer read GetIDStandart;
    property Locked: Boolean read GetLocked;
    property Months: Integer read GetMonths;
    property Portal: Boolean read GetPortal;
    property Years: Integer read GetYears;
    property Year: Integer read GetYear;
  end;

  ISpecEdSimpleEx = interface(ISpecEdSimple)
  ['{A3DDAAEA-D682-4864-A857-BF770FF69DB7}']
    function GetIDArea: Integer;
    procedure SetIDArea(const Value: Integer);
    property IDArea: Integer read GetIDArea write SetIDArea;
  end;

implementation

end.
