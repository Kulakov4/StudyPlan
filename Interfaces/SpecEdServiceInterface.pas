unit SpecEdServiceInterface;

interface

uses
  ChairsQuery, CourseNameQuery, SpecEdQuery;

type
  ISpecEdService = interface(IInterface)
    function GetChairsW: TChairsW;
    function GetCourseNameW: TCourseNameW;
    function GetSpecEdW: TSpecEdW;
    property ChairsW: TChairsW read GetChairsW;
    property CourseNameW: TCourseNameW read GetCourseNameW;
    property SpecEdW: TSpecEdW read GetSpecEdW;
  end;

implementation

end.
