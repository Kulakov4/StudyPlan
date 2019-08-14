unit DiscNameView;

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
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, DiscNameGroup,
  System.ImageList, Vcl.ImgList, cxImageList, FireDAC.Phys.OracleWrapper;

type
  TViewDiscName = class(TfrmGrid)
    actAdd: TAction;
    cxImageList1: TcxImageList;
    actEdit: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
  private
    FDiscNameGroup: TDiscNameGroup;
    function GetclIDChair: TcxGridDBBandedColumn;
    function GetclDisciplineName: TcxGridDBBandedColumn;
    procedure SetDiscNameGroup(const Value: TDiscNameGroup);
    { Private declarations }
  protected
  public
    procedure UpdateView; override;
    property clIDChair: TcxGridDBBandedColumn read GetclIDChair;
    property clDisciplineName: TcxGridDBBandedColumn read GetclDisciplineName;
    property DiscNameGroup: TDiscNameGroup read FDiscNameGroup
      write SetDiscNameGroup;
    { Public declarations }
  end;

implementation

uses
  cxDropDownEdit, GridSort, EditDisciplineFrm, InsertEditMode, DialogUnit;

{$R *.dfm}

procedure TViewDiscName.actAddExecute(Sender: TObject);
var
  F: TfrmEditDisciplineName;
begin
  inherited;
  F := TfrmEditDisciplineName.Create(DiscNameGroup);
  try
    F.Mode := InsertMode;
    F.ShowModal;
  finally
    FreeAndNil(F);
  end;
end;

procedure TViewDiscName.actEditExecute(Sender: TObject);
var
  F: TfrmEditDisciplineName;
begin
  inherited;
  F := TfrmEditDisciplineName.Create(DiscNameGroup);
  try
    F.Mode := EditMode;
    F.ShowModal;
  finally
    FreeAndNil(F);
  end;
end;

function TViewDiscName.GetclIDChair: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FDiscNameGroup.qDiscName.W.IDCHAR.FieldName);
end;

function TViewDiscName.GetclDisciplineName: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FDiscNameGroup.qDiscName.W.DisciplineName.FieldName);
end;

procedure TViewDiscName.SetDiscNameGroup(const Value: TDiscNameGroup);
begin
  if FDiscNameGroup = Value then
    Exit;

  FDiscNameGroup := Value;

  if FDiscNameGroup = nil then
  begin
    UpdateView;
    Exit;
  end;

  BeginUpdate;
  try
    DataSource.DataSet := FDiscNameGroup.qDiscName.FDQuery;

    // Настраиваем представление дисциплин
    with MainView.DataController do
    begin
      KeyFieldNames := FDiscNameGroup.qDiscName.W.PKFieldName;

      // Создаём все колонки
      CreateAllItems();
    end;

    clDisciplineName.BestFitMaxWidth := 600;

    // Настраиваем подстановочную колонку кафедра
    InitializeLookupColumn(clIDChair, FDiscNameGroup.qChairs.DataSource,
      lsEditList, FDiscNameGroup.qChairs.W.Shortening.FieldName,
      FDiscNameGroup.qChairs.W.ID_CHAIR.FieldName);

    InitView(MainView);
    MainView.OptionsView.ColumnAutoWidth := False;
    MainView.OptionsBehavior.ImmediateEditor := False;
    MainView.OptionsBehavior.IncSearch := True;
    MainView.OptionsData.Editing := False;
    MainView.OptionsData.Inserting := False;
    MainView.OptionsData.Deleting := False;

    clIDChair.Options.SortByDisplayText := isbtOn;
    GridSort.Add(TSortVariant.Create(clIDChair, [clIDChair, clDisciplineName]));
    GridSort.Add(TSortVariant.Create(clDisciplineName, [clDisciplineName, clIDChair]));
    ApplySort(MainView, clDisciplineName);

  finally
    EndUpdate;
  end;
  MyApplyBestFitForView(MainView);
  UpdateView;
end;

procedure TViewDiscName.UpdateView;
var
  AView: TcxGridDBBandedTableView;
  OK: Boolean;
begin
  inherited;
  AView := FocusedTableView;
  OK := (FDiscNameGroup <> nil) and (FDiscNameGroup.qDiscName.FDQuery.Active);

  actAdd.Enabled := OK;

  actEdit.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount = 1);

  actDeleteEx.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount > 0);
end;

end.
