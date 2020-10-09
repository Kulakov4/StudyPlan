unit CoursesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  GridFrame, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.Menus,
  System.Actions, Vcl.ActnList, cxClasses, dxBar, Vcl.ComCtrls, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  System.ImageList, Vcl.ImgList, cxImageList, cxDBLookupComboBox, cxCheckBox,
  TB2Item, TB2Dock, TB2Toolbar, Vcl.StdCtrls, NotifyEvents, Vcl.Samples.Spin,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, OptionsHelper, dxDateRanges, InsertEditMode, DSWrap,
  CourseViewInterface;

type
  TViewCourses = class(TfrmGrid)
    cxImageList: TcxImageList;
    actAddPlan: TAction;
    dxBarButton1: TdxBarButton;
    cxGridLevel2: TcxGridLevel;
    cxGridDBBandedTableView2: TcxGridDBBandedTableView;
    actEdit: TAction;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    actAddDiscipline: TAction;
    dxBarButton4: TdxBarButton;
    actEditPlan: TAction;
    actEditDiscipline: TAction;
    TBDock1: TTBDock;
    tbCources: TTBToolbar;
    TBItem1: TTBItem;
    TBItem3: TTBItem;
    TBItem4: TTBItem;
    TBToolbar1: TTBToolbar;
    tbi1: TTBItem;
    TBControlItem1: TTBControlItem;
    TBControlItem2: TTBControlItem;
    TBControlItem3: TTBControlItem;
    Label1: TLabel;
    Label2: TLabel;
    seYears: TSpinEdit;
    actCopy: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    actMove: TAction;
    N4: TMenuItem;
    TBItem2: TTBItem;
    actRefresh: TAction;
    TBItem5: TTBItem;
    TBToolbar2: TTBToolbar;
    tbci1: TTBControlItem;
    TBControlItem4: TTBControlItem;
    lbl1: TLabel;
    cxdblcbYears: TcxDBLookupComboBox;
    procedure actAddPlanExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actAddDisciplineExecute(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actEditDisciplineExecute(Sender: TObject);
    procedure actEditPlanExecute(Sender: TObject);
    procedure actMoveExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure cxGridDBBandedTableView2DblClick(Sender: TObject);
    procedure cxGridDBBandedTableView2EditKeyDown
      (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure cxGridDBBandedTableView2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridDBBandedTableView2MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cxGridDBBandedTableViewColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure cxGridDBBandedTableViewDblClick(Sender: TObject);
    procedure cxdblcbYearsPropertiesChange(Sender: TObject);
    procedure cxGridDBBandedTableView2CanFocusRecord
      (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      var AAllow: Boolean);
    procedure cxGridDBBandedTableView2CanSelectRecord
      (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      var AAllow: Boolean);
    procedure cxGridDBBandedTableViewCanFocusRecord
      (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      var AAllow: Boolean);
    procedure cxGridDBBandedTableViewCanSelectRecord
      (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      var AAllow: Boolean);
    procedure cxGridDBBandedTableViewDataControllerDetailExpanding
      (ADataController: TcxCustomDataController; ARecordIndex: Integer;
      var AAllow: Boolean);
  private
    FAccessLevel: TAccessLevel;
    FCanFocusRecord: Boolean;
    FCourseViewI: ICourseView;
    FDetailViewWrap: TGridViewWrap;
    function GetclIDChair: TcxGridDBBandedColumn;
    function GetclIDSpeciality: TcxGridDBBandedColumn;
    function GetclData: TcxGridDBBandedColumn;
    function GetclIDStudyPlan: TcxGridDBBandedColumn;
    function GetclIDDisciplineName: TcxGridDBBandedColumn;
    function GetclLec: TcxGridDBBandedColumn;
    function GetclIDShortSpeciality: TcxGridDBBandedColumn;
    function GetclLab: TcxGridDBBandedColumn;
    function GetclSem: TcxGridDBBandedColumn;
    function GetclZach: TcxGridDBBandedColumn;
    function GetclExam: TcxGridDBBandedColumn;
    function GetclGroupCount: TcxGridDBBandedColumn;
    function GetclIDSpecialityEducation: TcxGridDBBandedColumn;
    function GetDSWrap2: TDSWrap;
    procedure SetAccessLevel(const Value: TAccessLevel);
    procedure SetCourseViewI(const Value: ICourseView);
    procedure SetDSWrap2(const Value: TDSWrap);
    procedure ShowEditCourceForm(AMode: TMode);
    procedure ShowEditDisciplineForm(AMode: TMode);
    { Private declarations }
  protected
    procedure DoAfterLoadData(Sender: TObject);
    function GetFocusedTableView: TcxGridDBBandedTableView; override;
    procedure InitColumns(AView: TcxGridDBBandedTableView); override;
    property DSWrap2: TDSWrap read GetDSWrap2 write SetDSWrap2;
  public
    constructor Create(AOwner: TComponent); override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    procedure InitView(AView: TcxGridDBBandedTableView); override;
    procedure UpdateView; override;
    property AccessLevel: TAccessLevel read FAccessLevel write SetAccessLevel;
    property clIDChair: TcxGridDBBandedColumn read GetclIDChair;
    property clIDSpeciality: TcxGridDBBandedColumn read GetclIDSpeciality;
    property clData: TcxGridDBBandedColumn read GetclData;
    property clIDStudyPlan: TcxGridDBBandedColumn read GetclIDStudyPlan;
    property clIDDisciplineName: TcxGridDBBandedColumn
      read GetclIDDisciplineName;
    property clLec: TcxGridDBBandedColumn read GetclLec;
    property clIDShortSpeciality: TcxGridDBBandedColumn
      read GetclIDShortSpeciality;
    property clLab: TcxGridDBBandedColumn read GetclLab;
    property clSem: TcxGridDBBandedColumn read GetclSem;
    property clZach: TcxGridDBBandedColumn read GetclZach;
    property clExam: TcxGridDBBandedColumn read GetclExam;
    property clGroupCount: TcxGridDBBandedColumn read GetclGroupCount;
    property clIDSpecialityEducation: TcxGridDBBandedColumn
      read GetclIDSpecialityEducation;
    property CourseViewI: ICourseView read FCourseViewI write SetCourseViewI;
    { Public declarations }
  end;

implementation

uses
  GridSort, EditCourseForm, GridComboBox, DialogUnit, DBLookupComboBoxHelper,
  CourseStudyPlanEditForm;

{$R *.dfm}

constructor TViewCourses.Create(AOwner: TComponent);
begin
  inherited;
  InitView(cxGridDBBandedTableView2);
  seYears.Value := CurrentYear + 1;
  FCanFocusRecord := True;
end;

procedure TViewCourses.actAddPlanExecute(Sender: TObject);
begin
  inherited;
  ShowEditCourceForm(InsertMode);
end;

procedure TViewCourses.actEditExecute(Sender: TObject);
var
  AView: TcxGridDBBandedTableView;
begin
  inherited;

  BeginUpdate;
  try
    // CourceGroup.qAdmissions.W.PK.AsInteger
    // CourceGroup.qDPOSP.W.PK.AsInteger
    /// CourceGroup.qAdmissions.W.SaveBookmark;
    // CourceGroup.qDPOSP.W.SaveBookmark;

    AView := FocusedTableView;
    Assert(AView <> nil);

    if AView = MainView then
      actEditPlan.Execute
    else
      actEditDiscipline.Execute;

    // CourceGroup.qDPOSP.W.RestoreBookmark;
    // CourceGroup.qAdmissions.W.RestoreBookmark;
  finally
    EndUpdate;
  end;
end;

procedure TViewCourses.actAddDisciplineExecute(Sender: TObject);
begin
  inherited;
  ShowEditDisciplineForm(InsertMode);
end;

procedure TViewCourses.actCopyExecute(Sender: TObject);
var
  A: TArray<Integer>;
begin
  inherited;
  A := GetSelectedIntValues(clIDSpecialityEducation);
  if Length(A) = 0 then
    Exit;

  if not TDialog.Create.CopyPlanDialog(Length(A), seYears.Value) then
    Exit;

  FCourseViewI.Copy(A, seYears.Value);
end;

procedure TViewCourses.actEditDisciplineExecute(Sender: TObject);
begin
  inherited;
  ShowEditDisciplineForm(EditMode);
end;

procedure TViewCourses.actEditPlanExecute(Sender: TObject);
begin
  inherited;
  ShowEditCourceForm(EditMode);
end;

procedure TViewCourses.actMoveExecute(Sender: TObject);
var
  A: TArray<Integer>;
begin
  inherited;
  Assert(FCourseViewI.EdLvlW.RecordCount > 0);
  A := GetSelectedIntValues(clIDSpecialityEducation);

  BeginUpdate;
  try
    FCourseViewI.AdmissionMove(A,
      FCourseViewI.EdLvlW.ID_Education_Level.F.AsInteger);
  finally
    EndUpdate;
  end;
end;

procedure TViewCourses.actRefreshExecute(Sender: TObject);
begin
  inherited;
  BeginUpdate;
  try
    FCourseViewI.Refresh;
  finally
    EndUpdate;
  end;
end;

procedure TViewCourses.BeginUpdate;
begin
  // FCanFocusRecord := False;
  // MainView.DataController.DataModeController.SyncMode := False;
  // cxGridDBBandedTableView2.DataController.DataModeController.SyncMode := False;
end;

procedure TViewCourses.cxdblcbYearsPropertiesChange(Sender: TObject);
begin
  inherited;
  (Sender as TcxDBLookupComboBox).PostEditValue;
  FCourseViewI.IDYearW.TryPost;
end;

procedure TViewCourses.cxGridDBBandedTableView2CanFocusRecord
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := FCanFocusRecord;
end;

procedure TViewCourses.cxGridDBBandedTableView2CanSelectRecord
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := FCanFocusRecord;
end;

procedure TViewCourses.cxGridDBBandedTableView2DblClick(Sender: TObject);
begin
  inherited;
  actEdit.Execute;
end;

procedure TViewCourses.cxGridDBBandedTableView2EditKeyDown
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  DoOnEditKeyDown(Sender, AItem, AEdit, Key, Shift);
end;

procedure TViewCourses.cxGridDBBandedTableView2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  DoOnKeyOrMouseDown;
end;

procedure TViewCourses.cxGridDBBandedTableView2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  DoOnKeyOrMouseDown;
end;

procedure TViewCourses.cxGridDBBandedTableViewCanFocusRecord
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := FCanFocusRecord;
end;

procedure TViewCourses.cxGridDBBandedTableViewCanSelectRecord
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := FCanFocusRecord;
end;

procedure TViewCourses.cxGridDBBandedTableViewColumnHeaderClick
  (Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  ApplySort(Sender, AColumn);
end;

procedure TViewCourses.cxGridDBBandedTableViewDataControllerDetailExpanding
  (ADataController: TcxCustomDataController; ARecordIndex: Integer;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := FCanFocusRecord;
end;

procedure TViewCourses.cxGridDBBandedTableViewDblClick(Sender: TObject);
begin
  inherited;
  actEdit.Execute;
end;

procedure TViewCourses.DoAfterLoadData(Sender: TObject);
begin
  MyApplyBestFitForView(MainView);
  MainView.ViewData.Collapse(True);
  UpdateView;
end;

procedure TViewCourses.EndUpdate;
begin
  // MainView.DataController.DataModeController.SyncMode := True;
  // cxGridDBBandedTableView2.DataController.DataModeController.SyncMode := True;
  // FCanFocusRecord := True;
end;

function TViewCourses.GetclIDChair: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourseViewI.AdmissionsW.IDChair.FieldName);
end;

function TViewCourses.GetclIDSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourseViewI.AdmissionsW.IDSpeciality.FieldName);
end;

function TViewCourses.GetclData: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourseViewI.AdmissionsW.Data.FieldName);
end;

function TViewCourses.GetclIDStudyPlan: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourseViewI.CourseStudyPlanW.ID_StudyPlan.FieldName);
end;

function TViewCourses.GetclIDDisciplineName: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourseViewI.CourseStudyPlanW.IDDisciplineName.FieldName);
end;

function TViewCourses.GetclLec: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourseViewI.CourseStudyPlanW.LecData.FieldName);
end;

function TViewCourses.GetclIDShortSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourseViewI.AdmissionsW.IDShortSpeciality.FieldName);
end;

function TViewCourses.GetclLab: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourseViewI.CourseStudyPlanW.LabData.FieldName);
end;

function TViewCourses.GetclSem: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourseViewI.CourseStudyPlanW.SemData.FieldName);
end;

function TViewCourses.GetclZach: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourseViewI.CourseStudyPlanW.ZachData.FieldName);
end;

function TViewCourses.GetclExam: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourseViewI.CourseStudyPlanW.ExamData.FieldName);
end;

function TViewCourses.GetclGroupCount: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourseViewI.AdmissionsW.GroupCount.FieldName);
end;

function TViewCourses.GetclIDSpecialityEducation: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(FCourseViewI.AdmissionsW.PKFieldName);
end;

function TViewCourses.GetDSWrap2: TDSWrap;
begin
  Result := nil;

  if FDetailViewWrap <> nil then
    Result := FDetailViewWrap.DSWrap;
end;

function TViewCourses.GetFocusedTableView: TcxGridDBBandedTableView;
begin
  Result := inherited;

  // Если не первый уровень в фокусе
  if (Result = nil) then
  begin
    Result := GetDBBandedTableView(1);
    if (Result <> nil) and (not Result.Focused) then
      Result := nil;
  end;

end;

procedure TViewCourses.InitColumns(AView: TcxGridDBBandedTableView);
begin
  inherited;

  if AView = MainView then
  begin
    // Настраиваем подстановочную Наименование
    TDBLCB.InitColumn(clIDSpeciality, FCourseViewI.CourseNameW.Speciality,
      lsEditList);

    // Настраиваем подстановочную сокращённое наименование
    TDBLCB.InitColumn(clIDShortSpeciality,
      FCourseViewI.CourseNameW.SHORT_SPECIALITY, lsEditList);

    // Настраиваем подстановочную колонку Кафедра
    TDBLCB.InitColumn(clIDChair, FCourseViewI.ChairsW.Short_Name, lsFixedList);

    clIDChair.Options.SortByDisplayText := isbtOn;

    clIDSpeciality.BestFitMaxWidth := 900;
    clIDSpeciality.Options.SortByDisplayText := isbtOn;

    // *****************************
    // Сортировка
    // *****************************

    GridSort.Add(TSortVariant.Create(clIDChair, [clIDChair, clIDSpeciality,
      clData]));
    GridSort.Add(TSortVariant.Create(clIDSpeciality, [clIDSpeciality, clData,
      clIDChair]));
    GridSort.Add(TSortVariant.Create(clData, [clData, clIDSpeciality,
      clIDChair]));
    ApplySort(MainView, clIDSpeciality);
  end
  else
  begin
    // Настраиваем подстановочную колонку Наименование дисциплины
    TDBLCB.InitColumn(clIDDisciplineName, FCourseViewI.DiscNameW.DisciplineName,
      lsEditList);

    clIDDisciplineName.Options.SortByDisplayText := isbtOn;

    clLec.Options.AutoWidthSizable := False;
    clLec.Width := 100;
    clLab.Options.AutoWidthSizable := False;
    clLab.Width := 100;
    clSem.Options.AutoWidthSizable := False;
    clSem.Width := 100;
    clZach.Options.AutoWidthSizable := False;
    clZach.Width := 100;
    clExam.Options.AutoWidthSizable := False;
    clExam.Width := 100;

    clZach.PropertiesClass := TcxCheckBoxProperties;
    (clZach.Properties as TcxCheckBoxProperties).ValueChecked := 2;
    (clZach.Properties as TcxCheckBoxProperties).NullStyle := nssUnchecked;
    (clZach.Properties as TcxCheckBoxProperties).ValueUnchecked := 0;

    clExam.PropertiesClass := TcxCheckBoxProperties;
    (clExam.Properties as TcxCheckBoxProperties).ValueChecked := 2;
    (clExam.Properties as TcxCheckBoxProperties).NullStyle := nssUnchecked;
    (clExam.Properties as TcxCheckBoxProperties).ValueUnchecked := 0;
  end;
end;

procedure TViewCourses.InitView(AView: TcxGridDBBandedTableView);
begin
  inherited;
  // Сетка не синхронизирована с набором данных
  AView.DataController.DataModeController.SyncMode := False;

  MainView.OptionsData.Deleting := False;
  MainView.OptionsData.Appending := False;
  MainView.OptionsData.Inserting := False;
  MainView.OptionsData.Editing := False;
  MainView.OptionsView.CellAutoHeight := False;
  MainView.OptionsBehavior.CellHints := True;
  MainView.OptionsView.ExpandButtonsForEmptyDetails := False;
  MainView.OptionsBehavior.IncSearch := True;

  cxGridDBBandedTableView2.OptionsData.Deleting := False;
  cxGridDBBandedTableView2.OptionsData.Appending := False;
  cxGridDBBandedTableView2.OptionsData.Inserting := False;
  cxGridDBBandedTableView2.OptionsData.Editing := False;
  cxGridDBBandedTableView2.OptionsBehavior.CellHints := True;
  cxGridDBBandedTableView2.OptionsView.ColumnAutoWidth := True;

  DeleteMessages.Clear;
  DeleteMessages.Add(cxGridLevel, 'Удалить выделенные планы?');
  DeleteMessages.Add(cxGridLevel2, 'Удалить выделенные дисциплины?');
end;

procedure TViewCourses.SetAccessLevel(const Value: TAccessLevel);
begin
  FAccessLevel := Value;
  UpdateView;
end;

procedure TViewCourses.SetCourseViewI(const Value: ICourseView);
begin
  // Отписываемся от событий
  FEventList.Clear;

  FCourseViewI := Value;

  if FCourseViewI = nil then
  begin
    DSWrap := nil;
    DSWrap2 := nil;
    UpdateView;
    Exit;
  end;

  // Года
  TDBLCB.Init(cxdblcbYears, FCourseViewI.IDYearW.ID, FCourseViewI.YearsW.Year,
    lsFixedList);

  // **************************************
  // Связываем подчинённый набор с главным
  // **************************************
  with cxGridDBBandedTableView2.DataController do
  begin
    DetailKeyFieldNames := FCourseViewI.CourseStudyPlanW.
      IDSPECIALITYEDUCATION.FieldName;

    MasterKeyFieldNames := FCourseViewI.AdmissionsW.PKFieldName;
  end;

  DSWrap := FCourseViewI.AdmissionsW;
  DSWrap2 := FCourseViewI.CourseStudyPlanW;

  TNotifyEventWrap.Create(FCourseViewI.AfterLoadData, DoAfterLoadData,
    FEventList);
  DoAfterLoadData(nil);
end;

procedure TViewCourses.SetDSWrap2(const Value: TDSWrap);
begin
  if DSWrap2 = Value then
    Exit;

  if Value = nil then
  begin
    FreeAndNil(FDetailViewWrap);
  end
  else
  begin
    FDetailViewWrap := TGridViewWrap.Create(cxGridDBBandedTableView2, Value);
    FDetailViewWrap.Init;
  end;
end;

procedure TViewCourses.ShowEditCourceForm(AMode: TMode);
var
  A: TArray<Integer>;
  frm: TfrmEditCourse;
begin
  inherited;
  cxGrid.SetFocus;
  MainView.Focused := True;

  A := GetSelectedValues2<Integer>(clIDSpecialityEducation);

  if Length(A) = 0 then
    Exit;

  frm := TfrmEditCourse.Create(Self, FCourseViewI.GetCourseEditI(A[0]), AMode);
  try
    BeginUpdate;
    try
      frm.Mode := AMode;
      frm.ShowModal;
    finally
      EndUpdate;
    end;
  finally
    FreeAndNil(frm);
  end;

  cxGrid.SetFocus;
  MainView.Focused := True;

  MyApplyBestFitForView(MainView);

  UpdateView;
end;

procedure TViewCourses.ShowEditDisciplineForm(AMode: TMode);
var
  A: TArray<Integer>;
  frm: TfrmCourseStudyPlanEdit;
begin
  inherited;

  A := GetSelectedValues2<Integer>(clIDStudyPlan);
  if Length(A) = 0 then
    Exit;

  frm := TfrmCourseStudyPlanEdit.Create(Self, FCourseViewI.GetCourseStudyPlanEditI(A[0]), AMode );
  try
    frm.ShowModal;
  finally
    FreeAndNil(frm);
  end;

  UpdateView;
end;

procedure TViewCourses.UpdateView;
var
  AView: TcxGridDBBandedTableView;
  OK: Boolean;
begin
  inherited;
  AView := FocusedTableView;

  OK := (FCourseViewI <> nil) and (FCourseViewI.AdmissionsW.DataSet.Active) and
    (AccessLevel >= alManager);

  actAddPlan.Enabled := OK;

  actEdit.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount = 1);

  actDeleteEx.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount > 0);

  actAddDiscipline.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount = 1);

  actCopy.Enabled := OK and (AView <> nil) and (AView = MainView) and
    (AView.Controller.SelectedRowCount > 0);

  actMove.Enabled := OK and (AView <> nil) and (AView = MainView) and
    (AView.Controller.SelectedRowCount > 0) and
    (FCourseViewI.EdLvlW.RecordCount > 0);

  if OK and (actMove.Hint = '') then
  begin
    actMove.Caption := Format('Перенести на вкладку %s',
      [FCourseViewI.EdLvlW.Short_Education_Level.F.AsString]);
    actMove.Hint := actMove.Caption;
  end;

  actRefresh.Enabled := OK;
end;

end.
