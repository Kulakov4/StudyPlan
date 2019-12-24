unit DisciplinesView;

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
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, DPOSPQuery,
  DisciplineNameQuery, System.ImageList, Vcl.ImgList, cxImageList, TB2Dock,
  TB2Toolbar, CourceGroup, TB2Item;

type
  TViewDisciplines = class(TfrmGrid)
    dsDisciplineName: TDataSource;
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    actAdd: TAction;
    cxImageList: TcxImageList;
    actEdit: TAction;
    TBItem1: TTBItem;
    TBItem2: TTBItem;
    TBItem3: TTBItem;
    actSave: TAction;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
  private
    FDPOSPW: TDPOSPW;
    FCourceGroup: TCourceGroup;
    FDisciplineNameW: TDisciplineNameW;
    procedure DoOnExamChange(Sender: TObject);
    procedure DoOnIDDisciplineNameChanged(Sender: TObject);
    function GetclExam: TcxGridDBBandedColumn;
    function GetclIDDisciplineName: TcxGridDBBandedColumn;
    function GetclLab: TcxGridDBBandedColumn;
    function GetclLec: TcxGridDBBandedColumn;
    function GetclSem: TcxGridDBBandedColumn;
    function GetclZach: TcxGridDBBandedColumn;
    procedure SetCourceGroup(const Value: TCourceGroup);
    { Private declarations }
  public
    destructor Destroy; override;
    procedure UpdateView; override;
    property clExam: TcxGridDBBandedColumn read GetclExam;
    property clIDDisciplineName: TcxGridDBBandedColumn
      read GetclIDDisciplineName;
    property clLab: TcxGridDBBandedColumn read GetclLab;
    property clLec: TcxGridDBBandedColumn read GetclLec;
    property clSem: TcxGridDBBandedColumn read GetclSem;
    property clZach: TcxGridDBBandedColumn read GetclZach;
    property CourceGroup: TCourceGroup read FCourceGroup write SetCourceGroup;
    { Public declarations }
  end;

implementation

uses
  cxDropDownEdit, cxCheckBox, DisciplineEditForm, FireDAC.Comp.Client,
  InsertEditMode, cxDBLookupComboBox;

{$R *.dfm}

destructor TViewDisciplines.Destroy;
begin
  CourceGroup := nil;

  inherited;
end;

procedure TViewDisciplines.actAddExecute(Sender: TObject);
var
  frm: TfrmEditDiscipline;
begin
  inherited;
  frm := TfrmEditDiscipline.Create(CourceGroup);
  try
    frm.ShowModal;
  finally
    FreeAndNil(frm);
  end;

  MyApplyBestFitForView(MainView);
  UpdateView;
end;

procedure TViewDisciplines.actEditExecute(Sender: TObject);
var
  frm: TfrmEditDiscipline;
begin
  inherited;
  frm := TfrmEditDiscipline.Create(CourceGroup);
  try
    frm.Mode := EditMode;
    frm.ShowModal;
  finally
    FreeAndNil(frm);
  end;

  MyApplyBestFitForView(MainView);
  UpdateView;
end;

procedure TViewDisciplines.actSaveExecute(Sender: TObject);
begin
  inherited;
  FDPOSPW.TryPost;

  UpdateView;
end;

procedure TViewDisciplines.DoOnExamChange(Sender: TObject);
begin
  (Sender as TcxCheckBox).PostEditValue;
  UpdateView;
end;

procedure TViewDisciplines.DoOnIDDisciplineNameChanged(Sender: TObject);
begin
  (Sender as TcxLookupComboBox).PostEditValue;
  clIDDisciplineName.ApplyBestFit();
  UpdateView;
end;

function TViewDisciplines.GetclExam: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(FDPOSPW.ExamData.FieldName);
end;

function TViewDisciplines.GetclIDDisciplineName: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(FDPOSPW.IDDisciplineName.FieldName);
end;

function TViewDisciplines.GetclLab: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(FDPOSPW.LabData.FieldName);
end;

function TViewDisciplines.GetclLec: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(FDPOSPW.LecData.FieldName);
end;

function TViewDisciplines.GetclSem: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(FDPOSPW.SemData.FieldName);
end;

function TViewDisciplines.GetclZach: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(FDPOSPW.ZachData.FieldName);
end;

procedure TViewDisciplines.SetCourceGroup(const Value: TCourceGroup);
var
  AIDChair: Integer;
begin
  if FCourceGroup = Value then
    Exit;

  if FCourceGroup <> nil then
  begin
    FCourceGroup.qDisciplineName.W.DropClone
      (FDisciplineNameW.DataSet as TFDMemTable);
    FCourceGroup.qDPOSP.W.DropClone(FDPOSPW.DataSet as TFDMemTable);
  end;

  FCourceGroup := Value;

  if FCourceGroup = nil then
  begin
    Exit;
  end;

  // Получаем клон содержащий дисциплины одного учебного плана
  FDPOSPW := FCourceGroup.GetCurrSPW;

  Assert(FCourceGroup.qAdmissions.FDQuery.RecordCount > 0);
  AIDChair := FCourceGroup.qAdmissions.W.IDChair.F.AsInteger;
  Assert(AIDChair > 0);

  // Создаём обёртку и клон
  FDisciplineNameW := TDisciplineNameW.Create
    (FCourceGroup.qDisciplineName.W.AddClone(''));
  // Фильтруем названия дисциплин по кафедре
//  FDisciplineNameW.FilterByChair(AIDChair);

  dsDisciplineName.DataSet := FDisciplineNameW.DataSet;
  DataSource.DataSet := FDPOSPW.DataSet;
  MainView.DataController.CreateAllItems;

  InitView(MainView);
  MainView.OptionsBehavior.CellHints := True;

  // Настраиваем подстановочную колонку Наименование дисциплины
  InitializeLookupColumn(clIDDisciplineName, dsDisciplineName, lsEditList,
    FDisciplineNameW.DisciplineName.FieldName,
    FDisciplineNameW.PKFieldName);

  (clIDDisciplineName.Properties as TcxLookupComboBoxProperties).OnEditValueChanged :=
    DoOnIDDisciplineNameChanged;

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
  (clZach.Properties as TcxCheckBoxProperties).ImmediatePost := True;
  (clZach.Properties as TcxCheckBoxProperties).OnEditValueChanged :=
    DoOnExamChange;

  clExam.PropertiesClass := TcxCheckBoxProperties;
  (clExam.Properties as TcxCheckBoxProperties).ValueChecked := 2;
  (clExam.Properties as TcxCheckBoxProperties).NullStyle := nssUnchecked;
  (clExam.Properties as TcxCheckBoxProperties).ValueUnchecked := 0;
  (clExam.Properties as TcxCheckBoxProperties).ImmediatePost := True;
  (clExam.Properties as TcxCheckBoxProperties).OnEditValueChanged :=
    DoOnExamChange;

  {
    MainView.OptionsData.Deleting := False;
    MainView.OptionsData.Appending := False;
    MainView.OptionsData.Inserting := False;
    MainView.OptionsData.Editing := False;
  }

  DeleteMessages.Add(cxGridLevel, 'Удалить выбранные дисциплины?');

  MyApplyBestFitForView(MainView);

  UpdateView;
end;

procedure TViewDisciplines.UpdateView;
var
  AView: TcxGridDBBandedTableView;
  OK: Boolean;
begin
  inherited;
  OK := (CourceGroup <> nil) and (FDPOSPW.DataSet.Active) and
    (CourceGroup.qDisciplineName.W.DataSet.Active);

  AView := FocusedTableView;

  actAdd.Enabled := OK;

  actEdit.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount = 1);

  actDeleteEx.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount > 0);

  actSave.Enabled := OK and FDPOSPW.HaveAnyChanges;
end;

end.
