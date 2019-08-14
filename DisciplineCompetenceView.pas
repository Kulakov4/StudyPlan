unit DisciplineCompetenceView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataSetView_2, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls,
  DisciplineCompetence, DocumentView, KcxGridView, Vcl.Grids, Vcl.DBGrids,
  System.Actions, Vcl.ActnList, TB2Item, TB2Dock, TB2Toolbar, Vcl.ImgList,
  Vcl.StdCtrls, NotifyEvents, System.ImageList;

type
  TviewDisciplineCompetence = class(TDataSetView2)
    cxgrdlvl2: TcxGridLevel;
    cxgrdbndtblvw2: TcxGridDBBandedTableView;
    cxgrdlvl3: TcxGridLevel;
    cxgrdbndtblvw3: TcxGridDBBandedTableView;
    tbdckTop: TTBDock;
    TBToolbar1: TTBToolbar;
    TBItem1: TTBItem;
    TBItem2: TTBItem;
    ActionList1: TActionList;
    actAddIncreased: TAction;
    actAddThreshold: TAction;
    ilDisciplineCompetence: TImageList;
    actUndo: TAction;
    TBItem3: TTBItem;
    actPost: TAction;
    TBItem4: TTBItem;
    actDelete: TAction;
    TBItem5: TTBItem;
    actKnow: TAction;
    actAble: TAction;
    actPossess: TAction;
    TBItem7: TTBItem;
    TBItem8: TTBItem;
    TBItem9: TTBItem;
    actAddCompetence: TAction;
    TBItem10: TTBItem;
    TBSeparatorItem1: TTBSeparatorItem;
    TBSeparatorItem2: TTBSeparatorItem;
    TBSeparatorItem3: TTBSeparatorItem;
    TBSeparatorItem4: TTBSeparatorItem;
    TBToolbar2: TTBToolbar;
    actPrepareReport: TAction;
    TBItem6: TTBItem;
    procedure actAbleExecute(Sender: TObject);
    procedure actAddCompetenceExecute(Sender: TObject);
    procedure actAddIncreasedExecute(Sender: TObject);
    procedure actAddThresholdExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actKnowExecute(Sender: TObject);
    procedure actPossessExecute(Sender: TObject);
    procedure actPostExecute(Sender: TObject);
    procedure actPrepareReportExecute(Sender: TObject);
    procedure actUndoExecute(Sender: TObject);
  private
    FAfterCompetenceInsertEvent: TNotifyEventWrap;
    FCompetenceLevelNameColumn: TcxGridDBBandedColumn;
    FKcxGridDBBandedTableView2: TKcxGridDBBandedTableView;
    FKcxGridDBBandedTableView3: TKcxGridDBBandedTableView;
    procedure AddCompetence;
    procedure AddCompetencePart(ACompetencePartName: TIDCompetencePartName);
    procedure AddCompetencePartDetail(ACompetenceLevelName
      : TIDCompetenceLevelName);
    procedure AfterCompetenceInsert(Sender: TObject);
    function GetDocument: TDisciplineCompetence;
    function GetIsCompetencePartFocused: Boolean;
    function GetIsCompetencePartDetailFocused: Boolean;
    function GetIsCompetenceFocused: Boolean;
    function GetTableView(ALevel: Cardinal): TcxGridDBBandedTableView;
    function GetRow(ALevel: Cardinal): TcxCustomGridRow;
    { Private declarations }
  protected
    function GetFocusedTableView: TcxGridDBBandedTableView; override;
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn);
      override;
    procedure UpdateView; override;
    property Document: TDisciplineCompetence read GetDocument;
    property KcxGridDBBandedTableView2: TKcxGridDBBandedTableView
      read FKcxGridDBBandedTableView2;
    property KcxGridDBBandedTableView3: TKcxGridDBBandedTableView
      read FKcxGridDBBandedTableView3;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    property IsCompetencePartFocused: Boolean read GetIsCompetencePartFocused;
    property IsCompetencePartDetailFocused: Boolean
      read GetIsCompetencePartDetailFocused;
    property IsCompetenceFocused: Boolean read GetIsCompetenceFocused;
    { Public declarations }
  end;

implementation

uses SPViewDM, ViewFormEx, AllCompetenceGridView, ProgressBarForm,
  DisciplinePurposeView;

{$R *.dfm}

constructor TviewDisciplineCompetence.Create(AOwner: TComponent;
  AParent: TWinControl; AAlign: TAlign = alClient);
begin
  inherited;

  // Создаём представление, связанное с 2-м уровнем
  FKcxGridDBBandedTableView2 := TKcxGridDBBandedTableView.Create(Self,
    cxgrdbndtblvw2);
  // Подписываемся на событие о создании столбца
  TNotifyEventWrap.Create(FKcxGridDBBandedTableView2.AfterCreateColumn,
    OnCreateColumn);

  // Подписываемся на событие о инициализации столбца
  TNotifyEventWrap.Create(FKcxGridDBBandedTableView2.InitColumn,
    OnCreateColumn);

  // Создаём представление, связанное с 3-м уровнем
  FKcxGridDBBandedTableView3 := TKcxGridDBBandedTableView.Create(Self,
    cxgrdbndtblvw3);

  // Подписываемся на событие о создании столбца
  TNotifyEventWrap.Create(FKcxGridDBBandedTableView3.AfterCreateColumn,
    OnCreateColumn);

  // Подписываемся на событие о инициализации столбца
  TNotifyEventWrap.Create(FKcxGridDBBandedTableView3.InitColumn,
    OnCreateColumn);

end;

procedure TviewDisciplineCompetence.actAbleExecute(Sender: TObject);
begin
  AddCompetencePart(cpnAble);
  {
    cxGrid.BeginUpdate();
    try
    Document.AddAble;
    finally
    cxGrid.EndUpdate;
    end;
  }
end;

procedure TviewDisciplineCompetence.actAddCompetenceExecute(Sender: TObject);
begin
  AddCompetence;
end;

procedure TviewDisciplineCompetence.actAddIncreasedExecute(Sender: TObject);
begin
  AddCompetencePartDetail(clnIncreased);
  {
    cxGrid.BeginUpdate();
    try
    Document.AddIncreased;
    finally
    cxGrid.EndUpdate;
    end;
  }
end;

procedure TviewDisciplineCompetence.actAddThresholdExecute(Sender: TObject);
begin
  AddCompetencePartDetail(clnThreshold);
  {
    cxGrid.BeginUpdate();
    try
    Document.AddThreshold;
    finally
    cxGrid.EndUpdate;
    end;
  }
end;

procedure TviewDisciplineCompetence.actDeleteExecute(Sender: TObject);
var
  AMessageText: string;
  AMessageCaption: string;
  AView: TcxGridDBBandedTableView;
begin
  // DataSet может быть не пустым а текущее GridView не содержать ни одной записи
  // Поэтому удаляем средствами GridView

  AMessageText := '';

  AView := FocusedTableView;
  if AView = nil then
    Exit;

  if AView.Level = cxGridLevel then
  begin
    AMessageText :=
      Format('Полностью удалить компетенцию «%s» вместе с её компонентами?',
      [Document.Competence.Field('Code').AsString]);
    AMessageCaption := 'Удаление компетенции';
  end;

  if AView.Level = cxgrdlvl2 then
  begin
    AMessageText :=
      Format('Полностью удалить компонент «%s» вместе с его уровнями?',
      [Document.CompetencePart.Field('CompetencePartName').AsString]);
    AMessageCaption := 'Удаление компонента компетенции';
  end;

  if AView.Level = cxgrdlvl3 then
  begin
    AMessageText := Format('Удалить %s освоения компетенции?',
      [Document.CompetencePartDetail.Field('CompetenceLevelName')
      .AsString.ToLower]);
    AMessageCaption := 'Удаление уровня освоения компетенции';
  end;

  Assert(AMessageText <> '');

  if (AView.DataController.RowCount > 0) and
    (Application.MessageBox(PWideChar(AMessageText), PWideChar(AMessageCaption),
    MB_YESNO + MB_ICONQUESTION) = IDYES) then
  begin
    AView.DataController.DeleteFocused;
  end;
end;

procedure TviewDisciplineCompetence.actKnowExecute(Sender: TObject);
begin
  AddCompetencePart(cpnKnow);
  {
    cxGrid.BeginUpdate();
    try
    Document.AddKnow;
    finally
    cxGrid.EndUpdate;
    end;
  }
end;

procedure TviewDisciplineCompetence.actPossessExecute(Sender: TObject);
begin
  AddCompetencePart(cpnPossess);
  {
    cxGrid.BeginUpdate();
    try
    Document.AddPossess;
    finally
    cxGrid.EndUpdate;
    end;
  }
end;

procedure TviewDisciplineCompetence.actPostExecute(Sender: TObject);
begin
  cxGrid.BeginUpdate();
  try
    Document.DataSet.Post;
  finally
    cxGrid.EndUpdate;
  end;
end;

procedure TviewDisciplineCompetence.actPrepareReportExecute(Sender: TObject);
var
  frmDisciplinePurpose: TfrmViewEx;
  ProgressBarThread: TProgressBarThread;
begin
  if ((Document.Purpose.Trim.Length = 0) or (Document.Task.Trim.Length = 0)) and
    (Application.MessageBox('Цель и задачи дисциплины не заполнены. ' + #13#10 +
    'Хотите заполнить их сейчас?', 'Цель и задачи дисциплины',
    MB_YESNO + MB_ICONQUESTION) = IDYES) then
  begin
    frmDisciplinePurpose := TfrmViewEx.Create(Self,
      Format('Цель и задачи дисциплины «%s»', [Document.DisciplineName]),
      'DisciplinePurposeForm', [mbOk]);
    try
      frmDisciplinePurpose.ViewClass := TviewDisciplinePurpose;
      frmDisciplinePurpose.View.SetDocument(Document.StudyPlanInfo);
      frmDisciplinePurpose.ForcedRealign := True;
      frmDisciplinePurpose.ShowModal();
    finally
      FreeAndNil(frmDisciplinePurpose);
    end;
  end;

  ProgressBarThread := TProgressBarThread.Create();
  try
    cxGrid.BeginUpdate();
    try
      Document.PrepareReport;
    finally
      cxGrid.EndUpdate;
    end;
  finally
    ProgressBarThread.Terminate;
    ProgressBarThread.WaitFor;
    ProgressBarThread.Free;
  end;
end;

procedure TviewDisciplineCompetence.actUndoExecute(Sender: TObject);
begin
  cxGrid.BeginUpdate;
  try
    Document.DataSet.Cancel;
  finally
    cxGrid.EndUpdate;
  end;
end;

procedure TviewDisciplineCompetence.AddCompetence;
var
  AllCompetence: TAllCompetence;
  frmDisciplineCompetence: TfrmViewEx;
begin
  FreeAndNil(FAfterCompetenceInsertEvent);
  try
    frmDisciplineCompetence := TfrmViewEx.Create(Self, 'Компетенции',
      'AllCompetenceForm');
    try
      frmDisciplineCompetence.cxbtnOk.Caption := 'Выбрать';
      frmDisciplineCompetence.ViewClass := TdsgvAllCompetence;
      (frmDisciplineCompetence.View as TdsgvAllCompetence).ApplyBestFit
        := False;

      AllCompetence := TAllCompetence.Create(Self);
      try
        AllCompetence.YearParam.ParamValue :=
          Document.Competence.YearParam.ParamValue;
        AllCompetence.IDSpecialityParam.ParamValue :=
          Document.Competence.IDSpecialityParam.ParamValue;
        AllCompetence.Refresh;

        frmDisciplineCompetence.View.SetDocument(AllCompetence);
        if frmDisciplineCompetence.ShowModal = mrOk then
        begin
          cxGrid.BeginUpdate();
          try
            Document.AddCompetence(AllCompetence);
          finally
            cxGrid.EndUpdate;
          end;
        end
        else
          actUndo.Execute;

      finally
        FreeAndNil(AllCompetence);
      end;
    finally
      FreeAndNil(frmDisciplineCompetence);
    end;
  finally
    FAfterCompetenceInsertEvent := TNotifyEventWrap.Create
      (Document.Competence.Wrap.AfterInsert, AfterCompetenceInsert);
  end;
end;

procedure TviewDisciplineCompetence.AddCompetencePart(ACompetencePartName
  : TIDCompetencePartName);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  GetRow(0).Expand(False);
  AView := GetTableView(1);
  AView.Focused := True;

  Document.CompetencePart.DefaultCompetencePartName := ACompetencePartName;
  AView.DataController.Append;

  AColumn := AView.GetColumnByFieldName('CompetencePartDescription');
  // Site обеспечивает доступ к элементам размещённым на cxGrid
  AView.Site.SetFocus;
  // Показываем редактор для колонки
  AView.Controller.EditingController.ShowEdit(AColumn);
end;

procedure TviewDisciplineCompetence.AddCompetencePartDetail(ACompetenceLevelName
  : TIDCompetenceLevelName);
var
  AColumn: TcxGridDBBandedColumn;
  ARow: TcxCustomGridRow;
  AView: TcxGridDBBandedTableView;
begin
  ARow := GetRow(1);
  Assert(ARow <> nil);
  ARow.Expand(False);
  AView := GetTableView(2);
  AView.Focused := True;

  Document.CompetencePartDetail.DefaultCompetenceLevelName :=
    ACompetenceLevelName;
  AView.DataController.Append;

  AColumn := AView.GetColumnByFieldName('CompetencePartDetail');
  // Site обеспечивает доступ к элементам размещённым на cxGrid
  AView.Site.SetFocus;
  // Показываем редактор для колонки
  AView.Controller.EditingController.ShowEdit(AColumn);
end;

procedure TviewDisciplineCompetence.AfterCompetenceInsert(Sender: TObject);
begin
  AddCompetence;
end;

function TviewDisciplineCompetence.GetDocument: TDisciplineCompetence;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TDisciplineCompetence;
end;

function TviewDisciplineCompetence.GetFocusedTableView
  : TcxGridDBBandedTableView;
begin
  Result := inherited;

  // Если не первый уровень в фокусе
  if Result = nil then
  begin
    Result := GetTableView(1);
    if (Result <> nil) and (not Result.Focused) then
      Result := nil;
  end;

  // Если не второй уровень в фокусе
  if Result = nil then
  begin
    Result := GetTableView(2);
    if (Result <> nil) and (not Result.Focused) then
      Result := nil;
  end;
end;

function TviewDisciplineCompetence.GetIsCompetencePartFocused: Boolean;
var
  AcxGridDBBandedTableView: TcxGridDBBandedTableView;
begin
  AcxGridDBBandedTableView := GetTableView(1);
  Result := (AcxGridDBBandedTableView <> nil) and
    AcxGridDBBandedTableView.Focused;
end;

function TviewDisciplineCompetence.GetIsCompetencePartDetailFocused: Boolean;
var
  AcxGridDBBandedTableView: TcxGridDBBandedTableView;
begin
  AcxGridDBBandedTableView := GetTableView(2);
  Result := (AcxGridDBBandedTableView <> nil) and
    AcxGridDBBandedTableView.Focused;
end;

function TviewDisciplineCompetence.GetIsCompetenceFocused: Boolean;
var
  AcxGridDBBandedTableView: TcxGridDBBandedTableView;
begin
  AcxGridDBBandedTableView := GetTableView(0);
  Result := (AcxGridDBBandedTableView <> nil) and
    AcxGridDBBandedTableView.Focused;
end;

function TviewDisciplineCompetence.GetTableView(ALevel: Cardinal)
  : TcxGridDBBandedTableView;
var
  AcxGridDBBandedTableView: TcxGridDBBandedTableView;
  AcxGridMasterDataRow: TcxGridMasterDataRow;
  i: Integer;
begin
  Result := nil;
  Assert(ALevel < 3);

  case ALevel of
    0:
      Result := cxGridDBBandedTableView;
    1, 2:
      begin
        AcxGridDBBandedTableView := GetTableView(ALevel - 1);
        if AcxGridDBBandedTableView = nil then
          Exit;

        i := AcxGridDBBandedTableView.DataController.FocusedRowIndex;
        if i < 0 then
          Exit;

        // Assert(i >= 0);

        AcxGridMasterDataRow := GetTableView(ALevel - 1).ViewData.Rows[i]
          as TcxGridMasterDataRow;
        // Спускаемся на дочерний уровень
        Result := AcxGridMasterDataRow.ActiveDetailGridView as
          TcxGridDBBandedTableView;
      end;
  else
    raise Exception.Create('Уровень должен быть от 0 до 2');
  end;
end;

function TviewDisciplineCompetence.GetRow(ALevel: Cardinal): TcxCustomGridRow;
var
  i: Integer;
begin
  Result := nil;
  i := GetTableView(ALevel).DataController.FocusedRowIndex;
  if i >= 0 then
    Result := GetTableView(ALevel).ViewData.Rows[i];
end;

procedure TviewDisciplineCompetence.InitColumn(AcxGridDBBandedColumn
  : TcxGridDBBandedColumn);
begin
  // Колонки первого уровня
  if AcxGridDBBandedColumn.GridView = cxGridDBBandedTableView then
  begin
    // Колонки первого уровня

    AcxGridDBBandedColumn.Styles.Header := DM.cxstyl3;
    AcxGridDBBandedColumn.Styles.Content := DM.cxstyl3;

    if AnsiSameText(Document.Competence.KeyFieldName,
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('Code', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Width := 100;
      AcxGridDBBandedColumn.MinWidth := 100;
    end;

  end
  else if AcxGridDBBandedColumn.GridView = cxgrdbndtblvw2 then
  begin
    // Колонки второго уровня
    AcxGridDBBandedColumn.Styles.Header := DM.cxstyl2;
    AcxGridDBBandedColumn.Styles.Content := DM.cxstyl2;

    if AnsiSameText(Document.CompetencePart.KeyFieldName,
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('IDCompetence', AcxGridDBBandedColumn.DataBinding.FieldName)
    then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('COMPETENCEPARTNAME',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Width := 100;
      AcxGridDBBandedColumn.MinWidth := 100;
      AcxGridDBBandedColumn.Position.ColIndex := 2;
    end;

    if AnsiSameText('COMPETENCEPARTNAMEORDER',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('order_', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;
  end
  else if AcxGridDBBandedColumn.GridView = cxgrdbndtblvw3 then
  begin
    // Колонки третьего уровня

    if AnsiSameText(Document.CompetencePartDetail.Wrap.MultiSelectDSWrap.
      KeyFieldName, AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('IDCompetencePart',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('IDCompetenceLevelName',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('COMPETENCELEVELNAME',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Width := 100;
      AcxGridDBBandedColumn.MinWidth := 100;
      AcxGridDBBandedColumn.Position.ColIndex := 2;
      FCompetenceLevelNameColumn := AcxGridDBBandedColumn;
    end;

    if AnsiSameText('CompetencePartDetail',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      // FCompetenceLevelNameColumn.Index := AcxGridDBBandedColumn.Index - 1;
    end;

    if AnsiSameText('COMPETENCELEVELNAMEORDER',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('order_', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;

  end;

  AcxGridDBBandedColumn.Options.Sorting := False;
  // AcxGridDBBandedColumn.Options.HorzSizing := False;
  AcxGridDBBandedColumn.Options.Moving := False;
  AcxGridDBBandedColumn.Options.VertSizing := False;
  AcxGridDBBandedColumn.Options.Grouping := False;
  AcxGridDBBandedColumn.Options.Filtering := False;

end;

procedure TviewDisciplineCompetence.SetDocument(const Value: TDocument);
begin

  inherited;

  UpdateView;

  if FDocument <> nil then
  begin
    KcxGridDBBandedTableView.SetDocument(Document.Competence.Wrap);
    KcxGridDBBandedTableView2.SetDocument(Document.CompetencePart.Wrap);
    KcxGridDBBandedTableView3.SetDocument(Document.CompetencePartDetail.Wrap);
    FAfterCompetenceInsertEvent := TNotifyEventWrap.Create
      (Document.Competence.Wrap.AfterInsert, AfterCompetenceInsert);
    // DBGrid1.DataSource := Document.CompetencePartDetail.Wrap.DataSource;
  end
  else
  begin
    FreeAndNil(FAfterCompetenceInsertEvent);
    KcxGridDBBandedTableView.SetDocument(nil);
    KcxGridDBBandedTableView2.SetDocument(nil);
    KcxGridDBBandedTableView3.SetDocument(nil);
  end;

end;

procedure TviewDisciplineCompetence.UpdateView;
var
  AFocusedView: TcxGridDBBandedTableView;
begin
  AFocusedView := FocusedTableView;

  actUndo.Enabled := (FDocument <> nil) and (Document.DataSet <> nil) and
    (Document.DataSet.State in [dsInsert, dsEdit]);

  actPost.Enabled := actUndo.Enabled;

  actDelete.Enabled := (FDocument <> nil) and Document.IsAllSave and
    (AFocusedView <> nil) and (AFocusedView.DataController.RowCount > 0);

  actAddThreshold.Enabled := (FDocument <> nil) and
    Document.IsAddThresholdEnabled and (AFocusedView <> nil) and
    (((AFocusedView.Level = cxgrdlvl2) and (AFocusedView.DataController.RowCount
    > 0)) or (AFocusedView.Level = cxgrdlvl3));

  actAddIncreased.Enabled := actAddThreshold.Enabled;

  actKnow.Enabled := (FDocument <> nil) and Document.IsAddKnowEnabled and
    (AFocusedView <> nil) and
    (((AFocusedView.Level = cxGridLevel) and
    (AFocusedView.DataController.RowCount > 0)) or
    (AFocusedView.Level = cxgrdlvl2));

  actAble.Enabled := actKnow.Enabled;
  actPossess.Enabled := actKnow.Enabled;

  actAddCompetence.Enabled := (FDocument <> nil) and Document.IsAllSave;

  actPrepareReport.Enabled := (FDocument <> nil) and Document.IsAllSave;
end;

end.
