unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RxLogin, TB2Item, StdCtrls, TB2Dock, TB2Toolbar, Years,
  SpecEducation, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, CSE,
  SPUnit, LessonTypes, ExtCtrls, ActnList, ImgList, cxCheckBox, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, cxDBLabel, dxSkinscxPCPainter, cxPC,
  cxSplitter, Admissions, StudGroups, DPOStudyPlan, SPView2, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, Vcl.ComCtrls,
  StudyPlanFactors, dxDockControl, dxDockPanel, GridComboBox,
  SpecEducationGridComboBoxView, Cromis.Comm.IPC, Cromis.Comm.Custom,
  dxBarBuiltInMenu, System.Actions, cxClasses, cxLocalization,
  System.ImageList, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, DisciplineLit, KDBClient, CourceGroup,
  SpecEdGroup, SpecEdView, SPGroup, SPMainView, System.Contnrs, SPOView, VOView,
  RetrainingView, SpecEdSimpleQuery, SpecEdSimpleQuery2, CommissionOptions,
  Vcl.Menus;

const
  WM_SelectStudyPlan = WM_USER + 123;
  WM_AddDisciplineLit = WM_USER + 125;
  ProgramName = 'StudyPlan';
  IPCServerName = 'StudyPlanIPCServer';

type
  TfrmMain = class(TForm)
    rxldStudyPlan: TRxLoginDialog;
    pnlMain: TPanel;
    ImageList1: TImageList;
    ActionList1: TActionList;
    actReport: TAction;
    actDisciplines: TAction;
    cxpgcntrlMain: TcxPageControl;
    actQualifications: TAction;
    cxLocalizer1: TcxLocalizer;
    actEducationalStandarts: TAction;
    actSoftware: TAction;
    actCreateRetrainingPlan: TAction;
    cxtshDO: TcxTabSheet;
    cxtshNewDPO: TcxTabSheet;
    cxtshVO2: TcxTabSheet;
    cxtshFirst: TcxTabSheet;
    cxtshSPO2: TcxTabSheet;
    cxtshRetraining2: TcxTabSheet;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure actDisciplinesExecute(Sender: TObject);
    procedure actEducationalStandartsExecute(Sender: TObject);
    procedure actQualificationsExecute(Sender: TObject);
    procedure actReportExecute(Sender: TObject);
    procedure actSoftwareExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure rxldStudyPlanCheckUser(Sender: TObject;
      const UserName, Password: string; var AllowLogin: Boolean);
    procedure cxpcStudyPlanChange(Sender: TObject);
    procedure cxpgcntrlMainChange(Sender: TObject);
  private
    FCourceGrpDO: TCourceGroup;
    FCourceGrpDPO: TCourceGroup;
    FDisciplineListIDs: String;
    FEvents: TObjectList;
    FIPCServer: TIPCServer;
    FqSpecEdSimple: TQuerySpecEdSimple;
    FSPGrpVO: TSPGroup;
    FSPGrpSPO: TSPGroup;
    FSPGrpRetraining: TSPGroup;
    // FStudyPlanFactors: TStudyPlanFactors;
    FViewCourcesDO: TViewCources;
    FViewCourcesDPO: TViewCources;
    FViewRetraining: TViewRetraining;
    // FViewSpecEd: TViewSpecEd;
    FViewSPO: TViewSPO;
    FViewVO: TViewVO;
    // FYear: TYears;
    // FMountOfYear: TMountOfYear;
    // FSpecialitys: TSpecialitys;
    // FStudentGroups: TStudentGroups;
    function CheckPassword(AUserName, APassword: string): Boolean;
    procedure DoOnVOYearChange(Sender: TObject);
    procedure DoOnSPOYearChange(Sender: TObject);
    procedure DoOnRetrainingYearChange(Sender: TObject);
    procedure DoOnDOYearChange(Sender: TObject);
    procedure DoOnDPOYearChange(Sender: TObject);
    procedure DoOnRetrainingSpecEdChange(Sender: TObject);
    procedure DoOnSPOSpecEdChange(Sender: TObject);
    procedure DoOnVOSpecEdChange(Sender: TObject);
    function GetqSpecEdSimple: TQuerySpecEdSimple;
    procedure InternalSelectStudyPlan(IDSpecialityEducation: Integer;
      IDStudyPlan: Integer = 0);
    procedure LocalizeDevExpress;
    function Login: Boolean;
    procedure OnClientConnect(const Context: ICommContext);
    procedure OnClientDisconnect(const Context: ICommContext);
    procedure OnExecuteRequest(const Context: ICommContext;
      const Request, Response: IMessageData);
    procedure OnServerError(const Context: ICommContext;
      const Error: TServerError);
    procedure OpenSpecEd(AIDSpecialityEducation, AStudyPlanID: Integer);

    procedure RegisterProgram;
    procedure StartIPCServer;
    { Private declarations }
  protected
    procedure AddDisciplineLit(var Message: TMessage);
      message WM_AddDisciplineLit;
    procedure OnSelectStudyPlan(var Message: TMessage);
      message WM_SelectStudyPlan;
    procedure UpdateView;
  public
    destructor Destroy; override;
    procedure CheckSelectStudyPlan(Year, IDSpecialityEducation, x: Integer);
    procedure SelectStudyPlanByID(AStudyPlanID: Integer);
    property qSpecEdSimple: TQuerySpecEdSimple read GetqSpecEdSimple;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses DBServConnectionPooler, MyDataAccess, MyConnection, CMdLine,
  cxComboBoxGridView, DataSetView_2, DataSetWrap, DB, NotifyEvents, ViewFormEx,
  SpecialitySessionsView, SpecialitySessions, SpecEducationView,
  AdmissionGridView2, DPOPlanView, EssenceGridView, CSEView, SqlExpr,
  StudyPlanFactorsView2, Qualifications, System.Win.Registry, System.IOUtils,
  EducationalStandarts, AdoptionDatesForm, StudyPlanAdoption, UMKAdoption,
  SoftwareDocument, SoftwareView, SpecEducSimple, DisciplineNames,
  OptionsHelper, GridViewForm, DiscNameGroup, DiscNameView, MyDir,
  GetSpecEdBySP;

{$R *.dfm}

destructor TfrmMain.Destroy;
begin
  FreeAndNil(FEvents);
  inherited;
end;

procedure TfrmMain.actQualificationsExecute(Sender: TObject);
var
  Qualifications: TQualifications;
  frmQualifications: TfrmViewEx;
begin
  frmQualifications := TfrmViewEx.Create(Self, '������������',
    'QualifacationForm', [mbOk]);
  try
    Qualifications := TQualifications.Create(Self);
    try
      Qualifications.Refresh;
      frmQualifications.ViewClass := TdsgvEssence;
      (frmQualifications.View as TdsgvEssence)
        .cxgridDBBandedTableView.OptionsView.BandHeaders := False;
      frmQualifications.View.SetDocument(Qualifications);
      frmQualifications.ShowModal;
    finally
      Qualifications.Free;
    end;
  finally
    FreeAndNil(frmQualifications);
  end;

end;

procedure TfrmMain.actDisciplinesExecute(Sender: TObject);
var
  ADiscNameGroup: TDiscNameGroup;
  F: TfrmGridView;
begin
  ADiscNameGroup := TDiscNameGroup.Create(Self);
  F := TfrmGridView.Create(Self, '����������',
    TMyDir.AppDataDirFile('DisciplineNameForm.ini'), [mbOk]);
  try
    F.GridViewClass := TViewDiscName;
    (F.GridView as TViewDiscName).DiscNameGroup := ADiscNameGroup;
    F.ShowModal;
  finally
    FreeAndNil(F);
    FreeAndNil(ADiscNameGroup);
  end;
end;

procedure TfrmMain.actEducationalStandartsExecute(Sender: TObject);
(*
  var
  AfrmAdoptionDates: TfrmAdoptionDates;
  AEducationalStandarts: TEducationalStandarts;
  AStudyPlanAdoption: TStudyPlanAdoption;
  AUMKAdoption: TUMKAdoption;
  // frmEducationalStandarts: TfrmViewEx;
*)
begin
  (*
    Assert(FAllSpecEducation <> nil);

    AfrmAdoptionDates := TfrmAdoptionDates.Create(Self, '���� �����������',
    'AdoptionDateForm', [mbOk]);
    try
    AEducationalStandarts := TEducationalStandarts.Create(Self);
    AStudyPlanAdoption := TStudyPlanAdoption.Create(Self);
    AUMKAdoption := TUMKAdoption.Create(Self);
    try
    // ����������� ���� ����������� ������� ������ � ����
    AStudyPlanAdoption.YearParam.ParamValue := FAllSpecEducation.Year.Value;
    AStudyPlanAdoption.Refresh;

    AEducationalStandarts.Refresh;

    AUMKAdoption.YearParam.ParamValue := FAllSpecEducation.Year.Value;
    AUMKAdoption.Refresh;

    AfrmAdoptionDates.EducationalStandartsView.SetDocument
    (AEducationalStandarts);
    AfrmAdoptionDates.StudyPlanAdoptionView.SetDocument(AStudyPlanAdoption);
    AfrmAdoptionDates.UMKAdoptionView.SetDocument(AUMKAdoption);
    AfrmAdoptionDates.ShowModal;
    finally
    FreeAndNil(AUMKAdoption);
    FreeAndNil(AStudyPlanAdoption);
    FreeAndNil(AEducationalStandarts);
    end;
    finally
    FreeAndNil(AfrmAdoptionDates);
    end;
  *)
end;

procedure TfrmMain.actReportExecute(Sender: TObject);
begin;
end;

procedure TfrmMain.actSoftwareExecute(Sender: TObject);
var
  frmSoftware: TfrmViewEx;
  ASoftware: TSoftwareDocument;
begin
  ASoftware := TSoftwareDocument.Create(Self);
  frmSoftware := TfrmViewEx.Create(Self, '����������� �����������',
    'SoftwareForm', [mbOk]);
  try
    frmSoftware.ViewClass := TViewSoftware;
    frmSoftware.View.SetDocument(ASoftware);
    frmSoftware.ShowModal;
  finally
    FreeAndNil(frmSoftware);
  end;
end;

procedure TfrmMain.AddDisciplineLit(var Message: TMessage);
var
  ADisciplineLit: TDisciplineLit;
begin
  inherited;

  // ShowMessage(FDisciplineListIDs);

  ADisciplineLit := DisciplineLit.DiscLit;

  if ADisciplineLit.IDDisciplineNameParam.IsEmpty then
  begin
    Exit;
  end;

  // ��������� � ������ ����������
  ADisciplineLit.AddLit(FDisciplineListIDs);
  Application.BringToFront;
end;

function TfrmMain.CheckPassword(AUserName, APassword: string): Boolean;
var
  AMySQLQuery: TMySQLQuery;
  UserName: string;
begin
  Assert(DBServerConnectionPooler <> nil);
  Result := False;
  AMySQLQuery := TMySQLQuery.Create(nil, 0);
  try
    try
      AMySQLQuery.SQLConnection.Execute
        (Format('begin StudyPlanPack.logon(''%s'', ''%s'');  end;',
        [AUserName, APassword]), nil);

      AMySQLQuery.SQL.Text :=
        'select AUDIT_BASE.Authorization.AccessLevel from dual';
      AMySQLQuery.Open;

      if StudyProcessOptions = nil then
        StudyProcessOptions := TStudyPlanOptions.Create(Self);

      StudyProcessOptions.AccessLevel := AMySQLQuery.FieldByName('AccessLevel')
        .AsInteger;

      // ���������� ��� ������������ � ������ ����� �������� �� ��������� �����������
      StudyProcessOptions.UserName := AUserName;
      StudyProcessOptions.Password := APassword;

      // �������� ������� ����������������� ������������
      AMySQLQuery.SQL.Text := 'select STUDYPLANPACK.ID_CHAIR from dual';
      AMySQLQuery.Open;
      StudyProcessOptions.IDChair := AMySQLQuery.FieldByName('ID_CHAIR')
        .AsInteger;

      AMySQLQuery.SQL.Text :=
        'select ��.������� || '' '' || ��.���|| '' '' || ��.�������� ��� ' +
        'from �������������� �� ' +
        'where ��.������������� =  AUDIT_BASE.AUTHORIZATION."���������������"';
      AMySQLQuery.Open;
      UserName := Trim(AMySQLQuery.FieldByName('���').AsString);
      if UserName = '' then
        UserName := AUserName;

      Caption := Format('������� ���� - %s', [UserName]);

      Result := True;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    FreeAndNil(AMySQLQuery);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  ACommandLine: TCommandLine;
  AcxTabSheet: TcxTabSheet;
  AIDSpecialityEducation: Integer;
begin
  FEvents := TObjectList.Create;

  cxpgcntrlMain.ActivePage := cxtshFirst;
  UpdateView;

  FDisciplineListIDs := '';
  // ������������� NLS_LANG
  SetEnvironmentVariable('NLS_LANG', 'RUSSIAN_CIS.CL8MSWIN1251');

  if StudyProcessOptions = nil then
    StudyProcessOptions := TStudyPlanOptions.Create(Self);

  try
    // ������ ��� ���������� � �������� ��.
    DBServerConnectionPooler := TDBServerConnectionPooler.Create
      (TMyDBServerConnection);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

  if (DBServerConnectionPooler = nil) or (not Login) then
  begin
    Application.ShowMainForm := False;
    PostMessage(Handle, WM_QUIT, 0, 0);
    Exit;
  end;

  LocalizeDevExpress; // ������������ DevExpress
  RegisterProgram; // ������������ ��������� � �������
  StartIPCServer; // ��������� IPC ������

  AIDSpecialityEducation := 0;
  // AIDStudyPlan := 0;
  ACommandLine := TCommandLine.Create('/', '=');
  try
    if ACommandLine.Params.FindParam('IDSpecialityEducation') >= 0 then
      AIDSpecialityEducation :=
        StrToIntDef(ACommandLine.Params.ParamByName
        ('IDSpecialityEducation'), 0);
    (*
      if ACommandLine.Params.FindParam('IDStudyPlan') >= 0 then
      AIDStudyPlan :=
      StrToIntDef(ACommandLine.Params.ParamByName('IDStudyPlan'), 0);
    *)
  finally
    FreeAndNil(ACommandLine);
  end;

  (*
    // ���� � ���������� ��� ������� �������� ������ ��� � ������ � ���������� � ������� �����
    if AIDStudyPlan > 0 then
    begin
    ASpecEducationShort := TSpecEducationShort.Create(Self);
    try
    ASpecEducationShort.IDStudyPlanParam.ParamValue := AIDStudyPlan;
    ASpecEducationShort.Refresh;

    if ASpecEducationShort.DS.IsEmpty then
    begin
    AIDStudyPlan := (StudyProcessOptions as TStudyPlanOptions).IDStudyPlan;
    end
    else
    begin
    AYear := ASpecEducationShort.Field('year').AsInteger;
    AIDSpecialityEducation := ASpecEducationShort.Field
    ('ID_SpecialityEducation').AsInteger;
    end;

    finally
    ASpecEducationShort.Free;
    end;
    end
    else
    AIDStudyPlan := (StudyProcessOptions as TStudyPlanOptions).IDStudyPlan;
  *)
  // ���� � ���������� ��������� �� ������ ��� �����
  if AIDSpecialityEducation > 0 then
  begin
    if qSpecEdSimple.SearchByPK(AIDSpecialityEducation) = 1 then
    begin
      // ���� ����� ������� �� ������ ���
      if TOptions.SP.AcademicYear <> FqSpecEdSimple.W.Year.F.AsInteger then
      begin
        TOptions.SP.AcademicYear := FqSpecEdSimple.W.Year.F.AsInteger;
        TOptions.SP.IDSpecEdVO := 0;
        TOptions.SP.IDSpecEdSPO := 0;
        TOptions.SP.IDSpecEdRetraining := 0;
      end;

      TOptions.SP.IDEducationLevel :=
        FqSpecEdSimple.W.IDEducationLevel.F.AsInteger;

      case TOptions.SP.IDEducationLevel of
        1, 2: // ��
          TOptions.SP.IDSpecEdVO := AIDSpecialityEducation;
        3: // ���
          TOptions.SP.IDSpecEdSPO := AIDSpecialityEducation;
        5: // ��������������
          TOptions.SP.IDSpecEdRetraining := AIDSpecialityEducation;
      end;
    end
    else
    begin
      // ���� �� ������ ������� ���� � ��������������� �� ��������� ������
      // Options.IDSpecEdVO := 0;
      // Options.IDSpecEdSPO := 0;
      // Options.IDSpecEdRetraining := 0;
    end;
  end;

  AcxTabSheet := cxtshVO2;
  // ������������, ����� ������� ����� ���������
  case TOptions.SP.IDEducationLevel of
    1, 2: // ��
      AcxTabSheet := cxtshVO2;
    3: // ���
      AcxTabSheet := cxtshSPO2;
    4:
      AcxTabSheet := cxtshDO; // ��
    5: // ��������������
      AcxTabSheet := cxtshRetraining2;
    6:
      AcxTabSheet := cxtshNewDPO; // ���
  end;

  UpdateView;

  // ��������� �� ������ �������
  if AcxTabSheet.TabVisible then
    cxpgcntrlMain.ActivePage := AcxTabSheet
  else
    cxpgcntrlMain.ActivePage := cxtshVO2;

  // �������� ������ �������
  cxtshFirst.TabVisible := False;
end;

procedure TfrmMain.FormPaint(Sender: TObject);
begin
  OnPaint := nil;
  WindowState := wsMaximized;
end;

function TfrmMain.Login: Boolean;
var
  ACommandLine: TCommandLine;
  AUserName: string;
  APassword: string;
begin
  ACommandLine := TCommandLine.Create('/', '=');
  try
    try
      AUserName := ACommandLine.Params.ParamByName('username');
      APassword := ACommandLine.Params.ParamByName('password');
      Result := CheckPassword(AUserName, APassword);
    except
      // ���� � ���������� ��� ������������ � ������, �� ����������� ���
      rxldStudyPlan.IniFileName := TPath.Combine(TOptions.SP.AppDataDir,
        'Login.ini');
      Result := rxldStudyPlan.Login;
    end
  finally
    FreeAndNil(ACommandLine);
  end;
end;

procedure TfrmMain.rxldStudyPlanCheckUser(Sender: TObject;
  const UserName, Password: string; var AllowLogin: Boolean);
begin
  AllowLogin := CheckPassword(UserName, Password);
end;

procedure TfrmMain.cxpcStudyPlanChange(Sender: TObject);
begin
  {
    if (cxpcStudyPlan.ActivePage = cxtsSMQ) and (FStudyPlanFactors = nil) then
    begin
    FStudyPlanFactors := TStudyPlanFactors.Create(Self);
    FStudyPlanFactors.IDAdmissionParam.Master := FSpecEdVO;
    with TviewStudyPlanFactors.Create(Self, cxtsSMQ) do
    begin
    SetDocument(FStudyPlanFactors);
    end;
    FStudyPlanFactors.Refresh;
    end;
  }
end;

procedure TfrmMain.cxpgcntrlMainChange(Sender: TObject);
begin
  // *************************************************
  // ������ ������� �� ������� ��������������2
  // *************************************************
  if (cxpgcntrlMain.ActivePage = cxtshRetraining2) then
  begin
    if (FSPGrpRetraining = nil) then
    begin
      Assert(FSPGrpRetraining = nil);
      FSPGrpRetraining := TSPGroup.Create(Self, TOptions.SP.AcademicYear,
        TOptions.SP.IDSpecEdRetraining, sptRetraining);

      TNotifyEventWrap.Create(FSPGrpRetraining.OnYearChange,
        DoOnRetrainingYearChange, FEvents);
      TNotifyEventWrap.Create(FSPGrpRetraining.OnSpecEdChange,
        DoOnRetrainingSpecEdChange, FEvents);

      FViewRetraining := TViewRetraining.Create(Self);
      with FViewRetraining do
      begin
        AccessLevel := TOptions.AccessLevel;
        Name := 'ViewRetraining';
        Align := alClient;
        Parent := cxtshRetraining2;
        SPRetViewI := FSPGrpRetraining;
      end;
    end
    else
      FSPGrpRetraining.Year := TOptions.SP.AcademicYear;

    TOptions.SP.IDEducationLevel := 5;
  end;

  // *************************************************
  // ������ ������� �� ������� ���2
  // *************************************************
  if (cxpgcntrlMain.ActivePage = cxtshSPO2) then
  begin
    if FSPGrpSPO = nil then
    begin
      Assert(FSPGrpSPO = nil);
      FSPGrpSPO := TSPGroup.Create(Self, TOptions.SP.AcademicYear,
        TOptions.SP.IDSpecEdSPO, sptSPO);

      TNotifyEventWrap.Create(FSPGrpSPO.OnYearChange,
        DoOnSPOYearChange, FEvents);
      TNotifyEventWrap.Create(FSPGrpSPO.OnSpecEdChange,
        DoOnSPOSpecEdChange, FEvents);

      FViewSPO := TViewSPO.Create(Self);
      with FViewSPO do
      begin
        AccessLevel := TOptions.AccessLevel;
        Name := 'ViewSPO';
        Align := alClient;
        Parent := cxtshSPO2;
        SPViewI := FSPGrpSPO;
      end;
    end
    else
      FSPGrpSPO.Year := TOptions.SP.AcademicYear;

    TOptions.SP.IDEducationLevel := 3;
  end;

  // *************************************************
  // ������ ������� �� ������� ��2
  // *************************************************
  if cxpgcntrlMain.ActivePage = cxtshVO2 then
  begin
    if (FSPGrpVO = nil) then
    begin
      Assert(FSPGrpVO = nil);
      FSPGrpVO := TSPGroup.Create(Self, TOptions.SP.AcademicYear,
        TOptions.SP.IDSpecEdVO, sptVO);

      TNotifyEventWrap.Create(FSPGrpVO.OnYearChange, DoOnVOYearChange, FEvents);
      TNotifyEventWrap.Create(FSPGrpVO.OnSpecEdChange,
        DoOnVOSpecEdChange, FEvents);

      FViewVO := TViewVO.Create(Self);
      with FViewVO do
      begin
        AccessLevel := TOptions.AccessLevel;
        Name := 'ViewVO';
        Align := alClient;
        Parent := cxtshVO2;
        SPViewI := FSPGrpVO;
      end;
    end
    else
      FSPGrpVO.Year := TOptions.SP.AcademicYear;

    TOptions.SP.IDEducationLevel := 1;
  end;

  // *************************************************
  // ������ ������� �� ������� ��
  // *************************************************
  if cxpgcntrlMain.ActivePage = cxtshDO then
  begin
    if FViewCourcesDO = nil then
    begin
      FCourceGrpDO := TCourceGroup.Create(Self, TOptions.SP.AcademicYear, 4);

      TNotifyEventWrap.Create(FCourceGrpDO.OnYearChange,
        DoOnDOYearChange, FEvents);

      FViewCourcesDO := TViewCources.Create(Self);
      with FViewCourcesDO do
      begin
        Name := 'ViewCourcesDO';
        AccessLevel := TOptions.AccessLevel;
        Place(cxtshDO);
        CourceGroup := FCourceGrpDO;
      end;
    end
    else
      FCourceGrpDO.Year := TOptions.SP.AcademicYear;

    TOptions.SP.IDEducationLevel := 4;
  end;

  // *************************************************
  // ������ ������� �� ������� ���
  // *************************************************
  if cxpgcntrlMain.ActivePage = cxtshNewDPO then
  begin
    if FViewCourcesDPO = nil then
    begin
      FCourceGrpDPO := TCourceGroup.Create(Self, TOptions.SP.AcademicYear, 6);

      TNotifyEventWrap.Create(FCourceGrpDPO.OnYearChange,
        DoOnDPOYearChange, FEvents);

      FViewCourcesDPO := TViewCources.Create(Self);
      with FViewCourcesDPO do
      begin
        Name := 'ViewCourcesDPO';
        AccessLevel := TOptions.AccessLevel;
        Place(cxtshNewDPO);
        CourceGroup := FCourceGrpDPO;
      end;
    end
    else
      FCourceGrpDPO.Year := TOptions.SP.AcademicYear;

    TOptions.SP.IDEducationLevel := 6;
  end;
end;

{ TODO : ���� ����� ���� ��������� ����������!!! }
procedure TfrmMain.CheckSelectStudyPlan(Year, IDSpecialityEducation,
  x: Integer);
// var
// Y: Integer;
begin
  (*
    Y := FYear.PKValue;
    if (Y <> Year) then
    raise Exception.CreateFmt
    ('������ %d ��� �������� �� %d ��� �������� �����. %d', [x, Year, Y]);

    if (FSpecEdVO.Year.AsInteger <> Year) then
    raise Exception.CreateFmt
    ('������ %d ��� �������� ����� �� ����������� ���������� ����', [x]);

    if (FSpecEdVO.PKValue <> IDSpecialityEducation) then
    raise Exception.CreateFmt
    ('������ %d ��� �������� �� ������� ���� � ����� %d.',
    [x, IDSpecialityEducation]);
  *)
end;

procedure TfrmMain.DoOnVOYearChange(Sender: TObject);
begin
  if TOptions.SP.AcademicYear = FSPGrpVO.Year then
    Exit;

  // ��������� ������� �� ����� ���!
  TOptions.SP.AcademicYear := FSPGrpVO.Year;
  TOptions.SP.IDSpecEdVO := 0;
  TOptions.SP.IDSpecEdSPO := 0;
  TOptions.SP.IDSpecEdRetraining := 0;
end;

procedure TfrmMain.DoOnSPOYearChange(Sender: TObject);
begin
  if TOptions.SP.AcademicYear = FSPGrpSPO.Year then
    Exit;

  // ��������� ������� �� ����� ���!
  TOptions.SP.AcademicYear := FSPGrpSPO.Year;
  TOptions.SP.IDSpecEdVO := 0;
  TOptions.SP.IDSpecEdSPO := 0;
  TOptions.SP.IDSpecEdRetraining := 0;
end;

procedure TfrmMain.DoOnRetrainingYearChange(Sender: TObject);
begin
  if TOptions.SP.AcademicYear = FSPGrpRetraining.Year then
    Exit;

  // ��������� ������� �� ����� ���!
  TOptions.SP.AcademicYear := FSPGrpRetraining.Year;
  TOptions.SP.IDSpecEdVO := 0;
  TOptions.SP.IDSpecEdSPO := 0;
  TOptions.SP.IDSpecEdRetraining := 0;
end;

procedure TfrmMain.DoOnDOYearChange(Sender: TObject);
begin
  if TOptions.SP.AcademicYear = FCourceGrpDO.Year then
    Exit;

  // ��������� ������� �� ����� ���!
  TOptions.SP.AcademicYear := FCourceGrpDO.Year;
  TOptions.SP.IDSpecEdVO := 0;
  TOptions.SP.IDSpecEdSPO := 0;
  TOptions.SP.IDSpecEdRetraining := 0;
end;

procedure TfrmMain.DoOnDPOYearChange(Sender: TObject);
begin
  if TOptions.SP.AcademicYear = FCourceGrpDPO.Year then
    Exit;

  // ��������� ������� �� ����� ���!
  TOptions.SP.AcademicYear := FCourceGrpDPO.Year;
  TOptions.SP.IDSpecEdVO := 0;
  TOptions.SP.IDSpecEdSPO := 0;
  TOptions.SP.IDSpecEdRetraining := 0;
end;

procedure TfrmMain.DoOnRetrainingSpecEdChange(Sender: TObject);
begin
  // ���������� ��������� ����
  TOptions.SP.IDSpecEdRetraining := FSPGrpRetraining.IDSpecialityEducation;
end;

procedure TfrmMain.DoOnSPOSpecEdChange(Sender: TObject);
begin
  // ���������� ��������� ����
  TOptions.SP.IDSpecEdSPO := FSPGrpSPO.IDSpecialityEducation;
end;

procedure TfrmMain.DoOnVOSpecEdChange(Sender: TObject);
begin
  // ���������� ��������� ����
  TOptions.SP.IDSpecEdVO := FSPGrpVO.IDSpecialityEducation;
end;

function TfrmMain.GetqSpecEdSimple: TQuerySpecEdSimple;
begin
  if FqSpecEdSimple = nil then
    FqSpecEdSimple := TQuerySpecEdSimple.Create(Self);

  Result := FqSpecEdSimple;
end;

procedure TfrmMain.OnSelectStudyPlan(var Message: TMessage);
begin
  if Message.WParam <> 0 then
    InternalSelectStudyPlan(Message.WParam);
  if Message.LParam <> 0 then
    SelectStudyPlanByID(Message.LParam);

  Application.BringToFront;
end;

procedure TfrmMain.OnClientConnect(const Context: ICommContext);
begin
  // ��� ������� ��� ���������� Context.Client
end;

procedure TfrmMain.OnClientDisconnect(const Context: ICommContext);
begin
  // ��������������� ��� ������������
end;

procedure TfrmMain.OnExecuteRequest(const Context: ICommContext;
  const Request, Response: IMessageData);
var
  vId: Integer;
begin
  FDisciplineListIDs := '';
  try
    vId := Request.Data.ReadInteger('IDSpecialityEducation');
    if vId <> 0 then
      PostMessage(Handle, WM_SelectStudyPlan, vId, 0);

    vId := Request.Data.ReadInteger('IDStudyPlan');
    if vId <> 0 then
      PostMessage(Handle, WM_SelectStudyPlan, 0, vId);

    FDisciplineListIDs := Request.Data.ReadString('IDDescription');
    if not FDisciplineListIDs.IsEmpty then
      PostMessage(Handle, WM_AddDisciplineLit, 0, 0);

  except
    raise Exception.Create('�������� �������');
  end;
end;

procedure TfrmMain.OnServerError(const Context: ICommContext;
  const Error: TServerError);
begin
  // lbl1.Caption := Format('Server error: %d - %s', [Error.Code, Error.Desc]);
end;

procedure TfrmMain.RegisterProgram;
var
  R: TRegistry;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    R.OpenKey('Software\AsuSoft\' + ProgramName, True);
    R.WriteString('Path', ParamStr(0));
    R.WriteString('IPCServerName', IPCServerName);
    R.CloseKey;
  finally
    R.Free
  end;
end;

{ TODO : ���� ����� ���� ��������� ����������!!! }
procedure TfrmMain.InternalSelectStudyPlan(IDSpecialityEducation: Integer;
  IDStudyPlan: Integer = 0);
// var
// ASpecEducation: TSpecEducation;
// AYear: Integer;
begin
  (*
    // AYear := 0;
    ASpecEducation := TSpecEducation.Create(Self);
    try
    ASpecEducation.IDSpecEducationParam.ParamValue := IDSpecialityEducation;
    ASpecEducation.Refresh;

    if ASpecEducation.DS.IsEmpty then
    raise Exception.Create('������������ ��� ������');

    AYear := ASpecEducation.Year.AsInteger;
    finally
    ASpecEducation.Free;
    end;

    FSPVO.DetachViews;
    FSpecEdVO.DataSetWrap.DetachViews;
    FYear.DataSetWrap.DetachViews;
    try
    FSpecEdVO.BeginUpdate;

    // �������� ������ ���

    if not FYear.LocateYear(AYear) then
    raise Exception.Create
    ('������ ��� �������� �� ������ ��� �������� �����');

    // ��� ��������� ������ �� ����
    FSpecEdVO.EndUpdate();

    // FSpecEdVO.BeginUpdate;

    // �������� ������ �����
    if not FSpecEdVO.DS.Locate(FSpecEdVO.KeyFieldName, IDSpecialityEducation, [])
    then
    raise Exception.Create('������ ��� �������� �� ������ ������� ����');

    // FSpecEdVO.EndUpdate();

    if IDStudyPlan > 0 then
    FSPVO.StudyPlanCDS.Locate('ID_studyplan', IDStudyPlan, []);

    CheckSelectStudyPlan(AYear, IDSpecialityEducation, 0);

    finally
    CheckSelectStudyPlan(AYear, IDSpecialityEducation, 1);
    FYear.DataSetWrap.AttachViews;
    CheckSelectStudyPlan(AYear, IDSpecialityEducation, 2);
    FSpecEdVO.DataSetWrap.AttachViews;
    CheckSelectStudyPlan(AYear, IDSpecialityEducation, 3);
    FSPVO.AttachViews;
    CheckSelectStudyPlan(AYear, IDSpecialityEducation, 4);
    end;
    CheckSelectStudyPlan(AYear, IDSpecialityEducation, 5);
    // cxtbshtMain.SetFocus;
  *)
end;

procedure TfrmMain.LocalizeDevExpress;
begin
  try
    cxLocalizer1.FileName := ExtractFilePath(ParamStr(0)) + 'Localization.ini';
    cxLocalizer1.Active := True;
    cxLocalizer1.Locale := 1049;
  except
    ;
  end;
end;

procedure TfrmMain.OpenSpecEd(AIDSpecialityEducation, AStudyPlanID: Integer);
var
  AcxTabSheet: TcxTabSheet;
begin
  Assert(AIDSpecialityEducation > 0);
  Assert(AStudyPlanID > 0);

  if qSpecEdSimple.SearchByPK(AIDSpecialityEducation) = 0 then
    Exit;

  // ���� ����� ������� �� ������ ���
  if TOptions.SP.AcademicYear <> FqSpecEdSimple.W.Year.F.AsInteger then
  begin
    TOptions.SP.AcademicYear := FqSpecEdSimple.W.Year.F.AsInteger;
    TOptions.SP.IDSpecEdVO := 0;
    TOptions.SP.IDSpecEdSPO := 0;
    TOptions.SP.IDSpecEdRetraining := 0;
  end;

  TOptions.SP.IDEducationLevel := FqSpecEdSimple.W.IDEducationLevel.F.AsInteger;

  case TOptions.SP.IDEducationLevel of
    1, 2: // ��
      TOptions.SP.IDSpecEdVO := AIDSpecialityEducation;
    3: // ���
      TOptions.SP.IDSpecEdSPO := AIDSpecialityEducation;
    5: // ��������������
      TOptions.SP.IDSpecEdRetraining := AIDSpecialityEducation;
  end;

  AcxTabSheet := cxtshVO2;
  // ������������, ����� ������� ����� ���������
  case TOptions.SP.IDEducationLevel of
    1, 2: // ��
      AcxTabSheet := cxtshVO2;
    3: // ���
      AcxTabSheet := cxtshSPO2;
    4:
      AcxTabSheet := cxtshDO; // ��
    5: // ��������������
      AcxTabSheet := cxtshRetraining2;
    6:
      AcxTabSheet := cxtshNewDPO; // ���
  end;

  UpdateView;

  cxpgcntrlMain.ActivePage := nil;
  // ��������� �� ������ ������� ���� ��� �������� �������� ������������
  if AcxTabSheet.TabVisible then
    cxpgcntrlMain.ActivePage := AcxTabSheet
  else
    cxpgcntrlMain.ActivePage := cxtshVO2;

  // �������� ������ �������
  cxtshFirst.TabVisible := False;
end;

procedure TfrmMain.SelectStudyPlanByID(AStudyPlanID: Integer);
Var
  Q: TQryGetSpecEdBySP;
begin
  Q := TQryGetSpecEdBySP.Create(Self);
  try
    if Q.SearchBy(AStudyPlanID) = 0 then
      Exit;

    OpenSpecEd(Q.W.ID_SPECIALITYEDUCATION.F.AsInteger, AStudyPlanID);

    // InternalSelectStudyPlan(ASpecialityEducationID, AStudyPlanID);
  finally
    FreeAndNil(Q);
  end;
end;

procedure TfrmMain.StartIPCServer;
begin
  FIPCServer := TIPCServer.Create;
  FIPCServer.ServerName := IPCServerName;
  FIPCServer.OnServerError := OnServerError;
  FIPCServer.OnClientConnect := OnClientConnect;
  FIPCServer.OnExecuteRequest := OnExecuteRequest;
  FIPCServer.OnClientDisconnect := OnClientDisconnect;
  FIPCServer.Start;
end;

procedure TfrmMain.UpdateView;
var
  OK: Boolean;
begin
  OK := (StudyProcessOptions <> nil) and (TOptions.SP.AccessLevel > 0);

  cxtshVO2.TabVisible := OK and (TOptions.AccessLevel >= alTeacher);
  cxtshSPO2.TabVisible := OK and (TOptions.AccessLevel >= alTeacher);
  cxtshRetraining2.TabVisible := OK and ((TOptions.AccessLevel >= alManager) or
    (TOptions.AccessLevel = alAllReadOnly));
  cxtshDO.TabVisible := OK and ((TOptions.AccessLevel >= alManager) or
    (TOptions.AccessLevel = alAllReadOnly));
  cxtshNewDPO.TabVisible := OK and ((TOptions.AccessLevel >= alManager) or
    (TOptions.AccessLevel = alAllReadOnly));

  actDisciplines.Visible := OK and (TOptions.AccessLevel = alAdmin);
  actDisciplines.Enabled := OK and (TOptions.AccessLevel = alAdmin);

  actSoftware.Enabled := OK and (TOptions.AccessLevel = alAdmin);
  actEducationalStandarts.Enabled := OK and (TOptions.AccessLevel = alAdmin);
end;

end.
