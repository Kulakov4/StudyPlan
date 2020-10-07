unit CourceDiscNameViewModel;

interface

uses
  System.Classes, DiscNameQry, DiscNameInt, InsertEditMode, CourseStudyPlanQry,
  CourseStudyPlanInterface, CourceDiscEditInterface;

type
  TCourceDiscNameVM = class(TComponent, ICourceDiscEdit)
  strict private
    function GetCourseStudyPlanW: TCourseStudyPlanW;
    function GetIDChair: Integer;
    function GetIDSpecialityEducation: Integer;
  private
    FCourseStudyPlanW: TCourseStudyPlanW;
    FIDChair: Integer;
    FIDSPECIALITYEDUCATION: Integer;
    FqDiscName: TQryDiscName;
    function GetDiscNameW: TDiscNameW;
  protected
    property DiscNameW: TDiscNameW read GetDiscNameW;
  public
    constructor Create(AOwner: TComponent; ACourseStudyPlanW: TCourseStudyPlanW;
      AQryDiscName: TQryDiscName; AIDChair, AIDSPECIALITYEDUCATION: Integer);
      reintroduce;
    function ApplyDisciplines(AIDDisciplineName: Integer;
      ADiscNameInt: IDiscName): Integer;
    procedure ApplyCourseStudyPlan(ACourseStudyPlanInt: ICourseStudyPlan;
      AMode: TMode);
    procedure CancelUpdates;
  end;

implementation

constructor TCourceDiscNameVM.Create(AOwner: TComponent;
  ACourseStudyPlanW: TCourseStudyPlanW; AQryDiscName: TQryDiscName;
  AIDChair, AIDSPECIALITYEDUCATION: Integer);
begin
  inherited Create(AOwner);
  FCourseStudyPlanW := ACourseStudyPlanW;
  FqDiscName := AQryDiscName;
  FIDChair := AIDChair;
  FIDSPECIALITYEDUCATION := AIDSPECIALITYEDUCATION;
  ACourseStudyPlanW.SaveBookmark;
end;

function TCourceDiscNameVM.ApplyDisciplines(AIDDisciplineName: Integer;
  ADiscNameInt: IDiscName): Integer;
begin
  // ��� � ��� ���� ����� ID = NULL
  DiscNameW.LocateByPK(AIDDisciplineName, True);
  DiscNameW.UpdateShortCaption(ADiscNameInt.ShortDisciplineName);

  // �������-�� ��������� ��������� ��������� � ��
  FqDiscName.FDQuery.ApplyUpdates(0);
  FqDiscName.FDQuery.CommitUpdates;

  // ��� ������ ��������� ������������� ID
  Assert(FqDiscName.W.PK.AsInteger > 0);
  Result := FqDiscName.W.PK.AsInteger;
end;

procedure TCourceDiscNameVM.ApplyCourseStudyPlan(ACourseStudyPlanInt
  : ICourseStudyPlan; AMode: TMode);
var
  OK: Boolean;
begin
  OK := FCourseStudyPlanW.RestoreBookmark;

  // ���� �� ������������� ����������,
  // �� ����������� ������ ��������� � ������������� ������, ����� �����������
  if AMode = EditMode then
    Assert(OK);

  FCourseStudyPlanW.Save(ACourseStudyPlanInt, AMode);
end;

procedure TCourceDiscNameVM.CancelUpdates;
begin
  FqDiscName.FDQuery.CancelUpdates;
end;

function TCourceDiscNameVM.GetCourseStudyPlanW: TCourseStudyPlanW;
begin
  Result := FCourseStudyPlanW;
end;

function TCourceDiscNameVM.GetDiscNameW: TDiscNameW;
begin
  Result := FqDiscName.W;
end;

function TCourceDiscNameVM.GetIDChair: Integer;
begin
  Result := FIDChair;
end;

function TCourceDiscNameVM.GetIDSpecialityEducation: Integer;
begin
  Result := FIDSPECIALITYEDUCATION;
end;

end.
