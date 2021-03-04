unit CyclesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GridFrame, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, Data.DB, cxDBData,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.Menus,
  System.Actions, Vcl.ActnList, cxClasses, dxBar, Vcl.ComCtrls, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  cxDBLookupComboBox, cxBarEditItem, System.ImageList, Vcl.ImgList,
  cxImageList, CycleServiceInterface;

type
  TViewCycles = class(TfrmGrid)
    cxbeilcbCycleTypes: TcxBarEditItem;
    actAdd: TAction;
    cxImageList: TcxImageList;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    actSave: TAction;
    dxBarButton3: TdxBarButton;
    procedure actAddExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure cxbeilcbCycleTypesPropertiesChange(Sender: TObject);
  private
    FCycleServiceI: ICycleService;
    function GetclIDCycleType: TcxGridDBBandedColumn;
    function GetIDCycleType: Integer;
    procedure SetCycleServiceI(const Value: ICycleService);
    procedure SetIDCycleType(const Value: Integer);
    { Private declarations }
  protected
    procedure InitColumns(AView: TcxGridDBBandedTableView); override;
    property IDCycleType: Integer read GetIDCycleType write SetIDCycleType;
  public
    procedure UpdateView; override;
    property clIDCycleType: TcxGridDBBandedColumn read GetclIDCycleType;
    property CycleServiceI: ICycleService read FCycleServiceI write
        SetCycleServiceI;
    { Public declarations }
  end;

implementation

uses
  DBLookupComboBoxHelper, cxDropDownEdit;

{$R *.dfm}

procedure TViewCycles.actAddExecute(Sender: TObject);
begin
  inherited;
  MainView.DataController.Append;
  FocusColumnEditor(MainView, FCycleServiceI.CycleW.Cycle.FieldName);

  UpdateView;
end;

procedure TViewCycles.actSaveExecute(Sender: TObject);
begin
  inherited;
  CycleServiceI.CycleW.TryPost;
  UpdateView;
end;

procedure TViewCycles.cxbeilcbCycleTypesPropertiesChange(Sender: TObject);
begin
  inherited;
  (Sender as TcxLookupComboBox).PostEditValue;
  CycleServiceI.CycleW.FilterByCycleType(IDCycleType);
end;

function TViewCycles.GetclIDCycleType: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FCycleServiceI.CycleW.IDCycle_Type.FieldName);
end;

function TViewCycles.GetIDCycleType: Integer;
begin
  if VarIsNull(cxbeilcbCycleTypes.EditValue) then
    Result := 0
  else
    Result := cxbeilcbCycleTypes.EditValue;
end;

procedure TViewCycles.InitColumns(AView: TcxGridDBBandedTableView);
begin
  inherited;

  // Настраиваем подстановочную колонку кафедра
  TDBLCB.InitColumn(clIDCycleType, FCycleServiceI.CycleTypeW.CycleType,
    lsFixedList);

  MyApplyBestFitForView(MainView);

  UpdateView;
end;

procedure TViewCycles.SetCycleServiceI(const Value: ICycleService);
var
  p: TcxLookupComboBoxProperties;
begin
  FCycleServiceI := Value;

  if FCycleServiceI = nil then
  begin
    DSWrap := nil;
    exit;
  end;

  DSWrap := FCycleServiceI.CycleW;

  p := cxbeilcbCycleTypes.Properties as TcxLookupComboBoxProperties;

  TDBLCB.Init(p, FCycleServiceI.CycleTypeW.CycleType, lsFixedList);
  IDCycleType := CycleServiceI.CycleTypeW.PK.AsInteger;
  CycleServiceI.CycleW.FilterByCycleType(IDCycleType);
end;

procedure TViewCycles.SetIDCycleType(const Value: Integer);
begin
  cxbeilcbCycleTypes.EditValue := Value;
end;

procedure TViewCycles.UpdateView;
var
  OK: Boolean;
begin
  OK := (CycleServiceI <> nil) and (CycleServiceI.CycleW.DataSet.Active);
  actAdd.Enabled := OK;
  actSave.Enabled := OK and CycleServiceI.CycleW.HaveAnyChanges;
  actDeleteEx.Enabled := OK and (MainView.Controller.SelectedRowCount > 0);
end;

end.
