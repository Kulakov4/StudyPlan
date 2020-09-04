unit CourceGroup;

interface

uses
  System.Classes, Admissions, DPOStudyPlan, Years, AdmissionsQuery, ChairsQuery,
  CourceNameQuery, System.Contnrs, NotifyEvents, StudentGroupsQuery,
  CourceEdTypesQuery, YearsQry, EdLvlQry, Data.DB, FireDAC.Comp.DataSet,
  DiscNameQry, CourseStudyPlanQry, FDDumb;

type
  TCourceGroup = class(TComponent)
  private
    FAfterLoadData: TNotifyEventsEx;
    FEventList: TObjectList;
    FIDEducationLevel: Integer;
    FOnYearChange: TNotifyEventsEx;
    FqCourseStudyPlan: TQryCourseStudyPlan;
    FqAdmissions: TQueryAdmissions;
    FqChairs: TQueryChairs;
    FqCourceName: TQueryCourceName;
    FqDiscName: TQryDiscName;
    FqEdLvl: TQryEdLvl;
    FqStudentGroups: TQueryStudentGroups;
    FqYears: TQryYears;
    FYearDumb: TFDDumb;
    function GetqDiscName: TQryDiscName;
    function GetqEdLvl: TQryEdLvl;
    function GetqStudentGroups: TQueryStudentGroups;
    function GetYear: Integer;
    procedure SetYear(const Value: Integer);
  protected
    procedure DoAfterYearPost(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; AYear, AIDEducationLevel: Integer);
      reintroduce;
    destructor Destroy; override;
    procedure Copy(AIDArray: TArray<Integer>; AYear: Integer);
    procedure Refresh;
    property AfterLoadData: TNotifyEventsEx read FAfterLoadData;
    property qCourseStudyPlan: TQryCourseStudyPlan read FqCourseStudyPlan;
    property qAdmissions: TQueryAdmissions read FqAdmissions;
    property qChairs: TQueryChairs read FqChairs;
    property qCourceName: TQueryCourceName read FqCourceName;
    property qDiscName: TQryDiscName read GetqDiscName;
    property qEdLvl: TQryEdLvl read GetqEdLvl;
    property qStudentGroups: TQueryStudentGroups read GetqStudentGroups;
    property qYears: TQryYears read FqYears;
    property Year: Integer read GetYear write SetYear;
    property YearDumb: TFDDumb read FYearDumb;
    property OnYearChange: TNotifyEventsEx read FOnYearChange;
  end;

implementation

uses
  System.SysUtils, CopyStudyPlanQuery;

constructor TCourceGroup.Create(AOwner: TComponent;
  AYear, AIDEducationLevel: Integer);
begin
  inherited Create(AOwner);

  Assert(AYear > 0);
  Assert(AIDEducationLevel > 0);

  FIDEducationLevel := AIDEducationLevel;

  FEventList := TObjectList.Create;
  FAfterLoadData := TNotifyEventsEx.Create(Self);
  FOnYearChange := TNotifyEventsEx.Create(Self);

  // ����
  FqYears := TQryYears.Create(Self);
  FqYears.W.RefreshQuery;
  FqYears.W.LocateByPK(AYear, True);

  // ������� ���
  FYearDumb := TFDDumb.Create(Self);
  // ������������� �� ��������� �������� ����
  TNotifyEventWrap.Create(FYearDumb.W.AfterPost, DoAfterYearPost, FEventList);
  FYearDumb.W.RefreshQuery;

  // ���� ������ �� �����
  FqAdmissions := TQueryAdmissions.Create(Self);

  // ��� ���������� ��������
  // TNotifyEventWrap.Create(FqAdmissions.W.BeforeDelete, DoBeforeDelete,
  // FEventList);

  // ���������� �� ������
  FqCourseStudyPlan := TQryCourseStudyPlan.Create(Self);
  FqCourseStudyPlan.Name := 'FqDPOSP_Main';

  // �������
  FqChairs := TQueryChairs.Create(Self);
  FqChairs.W.RefreshQuery;

  // �������� ������
  FqCourceName := TQueryCourceName.Create(Self);
  FqCourceName.SearchCourceName;

  // ���� ��� ����� �������� "�����" ����� ������
  qEdLvl.Search([4, 6], AIDEducationLevel);

  // ��������� ����� ����
  Year := AYear;
end;

destructor TCourceGroup.Destroy;
begin
  FreeAndNil(FEventList);
  FreeAndNil(FAfterLoadData);
  FreeAndNil(FOnYearChange);
  inherited;
end;

procedure TCourceGroup.Copy(AIDArray: TArray<Integer>; AYear: Integer);
begin
  Assert(Length(AIDArray) > 0);
  Assert(AYear > 0);

  TQueryCopyStudyPlan.Copy(AIDArray, AYear);
end;

procedure TCourceGroup.DoAfterYearPost(Sender: TObject);
begin
  Assert(FIDEducationLevel > 0);

  // ���������� �� ������
  FqCourseStudyPlan.Search(FIDEducationLevel, Year);

  // ���� ������ �� �����
  FqAdmissions.Search(FIDEducationLevel, Year);

  FAfterLoadData.CallEventHandlers(Self);
  FOnYearChange.CallEventHandlers(Self);
end;

function TCourceGroup.GetqDiscName: TQryDiscName;
begin
  if FqDiscName = nil then
  begin
    // ������ ����� ��������� ������
    FqDiscName := TQryDiscName.Create(Self);
    FqDiscName.FDQuery.CachedUpdates := True;
    FqDiscName.SearchByType([3]); // ���������� ������;
  end;

  Result := FqDiscName;
end;

function TCourceGroup.GetqStudentGroups: TQueryStudentGroups;
begin
  if FqStudentGroups = nil then
    FqStudentGroups := TQueryStudentGroups.Create(Self);

  Result := FqStudentGroups;
end;

function TCourceGroup.GetqEdLvl: TQryEdLvl;
begin
  if FqEdLvl = nil then
    FqEdLvl := TQryEdLvl.Create(Self);

  Result := FqEdLvl;
end;

function TCourceGroup.GetYear: Integer;
begin
  Result := FYearDumb.W.ID.F.AsInteger;
end;

procedure TCourceGroup.Refresh;
begin
  qCourseStudyPlan.W.RefreshQuery;
  qAdmissions.W.RefreshQuery;
end;

procedure TCourceGroup.SetYear(const Value: Integer);
begin
  if Year = Value then
    Exit;

  // �������� ������ ��� ���
  FYearDumb.W.UpdateID(Value);
end;

end.
