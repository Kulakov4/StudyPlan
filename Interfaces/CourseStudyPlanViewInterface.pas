unit CourseStudyPlanViewInterface;

interface

uses
  CourseStudyPlanQry, DiscNameQry, CourseStudyPlanEditInterface;

type
  ICourseStudyPlanView = interface(IInterface)
    procedure ApplyCourseStudyPlan;
    procedure CancelCourseStudyPlan;
    function GetCourseStudyPlanEditI(AIDStudyPlan: Integer): ICourseStudyPlanEdit;
    function GetCourseStudyPlanW: TCourseStudyPlanW;
    function GetDiscNameW: TDiscNameW;
    property CourseStudyPlanW: TCourseStudyPlanW read GetCourseStudyPlanW;
    property DiscNameW: TDiscNameW read GetDiscNameW;
  end;

implementation

end.