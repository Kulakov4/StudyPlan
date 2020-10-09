unit CourseGroup;

interface

uses
  System.Classes, Admissions, DPOStudyPlan, Years, AdmissionsQuery, ChairsQuery,
  CourseNameQuery, System.Contnrs, NotifyEvents, StudentGroupsQuery,
  CourseEdTypesQuery, YearsQry, EdLvlQry, Data.DB, FireDAC.Comp.DataSet,
  DiscNameQry, CourseStudyPlanQry, FDDumb, CourseViewInterface,
  CourseEditInterface, CourseStudyPlanViewInterface, CourseNameInterface,
  InsertEditMode, CourseStudyPlanEditInterface, DiscNameInt;

type
  TCourseGroup = class(TComponent, ICourseView, ICourseEdit,
    ICourseStudyPlanView, ICourseStudyPlanEdit)
  strict private
    procedure AdmissionMove(AIDArr: TArray<Integer>;
      AIDEducationLevel: Integer);
    procedure ApplyStudGroups;
    procedure CancelCourceEdit;
    function ApplyCourseName(ACourseNameI: ICourseName): Integer;
    procedure ApplyCourseStudyPlan;
    function ApplyDisciplines(ADiscNameI: IDiscName): Integer;
    procedure CancelCourseStudyPlan;
    function GetAdmissionsW: TAdmissionsW;
    function GetAfterLoadData: TNotifyEventsEx;
    function GetAllCourseStudyPlanW: TCourseStudyPlanW;
    function GetChairsW: TChairsW;
    function GetCourseEditI(AIDSpecialityEducation: Integer): ICourseEdit;
    function GetCourseNameW: TCourseNameW;
    function GetCourseStudyPlanEditI(AIDStudyPlan: Integer)
      : ICourseStudyPlanEdit;
    function GetCourseStudyPlanViewI: ICourseStudyPlanView;
    function GetCourseStudyPlanW: TCourseStudyPlanW;
    function GetDiscNameW: TDiscNameW;
    function GetEdLvlW: TEdLvlW;
    function GetIDChair: Integer;
    function GetIDSpecialityEducation: Integer;
    function GetIDYearW: TDumbW;
    function GetID_SpecialityEducation: Integer; stdcall;
    function GetID_StudyPlan: Integer; stdcall;
    function GetStudentGroupsW: TStudentGroupsW;
    function GetYearsW: TYearsW;
    procedure SearchStudGroups(AIDSpecialityEducation: Integer);
    procedure SetID_SpecialityEducation(const Value: Integer); stdcall;
  private
    FAfterLoadData: TNotifyEventsEx;
    FEventList: TObjectList;
    FIDEducationLevel: Integer;
    FID_SpecialityEducation: Integer;
    FID_StudyPlan: Integer;
    FOnYearChange: TNotifyEventsEx;
    FqAllCourseStudyPlan: TQryCourseStudyPlan;
    FqAdmissions: TQueryAdmissions;
    FqChairs: TQueryChairs;
    FqCourseName: TQueryCourseName;
    FqCourseStudyPlan: TQryCourseStudyPlan;
    FqDiscName: TQryDiscName;
    FqEdLvl: TQryEdLvl;
    FqStudentGroups: TQueryStudentGroups;
    FqYears: TQryYears;
    FYearDumb: TFDDumb;
    procedure DoAfterDisciplinesApplyUpdates(ADataSet: TFDDataSet;
      AErrorCount: Integer);
    function GetqCourseStudyPlan: TQryCourseStudyPlan;
    function GetqDiscName: TQryDiscName;
    function GetqEdLvl: TQryEdLvl;
    function GetqStudentGroups: TQueryStudentGroups;
    function GetYear: Integer;
    procedure SetYear(const Value: Integer);
  protected
    procedure DoAfterYearPost(Sender: TObject);
    property qCourseStudyPlan: TQryCourseStudyPlan read GetqCourseStudyPlan;
  public
    constructor Create(AOwner: TComponent; AYear, AIDEducationLevel: Integer);
      reintroduce;
    destructor Destroy; override;
    procedure Copy(AIDArray: TArray<Integer>; AYear: Integer);
    procedure Refresh;
    property AfterLoadData: TNotifyEventsEx read FAfterLoadData;
    property qAllCourseStudyPlan: TQryCourseStudyPlan read FqAllCourseStudyPlan;
    property qAdmissions: TQueryAdmissions read FqAdmissions;
    property qChairs: TQueryChairs read FqChairs;
    property qCourseName: TQueryCourseName read FqCourseName;
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

constructor TCourseGroup.Create(AOwner: TComponent;
  AYear, AIDEducationLevel: Integer);
begin
  inherited Create(AOwner);

  Assert(AYear > 0);
  Assert(AIDEducationLevel > 0);

  FIDEducationLevel := AIDEducationLevel;

  FEventList := TObjectList.Create;
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
  FqAllCourseStudyPlan := TQryCourseStudyPlan.Create(Self);
  FqAllCourseStudyPlan.Name := 'FqDPOSP_Main';

  // �������
  FqChairs := TQueryChairs.Create(Self);
  FqChairs.W.RefreshQuery;

  // �������� ������
  FqCourseName := TQueryCourseName.Create(Self);
  FqCourseName.SearchCourceName;

  // ���� ��� ����� �������� "�����" ����� ������
  qEdLvl.Search([4, 6], AIDEducationLevel);

  // ��������� ����� ����
  Year := AYear;
end;

destructor TCourseGroup.Destroy;
begin
  FreeAndNil(FEventList);
  FreeAndNil(FAfterLoadData);
  FreeAndNil(FOnYearChange);
  inherited;
end;

procedure TCourseGroup.AdmissionMove(AIDArr: TArray<Integer>;
  AIDEducationLevel: Integer);
begin
  qAdmissions.Move(AIDArr, AIDEducationLevel);
end;

procedure TCourseGroup.ApplyStudGroups;
begin
  if not qStudentGroups.FDQuery.Active then
    Exit;

  // �������-�� ��������� ��������� ��������� � ��
  qStudentGroups.FDQuery.ApplyUpdates(0);
  qStudentGroups.FDQuery.CommitUpdates;
  Assert(qStudentGroups.FDQuery.ChangeCount = 0);

  // ��������� ���-�� ����� �������� �����
  qAdmissions.W.ID_SpecialityEducation.Locate(FID_SpecialityEducation,
    [], True);
  qAdmissions.SetGroupCount(qStudentGroups.FDQuery.RecordCount);
end;

procedure TCourseGroup.CancelCourceEdit;
begin
  // �� ��������� ��������� ��������� � ��
  qCourseName.FDQuery.CancelUpdates;

  // �������� ��������� ��������� � �������
  if qStudentGroups.FDQuery.Active then
    qStudentGroups.FDQuery.CancelUpdates;
end;

procedure TCourseGroup.Copy(AIDArray: TArray<Integer>; AYear: Integer);
begin
  Assert(Length(AIDArray) > 0);
  Assert(AYear > 0);

  TQueryCopyStudyPlan.Copy(AIDArray, AYear);
end;

function TCourseGroup.ApplyCourseName(ACourseNameI: ICourseName): Integer;
begin
  qCourseName.W.Save(ACourseNameI, EditMode);
  Result := qCourseName.ApplyUpdates;
end;

procedure TCourseGroup.ApplyCourseStudyPlan;
begin
  FqCourseStudyPlan.W.TryPost;

  if FqCourseStudyPlan.FDQuery.ChangeCount = 0 then
    Exit;

  FqCourseStudyPlan.FDQuery.ApplyUpdates(0);
  FqCourseStudyPlan.FDQuery.CommitUpdates;
  Assert(FqCourseStudyPlan.FDQuery.ChangeCount = 0);
end;

function TCourseGroup.ApplyDisciplines(ADiscNameI: IDiscName): Integer;
begin
  // ��� � ��� ���� ����� ID = NULL
  qDiscName.W.Save(ADiscNameI, EditMode);

  // �������-�� ��������� ��������� ��������� � ��
  qDiscName.FDQuery.ApplyUpdates(0);
  qDiscName.FDQuery.CommitUpdates;

  // ��� ������ ��������� ������������� ID
  Assert(qDiscName.W.PK.AsInteger > 0);
  Result := qDiscName.W.PK.AsInteger;
end;

procedure TCourseGroup.CancelCourseStudyPlan;
begin
  FqCourseStudyPlan.W.TryCancel;
  if FqCourseStudyPlan.FDQuery.ChangeCount = 0 then
    Exit;

  FqCourseStudyPlan.FDQuery.CancelUpdates;
  Assert(FqCourseStudyPlan.FDQuery.ChangeCount = 0);
end;

procedure TCourseGroup.DoAfterDisciplinesApplyUpdates(ADataSet: TFDDataSet;
  AErrorCount: Integer);
var
  AW: TCourseStudyPlanW;
  I: Integer;
begin
  // ������ ������ ��������� �������� ����� ������
  // ��, ��� ������� � ���� ������, ����������� � � qCourseStudyPlan
  // ���� ���� qCourseStudyPlan ���������� CahedUpdates
  AW := TCourseStudyPlanW.Create(qCourseStudyPlan.W.AddClone(''));

  FqCourseStudyPlan.FDQuery.FilterChanges := [FireDAC.Comp.DataSet.rtModified,
    FireDAC.Comp.DataSet.rtInserted];
  FqCourseStudyPlan.FDQuery.First;
  while not FqCourseStudyPlan.FDQuery.Eof do
  begin
    case FqCourseStudyPlan.FDQuery.UpdateStatus of
      usModified:
        begin
          // ���� ��� ������ � ������� �������
          AW.LocateByPK(FqCourseStudyPlan.W.ID_StudyPlan.F.AsInteger, True);
          AW.TryEdit;
        end;
      usInserted:
        // ��������� ��� ������ � ������ �������
        AW.TryAppend;
    end;

    for I := 0 to FqCourseStudyPlan.FDQuery.FieldCount - 1 do
      AW.DataSet.Fields[I].Value := FqCourseStudyPlan.FDQuery.Fields[I].Value;

    AW.TryPost;

    FqCourseStudyPlan.FDQuery.Next;
  end;

  FqCourseStudyPlan.FDQuery.FilterChanges := [FireDAC.Comp.DataSet.rtDeleted];
  FqCourseStudyPlan.FDQuery.First;
  while not FqCourseStudyPlan.FDQuery.Eof do
  begin
    // ���� ��� ������ � ������� �������
    AW.LocateByPK(FqCourseStudyPlan.W.ID_StudyPlan.F.AsInteger, True);
    AW.DataSet.Delete;

    FqCourseStudyPlan.FDQuery.Next;
  end;

  FqCourseStudyPlan.FDQuery.FilterChanges := [FireDAC.Comp.DataSet.rtModified,
    FireDAC.Comp.DataSet.rtInserted, FireDAC.Comp.DataSet.rtUnModified];

end;

procedure TCourseGroup.DoAfterYearPost(Sender: TObject);
begin
  Assert(FIDEducationLevel > 0);

  // ���������� �� ������
  FqAllCourseStudyPlan.Search(FIDEducationLevel, Year);

  // ���� ������ �� �����
  FqAdmissions.Search(FIDEducationLevel, Year);

  if FAfterLoadData <> nil then
    FAfterLoadData.CallEventHandlers(Self);

  FOnYearChange.CallEventHandlers(Self);
end;

function TCourseGroup.GetAdmissionsW: TAdmissionsW;
begin
  Result := qAdmissions.W;
end;

function TCourseGroup.GetAfterLoadData: TNotifyEventsEx;
begin
  if FAfterLoadData = nil then
    FAfterLoadData := TNotifyEventsEx.Create(Self);

  Result := FAfterLoadData;
end;

function TCourseGroup.GetAllCourseStudyPlanW: TCourseStudyPlanW;
begin
  Result := qAllCourseStudyPlan.W;
end;

function TCourseGroup.GetChairsW: TChairsW;
begin
  Result := qChairs.W;
end;

function TCourseGroup.GetCourseEditI(AIDSpecialityEducation: Integer)
  : ICourseEdit;
begin
  // ���������� ��� ������ ������ ������, ������� �� �����������
  FID_SpecialityEducation := AIDSpecialityEducation;
  Result := Self;
end;

function TCourseGroup.GetCourseNameW: TCourseNameW;
begin
  Result := qCourseName.W;
end;

function TCourseGroup.GetCourseStudyPlanEditI(AIDStudyPlan: Integer)
  : ICourseStudyPlanEdit;
begin
  Assert(AIDStudyPlan > 0);
  // ����������, ����� ������ �������� ����� �� ����� �������������
  FID_StudyPlan := AIDStudyPlan;

  Result := Self;
  // ������ ������ ��� �������������
  (*
    AModel := TCourceDiscNameVM.Create(Self, CourceGroup.qAllCourseStudyPlan.W,
    CourceGroup.qDiscName, CourceGroup.qAdmissions.W.IDChair.F.AsInteger,
    CourceGroup.qAdmissions.W.ID_SpecialityEducation.F.AsInteger);
  *)
end;

function TCourseGroup.GetCourseStudyPlanViewI: ICourseStudyPlanView;
begin
  // ���� ����������� �������� ����� �� �������������� ������
  qCourseStudyPlan.Search(FID_SpecialityEducation);
  qCourseStudyPlan.FDQuery.CachedUpdates := True;
  qCourseStudyPlan.FDQuery.AfterApplyUpdates := DoAfterDisciplinesApplyUpdates;

  Result := Self;
end;

function TCourseGroup.GetCourseStudyPlanW: TCourseStudyPlanW;
begin
  // ���������� ICourseStudyPlanView
  // ���������� ������ ��������� ������ ������ �� �����

  Result := qCourseStudyPlan.W;
end;

function TCourseGroup.GetDiscNameW: TDiscNameW;
begin
  Result := qDiscName.W;
end;

function TCourseGroup.GetEdLvlW: TEdLvlW;
begin
  Result := qEdLvl.W;
end;

function TCourseGroup.GetIDChair: Integer;
begin
  // ��� ������� - ������������ ��� �������������� ����������
  // ICourseStudyPlanEdit

  // �� ������ �����, ����� ����� �� ����� �� �����������
  Assert(FID_SpecialityEducation > 0);
  qAdmissions.W.ID_SpecialityEducation.Locate(FID_SpecialityEducation, [], True);
  Result := qAdmissions.W.IDChair.F.AsInteger;
end;

function TCourseGroup.GetIDSpecialityEducation: Integer;
begin
  // ���������� ICourseStudyPlanEdit
  Assert(FID_SpecialityEducation > 0);
  Result := FID_SpecialityEducation;
end;

function TCourseGroup.GetIDYearW: TDumbW;
begin
  Result := YearDumb.W;
end;

function TCourseGroup.GetID_SpecialityEducation: Integer;
begin
  Result := FID_SpecialityEducation;
end;

function TCourseGroup.GetID_StudyPlan: Integer;
begin
  // ���������� ICourseStudyPlanEdit
  Assert(FID_StudyPlan > 0);
  Result := FID_StudyPlan;
end;

function TCourseGroup.GetqCourseStudyPlan: TQryCourseStudyPlan;
begin
  if FqCourseStudyPlan = nil then
    FqCourseStudyPlan := TQryCourseStudyPlan.Create(Self);

  Result := FqCourseStudyPlan;
end;

function TCourseGroup.GetqDiscName: TQryDiscName;
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

function TCourseGroup.GetqStudentGroups: TQueryStudentGroups;
begin
  if FqStudentGroups = nil then
    FqStudentGroups := TQueryStudentGroups.Create(Self);

  Result := FqStudentGroups;
end;

function TCourseGroup.GetqEdLvl: TQryEdLvl;
begin
  if FqEdLvl = nil then
    FqEdLvl := TQryEdLvl.Create(Self);

  Result := FqEdLvl;
end;

function TCourseGroup.GetStudentGroupsW: TStudentGroupsW;
begin
  Result := qStudentGroups.W;
end;

function TCourseGroup.GetYear: Integer;
begin
  Result := FYearDumb.W.ID.F.AsInteger;
end;

function TCourseGroup.GetYearsW: TYearsW;
begin
  Result := qYears.W;
end;

procedure TCourseGroup.Refresh;
begin
  qAllCourseStudyPlan.W.RefreshQuery;
  qAdmissions.W.RefreshQuery;
end;

procedure TCourseGroup.SearchStudGroups(AIDSpecialityEducation: Integer);
begin
  qAdmissions.W.ID_SpecialityEducation.Locate(AIDSpecialityEducation, [], True);
  qStudentGroups.Search(AIDSpecialityEducation, True);

  // �������� �� ��������� ��� ���� Start_Year!
  qStudentGroups.W.Start_Year_DefaultValue := qAdmissions.W.Year.F.AsInteger;
end;

procedure TCourseGroup.SetID_SpecialityEducation(const Value: Integer);
begin
  if FID_SpecialityEducation = Value then
    Exit;

  Assert(FID_SpecialityEducation = 0);
  Assert(Value > 0);
  FID_SpecialityEducation := Value;
end;

procedure TCourseGroup.SetYear(const Value: Integer);
begin
  if Year = Value then
    Exit;

  // �������� ������ ��� ���
  FYearDumb.W.UpdateID(Value);
end;

end.
