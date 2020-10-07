unit CourceDiscEditInterface;

interface

uses
  DiscNameQry, DiscNameInt, CourseStudyPlanInterface, InsertEditMode,
  CourseStudyPlanQry;

type
  ICourceDiscEdit = interface(IInterface)
    procedure ApplyCourseStudyPlan(ACourseStudyPlanInt: ICourseStudyPlan; AMode:
        TMode);
    function ApplyDisciplines(AIDDisciplineName: Integer; ADiscNameInt: IDiscName):
        Integer;
    procedure CancelUpdates;
    function GetCourseStudyPlanW: TCourseStudyPlanW;
    function GetDiscNameW: TDiscNameW;
    function GetIDChair: Integer;
    function GetIDSpecialityEducation: Integer;
    property CourseStudyPlanW: TCourseStudyPlanW read GetCourseStudyPlanW;
    property DiscNameW: TDiscNameW read GetDiscNameW;
    property IDChair: Integer read GetIDChair;
    property IDSpecialityEducation: Integer read GetIDSpecialityEducation;
  end;

implementation

end.
