unit SpecSessView;

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
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, SpecSessGroup,
  SpecSessQry, Vcl.StdCtrls, cxTextEdit, cxContainer, System.ImageList,
  Vcl.ImgList, cxImageList, dxDateRanges;

type
  TViewSpecSess = class(TfrmGrid)
    cxCellTextEdit: TcxTextEdit;
    actAddLevel: TAction;
    cxImageList1: TcxImageList;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    actSave: TAction;
    actAddSession: TAction;
    dxBarButton3: TdxBarButton;
    actDropLevel: TAction;
    dxbbDelete: TdxBarButton;
    actDropSession: TAction;
    actCancel: TAction;
    dxBarButton4: TdxBarButton;
    procedure actAddLevelExecute(Sender: TObject);
    procedure actAddSessionExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actDropLevelExecute(Sender: TObject);
    procedure actDropSessionExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure cxCellTextEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridDBBandedTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridDBBandedTableViewCellDblClick
      (Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridDBBandedTableViewMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cxGridLayoutChanged(Sender: TcxCustomGrid;
      AGridView: TcxCustomGridView);
    procedure cxGridDBBandedTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxCellTextEditPropertiesEditValueChanged(Sender: TObject);
  private
    FEditingFieldName: string;
    FEditingValue: Variant;
    FSpecSessGroup: TSpecSessGroup;
    function GetCellEdit: TcxTextEdit;
    function GetclSession: TcxGridDBBandedColumn;
    function GetclLevel: TcxGridDBBandedColumn;
    function GetclID_SpecialitySession: TcxGridDBBandedColumn;
    function GetclLevel_Year: TcxGridDBBandedColumn;
    function GetW: TSpecSessW;
    procedure SetSpecSessGroup(const Value: TSpecSessGroup);
    procedure ShowCellEdit;
    { Private declarations }
  protected
    procedure InitColumns(AView: TcxGridDBBandedTableView); override;
    property CellEdit: TcxTextEdit read GetCellEdit;
    property W: TSpecSessW read GetW;
  public
    constructor Create(AOwner: TComponent); override;
    procedure InitView(AView: TcxGridDBBandedTableView); override;
    procedure UpdateView; override;
    property clSession: TcxGridDBBandedColumn read GetclSession;
    property clLevel: TcxGridDBBandedColumn read GetclLevel;
    property clID_SpecialitySession: TcxGridDBBandedColumn
      read GetclID_SpecialitySession;
    property clLevel_Year: TcxGridDBBandedColumn read GetclLevel_Year;
    property SpecSessGroup: TSpecSessGroup read FSpecSessGroup
      write SetSpecSessGroup;
    { Public declarations }
  end;

implementation

uses
  cxDropDownEdit, System.Generics.Collections, System.Types;

{$R *.dfm}

constructor TViewSpecSess.Create(AOwner: TComponent);
begin
  inherited;
  cxCellTextEdit.Parent := cxGrid;
  cxCellTextEdit.Visible := False;
end;

procedure TViewSpecSess.actAddLevelExecute(Sender: TObject);
begin
  inherited;
  SpecSessGroup.qSpecSess.W.AppendSpecSess := assLevel;
  MainView.Controller.ClearSelection;
  MainView.DataController.Append;
  FocusColumnEditor(MainView, SpecSessGroup.qSpecSess.W.Session_.FieldName);
  UpdateView;
end;

procedure TViewSpecSess.actAddSessionExecute(Sender: TObject);
begin
  inherited;
  SpecSessGroup.qSpecSess.W.AppendSpecSess := assSession;
  MainView.Controller.ClearSelection;
  MainView.DataController.Append;
  FocusColumnEditor(MainView, SpecSessGroup.qSpecSess.W.Session_.FieldName);
  UpdateView;
end;

procedure TViewSpecSess.actCancelExecute(Sender: TObject);
begin
  inherited;
  SpecSessGroup.qSpecSess.W.TryCancel;
  UpdateView;
end;

procedure TViewSpecSess.actDropLevelExecute(Sender: TObject);
var
  ALevel: Variant;
  I: Integer;
//  src: Integer;
begin
  inherited;
  ALevel := MainView.Controller.SelectedRows[0].Values[clLevel.Index];
//  src := MainView.Controller.SelectedRowCount;

  MainView.Controller.ClearSelection;

  // Выделяем все строки с таким же курсом как у текущей
  for I := 0 to MainView.ViewData.RowCount - 1 do
  begin
    if MainView.ViewData.Rows[I].Values[clLevel.Index] = ALevel then
      MainView.ViewData.Rows[I].Selected := True;
  end;

  MainView.Controller.DeleteSelection;
  UpdateView;
end;

procedure TViewSpecSess.actDropSessionExecute(Sender: TObject);
begin
  inherited;
  // MainView.DataController.DeleteFocused;
  MainView.Controller.DeleteSelection;
  UpdateView;
end;

procedure TViewSpecSess.actSaveExecute(Sender: TObject);
begin
  inherited;
  SpecSessGroup.qSpecSess.W.TryPost;
  UpdateView;
end;

procedure TViewSpecSess.cxCellTextEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 27 then
  begin
    (Sender as TcxTextEdit).Hide;
    cxGrid.SetFocus;
  end;
end;

procedure TViewSpecSess.cxCellTextEditPropertiesEditValueChanged
  (Sender: TObject);
var
  AValue: Integer;
  AcxTextEdit: TcxTextEdit;
//  S: string;
begin
  inherited;
  AcxTextEdit := Sender as TcxTextEdit;
  AValue := StrToIntDef(AcxTextEdit.Text, 0);
  if AValue = 0 then
    Exit;

  // Обновляем значение поля в БД
  SpecSessGroup.qSpecSess.W.Update(FEditingFieldName, FEditingValue, AValue);
  AcxTextEdit.Hide;
  cxGrid.SetFocus;
end;

procedure TViewSpecSess.cxGridDBBandedTableViewCellClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  CellEdit.Hide;
end;

procedure TViewSpecSess.cxGridDBBandedTableViewCellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  ShowCellEdit;

  // Чтобы не срабатывало событие OnCellClick
  AHandled := True;
end;

procedure TViewSpecSess.cxGridDBBandedTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  S: string;
begin
  inherited;
  S := Sender.ClassName;

  if (Key = 13) and (Shift = []) then
    ShowCellEdit;
end;

procedure TViewSpecSess.cxGridDBBandedTableViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  HT: TcxCustomGridHitTest;
begin
  inherited;
  HT := MainView.ViewInfo.GetHitTest(X, Y);
  if HT is TcxGridViewNoneHitTest then
    CellEdit.Hide;
end;

procedure TViewSpecSess.cxGridLayoutChanged(Sender: TcxCustomGrid;
  AGridView: TcxCustomGridView);
begin
  inherited;
  {
    if MainView.Controller.FocusedRow = nil then
    Exit;

    if MainView.Controller.FocusedRow.IsData then
    Edit1.Visible := True
    else
    Edit1.Visible := False;
  }
end;

function TViewSpecSess.GetCellEdit: TcxTextEdit;
begin
  Result := cxCellTextEdit;
end;

function TViewSpecSess.GetclSession: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Session_.FieldName);
end;

function TViewSpecSess.GetclLevel: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Level_.FieldName);
end;

function TViewSpecSess.GetclID_SpecialitySession: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.ID_SpecialitySession.FieldName);
end;

function TViewSpecSess.GetclLevel_Year: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Level_year.FieldName);
end;

function TViewSpecSess.GetW: TSpecSessW;
begin
  Assert(FSpecSessGroup <> nil);
  Result := FSpecSessGroup.qSpecSess.W;
end;

procedure TViewSpecSess.InitColumns(AView: TcxGridDBBandedTableView);
var
  I: Integer;
begin
  inherited;
  // Настраиваем подстановочную наименование сессии
  InitializeLookupColumn(clSession, FSpecSessGroup.qSessType.W.DataSource,
    lsFixedList, FSpecSessGroup.qSessType.W.SessionType.FullName,
    FSpecSessGroup.qSessType.W.PKFieldName);

  // Группируем планы по году
  // clYear.GroupIndex := 0;
  // clYear.Options.Grouping := True;

  // *****************************
  // Сортировка
  // *****************************
  clSession.Options.SortByDisplayText := isbtOn;

  clLevel.Options.CellMerging := True;
  clLevel_Year.Options.CellMerging := True;

  MyApplyBestFitForView(MainView);
  for I := 0 to MainView.ColumnCount - 1 do
    MainView.Columns[I].MinWidth := MainView.Columns[I].Width;

  MainView.OptionsView.ColumnAutoWidth := True;

  FocusTopLeft(W.Level_.FieldName);
end;

procedure TViewSpecSess.InitView(AView: TcxGridDBBandedTableView);
begin
  inherited;
  MainView.OptionsView.ColumnAutoWidth := False;
  MainView.OptionsData.Deleting := False;
end;

procedure TViewSpecSess.SetSpecSessGroup(const Value: TSpecSessGroup);
begin
  if FSpecSessGroup = Value then
    Exit;

  FSpecSessGroup := Value;

  if FSpecSessGroup = nil then
  begin
    DSWrap := nil;
    Exit;
  end;

  DSWrap := FSpecSessGroup.qSpecSess.W;

  UpdateView;
end;

procedure TViewSpecSess.ShowCellEdit;
var
  ACellViewInfo: TcxGridTableDataCellViewInfo;
  ACVI: TcxGridTableDataCellViewInfo;
  ARecordIndex: Integer;
  R: TRect;
begin
  ARecordIndex := MainView.Controller.FocusedRecordIndex;
  ACellViewInfo := MainView.ViewInfo.RecordsViewInfo[ARecordIndex]
    .GetCellViewInfoByItem(MainView.Controller.FocusedColumn);

  FEditingFieldName := (ACellViewInfo.Item as TcxGridDBBandedColumn)
    .DataBinding.FieldName;

  R := ACellViewInfo.Bounds;
  ARecordIndex := MainView.Controller.FocusedRecordIndex - 1;
  while ARecordIndex >= 0 do
  begin
    ACVI := MainView.ViewInfo.RecordsViewInfo[ARecordIndex]
      .GetCellViewInfoByItem(MainView.Controller.FocusedColumn);

    // если границы предыдущей ячейки не пересакаются с текущей
    if not ACVI.Bounds.IntersectsWith(ACellViewInfo.Bounds) then
      break;

    R := ACVI.Bounds;

    Dec(ARecordIndex);
  end;
  // Запоминаем список идентификаторов, записи которых будем редактировать
  CellEdit.Visible := True;
  CellEdit.BoundsRect := R;
  CellEdit.Properties.OnEditValueChanged := nil;
  FEditingValue := StrToIntDef(VarToStrDef(ACellViewInfo.Value, ''), 0);
  CellEdit.Text := VarToStrDef(ACellViewInfo.Value, '');
  CellEdit.Properties.OnEditValueChanged :=
    cxCellTextEditPropertiesEditValueChanged;
  CellEdit.SetFocus;
end;

procedure TViewSpecSess.UpdateView;
var
  ADeleteEnabled: Boolean;
  OK: Boolean;
begin
  inherited;
  OK := (SpecSessGroup <> nil) and (SpecSessGroup.qSpecSess.FDQuery.Active);
  actAddLevel.Enabled := OK and (not SpecSessGroup.qSpecSess.W.HaveAnyChanges);
  actAddSession.Enabled := actAddLevel.Enabled;

  actSave.Enabled := OK and SpecSessGroup.qSpecSess.W.HaveAnyChanges;
  actCancel.Enabled := actSave.Enabled;

  ADeleteEnabled := OK and (not SpecSessGroup.qSpecSess.W.HaveAnyChanges) and
    (MainView.Controller.SelectedRowCount = 1) and
    (MainView.Controller.SelectedColumnCount > 0);

  actDropLevel.Enabled := ADeleteEnabled and
    ((MainView.Controller.SelectedColumns[0] = clLevel) or
    (MainView.Controller.SelectedColumns[0] = clLevel_Year));

  actDropSession.Enabled := ADeleteEnabled and (not actDropLevel.Enabled);

  if actDropLevel.Enabled then
    dxbbDelete.Action := actDropLevel
  else
    dxbbDelete.Action := actDropSession;
end;

end.
