unit EditCourseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  Data.DB, CourseNameQuery, FireDAC.Comp.Client, InsertEditMode, Vcl.ExtCtrls,
  StudentGroupsView, dxNavBarCollns, cxClasses, dxNavBarBase, dxNavBar,
  dxBarBuiltInMenu, cxPC, AdmissionsInterface, FDDumb, CourseEditInterface,
  CourseStudyPlanView, CourseNameInterface;

type
  TfrmEditCourse = class(TForm, IAdmission, ICourseName)
    btnClose: TcxButton;
    cxPageControl: TcxPageControl;
    cxtshPlan: TcxTabSheet;
    cxtshDisciplines: TcxTabSheet;
    cxtshGroups: TcxTabSheet;
    Label10: TLabel;
    cxdblcbChair: TcxDBLookupComboBox;
    Label11: TLabel;
    cxdblcbSpeciality: TcxDBLookupComboBox;
    Label12: TLabel;
    cxteShort: TcxTextEdit;
    Label1: TLabel;
    cxteData: TcxTextEdit;
    procedure cxdblcbChairPropertiesChange(Sender: TObject);
    procedure cxdblcbSpecialityPropertiesEditValueChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxdblcbSpecialityPropertiesNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
    procedure cxPageControlChange(Sender: TObject);
    procedure cxPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet;
      var AllowChange: Boolean);
  strict private
    function GetID_Speciality: Integer;
    function GetID_SpecialityEducation: Integer; stdcall;
    function GetShortSpeciality: string;
    function GetSpeciality: string;
  private
    FCourseEditI: ICourseEdit;
    FCourseNameW: TCourseNameW;
    FMode: TMode;
    FqChairDumb: TFDDumb;
    FqSpecialityDumb: TFDDumb;
    FCourceStudyPlanView: TCourceStudyPlanView2;
    FViewStudentGroups: TViewStudentGroups;
    function GetData: Integer;
    function GetIDChair: Integer;
    function GetIDSpeciality: Integer;
    procedure SavePlan;
    procedure SetData(const Value: Integer);
    procedure SetIDChair(const Value: Integer);
    procedure SetIDSpeciality(const Value: Integer);
    procedure SetMode(const Value: TMode);
    { Private declarations }
  protected
    procedure CheckPlan;
  public
    constructor Create(AOwner: TComponent; ACourseEditI: ICourseEdit;
      AMode: TMode); reintroduce;
    destructor Destroy; override;
    property Data: Integer read GetData write SetData;
    property IDChair: Integer read GetIDChair write SetIDChair;
    property IDSpeciality: Integer read GetIDSpeciality write SetIDSpeciality;
    property Mode: TMode read FMode write SetMode;
    { Public declarations }
  end;

implementation

uses
  CommissionOptions, DBLookupComboBoxHelper;

{$R *.dfm}

constructor TfrmEditCourse.Create(AOwner: TComponent; ACourseEditI: ICourseEdit;
  AMode: TMode);
begin
  inherited Create(AOwner);
  Assert(ACourseEditI <> nil);
  FCourseEditI := ACourseEditI;

  cxPageControl.ActivePage := cxtshPlan;

  // ********************************************
  // �������� ������
  // ********************************************

  // ������ ������ ������ ������ ������� �������� ������
  FCourseNameW := TCourseNameW.Create(FCourseEditI.CourseNameW.AddClone(''));

  FqSpecialityDumb := TFDDumb.Create(Self);

  TDBLCB.Init(cxdblcbSpeciality, FqSpecialityDumb.W.ID, FCourseNameW.Speciality,
    lsEditList);

  // *************
  // �������
  // *************
  FqChairDumb := TFDDumb.Create(Self);

  if StudyProcessOptions.IDChair > 0 then
  begin
    FqChairDumb.W.UpdateID(StudyProcessOptions.IDChair);
    cxdblcbChair.Enabled := False;
  end;

  TDBLCB.Init(cxdblcbChair, FqChairDumb.W.ID, FCourseEditI.ChairsW.������������,
    lsFixedList);

  Mode := AMode;
end;

destructor TfrmEditCourse.Destroy;
begin
  inherited;
  // ������� ����
  FCourseEditI.CourseNameW.DropClone(FCourseNameW.DataSet as TFDMemTable);
end;

procedure TfrmEditCourse.CheckPlan;
var
  x: Integer;
begin
  if FqChairDumb.W.ID.F.AsInteger = 0 then
    raise Exception.Create('�� ������� �������');

  if cxdblcbSpeciality.Text = '' then
    raise Exception.Create('�� ������ ������������');

  if cxteShort.Text = '' then
    raise Exception.Create('�� ������ ����������');

  if cxteData.Text = '' then
    raise Exception.Create('�� ������ ���������� �����');

  // ���� ����� ���-�� �����
  if cxteData.Text <> '' then
  begin
    x := StrToIntDef(cxteData.Text, -1);
    if x < 0 then
      raise Exception.Create
        ('�������� ���������� ����� �� �������� ����� ������������� ������');
  end;
end;

procedure TfrmEditCourse.cxdblcbChairPropertiesChange(Sender: TObject);
begin
  (Sender as TcxDBLookupComboBox).PostEditValue;
  Assert(FqChairDumb.W.ID.F.AsInteger > 0);

  // ��������� ���������� ������ �������� ������ (��������������) �� �������
  FCourseNameW.FilterByChair(FqChairDumb.W.ID.F.AsInteger);

  cxdblcbSpeciality.Enabled := True;
  cxteShort.Enabled := True;
end;

procedure TfrmEditCourse.cxdblcbSpecialityPropertiesEditValueChanged
  (Sender: TObject);
var
  AcxDBLookupComboBox: TcxDBLookupComboBox;
begin
  AcxDBLookupComboBox := Sender as TcxDBLookupComboBox;
  AcxDBLookupComboBox.PostEditValue;
  if FqSpecialityDumb.W.ID.F.AsInteger = 0 then
  begin
    cxteShort.Text := '';
  end
  else
  begin
    FCourseNameW.LocateByPK(FqSpecialityDumb.W.ID.F.AsInteger, True);
    cxteShort.Text := FCourseNameW.SHORT_SPECIALITY.F.AsString;
  end;

end;

procedure TfrmEditCourse.cxdblcbSpecialityPropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  if AText = '' then
    Exit;

  // �������� �������� ����� ������������ �������������� (���� � ID = NULL)
  FCourseNameW.Save(Self, InsertMode);
end;

procedure TfrmEditCourse.cxPageControlChange(Sender: TObject);
begin
  // ������� �� ������� ����������
  if (cxPageControl.ActivePage = cxtshDisciplines) and
    (FCourceStudyPlanView = nil) then
  begin
    // � ����� ������� ���� ������ ���� ��� �������
    Assert(FCourseEditI.AdmissionsW.PK.AsInteger > 0);

    // ������ �������������
    FCourceStudyPlanView := TCourceStudyPlanView2.Create(Self);
    FCourceStudyPlanView.Place(cxtshDisciplines);
    FCourceStudyPlanView.CourseStudyPlanViewI :=
      FCourseEditI.GetCourseStudyPlanViewI;
  end;

  // ������� �� ������� ������
  if (cxPageControl.ActivePage = cxtshGroups) and (FViewStudentGroups = nil)
  then
  begin
    // � ����� ������� ���� ������ ���� ��� �������
    Assert(FCourseEditI.AdmissionsW.PK.AsInteger > 0);

    FCourseEditI.SearchStudGroups(FCourseEditI.ID_SpecialityEducation);

    FViewStudentGroups := TViewStudentGroups.Create(Self);
    FViewStudentGroups.Place(cxtshGroups);
    FViewStudentGroups.SGW := FCourseEditI.StudentGroupsW;
  end;
end;

procedure TfrmEditCourse.cxPageControlPageChanging(Sender: TObject;
  NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  // �������� ������� ���� - ���� �� ���������
  if cxPageControl.ActivePage = cxtshPlan then
  begin
    try
      SavePlan;
    except
      AllowChange := False;
      raise;
    end;
  end;
end;

procedure TfrmEditCourse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOK then
  begin
    // �������� ��������� � ����������� �������� ����� ������
    if FCourceStudyPlanView <> nil then
      FCourceStudyPlanView.CourseStudyPlanViewI.CancelCourseStudyPlan;

    // �� ��������� ��������� ��������� � ������ ������
    FCourseEditI.CancelCourceEdit;

    Exit;
  end;

  try
    SavePlan;

    // ��������� ��������� � ����������� �������� ����� ������
    if FCourceStudyPlanView <> nil then
      FCourceStudyPlanView.CourseStudyPlanViewI.ApplyCourseStudyPlan;

    // ��������� ��������� ������ � ���� ������
    FCourseEditI.ApplyStudGroups;
  except
    Action := caNone;
    raise;
  end;
end;

function TfrmEditCourse.GetData: Integer;
begin
  Result := StrToIntDef(cxteData.Text, 0);
end;

function TfrmEditCourse.GetIDChair: Integer;
begin
  Result := FqChairDumb.W.ID.F.AsInteger;
end;

function TfrmEditCourse.GetIDSpeciality: Integer;
begin
  Result := FqSpecialityDumb.W.ID.F.AsInteger;
end;

function TfrmEditCourse.GetID_Speciality: Integer;
begin
  Result := FqSpecialityDumb.W.ID.F.AsInteger;
end;

function TfrmEditCourse.GetID_SpecialityEducation: Integer;
begin
  Result := FCourseEditI.ID_SpecialityEducation;
end;

function TfrmEditCourse.GetShortSpeciality: string;
begin
  Result := cxteShort.Text;
end;

function TfrmEditCourse.GetSpeciality: string;
begin
  Result := cxdblcbSpeciality.Text;
end;

procedure TfrmEditCourse.SavePlan;
var
  AIDSpeciality: Integer;
begin
  CheckPlan;

  // ��������� ������������ ������ (�������������)
  AIDSpeciality := FCourseEditI.ApplyCourseName(Self);

  // �������� ���� ��� �������������
  FqSpecialityDumb.W.UpdateID(AIDSpeciality);

  // ��������� ���������� � ������ ������
  FCourseEditI.AdmissionsW.Save(Self, FMode);
  // ��������� ��� ������
  FCourseEditI.ID_SpecialityEducation :=
    FCourseEditI.AdmissionsW.ID_SpecialityEducation.F.AsInteger;

  // ������ ���� ����� ������ ���������������!
  FMode := EditMode;
end;

procedure TfrmEditCourse.SetData(const Value: Integer);
begin
  cxteData.Text := IntToStr(Value);
end;

procedure TfrmEditCourse.SetIDChair(const Value: Integer);
begin
  FqChairDumb.W.UpdateID(Value);
end;

procedure TfrmEditCourse.SetIDSpeciality(const Value: Integer);
begin
  FqSpecialityDumb.W.UpdateID(Value);
end;

procedure TfrmEditCourse.SetMode(const Value: TMode);
begin
  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FCourseEditI.ID_SpecialityEducation > 0);
        FCourseEditI.AdmissionsW.ID_SpecialityEducation.Locate
          (FCourseEditI.ID_SpecialityEducation, [], True);
        with FCourseEditI do
        begin
          IDChair := AdmissionsW.IDChair.F.AsInteger;
          IDSpeciality := AdmissionsW.IDSpeciality.F.AsInteger;
          Data := AdmissionsW.Data.F.AsInteger;
        end;

        Caption := '�������������� �����';
      end;
    InsertMode:
      begin
        if StudyProcessOptions.IDChair > 0 then
        begin
          IDChair := StudyProcessOptions.IDChair;
        end;
        IDSpeciality := 0;
        Data := 0;

        Caption := '����� ����';
      end;
  end;
end;

end.
