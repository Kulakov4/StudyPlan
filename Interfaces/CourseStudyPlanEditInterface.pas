unit CourseStudyPlanEditInterface;

interface

uses
  DiscNameQry, DiscNameInt, CourseStudyPlanInterface, InsertEditMode,
  CourseStudyPlanQry;

type
  ICourseStudyPlanEdit = interface(IInterface)
    function ApplyDisciplines(ADiscNameI: IDiscName): Integer;
    function GetCourseStudyPlanW: TCourseStudyPlanW;
    function GetDiscNameW: TDiscNameW;
    function GetIDChair: Integer;
    function GetIDSpecialityEducation: Integer;
    function GetID_StudyPlan: Integer; stdcall;
    property CourseStudyPlanW: TCourseStudyPlanW read GetCourseStudyPlanW;
    property DiscNameW: TDiscNameW read GetDiscNameW;
    property IDChair: Integer read GetIDChair;
    property IDSpecialityEducation: Integer read GetIDSpecialityEducation;
    property ID_StudyPlan: Integer read GetID_StudyPlan;
  end;

implementation

end.
