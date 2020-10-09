unit CourseStudyPlanInterface;

interface

type
  ICourseStudyPlan = interface(IInterface)
    function GetIDChair: Integer;
    function GetIDDisciplineName: Integer;
    function GetIDSPECIALITYEDUCATION: Integer;
    function GetLec: Integer;
    function GetLab: Integer;
    function GetSem: Integer;
    function GetZach: Boolean;
    function GetExam: Boolean;
    function GetID_StudyPlan: Integer;
    property IDChair: Integer read GetIDChair;
    property IDDisciplineName: Integer read GetIDDisciplineName;
    property IDSPECIALITYEDUCATION: Integer read GetIDSPECIALITYEDUCATION;
    property Lec: Integer read GetLec;
    property Lab: Integer read GetLab;
    property Sem: Integer read GetSem;
    property Zach: Boolean read GetZach;
    property Exam: Boolean read GetExam;
    property ID_StudyPlan: Integer read GetID_StudyPlan;
  end;

implementation

end.
