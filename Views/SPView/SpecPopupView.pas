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
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, SpecByChairQry;

type
  TViewSpecPopup = class(TfrmGrid)
  private
    FQrySpecByChair: TQrySpecByChair;
    function GetclCalcSpeciality: TcxGridDBBandedColumn;
    function GetclChiper_Speciality: TcxGridDBBandedColumn;
    function GetclSpeciality: TcxGridDBBandedColumn;
    procedure SetQrySpecByChair(const Value: TQrySpecByChair);
    { Private declarations }
  public
    procedure InitView(AView: TcxGridDBBandedTableView); override;
    property clCalcSpeciality: TcxGridDBBandedColumn read GetclCalcSpeciality;
    property clChiper_Speciality: TcxGridDBBandedColumn
      read GetclChiper_Speciality;
    property clSpeciality: TcxGridDBBandedColumn read GetclSpeciality;
    property QrySpecByChair: TQrySpecByChair read FQrySpecByChair
      write SetQrySpecByChair;
    { Public declarations }
  end;

implementation

uses
  GridSort;

{$R *.dfm}

function TViewSpecPopup.GetclCalcSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FQrySpecByChair.W.CalcSpeciality.FieldName);
end;

function TViewSpecPopup.GetclChiper_Speciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FQrySpecByChair.W.CHIPER_SPECIALITY.FieldName);
end;

function TViewSpecPopup.GetclSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FQrySpecByChair.W.Speciality.FieldName);
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

  clCalcSpeciality.Visible := False;

  GridSort.Add(TSortVariant.Create(clSpeciality,
    [clSpeciality, clChiper_Speciality] ));

  // Сортируем по специальности
  ApplySort(MainView, clSpeciality);
  FocusTopLeft(FQrySpecByChair.W.Chiper_Speciality.FieldName);
end;

procedure TViewSpecPopup.SetQrySpecByChair(const Value: TQrySpecByChair);
begin
  if FQrySpecByChair = Value then
    Exit;

  FQrySpecByChair := Value;

  if FQrySpecByChair = nil then
  begin
    DataSource := nil;
    Exit;
  end;

  BeginUpdate;
  try
    DataSource.DataSet := FQrySpecByChair.FDQuery;

    // Настраиваем представление планов
    with MainView.DataController do
    begin
      KeyFieldNames := FQrySpecByChair.W.PKFieldName;

      // Создаём все колонки
      CreateAllItems();
    end;

    InitView(MainView);
  finally
    EndUpdate;
  end;

  MyApplyBestFitForView(MainView);
  UpdateView;

end;

end.
