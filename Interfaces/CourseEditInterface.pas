unit CourseEditInterface;

interface

uses
  AdmissionsQuery, ChairsQuery, CourseStudyPlanViewInterface,
  StudentGroupsQuery, CourseNameInterface, CourseNameQuery;

type
  ICourseEdit = interface(IInterface)
    procedure ApplyStudGroups;
    procedure CancelCourceEdit;
    function ApplyCourseName(ACourseNameI: ICourseName): Integer;
    function GetAdmissionsW: TAdmissionsW;
    function GetChairsW: TChairsW;
    function GetCourseStudyPlanViewI: ICourseStudyPlanView;
    function GetCourseNameW: TCourseNameW;
    function GetID_SpecialityEducation: Integer; stdcall;
    function GetStudentGroupsW: TStudentGroupsW;
    procedure SearchStudGroups(AIDSpecialityEducation: Integer);
    procedure SetID_SpecialityEducation(const Value: Integer); stdcall;
    property AdmissionsW: TAdmissionsW read GetAdmissionsW;
    property ChairsW: TChairsW read GetChairsW;
    property CourseNameW: TCourseNameW read GetCourseNameW;
    property ID_SpecialityEducation: Integer read GetID_SpecialityEducation
      write SetID_SpecialityEducation;
    property StudentGroupsW: TStudentGroupsW read GetStudentGroupsW;
  end;

implementation

end.
