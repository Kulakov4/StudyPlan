unit CourceEditInterface;

interface

uses
  AdmissionsQuery, CourceNameQuery, ChairsQuery, CourceStudyPlanViewInterface,
  StudentGroupsQuery;

type
  ICourceEdit = interface(IInterface)
    procedure CancelCourceEdit;
    function GetAdmissionsW: TAdmissionsW;
    function GetChairsW: TChairsW;
    function GetCourceStudyPlanViewI: ICourceStudyPlanView;
    function GetCourceNameW: TCourceNameW;
    function GetStudentGroupsW: TStudentGroupsW;
    procedure SearchStudGroups;
    property AdmissionsW: TAdmissionsW read GetAdmissionsW;
    property ChairsW: TChairsW read GetChairsW;
    property CourceNameW: TCourceNameW read GetCourceNameW;
    property StudentGroupsW: TStudentGroupsW read GetStudentGroupsW;
  end;

implementation

end.
