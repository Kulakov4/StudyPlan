unit SoftwareView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataSetView_2, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls,
  SoftwareDocument, DocumentView, KcxGridView, TB2Dock, TB2Toolbar,
  System.Actions, Vcl.ActnList, Vcl.ImgList, TB2Item, Vcl.Menus,
  cxGridCustomPopupMenu, cxGridPopupMenu, DragHelper, Software, System.ImageList;

type
  TViewSoftware = class(TDataSetView2)
    cxGridLevel2: TcxGridLevel;
    cxGridDBBandedTableView2: TcxGridDBBandedTableView;
    tbdckTop: TTBDock;
    tbMain: TTBToolbar;
    ActionList: TActionList;
    actAddSoftwareType: TAction;
    ImageList: TImageList;
    tbiAddSoftwareType: TTBItem;
    actAddSoftware: TAction;
    tbiAddSoftware: TTBItem;
    actDelete: TAction;
    tbiDelete: TTBItem;
    cxGridPopupMenu: TcxGridPopupMenu;
    PopupMenu: TPopupMenu;
    actPasteFromBuffer: TAction;
    N1: TMenuItem;
    procedure actAddSoftwareExecute(Sender: TObject);
    procedure actAddSoftwareTypeExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPasteFromBufferExecute(Sender: TObject);
    procedure cxGridDBBandedTableView2DragDrop(Sender, Source: TObject; X, Y:
        Integer);
    procedure cxGridDBBandedTableView2DragOver(Sender, Source: TObject;
      X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure cxGridDBBandedTableView2EditKeyDown
      (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure cxGridDBBandedTableView2StartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure cxGridDBBandedTableViewDragDrop(Sender, Source: TObject;
      X, Y: Integer);
    procedure cxGridDBBandedTableViewDragOver(Sender, Source: TObject; X, Y:
        Integer; State: TDragState; var Accept: Boolean);
    procedure cxGridDBBandedTableViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
  private
    FDropDrag: TSDropDrag;
    FKcxGridDBBandedTableView2: TKcxGridDBBandedTableView;
    FSoftwareKeyColumn: TcxGridDBBandedColumn;
    FSoftwareTypeKeyColumn: TcxGridDBBandedColumn;
    FStartDrag: TSStartDrag;
    FStartDragLevel: TcxGridLevel;
    function GetDocument: TSoftwareDocument;
    { Private declarations }
  protected
    function GetFocusedTableView: TcxGridDBBandedTableView; override;
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn);
      override;
    property Document: TSoftwareDocument read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    procedure UpdateView; override;
    property KcxGridDBBandedTableView2: TKcxGridDBBandedTableView
      read FKcxGridDBBandedTableView2;
    { Public declarations }
  end;

var
  ViewSoftware: TViewSoftware;

implementation

{$R *.dfm}

uses NotifyEvents, Vcl.Clipbrd;

constructor TViewSoftware.Create(AOwner: TComponent; AParent: TWinControl;
  AAlign: TAlign = alClient);
begin
  inherited;
  // Создаём представление, связанное с 2-м уровнем
  FKcxGridDBBandedTableView2 := TKcxGridDBBandedTableView.Create(Self,
    cxGridDBBandedTableView2);
  // Подписываемся на событие о создании столбца
  TNotifyEventWrap.Create(FKcxGridDBBandedTableView2.AfterCreateColumn,
    OnCreateColumn);
  // Подписываемся на событие о инициализации столбца
  TNotifyEventWrap.Create(FKcxGridDBBandedTableView2.InitColumn,
    OnCreateColumn);

  FStartDrag := TSStartDrag.Create;
  FDropDrag := TSDropDrag.Create;
end;

procedure TViewSoftware.actAddSoftwareExecute(Sender: TObject);
var
  ARow: TcxCustomGridRow;
  AView: TcxGridDBBandedTableView;
begin
  // Получаем сфокусированную запись о типе ПО
  ARow := GetRow(0);

  if ARow = nil then
    Exit;

  cxGrid.BeginUpdate();
  try
    // раскрываем дочернее представление
    (ARow as TcxGridMasterDataRow).Expand(False);
    // Получаем текущее представление второго уровня (ПО)
    AView := GetDBBandedTableView(1);
    // Фокусируем его
    AView.Focused := True;
    // Просим контроллер вставить запись
    AView.DataController.Append;
  finally
    // Очищаем кэш глобальных нидексов
    cxGrid.EndUpdate;
  end;
  FocusColumnEditor(1, 'Name');
  UpdateView;
end;

procedure TViewSoftware.actAddSoftwareTypeExecute(Sender: TObject);
var
  AView: TcxGridDBBandedTableView;
begin
  cxGrid.BeginUpdate();
  try
    // Получаем текущее представление второго уровня (разделы)
    AView := GetDBBandedTableView(0);
    // Фокусируем его
    AView.Focused := True;
    // Просим контроллер вставить запись
    AView.DataController.Append;
  finally
    // Очищаем кэш глобальных нидексов
    cxGrid.EndUpdate;
  end;
  FocusColumnEditor(0, 'SoftwareType');
  UpdateView;
end;

procedure TViewSoftware.actDeleteExecute(Sender: TObject);
var
  AView: TcxGridDBBandedTableView;
  S: string;
begin
  AView := FocusedTableView;
  if AView = nil then
    Exit;

  S := '';
  if AView.Level = cxGridLevel then
    S := 'Удалить тип';

  if AView.Level = cxGridLevel2 then
    S := 'Удалить ПО';

  if (S <> '') and (Application.MessageBox(PWideChar(S), 'Удаление',
    MB_YESNO + MB_ICONQUESTION) = IDYES) and
    (AView.DataController.RecordCount > 0) then
  begin
    if AView.Controller.SelectedRowCount > 0 then
      AView.DataController.DeleteSelection
    else
      AView.DataController.DeleteFocused;

    if (AView.DataController.RecordCount = 0) and (AView.MasterGridRecord <> nil)
    then
    begin
      AView.MasterGridRecord.Collapse(False);
    end;

  end;

  UpdateView;
end;

procedure TViewSoftware.actPasteFromBufferExecute(Sender: TObject);
var
  AColumn: TcxGridDBBandedColumn;
  AList: TStringList;
  ANewList: TStringList;
  i: Integer;
  S: string;
  X: Integer;
begin
  if not Clipboard.HasFormat(CF_TEXT) then
    Exit;

  AList := TStringList.Create;
  ANewList := TStringList.Create;
  try
    AList.Text := Clipboard.AsText;
    for i := 0 to AList.Count - 1 do
    begin
      S := AList[i].Trim(['"', '''', ' ']);
      if S <> '' then
        ANewList.Add(S);
    end;
    AColumn := cxGridDBBandedTableView.GetColumnByFieldName
      (Document.SoftwareTypes.KeyFieldName);
    Assert(AColumn <> nil);
    X := cxGridDBBandedTableView.Controller.FocusedRow.Values[AColumn.Index];

    cxGrid.BeginUpdate();
    try
      Document.Software.AppendList(ANewList, X);
    finally
      cxGrid.EndUpdate;
    end;

  finally
    FreeAndNil(ANewList);
    FreeAndNil(AList);
  end;

end;

procedure TViewSoftware.cxGridDBBandedTableView2DragDrop(Sender, Source:
    TObject; X, Y: Integer);
var
  AcxCustomGridHitTest: TcxCustomGridHitTest;
  AcxGridRecordCellHitTest: TcxGridRecordCellHitTest;
  AcxGridViewNoneHitTest: TcxGridViewNoneHitTest;
//  ARow: TcxCustomGridRow;
  AView: TcxGridDBBandedTableView;
begin
  // Assert(FThemeUnionKeyColumn <> nil);
  // Assert(FThemeUnionOrderColumn <> nil);
  // Assert(FSessionUnionKeyColumn <> nil);
  FDropDrag.IDParent := 0;

  cxGridDBBandedTableView2.BeginUpdate();
  try
    // Определяем точку переноса
    AcxCustomGridHitTest := (Sender as TcxGridSite).ViewInfo.GetHitTest(X, Y);

    // Если бросили на ячейке
    if AcxCustomGridHitTest is TcxGridRecordCellHitTest then
    begin
      AcxGridRecordCellHitTest :=
        AcxCustomGridHitTest as TcxGridRecordCellHitTest;

      FDropDrag.IDParent := AcxGridRecordCellHitTest.GridRecord.ParentRecord.Values[FSoftwareTypeKeyColumn.Index];
    end;

    // Если бросили в пустом представлении
    if AcxCustomGridHitTest is TcxGridViewNoneHitTest then
    begin
      AcxGridViewNoneHitTest := AcxCustomGridHitTest as TcxGridViewNoneHitTest;


      AView := (AcxGridViewNoneHitTest.GridView as TcxGridDBBandedTableView);
      FDropDrag.IDParent := AView.MasterGridRecord.Values[FSoftwareTypeKeyColumn.Index];
{
      ARow := GetRow(0);
      if ARow <> nil then
        FDropDrag.IDParent := ARow.Values[FSoftwareTypeKeyColumn.Index];
}
    end;

    if FDropDrag.IDParent > 0 then
      Document.Software.MoveDSRecord(FStartDrag, FDropDrag);

  finally
    cxGridDBBandedTableView2.EndUpdate;
  end;

  GetDBBandedTableView(1).Focused := True;

end;

procedure TViewSoftware.cxGridDBBandedTableView2DragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  AcxGridRecordCellHitTest: TcxGridRecordCellHitTest;
  AcxGridSite: TcxGridSite;
  AcxGridViewNoneHitTest: TcxGridViewNoneHitTest;
  AIDParent: Integer;
  HT: TcxCustomGridHitTest;
begin
  Accept := False;

  AcxGridSite := Sender as TcxGridSite;
  HT := AcxGridSite.ViewInfo.GetHitTest(X, Y);

  // Если перетаскиваем на пустой GridView
  if HT is TcxGridViewNoneHitTest then
  begin
    AcxGridViewNoneHitTest := HT as TcxGridViewNoneHitTest;

    Accept := AcxGridViewNoneHitTest.GridView.Level = cxGridLevel2;
  end;

  // Если перетаскиваем на ячейку GridView
  if HT is TcxGridRecordCellHitTest then
  begin
    AcxGridRecordCellHitTest := HT as TcxGridRecordCellHitTest;
    Assert(AcxGridRecordCellHitTest.GridRecord.ParentRecord <> nil);
    AIDParent := AcxGridRecordCellHitTest.GridRecord.ParentRecord.Values[FSoftwareTypeKeyColumn.Index];

    Accept := FStartDrag.IDParent <> AIDParent;
  end

end;

procedure TViewSoftware.cxGridDBBandedTableView2EditKeyDown
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
var
  S: string;
begin
  inherited;
  S := Format(',%s,', [(AItem as TcxGridDBBandedColumn)
    .DataBinding.FieldName.ToLower]);
  if (Key = 13) and (',name,'.IndexOf(S) >= 0) then
    Sender.DataController.Post();
end;

procedure TViewSoftware.cxGridDBBandedTableView2StartDrag(Sender: TObject;
  var DragObject: TDragObject);
var
  i: Integer;
begin
  Assert(FSoftwareTypeKeyColumn <> nil);
  Assert(FSoftwareKeyColumn <> nil);

  with (Sender as TcxGridSite).GridView as TcxGridDBBandedTableView do
  begin
    Assert(Controller.SelectedRowCount > 0);

    FStartDragLevel := Level as TcxGridLevel;

    // Запоминаем код сессии переносимых записей
    FStartDrag.IDParent := MasterGridRecord.Values
      [FSoftwareTypeKeyColumn.Index];

    // запоминаем минимальный порядок записи которую начали переносить
    // FStartDrag.MinOrderValue := Controller.SelectedRows[0].Values
    // [FThemeUnionOrderColumn.Index];
    // запоминаем максимальный порядок записи которую начали переносить
    // FStartDrag.MaxOrderValue := Controller.SelectedRows
    // [Controller.SelectedRecordCount - 1].Values[FThemeUnionOrderColumn.Index];

    SetLength(FStartDrag.Keys, Controller.SelectedRowCount);
    for i := 0 to Controller.SelectedRowCount - 1 do
    begin
      FStartDrag.Keys[i] := Controller.SelectedRecords[i].Values
        [FSoftwareKeyColumn.Index];
    end;
  end;

end;

procedure TViewSoftware.cxGridDBBandedTableViewDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  AcxCustomGridHitTest: TcxCustomGridHitTest;
  AcxGridRecordCellHitTest: TcxGridRecordCellHitTest;
//  AcxGridViewNoneHitTest: TcxGridViewNoneHitTest;
begin
  // Assert(FThemeUnionKeyColumn <> nil);
  // Assert(FThemeUnionOrderColumn <> nil);
  // Assert(FSessionUnionKeyColumn <> nil);
//  AcxGridDBBandedTableView := nil;

  cxGridDBBandedTableView2.BeginUpdate();
  try
    // Определяем точку переноса
    AcxCustomGridHitTest := (Sender as TcxGridSite).ViewInfo.GetHitTest(X, Y);

    if AcxCustomGridHitTest is TcxGridRecordCellHitTest then
    begin
      AcxGridRecordCellHitTest :=
        AcxCustomGridHitTest as TcxGridRecordCellHitTest;
//      AcxGridDBBandedTableView := AcxGridRecordCellHitTest.GridView as
//        TcxGridDBBandedTableView;

      FDropDrag.IDParent := AcxGridRecordCellHitTest.GridRecord.Values[FSoftwareTypeKeyColumn.Index];
      Document.Software.MoveDSRecord(FStartDrag, FDropDrag);
    end;
{
    if AcxCustomGridHitTest is TcxGridViewNoneHitTest then
    begin
      AcxGridViewNoneHitTest := AcxCustomGridHitTest as TcxGridViewNoneHitTest;
      AcxGridDBBandedTableView := AcxGridViewNoneHitTest.GridView as
        TcxGridDBBandedTableView;
    end;

    if AcxGridDBBandedTableView <> nil then
    begin
    end;
}
  finally
    cxGridDBBandedTableView2.EndUpdate;
  end;

  GetDBBandedTableView(1).Focused := True;
end;

procedure TViewSoftware.cxGridDBBandedTableViewDragOver(Sender, Source:
    TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  AcxGridRecordCellHitTest: TcxGridRecordCellHitTest;
  AcxGridSite: TcxGridSite;
  AcxGridViewNoneHitTest: TcxGridViewNoneHitTest;
  HT: TcxCustomGridHitTest;
begin
  Accept := False;

  AcxGridSite := Sender as TcxGridSite;
  HT := AcxGridSite.ViewInfo.GetHitTest(X, Y);

  // Если перетаскиваем на пустой GridView
  if HT is TcxGridViewNoneHitTest then
  begin
    AcxGridViewNoneHitTest := HT as TcxGridViewNoneHitTest;

    Accept := AcxGridViewNoneHitTest.GridView.Level = cxGridLevel;
  end;

  // Если перетаскиваем на ячейку GridView
  if HT is TcxGridRecordCellHitTest then
  begin
    AcxGridRecordCellHitTest := HT as TcxGridRecordCellHitTest;

    Accept := (AcxGridRecordCellHitTest.GridView.Level = cxGridLevel) and
      (AcxGridRecordCellHitTest.GridRecord.RecordIndex <>
      AcxGridSite.GridView.DataController.FocusedRecordIndex);
  end
end;

procedure TViewSoftware.cxGridDBBandedTableViewEditKeyDown
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
var
  S: string;
begin
  inherited;
  S := Format(',%s,', [(AItem as TcxGridDBBandedColumn)
    .DataBinding.FieldName.ToLower]);
  if (Key = 13) and (',softwaretype,'.IndexOf(S) >= 0) then
    Document.SoftwareTypes.Wrap.Post()
end;

function TViewSoftware.GetDocument: TSoftwareDocument;
begin
  Result := FDocument as TSoftwareDocument;
end;

function TViewSoftware.GetFocusedTableView: TcxGridDBBandedTableView;
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

procedure TViewSoftware.InitColumn(AcxGridDBBandedColumn
  : TcxGridDBBandedColumn);
begin
  if AcxGridDBBandedColumn.GridView = cxGridDBBandedTableView then
  begin
    if AnsiSameText(Document.SoftwareTypes.KeyFieldName,
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
      FSoftwareTypeKeyColumn := AcxGridDBBandedColumn;
    end;
  end;

  if AcxGridDBBandedColumn.GridView = cxGridDBBandedTableView2 then
  begin
    if AnsiSameText(Document.Software.KeyFieldName,
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := True;
      FSoftwareKeyColumn := AcxGridDBBandedColumn;
    end;

    if AnsiSameText('Name', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.MinWidth := 500;
    end;
  end;

//  AcxGridDBBandedColumn.Options.Sorting := False;
  AcxGridDBBandedColumn.Options.Moving := False;
  AcxGridDBBandedColumn.Options.VertSizing := False;
  AcxGridDBBandedColumn.Options.Grouping := False;
  AcxGridDBBandedColumn.Options.Filtering := True;
end;

procedure TViewSoftware.SetDocument(const Value: TDocument);
begin
  inherited;

  UpdateView;

  if (FDocument <> nil) then
  begin
    KcxGridDBBandedTableView.SetDocument(Document.SoftwareTypes.Wrap);
    KcxGridDBBandedTableView2.SetDocument(Document.Software.Wrap);
  end
  else
  begin
    KcxGridDBBandedTableView.SetDocument(nil);
    KcxGridDBBandedTableView2.SetDocument(nil);
  end;
end;

procedure TViewSoftware.UpdateView;
var
  AView: TcxGridDBBandedTableView;
begin
  AView := FocusedTableView;

  actAddSoftwareType.Enabled := (FDocument <> nil) and
    (Document.SoftwareTypes.DS.Active) and (AView <> nil) and
    (AView.Level = cxGridLevel);

  actAddSoftware.Enabled := (FDocument <> nil) and (Document.Software.DS.Active)
    and (AView <> nil) and ((AView.Level = cxGridLevel) or
    (AView.Level = cxGridLevel2));

  actDelete.Enabled := (FDocument <> nil) and (Document.SoftwareTypes.DS.Active)
    and (Document.Software.DS.Active) and (AView <> nil) and
    (AView.DataController.RecordCount > 0);
end;

end.
