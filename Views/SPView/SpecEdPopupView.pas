unit SpecEdPopupView;

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
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, SpecEdQuery,
  cxCheckBox, dxDateRanges;

type
  TViewSpecEdPopup = class(TfrmGrid)
    cxDisabledStyle: TcxStyle;
    procedure clCalcGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure clCalcGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBBandedTableViewCustomDrawCell
      (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBBandedTableViewStylesGetContentStyle
      (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    function GetCalcColumnText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer): String;
    function GetclChiper_Speciality: TcxGridDBBandedColumn;
    function GetclData: TcxGridDBBandedColumn;
    function GetclEducationOrder: TcxGridDBBandedColumn;
    function GetclEducation: TcxGridDBBandedColumn;
    function GetclIDChair: TcxGridDBBandedColumn;
    function GetclLocked: TcxGridDBBandedColumn;
    function GetclIDSpeciality: TcxGridDBBandedColumn;
    function GetclSpeciality: TcxGridDBBandedColumn;
    function GetclPK: TcxGridDBBandedColumn;
    function GetclEnable: TcxGridDBBandedColumn;
    function GetclSpecialityEx: TcxGridDBBandedColumn;
    function GetclYear: TcxGridDBBandedColumn;
    function GetW: TSpecEdW;
    procedure SetW(const Value: TSpecEdW);
    { Private declarations }
  protected
    procedure InitColumns(AView: TcxGridDBBandedTableView); override;
  public
    procedure InitView(AView: TcxGridDBBandedTableView); override;
    property clChiper_Speciality: TcxGridDBBandedColumn
      read GetclChiper_Speciality;
    property clData: TcxGridDBBandedColumn read GetclData;
    property clEducationOrder: TcxGridDBBandedColumn read GetclEducationOrder;
    property clEducation: TcxGridDBBandedColumn read GetclEducation;
    property clIDChair: TcxGridDBBandedColumn read GetclIDChair;
    property clLocked: TcxGridDBBandedColumn read GetclLocked;
    property clIDSpeciality: TcxGridDBBandedColumn read GetclIDSpeciality;
    property clSpeciality: TcxGridDBBandedColumn read GetclSpeciality;
    property clPK: TcxGridDBBandedColumn read GetclPK;
    property clEnable: TcxGridDBBandedColumn read GetclEnable;
    property clSpecialityEx: TcxGridDBBandedColumn read GetclSpecialityEx;
    property clYear: TcxGridDBBandedColumn read GetclYear;
    property W: TSpecEdW read GetW write SetW;
    { Public declarations }
  end;

implementation

uses
  cxDropDownEdit, GridSort;

{$R *.dfm}

procedure TViewSpecEdPopup.clCalcGetDataText(Sender: TcxCustomGridTableItem;
  ARecordIndex: Integer; var AText: string);
var
  AclIDSpec: TcxGridDBBandedColumn;
  ARecord: TcxCustomGridRecord;
  AView: TcxGridDBBandedTableView;
begin
  AView := Sender.GridView as TcxGridDBBandedTableView;

  AclIDSpec := AView.GetColumnByFieldName(W.IDSpeciality.FieldName);

  Assert(AclIDSpec <> nil);

  ARecord := AView.ViewData.Records[ARecordIndex];

  AText := Format('%s ()', [ARecord.DisplayTexts[AclIDSpec.Index]])
end;

procedure TViewSpecEdPopup.clCalcGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  AText := GetCalcColumnText(Sender, ARecord.RecordIndex);
end;

procedure TViewSpecEdPopup.cxGridDBBandedTableViewCustomDrawCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  ACol: TcxGridDBBandedColumn;
  V: Variant;
begin
  inherited;
  if not AViewInfo.GridRecord.IsData then
    Exit;
  if AViewInfo.Selected then
    Exit;
  // if AViewInfo.Focused then Exit;
  // if AViewInfo.IsHotTracked then Exit;

  ACol := AViewInfo.Item as TcxGridDBBandedColumn;
  if ACol.Options.CellMerging then
    Exit;
  V := AViewInfo.GridRecord.Values[4];
  if VarIsNull(V) then
    Exit;

  if V = 0 then
  begin
    ACanvas.Brush.Color := cxDisabledStyle.Color;
  end;
end;

procedure TViewSpecEdPopup.cxGridDBBandedTableViewStylesGetContentStyle
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
{
  var
  ACol: TcxGridDBBandedColumn;
  AEnabled: Integer;
  AView: TcxGridDBBandedTableView;
  V: Variant;
}
begin
  inherited;
  {
    if ARecord = nil then
    Exit;
    if not ARecord.IsData then
    Exit;
    if Sender = nil then
    Exit;
    // if AItem = nil then Exit;
    // if MainView = nil then Exit;

    AView := Sender as TcxGridDBBandedTableView;
    ACol := AView.GetColumnByFieldName
    (FSPGroup.qSpecEd.W.ENABLE_SPECIALITYEDUCATION.FieldName);

    V := ARecord.Values[ACol.Index];

    if VarIsNull(V) then
    Exit;

    AEnabled := V; // ARecord.Values[clEnable.Index];
    if AEnabled = 0 then
    begin
    ACol := AItem as TcxGridDBBandedColumn;
    if ACol.DataBinding.FieldName <> SPGroup.qSpecEd.W.SpecialityEx.FieldName then
    AStyle := cxDisabledStyle;
    end;
  }
end;

function TViewSpecEdPopup.GetCalcColumnText(Sender: TcxCustomGridTableItem;
  ARecordIndex: Integer): String;
var
  AclIDSpec: TcxGridDBBandedColumn;
  ARecord: TcxCustomGridRecord;
  AView: TcxGridDBBandedTableView;
begin
  AView := Sender.GridView as TcxGridDBBandedTableView;

  AclIDSpec := AView.GetColumnByFieldName(W.IDSpeciality.FieldName);

  Assert(AclIDSpec <> nil);

  ARecord := AView.ViewData.Records[ARecordIndex];

  Result := Format('%s ()', [ARecord.DisplayTexts[AclIDSpec.Index]])
end;

function TViewSpecEdPopup.GetclChiper_Speciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.CHIPER_SPECIALITY.FieldName);
end;

function TViewSpecEdPopup.GetclData: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Data.FieldName);
end;

function TViewSpecEdPopup.GetclEducationOrder: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Education_Order.FieldName);
end;

function TViewSpecEdPopup.GetclEducation: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Education.FieldName);
end;

function TViewSpecEdPopup.GetclIDChair: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.IDChair.FieldName);
end;

function TViewSpecEdPopup.GetclLocked: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Locked.FieldName);
end;

function TViewSpecEdPopup.GetclIDSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.IDSpeciality.FieldName);
end;

function TViewSpecEdPopup.GetclSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Speciality.FieldName);
end;

function TViewSpecEdPopup.GetclPK: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.PKFieldName);
end;

function TViewSpecEdPopup.GetclEnable: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (W.ENABLE_SPECIALITYEDUCATION.FieldName);
end;

function TViewSpecEdPopup.GetclSpecialityEx: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.SpecialityEx.FieldName);
end;

function TViewSpecEdPopup.GetclYear: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Year.FieldName);
end;

function TViewSpecEdPopup.GetW: TSpecEdW;
begin
  Result := DSWrap as TSpecEdW;
end;

procedure TViewSpecEdPopup.InitColumns(AView: TcxGridDBBandedTableView);
begin
  inherited;
  clYear.Visible := False;
  clData.Visible := False;
  clEnable.Visible := False;
  clPK.Visible := False;
  clSpecialityEx.Visible := False;
  clSpeciality.Options.CellMerging := True;
  clChiper_Speciality.Options.CellMerging := True;

  clLocked.PropertiesClass := TcxCheckBoxProperties;
  with clLocked.Properties as TcxCheckBoxProperties do
  begin
    ValueChecked := 1;
    ValueUnchecked := 0;
  end;

  GridSort.Add(TSortVariant.Create(clYear, [clYear, clSpeciality,
    clEducationOrder], [msoDescending, msoAscending, msoAscending]));

  // Сортируем по году
  ApplySort(MainView, clYear);
  MyApplyBestFitForView(MainView);
  FocusTopLeft;
end;

procedure TViewSpecEdPopup.InitView(AView: TcxGridDBBandedTableView);
begin
  inherited;
  MainView.OptionsBehavior.ImmediateEditor := False;
  MainView.OptionsView.ColumnAutoWidth := False;
  MainView.OptionsSelection.CellMultiSelect := False;
  MainView.OptionsSelection.MultiSelect := False;
  MainView.OptionsSelection.CellSelect := False;
  MainView.OptionsSelection.InvertSelect := False;
end;

procedure TViewSpecEdPopup.SetW(const Value: TSpecEdW);
begin
  DSWrap := Value;
end;

end.
