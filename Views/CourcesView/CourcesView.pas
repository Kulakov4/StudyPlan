unit CourcesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GridFrame, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.Menus,
  System.Actions, Vcl.ActnList, cxClasses, dxBar, Vcl.ComCtrls, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, CourceGroup,
  System.ImageList, Vcl.ImgList, cxImageList, cxDBLookupComboBox, cxCheckBox,
  TB2Item, TB2Dock, TB2Toolbar, Vcl.StdCtrls, NotifyEvents, Vcl.Samples.Spin,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, OptionsHelper, dxDateRanges, InsertEditMode, DSWrap;

type
  TViewCources = class(TfrmGrid)
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
    FCourceGroup: TCourceGroup;
    FDetailViewWrap: TGridViewWrap;
    function GetclIDChair: TcxGridDBBandedColumn;
    function GetclIDSpeciality: TcxGridDBBandedColumn;
    function GetclData: TcxGridDBBandedColumn;
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
    procedure SetCourceGroup(const Value: TCourceGroup);
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
    property CourceGroup: TCourceGroup read FCourceGroup write SetCourceGroup;
    { Public declarations }
  end;

implementation

uses
  GridSort, EditCourseForm, GridComboBox, DialogUnit, DBLookupComboBoxHelper,
  CourceDiscEditForm, CourceDiscNameViewModel;

{$R *.dfm}

constructor TViewCources.Create(AOwner: TComponent);
begin
  inherited;
  InitView(cxGridDBBandedTableView2);
  seYears.Value := CurrentYear + 1;
  FCanFocusRecord := True;
end;

procedure TViewCources.actAddPlanExecute(Sender: TObject);
begin
  inherited;
  ShowEditCourceForm(InsertMode);
end;

procedure TViewCources.actEditExecute(Sender: TObject);
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

procedure TViewCources.actAddDisciplineExecute(Sender: TObject);
begin
  inherited;
  ShowEditDisciplineForm(InsertMode);
end;

procedure TViewCources.actCopyExecute(Sender: TObject);
var
  A: TArray<Integer>;
begin
  inherited;
  A := GetSelectedIntValues(clIDSpecialityEducation);
  if Length(A) = 0 then
    Exit;

  if not TDialog.Create.CopyPlanDialog(Length(A), seYears.Value) then
    Exit;

  FCourceGroup.Copy(A, seYears.Value);
end;

procedure TViewCources.actEditDisciplineExecute(Sender: TObject);
begin
  inherited;
  ShowEditDisciplineForm(EditMode);
end;

procedure TViewCources.actEditPlanExecute(Sender: TObject);
begin
  inherited;
  ShowEditCourceForm(EditMode);
end;

procedure TViewCources.actMoveExecute(Sender: TObject);
var
  A: TArray<Integer>;
begin
  inherited;
  Assert(CourceGroup.qEdLvl.FDQuery.RecordCount > 0);
  A := GetSelectedIntValues(clIDSpecialityEducation);

  BeginUpdate;
  try
    CourceGroup.qAdmissions.Move(A,
      CourceGroup.qEdLvl.W.ID_Education_Level.F.AsInteger);
  finally
    EndUpdate;
  end;
end;

procedure TViewCources.actRefreshExecute(Sender: TObject);
begin
  inherited;
  BeginUpdate;
  try
    FCourceGroup.Refresh;
  finally
    EndUpdate;
  end;
end;

procedure TViewCources.BeginUpdate;
begin
  // FCanFocusRecord := False;
  // MainView.DataController.DataModeController.SyncMode := False;
  // cxGridDBBandedTableView2.DataController.DataModeController.SyncMode := False;
end;

procedure TViewCources.cxdblcbYearsPropertiesChange(Sender: TObject);
begin
  inherited;
  (Sender as TcxDBLookupComboBox).PostEditValue;
  FCourceGroup.YearDumb.W.TryPost;
end;

procedure TViewCources.cxGridDBBandedTableView2CanFocusRecord
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := FCanFocusRecord;
end;

procedure TViewCources.cxGridDBBandedTableView2CanSelectRecord
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := FCanFocusRecord;
end;

procedure TViewCources.cxGridDBBandedTableView2DblClick(Sender: TObject);
begin
  inherited;
  actEdit.Execute;
end;

procedure TViewCources.cxGridDBBandedTableView2EditKeyDown
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  DoOnEditKeyDown(Sender, AItem, AEdit, Key, Shift);
end;

procedure TViewCources.cxGridDBBandedTableView2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  DoOnKeyOrMouseDown;
end;

procedure TViewCources.cxGridDBBandedTableView2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  DoOnKeyOrMouseDown;
end;

procedure TViewCources.cxGridDBBandedTableViewCanFocusRecord
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := FCanFocusRecord;
end;

procedure TViewCources.cxGridDBBandedTableViewCanSelectRecord
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := FCanFocusRecord;
end;

procedure TViewCources.cxGridDBBandedTableViewColumnHeaderClick
  (Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  ApplySort(Sender, AColumn);
end;

procedure TViewCources.cxGridDBBandedTableViewDataControllerDetailExpanding
  (ADataController: TcxCustomDataController; ARecordIndex: Integer;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := FCanFocusRecord;
end;

procedure TViewCources.cxGridDBBandedTableViewDblClick(Sender: TObject);
begin
  inherited;
  actEdit.Execute;
end;

procedure TViewCources.DoAfterLoadData(Sender: TObject);
begin
  MyApplyBestFitForView(MainView);
  MainView.ViewData.Collapse(True);
  UpdateView;
end;

procedure TViewCources.EndUpdate;
begin
  // MainView.DataController.DataModeController.SyncMode := True;
  // cxGridDBBandedTableView2.DataController.DataModeController.SyncMode := True;
  // FCanFocusRecord := True;
end;

function TViewCources.GetclIDChair: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourceGroup.qAdmissions.W.IDChair.FieldName);
end;

function TViewCources.GetclIDSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourceGroup.qAdmissions.W.IDSpeciality.FieldName);
end;

function TViewCources.GetclData: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourceGroup.qAdmissions.W.Data.FieldName);
end;

function TViewCources.GetclIDDisciplineName: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourceGroup.qCourseStudyPlan.W.IDDisciplineName.FieldName);
end;

function TViewCources.GetclLec: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourceGroup.qCourseStudyPlan.W.LecData.FieldName);
end;

function TViewCources.GetclIDShortSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourceGroup.qAdmissions.W.IDShortSpeciality.FieldName);
end;

function TViewCources.GetclLab: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourceGroup.qCourseStudyPlan.W.LabData.FieldName);
end;

function TViewCources.GetclSem: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourceGroup.qCourseStudyPlan.W.SemData.FieldName);
end;

function TViewCources.GetclZach: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourceGroup.qCourseStudyPlan.W.ZachData.FieldName);
end;

function TViewCources.GetclExam: TcxGridDBBandedColumn;
begin
  Result := cxGridDBBandedTableView2.GetColumnByFieldName
    (FCourceGroup.qCourseStudyPlan.W.ExamData.FieldName);
end;

function TViewCources.GetclGroupCount: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourceGroup.qAdmissions.W.GroupCount.FieldName);
end;

function TViewCources.GetclIDSpecialityEducation: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCourceGroup.qAdmissions.W.PKFieldName);
end;

function TViewCources.GetDSWrap2: TDSWrap;
begin
  Result := nil;

  if FDetailViewWrap <> nil then
    Result := FDetailViewWrap.DSWrap;
end;

function TViewCources.GetFocusedTableView: TcxGridDBBandedTableView;
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

procedure TViewCources.InitColumns(AView: TcxGridDBBandedTableView);
begin
  inherited;

  if AView = MainView then
  begin
    // Настраиваем подстановочную Наименование
    InitializeLookupColumn(clIDSpeciality, FCourceGroup.qCourceName.DataSource,
      lsEditList, FCourceGroup.qCourceName.W.Speciality.FieldName,
      FCourceGroup.qCourceName.W.ID_Speciality.FieldName);

    // Настраиваем подстановочную сокращённое наименование
    InitializeLookupColumn(clIDShortSpeciality,
      FCourceGroup.qCourceName.DataSource, lsEditList,
      FCourceGroup.qCourceName.W.SHORT_SPECIALITY.FieldName,
      FCourceGroup.qCourceName.W.ID_Speciality.FieldName);

    // Настраиваем подстановочную колонку Кафедра
    InitializeLookupColumn(clIDChair, FCourceGroup.qChairs.DataSource,
      lsFixedList, FCourceGroup.qChairs.W.Short_Name.FieldName,
      FCourceGroup.qChairs.W.ID_CHAIR.FieldName);
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
    InitializeLookupColumn(clIDDisciplineName,
      FCourceGroup.qDiscName.DataSource, lsEditList,
      FCourceGroup.qDiscName.W.DisciplineName.FieldName,
      FCourceGroup.qDiscName.W.PKFieldName);

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

procedure TViewCources.InitView(AView: TcxGridDBBandedTableView);
begin
  inherited;
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

procedure TViewCources.SetAccessLevel(const Value: TAccessLevel);
begin
  FAccessLevel := Value;
  UpdateView;
end;

procedure TViewCources.SetCourceGroup(const Value: TCourceGroup);
begin
  if FCourceGroup = Value then
    Exit;

  // Отписываемся от событий
  FEventList.Clear;

  FCourceGroup := Value;

  if FCourceGroup = nil then
  begin
    DSWrap := nil;
    UpdateView;
    Exit;
  end;

  // Года
  TDBLCB.Init(cxdblcbYears, FCourceGroup.YearDumb.W.ID,
    FCourceGroup.qYears.W.Year, lsFixedList);

  // **************************************
  // Связываем подчинённый набор с главным
  // **************************************
  with cxGridDBBandedTableView2.DataController do
  begin
    DetailKeyFieldNames := FCourceGroup.qCourseStudyPlan.W.
      IDSPECIALITYEDUCATION.FieldName;

    MasterKeyFieldNames := FCourceGroup.qAdmissions.W.PKFieldName;
  end;

  DSWrap := FCourceGroup.qAdmissions.W;
  DSWrap2 := FCourceGroup.qCourseStudyPlan.W;

  BeginUpdate;
  try


    // ApplyBestFitForDetail := True;

    TNotifyEventWrap.Create(FCourceGroup.AfterLoadData, DoAfterLoadData,
      FEventList);
  finally
    EndUpdate;
  end;
  DoAfterLoadData(nil);
end;

procedure TViewCources.SetDSWrap2(const Value: TDSWrap);
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

procedure TViewCources.ShowEditCourceForm(AMode: TMode);
var
  frm: TfrmEditCourse;
begin
  inherited;
  cxGrid.SetFocus;
  MainView.Focused := True;

  frm := TfrmEditCourse.Create(FCourceGroup);
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

procedure TViewCources.ShowEditDisciplineForm(AMode: TMode);
var
  AModel: TCourceDiscNameVM;
  frm: TfrmCourceDiscEdit;
begin
  inherited;
  Assert(FCourceGroup.qAdmissions.W.DataSet.RecordCount > 0);

  // Создаём модель для представления
  AModel := TCourceDiscNameVM.Create(Self, CourceGroup.qCourseStudyPlan.W,
    CourceGroup.qDiscName, CourceGroup.qAdmissions.W.IDChair.F.AsInteger,
    CourceGroup.qAdmissions.W.ID_SpecialityEducation.F.AsInteger);

  BeginUpdate;
  try
    frm := TfrmCourceDiscEdit.Create(AModel);
    try
      frm.Mode := AMode;
      frm.ShowModal;
    finally
      FreeAndNil(AModel);
    end;
  finally
    EndUpdate;
  end;

  UpdateView;
end;

procedure TViewCources.UpdateView;
var
  AView: TcxGridDBBandedTableView;
  OK: Boolean;
begin
  inherited;
  AView := FocusedTableView;
  OK := (FCourceGroup <> nil) and (FCourceGroup.qAdmissions.FDQuery.Active) and
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
    (FCourceGroup.qEdLvl.FDQuery.RecordCount > 0);

  if OK and (actMove.Hint = '') then
  begin
    actMove.Caption := Format('Перенести на вкладку %s',
      [FCourceGroup.qEdLvl.W.Short_Education_Level.F.AsString]);
    actMove.Hint := actMove.Caption;
  end;

  actRefresh.Enabled := OK;
end;

end.
