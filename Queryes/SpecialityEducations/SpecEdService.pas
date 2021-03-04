unit SpecEdService;

interface

uses
  System.Classes, SpecEdQuery, ChairsQuery, CourseNameQuery;

type
  TSpecEdService = class(TComponent)
  private
    FqryChairs: TQueryChairs;
    FqryCourseName: TQueryCourseName;
    FqrySpecEd: TQuerySpecEd;
    function GetChairsW: TChairsW;
    function GetCourseNameW: TCourseNameW;
    function GetSpecEdW: TSpecEdW;
  public
    property ChairsW: TChairsW read GetChairsW;
    property CourseNameW: TCourseNameW read GetCourseNameW;
    property SpecEdW: TSpecEdW read GetSpecEdW;
  end;

implementation

function TSpecEdService.GetChairsW: TChairsW;
begin
  // Кафедры
  if FqryChairs = nil then
  begin
    FqryChairs := TQueryChairs.Create(Self);
    FqryChairs.W.RefreshQuery;
  end;
  Result := FqryChairs.W;
end;

function TSpecEdService.GetCourseNameW: TCourseNameW;
begin
  // Названия специальностей
  if FqryCourseName = nil then
  begin
    FqryCourseName := TQueryCourseName.Create(Self);
    FqryCourseName.Search(True);
  end;

  Result := FqryCourseName.W;
end;

function TSpecEdService.GetSpecEdW: TSpecEdW;
begin
  // Учебные планы (наборы)
  if FqrySpecEd = nil then
  begin
    FqrySpecEd := TQuerySpecEd.Create(Self);
    FqrySpecEd.W.RefreshQuery;
  end;

  Result := FqrySpecEd.W;
end;

end.
