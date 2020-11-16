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
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  System.ImageList, Vcl.ImgList, cxImageList, FireDAC.Phys.OracleWrapper,
  dxDateRanges, DiscNameViewInterface;

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
  strict private
  private
    FDiscNameViewI: IDiscNameView;
    function GetclIDChair: TcxGridDBBandedColumn;
    function GetclDisciplineName: TcxGridDBBandedColumn;
    function GetclID_DisciplineName: TcxGridDBBandedColumn;
    procedure SetDiscNameViewI(const Value: IDiscNameView);
    { Private declarations }
  protected
    procedure InitColumns(AView: TcxGridDBBandedTableView); override;
  public
    procedure InitView(AView: TcxGridDBBandedTableView); override;
    procedure UpdateView; override;
    property clIDChair: TcxGridDBBandedColumn read GetclIDChair;
    property clDisciplineName: TcxGridDBBandedColumn read GetclDisciplineName;
    property clID_DisciplineName: TcxGridDBBandedColumn
      read GetclID_DisciplineName;
    property DiscNameViewI: IDiscNameView read FDiscNameViewI
      write SetDiscNameViewI;
    { Public declarations }
  end;

implementation

uses
  cxDropDownEdit, GridSort, EditDisciplineFrm, InsertEditMode, DialogUnit,
  DBLookupComboBoxHelper;

{$R *.dfm}

procedure TViewDiscName.actAddExecute(Sender: TObject);
var
  F: TfrmEditDisciplineName;
begin
  inherited;

  F := TfrmEditDisciplineName.Create(Self, DiscNameViewI.GetDiscNameEditI(0),
    InsertMode);
  try
    F.ShowModal;
  finally
    FreeAndNil(F);
  end;
end;

procedure TViewDiscName.actEditExecute(Sender: TObject);
var
  A: TArray<Integer>;
  AIDDisciplineName: Integer;
  F: TfrmEditDisciplineName;
begin
  inherited;
  A := GetSelectedIntValues(clID_DisciplineName);
  Assert(Length(A) > 0);

  AIDDisciplineName := A[0];

  F := TfrmEditDisciplineName.Create(Self,
    DiscNameViewI.GetDiscNameEditI(AIDDisciplineName), EditMode);
  try
    F.ShowModal;
  finally
    FreeAndNil(F);
  end;
end;

function TViewDiscName.GetclIDChair: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FDiscNameViewI.DiscNameW.IDChair.FieldName);
end;

function TViewDiscName.GetclDisciplineName: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FDiscNameViewI.DiscNameW.DisciplineName.FieldName);
end;

function TViewDiscName.GetclID_DisciplineName: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FDiscNameViewI.DiscNameW.ID_DisciplineName.FieldName);
end;

procedure TViewDiscName.InitColumns(AView: TcxGridDBBandedTableView);
begin
  inherited;
  clDisciplineName.BestFitMaxWidth := 600;

  // Настраиваем подстановочную колонку кафедра
  TDBLCB.InitColumn(clIDChair, FDiscNameViewI.ChairsW.Shortening);

  clIDChair.Options.SortByDisplayText := isbtOn;
  GridSort.Add(TSortVariant.Create(clIDChair, [clIDChair, clDisciplineName]));
  GridSort.Add(TSortVariant.Create(clDisciplineName, [clDisciplineName,
    clIDChair]));
  ApplySort(MainView, clDisciplineName);

  MyApplyBestFitForView(MainView);

  UpdateView;
end;

procedure TViewDiscName.InitView(AView: TcxGridDBBandedTableView);
begin
  inherited;
  MainView.OptionsView.ColumnAutoWidth := False;
  MainView.OptionsBehavior.ImmediateEditor := False;
  MainView.OptionsBehavior.IncSearch := True;
  MainView.OptionsData.Editing := False;
  MainView.OptionsData.Inserting := False;
  MainView.OptionsData.Deleting := False;
end;

procedure TViewDiscName.SetDiscNameViewI(const Value: IDiscNameView);
begin
  if FDiscNameViewI = Value then
    Exit;

  FDiscNameViewI := Value;

  if FDiscNameViewI = nil then
    DSWrap := nil
  else
    DSWrap := FDiscNameViewI.DiscNameW;

  UpdateView;
end;

procedure TViewDiscName.UpdateView;
var
  AView: TcxGridDBBandedTableView;
  OK: Boolean;
begin
  inherited;
  AView := FocusedTableView;
  OK := (FDiscNameViewI <> nil) and (FDiscNameViewI.DiscNameW.DataSet.Active);

  actAdd.Enabled := OK;

  actEdit.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount = 1);

  actDeleteEx.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount > 0);
end;

end.
