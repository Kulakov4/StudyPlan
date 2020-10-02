unit StudentGroupsView;

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
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, StudentGroupsQuery,
  System.ImageList, Vcl.ImgList, cxImageList, TB2Dock, TB2Toolbar, TB2Item,
  dxDateRanges;

type
  TViewStudentGroups = class(TfrmGrid)
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    cxImageList: TcxImageList;
    actAdd: TAction;
    TBItem1: TTBItem;
    TBItem2: TTBItem;
    procedure actAddExecute(Sender: TObject);
  private
    function GetclName: TcxGridDBBandedColumn;
    function GetSGW: TStudentGroupsW;
    procedure SetSGW(const Value: TStudentGroupsW);
    { Private declarations }
  protected
    procedure InitColumns(AView: TcxGridDBBandedTableView); override;
  public
    property clName: TcxGridDBBandedColumn read GetclName;
    property SGW: TStudentGroupsW read GetSGW write SetSGW;
    { Public declarations }
  end;

implementation

uses
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

{$R *.dfm}

procedure TViewStudentGroups.actAddExecute(Sender: TObject);
begin
  inherited;
  MainView.DataController.Append;
  FocusColumnEditor(MainView, SGW.Name.FieldName);

  UpdateView;
end;

function TViewStudentGroups.GetclName: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName(SGW.Name.FieldName);
end;

function TViewStudentGroups.GetSGW: TStudentGroupsW;
begin
  Result := DSWrap as TStudentGroupsW;
end;

procedure TViewStudentGroups.InitColumns(AView: TcxGridDBBandedTableView);
begin
  inherited;
  MyApplyBestFitForView(MainView);

  PostOnEnterFields.Add(SGW.Name.FieldName);
end;

procedure TViewStudentGroups.SetSGW(const Value: TStudentGroupsW);
begin
  DSWrap := Value;
end;

end.
