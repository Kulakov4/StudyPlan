unit SPViewInterface;

interface

uses
  FDDumb, YearsQry, SpecEdSimpleWrap, CourseNameQuery, SpecEdQuery,
  ChairsQuery, SPUnit, EdQuery, SPEditInterface;

type
  ISPView = interface(IInterface)
    procedure CopyStudyPlan(AYear: Integer);
    procedure DeleteStudyPlan;
    procedure DoOnReportPlanGraphBySpecExec;
    function GetActivePlansOnly: Boolean;
    function GetAllChairsW: TChairsW;
    function GetCourseNameW: TCourseNameW;
    function GetIDSpecEdW: TDumbW;
    function GetIDYearW: TDumbW;
    function GetSP: TStudyPlan;
    function GetSpecEdSimpleW: TSpecEdSimpleW;
    function GetSpecEdW: TSpecEdW;
    function GetSPEditInterface: ISPEdit;
    function GetYearsW: TYearsW;
    procedure LockAllStudyPlans;
    procedure SetActivePlansOnly(const Value: Boolean);
    property ActivePlansOnly: Boolean read GetActivePlansOnly
      write SetActivePlansOnly;
    property AllChairsW: TChairsW read GetAllChairsW;
    property CourseNameW: TCourseNameW read GetCourseNameW;
    property IDSpecEdW: TDumbW read GetIDSpecEdW;
    property IDYearW: TDumbW read GetIDYearW;
    property SP: TStudyPlan read GetSP;
    property SpecEdSimpleW: TSpecEdSimpleW read GetSpecEdSimpleW;
    property SpecEdW: TSpecEdW read GetSpecEdW;
    property YearsW: TYearsW read GetYearsW;
  end;

implementation

end.
