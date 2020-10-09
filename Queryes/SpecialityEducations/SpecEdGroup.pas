unit SpecEdGroup;

interface

uses
  System.Classes, SpecEdQuery, ChairsQuery, CourseNameQuery;

type
  TSpecEdGroup = class(TComponent)
  private
    FqChairs: TQueryChairs;
    FqCourseName: TQueryCourseName;
    FqSpecEd: TQuerySpecEd;
  public
    constructor Create(AOwner: TComponent); override;
    property qChairs: TQueryChairs read FqChairs;
    property qCourseName: TQueryCourseName read FqCourseName;
    property qSpecEd: TQuerySpecEd read FqSpecEd;
  end;

implementation

constructor TSpecEdGroup.Create(AOwner: TComponent);
begin
  inherited;
  // Учебные планы (наборы)
  FqSpecEd := TQuerySpecEd.Create(Self);
  FqSpecEd.W.RefreshQuery;

  // Кафедры
  FqChairs := TQueryChairs.Create(Self);
  FqChairs.W.RefreshQuery;

  // Названия специальностей
  FqCourseName := TQueryCourseName.Create(Self);
  FqCourseName.Search();

end;

end.
