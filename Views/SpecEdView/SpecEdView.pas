unit SpecEdView;

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
  dxDateRanges, SpecEdServiceInterface;

type
  TViewSpecEd = class(TfrmGrid)
  private
    FSpecEdServiceI: ISpecEdService;
    function GetclIDChair: TcxGridDBBandedColumn;
    function GetclIDSpeciality: TcxGridDBBandedColumn;
    function GetclData: TcxGridDBBandedColumn;
    function GetclYear: TcxGridDBBandedColumn;
    function GetW: TSpecEdW;
    procedure SetSpecEdServiceI(const Value: ISpecEdService);
    { Private declarations }
  protected
    procedure InitColumns(AView: TcxGridDBBandedTableView); override;
    property W: TSpecEdW read GetW;
  public
    procedure InitView(AView: TcxGridDBBandedTableView); override;
    property clIDChair: TcxGridDBBandedColumn read GetclIDChair;
    property clIDSpeciality: TcxGridDBBandedColumn read GetclIDSpeciality;
    property clData: TcxGridDBBandedColumn read GetclData;
    property clYear: TcxGridDBBandedColumn read GetclYear;
    property SpecEdServiceI: ISpecEdService read FSpecEdServiceI write
        SetSpecEdServiceI;
    { Public declarations }
  end;

implementation

uses
  cxDropDownEdit, GridSort, DBLookupComboBoxHelper;

{$R *.dfm}

function TViewSpecEd.GetclIDChair: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.IDChair.FieldName);
end;

function TViewSpecEd.GetclIDSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.IDSpeciality.FieldName);
end;

function TViewSpecEd.GetclData: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Data.FieldName);
end;

function TViewSpecEd.GetclYear: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(W.Year.FieldName);
end;

function TViewSpecEd.GetW: TSpecEdW;
begin
  Assert(FSpecEdServiceI <> nil);
  Result := FSpecEdServiceI.SpecEdW;
end;

procedure TViewSpecEd.InitColumns(AView: TcxGridDBBandedTableView);
begin
  inherited;
  // Настраиваем подстановочную колонку Кафедра
  TDBLCB.InitColumn(clIDChair, FSpecEdServiceI.ChairsW.Short_Name, lsFixedList);

  // Группируем планы по году
  // clYear.GroupIndex := 0;
  // clYear.Options.Grouping := True;

  // *****************************
  // Сортировка
  // *****************************
  clIDSpeciality.Options.SortByDisplayText := isbtOn;
  clIDChair.Options.SortByDisplayText := isbtOn;

  GridSort.Add(TSortVariant.Create(clYear, [clYear, clIDChair, clIDSpeciality,
    clData], [msoDescending, msoAscending, msoAscending, msoAscending]));

  // Сортируем по году
  ApplySort(MainView, clYear);
  FocusTopLeft(W.IDSpeciality.FieldName);

  clYear.GroupIndex := 0;
  clYear.Visible := False;
  clIDChair.GroupIndex := 1;
  clIDChair.Visible := False;

  MyApplyBestFitForView(MainView);
end;

procedure TViewSpecEd.InitView(AView: TcxGridDBBandedTableView);
begin
  inherited;
  MainView.OptionsView.ColumnAutoWidth := False;
end;

procedure TViewSpecEd.SetSpecEdServiceI(const Value: ISpecEdService);
begin
  FSpecEdServiceI := Value;

  if FSpecEdServiceI = nil then
  begin
    DSWrap := nil;
    Exit;
  end;

  DSWrap := FSpecEdServiceI.SpecEdW;

  UpdateView;
end;

end.
