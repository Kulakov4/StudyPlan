unit CourseStudyPlanInterface;

interface

type
  ICourseStudyPlan = interface(IInterface)
    function GetIDChair: Integer; stdcall;
    function GetIDDisciplineName: Integer; stdcall;
    function GetIDSPECIALITYEDUCATION: Integer; stdcall;
    function GetLec: Integer; stdcall;
    function GetLab: Integer; stdcall;
    function GetSem: Integer; stdcall;
    function GetZach: Boolean; stdcall;
    function GetExam: Boolean; stdcall;
    property IDChair: Integer read GetIDChair;
    property IDDisciplineName: Integer read GetIDDisciplineName;
    property IDSPECIALITYEDUCATION: Integer read GetIDSPECIALITYEDUCATION;
    property Lec: Integer read GetLec;
    property Lab: Integer read GetLab;
    property Sem: Integer read GetSem;
    property Zach: Boolean read GetZach;
    property Exam: Boolean read GetExam;
  end;

implementation

end.
