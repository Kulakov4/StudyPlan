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
  SpecEdGroup;

type
  TViewSpecEd = class(TfrmGrid)
    dsChairs: TDataSource;
  private
    FSpecEdGr: TSpecEdGroup;
    function GetclIDChair: TcxGridDBBandedColumn;
    function GetclIDSpeciality: TcxGridDBBandedColumn;
    function GetclData: TcxGridDBBandedColumn;
    function GetclYear: TcxGridDBBandedColumn;
    procedure SetSpecEdGr(const Value: TSpecEdGroup);
    { Private declarations }
  public
    procedure InitView(AView: TcxGridDBBandedTableView); override;
    property clIDChair: TcxGridDBBandedColumn read GetclIDChair;
    property clIDSpeciality: TcxGridDBBandedColumn read GetclIDSpeciality;
    property clData: TcxGridDBBandedColumn read GetclData;
    property clYear: TcxGridDBBandedColumn read GetclYear;
    property SpecEdGr: TSpecEdGroup read FSpecEdGr write SetSpecEdGr;
    { Public declarations }
  end;

implementation

uses
  cxDropDownEdit, GridSort;

{$R *.dfm}

function TViewSpecEd.GetclIDChair: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FSpecEdGr.qSpecEd.W.IDChair.FieldName);
end;

function TViewSpecEd.GetclIDSpeciality: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (FSpecEdGr.qSpecEd.W.IDSpeciality.FieldName);
end;

function TViewSpecEd.GetclData: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(FSpecEdGr.qSpecEd.W.Data.FieldName);
end;

function TViewSpecEd.GetclYear: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(FSpecEdGr.qSpecEd.W.Year.FieldName);
end;

procedure TViewSpecEd.InitView(AView: TcxGridDBBandedTableView);
begin
  inherited;
  MainView.OptionsView.ColumnAutoWidth := False;

  // ����������� �������������� ������� �������
  InitializeLookupColumn(clIDChair, dsChairs, lsFixedList,
    FSpecEdGr.qChairs.W.Short_Name.FieldName,
    FSpecEdGr.qChairs.W.ID_CHAIR.FieldName);

  // ���������� ����� �� ����
  // clYear.GroupIndex := 0;
  // clYear.Options.Grouping := True;

  // *****************************
  // ����������
  // *****************************
  clIDSpeciality.Options.SortByDisplayText := isbtOn;
  clIDChair.Options.SortByDisplayText := isbtOn;

  GridSort.Add(TSortVariant.Create(clYear, [clYear, clIDChair, clIDSpeciality,
    clData], [msoDescending, msoAscending, msoAscending, msoAscending]));

  // ��������� �� ����
  ApplySort(MainView, clYear);
  FocusTopLeft(FSpecEdGr.qSpecEd.W.IDSpeciality.FieldName );

  clYear.GroupIndex := 0;
  clYear.Visible := False;
  clIDChair.GroupIndex := 1;
  clIDChair.Visible := False;
end;

procedure TViewSpecEd.SetSpecEdGr(const Value: TSpecEdGroup);
begin
  if FSpecEdGr = Value then
    Exit;

  FSpecEdGr := Value;

  if FSpecEdGr = nil then
  begin
    dsChairs.DataSet := nil;
    DataSource.DataSet := nil;
    Exit;
  end;

  BeginUpdate;
  try
    DataSource.DataSet := FSpecEdGr.qSpecEd.FDQuery;
    dsChairs.DataSet := FSpecEdGr.qChairs.FDQuery;

    // ����������� ������������� ������
    with MainView.DataController do
    begin
      KeyFieldNames := FSpecEdGr.qSpecEd.W.PKFieldName;

      // ������ ��� �������
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
