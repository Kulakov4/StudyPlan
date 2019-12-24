unit CreateCourcePlanForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, FDDumbQuery, CourceGroup, Data.DB,
  CourceNameQuery, FireDAC.Comp.Client, InsertEditMode, Vcl.ExtCtrls,
  StudentGroupsView, dxNavBarCollns, cxClasses, dxNavBarBase, dxNavBar,
  dxBarBuiltInMenu, cxPC, DisciplinesView, DPOSPQuery;

type
  TfrmCreateCourcePlan = class(TForm)
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
    dsSpeciality: TDataSource;
    procedure cxdblcbChairPropertiesChange(Sender: TObject);
    procedure cxdblcbSpecialityPropertiesEditValueChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxdblcbSpecialityPropertiesNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
    procedure cxPageControlChange(Sender: TObject);
    procedure cxPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet;
      var AllowChange: Boolean);
  private
    FCourceGroup: TCourceGroup;
    FCourceName: TFDMemTable;
    FCourceNameW: TCourceNameW;
    FID: Integer;
    FMode: TMode;
    FqChairDumb: TQueryFDDumb;
    FqSpecialityDumb: TQueryFDDumb;
    FViewDisciplines: TViewDisciplines;
    FViewStudentGroups: TViewStudentGroups;
    function GetData: Integer;
    function GetIDChair: Integer;
    function GetIDSpeciality: Integer;
    procedure SavePlan;
    procedure SaveGroups;
    procedure SaveSP;
    procedure SetData(const Value: Integer);
    procedure SetIDChair(const Value: Integer);
    procedure SetIDSpeciality(const Value: Integer);
    procedure SetMode(const Value: TMode);
    { Private declarations }
  protected
    procedure CheckPlan;
  public
    constructor Create(AOwner: TComponent); override;
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

constructor TfrmCreateCourcePlan.Create(AOwner: TComponent);
begin
  inherited;
  Assert(AOwner is TCourceGroup);

  FCourceGroup := AOwner as TCourceGroup;

  FID := FCourceGroup.qAdmissions.W.PK.AsInteger;

  FCourceGroup.qDPOSP.FDQuery.CachedUpdates := True;

  cxPageControl.ActivePage := cxtshPlan;

  // ������ ����
  FCourceName := FCourceGroup.qCourceName.W.AddClone('');
  // ������ ������
  FCourceNameW := TCourceNameW.Create(FCourceName);

  FMode := InsertMode;

  // *************
  // �������
  // *************
  FqChairDumb := TQueryFDDumb.Create(Self);
  FqChairDumb.Name := 'qChairDumb';

  if StudyProcessOptions.IDChair > 0 then
  begin
    FqChairDumb.W.UpdateID(StudyProcessOptions.IDChair);
    cxdblcbChair.Enabled := False;
  end;

  TDBLCB.Init(cxdblcbChair, FqChairDumb.DataSource, FqChairDumb.W.ID.FieldName,
    FCourceGroup.qChairs.DataSource, FCourceGroup.qChairs.W.������������,
    lsFixedList);

  // ********************************************
  // �������������
  // ********************************************
  FqSpecialityDumb := TQueryFDDumb.Create(Self);
  FqSpecialityDumb.Name := 'qSpecialityDumb';
  dsSpeciality.DataSet := FCourceNameW.DataSet;

  TDBLCB.Init(cxdblcbSpeciality, FqSpecialityDumb.DataSource,
    FqSpecialityDumb.W.ID.FieldName, dsSpeciality, FCourceNameW.Speciality,
    lsEditList);
end;

destructor TfrmCreateCourcePlan.Destroy;
begin
  inherited;
  // ������� ������
  FreeAndNil(FCourceNameW);
  // ������� ����
  FCourceGroup.qCourceName.W.DropClone(FCourceName);
end;

procedure TfrmCreateCourcePlan.CheckPlan;
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

procedure TfrmCreateCourcePlan.cxdblcbChairPropertiesChange(Sender: TObject);
begin
  (Sender as TcxDBLookupComboBox).PostEditValue;
  Assert(FqChairDumb.W.ID.F.AsInteger > 0);
  // ��������� ���������� ������ �������������� �� �������
  FCourceNameW.FilterByChair(FqChairDumb.W.ID.F.AsInteger);
  cxdblcbSpeciality.Enabled := True;
  cxteShort.Enabled := True;
end;

procedure TfrmCreateCourcePlan.cxdblcbSpecialityPropertiesEditValueChanged
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
    FCourceNameW.LocateByPK(FqSpecialityDumb.W.ID.F.AsInteger, True);
    cxteShort.Text := FCourceNameW.SHORT_SPECIALITY.F.AsString;
  end;

end;

procedure TfrmCreateCourcePlan.cxdblcbSpecialityPropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  if AText = '' then
    Exit;

  // �������� �������� ����� ������������ �������������� (���� � ID = NULL)
  FCourceNameW.Append(AText, cxteShort.Text, FqChairDumb.W.ID.F.AsInteger);

end;

procedure TfrmCreateCourcePlan.cxPageControlChange(Sender: TObject);
begin
  // ������� �� ������� ����������
  if (cxPageControl.ActivePage = cxtshDisciplines) and (FViewDisciplines = nil)
  then
  begin
    // � ����� ������� ���� ������ ���� ��� �������
    Assert(FCourceGroup.qAdmissions.W.PK.AsInteger > 0);

    // ������ �������������
    FViewDisciplines := TViewDisciplines.Create(Self);
    FViewDisciplines.Place(cxtshDisciplines);
    FViewDisciplines.CourceGroup := FCourceGroup;
  end;

  // ������� �� ������� ������
  if (cxPageControl.ActivePage = cxtshGroups) and (FViewStudentGroups = nil)
  then
  begin
    // � ����� ������� ���� ������ ���� ��� �������
    Assert(FCourceGroup.qAdmissions.W.PK.AsInteger > 0);

    FCourceGroup.qStudentGroups.Search
      (FCourceGroup.qAdmissions.W.PK.AsInteger, True);

    // �������� �� ��������� ��� ���� Start_Year!
    FCourceGroup.qStudentGroups.W.Start_Year_DefaultValue :=
      FCourceGroup.qAdmissions.W.Year.F.AsInteger;

    FViewStudentGroups := TViewStudentGroups.Create(Self);
    FViewStudentGroups.Place(cxtshGroups);
    FViewStudentGroups.SGW := FCourceGroup.qStudentGroups.W;
  end;
end;

procedure TfrmCreateCourcePlan.cxPageControlPageChanging(Sender: TObject;
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

procedure TfrmCreateCourcePlan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult <> mrOK then
  begin
    // �� ��������� ��������� ��������� � ��
    FCourceGroup.qCourceName.FDQuery.CancelUpdates;
    FCourceGroup.qDPOSP.FDQuery.CancelUpdates;

    if FCourceGroup.qStudentGroups.FDQuery.Active then
      FCourceGroup.qStudentGroups.FDQuery.CancelUpdates;

    FCourceGroup.qDPOSP.FDQuery.CachedUpdates := False;
    Exit;
  end;

  try
    if FMode = EditMode then
    begin
      Assert(FID > 0);
      // ������������ � ��� ������, ������� ������ �������������
      FCourceGroup.qAdmissions.W.LocateByPK(FID, True);
    end;


    SavePlan;
    if FID = 0 then
      FID := FCourceGroup.qAdmissions.W.PK.AsInteger;

    SaveSP;
    SaveGroups;
    FCourceGroup.qDPOSP.FDQuery.CachedUpdates := False;

    FCourceGroup.qAdmissions.W.LocateByPK(FID, True);

    // ��������� ���-�� ����� �������� �����
    if FCourceGroup.qStudentGroups.FDQuery.Active then
    begin
      FCourceGroup.qAdmissions.SetGroupCount
        (FCourceGroup.qStudentGroups.FDQuery.RecordCount);
    end;

    FCourceGroup.qAdmissions.W.LocateByPK(FID, True);
  except
    Action := caNone;
    raise;
  end;
end;

function TfrmCreateCourcePlan.GetData: Integer;
begin
  Result := StrToIntDef(cxteData.Text, 0);
end;

function TfrmCreateCourcePlan.GetIDChair: Integer;
begin
  Result := FqChairDumb.W.ID.F.AsInteger;
end;

function TfrmCreateCourcePlan.GetIDSpeciality: Integer;
begin
  Result := FqSpecialityDumb.W.ID.F.AsInteger;
end;

procedure TfrmCreateCourcePlan.SavePlan;
begin
  CheckPlan;

  // ��� � ��� ���� ����� ID = NULL
  FCourceNameW.LocateByPK(FqSpecialityDumb.W.ID.F.AsInteger);
  FCourceNameW.UpdateShortCaption(cxteShort.Text);

  // �������-�� ��������� ��������� ��������� � ��
  FCourceGroup.qCourceName.FDQuery.ApplyUpdates(0);
  FCourceGroup.qCourceName.FDQuery.CommitUpdates;
  Assert(FCourceGroup.qCourceName.FDQuery.ChangeCount = 0);

  // ��� ������ ��������� ������������� ID
  Assert(FCourceNameW.PK.AsInteger > 0);

  FqSpecialityDumb.W.UpdateID(FCourceNameW.PK.AsInteger);

  with FCourceGroup.qAdmissions.W do
  begin
    if Mode = InsertMode then
      TryAppend
    else
      TryEdit;

    IDSpeciality.F.AsInteger := Self.IDSpeciality;
    IDChair.F.AsInteger := Self.IDChair;
    Data.F.AsInteger := Self.Data;

    TryPost;

    // ������ ���� ����� ������ ���������������!
    FMode := EditMode;
  end;
end;

procedure TfrmCreateCourcePlan.SaveGroups;
begin
  if FCourceGroup.qStudentGroups.FDQuery.Active then
  begin
    // �������-�� ��������� ��������� ��������� � ��
    FCourceGroup.qStudentGroups.FDQuery.ApplyUpdates(0);
    FCourceGroup.qStudentGroups.FDQuery.CommitUpdates;
    Assert(FCourceGroup.qStudentGroups.FDQuery.ChangeCount = 0);
  end;
end;

procedure TfrmCreateCourcePlan.SaveSP;
begin
  // �������-�� ��������� ��������� ��������� � ��
  FCourceGroup.qDPOSP.FDQuery.ApplyUpdates(0);
  FCourceGroup.qDPOSP.FDQuery.CommitUpdates;
  Assert(FCourceGroup.qDPOSP.FDQuery.ChangeCount = 0);
end;

procedure TfrmCreateCourcePlan.SetData(const Value: Integer);
begin
  cxteData.Text := IntToStr(Value);
end;

procedure TfrmCreateCourcePlan.SetIDChair(const Value: Integer);
begin
  FqChairDumb.W.UpdateID(Value);
end;

procedure TfrmCreateCourcePlan.SetIDSpeciality(const Value: Integer);
begin
  FqSpecialityDumb.W.UpdateID(Value);
end;

procedure TfrmCreateCourcePlan.SetMode(const Value: TMode);
begin
  if FMode = Value then
    Exit;

  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FCourceGroup.qAdmissions.W.DataSet.RecordCount > 0);
        with FCourceGroup.qAdmissions do
        begin
          IDChair := W.IDChair.F.AsInteger;
          IDSpeciality := W.IDSpeciality.F.AsInteger;
          Data := W.Data.F.AsInteger;
        end;

        Caption := '�������������� �����';
        // btnClose.Caption := '���������';
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
        // btnClose.Caption := '�������';
      end;
  end;
end;

end.
