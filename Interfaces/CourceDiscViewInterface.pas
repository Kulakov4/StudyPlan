unit CourceDiscViewInterface;

interface

uses
  CourseStudyPlanQry, DiscNameQry, CourceDiscEditInterface;

type
  ICourceDiscView = interface(IInterface)
    function GetCourceDiscEditI: ICourceDiscEdit;
    function GetCourseStudyPlanW: TCourseStudyPlanW;
    function GetDiscNameW: TDiscNameW;
    property CourseStudyPlanW: TCourseStudyPlanW read GetCourseStudyPlanW;
    property DiscNameW: TDiscNameW read GetDiscNameW;
  end;

implementation

end.
