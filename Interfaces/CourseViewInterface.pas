unit CourseViewInterface;

interface

uses
  CourseStudyPlanQry, AdmissionsQuery, NotifyEvents, CourseEditInterface,
  InsertEditMode, EdLvlQry, FDDumb, CourseNameQuery, ChairsQuery, DiscNameQry,
  YearsQry, CourseStudyPlanEditInterface;

type
  ICourseView = interface(IInterface)
    procedure Copy(AIDArray: TArray<Integer>; AYear: Integer);
    function GetAdmissionsW: TAdmissionsW;
    function GetAfterLoadData: TNotifyEventsEx;
    function GetCourseEditI(AIDSpecialityEducation: Integer): ICourseEdit;
    function GetAllCourseStudyPlanW: TCourseStudyPlanW;
    function GetEdLvlW: TEdLvlW;
    procedure AdmissionMove(AIDArr: TArray<Integer>;
      AIDEducationLevel: Integer);
    function GetChairsW: TChairsW;
    function GetCourseNameW: TCourseNameW;
    function GetCourseStudyPlanEditI(AIDStudyPlan: Integer)
      : ICourseStudyPlanEdit;
    function GetDiscNameW: TDiscNameW;
    function GetIDYearW: TDumbW;
    function GetYearsW: TYearsW;
    procedure Refresh;
    property AdmissionsW: TAdmissionsW read GetAdmissionsW;
    property AfterLoadData: TNotifyEventsEx read GetAfterLoadData;
    property ChairsW: TChairsW read GetChairsW;
    property CourseNameW: TCourseNameW read GetCourseNameW;
    property AllCourseStudyPlanW: TCourseStudyPlanW read GetAllCourseStudyPlanW;
    property DiscNameW: TDiscNameW read GetDiscNameW;
    property EdLvlW: TEdLvlW read GetEdLvlW;
    property IDYearW: TDumbW read GetIDYearW;
    property YearsW: TYearsW read GetYearsW;
  end;

implementation

end.
