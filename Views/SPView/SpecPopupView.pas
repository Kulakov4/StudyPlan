unit SpecPopupView;

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
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, SpecByChairQry,
  dxDateRanges;

type
  TViewSpecPopup = class(TfrmGrid)
  private
    function GetclCalcSpeciality: TcxGridDBBandedColumn;
    function GetclChiper_Speciality: TcxGridDBBandedColumn;
    function GetclSpeciality: TcxGridDBBandedColumn;
    function GetW: TSpecByChairW;
    procedure SetW(const Value: TSpecByChairW);
    { Private declarations }
  protected
    procedure InitColumns(AView: TcxGridDBBandedTableView); override;
  public
    procedure InitView(AView: TcxGridDBBandedTableView); override;
    property clCalcSpeciality: TcxGridDBBandedColumn read GetclCalcSpeciality;
    property clChiper_Speciality: TcxGridDBBandedColumn
      read GetclChiper_Speciality;
    property clSpeciality: TcxGridDBBandedColumn read GetclSpeciality;
    property W: TSpecByChairW read GetW write SetW;
    { Public declarations }
  end;

implementation

uses
  GridSort;

{$R *.dfm}

function TViewSpecPopup.GetclCalcSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.CalcSpeciality.FieldName);
end;

function TViewSpecPopup.GetclChiper_Speciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.CHIPER_SPECIALITY.FieldName);
end;

function TViewSpecPopup.GetclSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Speciality.FieldName);
end;

function TViewSpecPopup.GetW: TSpecByChairW;
begin
  Result := DSWrap as TSpecByChairW;
end;

procedure TViewSpecPopup.InitColumns(AView: TcxGridDBBandedTableView);
begin
  inherited;
  clCalcSpeciality.Visible := False;

  GridSort.Add(TSortVariant.Create(clSpeciality,
    [clSpeciality, clChiper_Speciality] ));

  // Сортируем по специальности
  ApplySort(MainView, clSpeciality);
  FocusTopLeft(W.Chiper_Speciality.FieldName);
end;

procedure TViewSpecPopup.InitView(AView: TcxGridDBBandedTableView);
begin
  inherited;

  MainView.OptionsBehavior.ImmediateEditor := False;
  MainView.OptionsView.ColumnAutoWidth := False;
  MainView.OptionsSelection.CellMultiSelect := False;
  MainView.OptionsSelection.MultiSelect := False;
  MainView.OptionsSelection.CellSelect := False;
  MainView.OptionsSelection.InvertSelect := False;
end;

procedure TViewSpecPopup.SetW(const Value: TSpecByChairW);
begin
  DSWrap := Value;
end;

end.
