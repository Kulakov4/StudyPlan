unit QuerysView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataSetView_2, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls, StudyPlanFactors, DocumentView,
  TB2Dock, cxContainer, TB2Item, cxTextEdit, cxMemo, cxRichEdit, cxDBRichEdit,
  TB2Toolbar, cxSplitter, cxDBEdit, DataSetControlsView,
  FactorRulesView, EssenceGridView, cxNavigator;

type
  TdsgvQuerys = class(TdsgvEssence)
    pnlRight: TPanel;
    cxs1: TcxSplitter;
    cxdbmQueryText: TcxDBMemo;
    cxs2: TcxSplitter;
    pnlQueryParameters: TPanel;
  private
    FdsgvQueryParameters: TdsgvFactorRules;
    function GetDocument: TQuerys;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    property Document: TQuerys read GetDocument;
    { Public declarations }
  end;

implementation

{$R *.dfm}

constructor TdsgvQuerys.Create(AOwner: TComponent; AParent: TWinControl;
    AAlign: TAlign = alClient);
begin
  inherited;
  FdsgvQueryParameters := TdsgvFactorRules.Create(Self, pnlQueryParameters);
end;

function TdsgvQuerys.GetDocument: TQuerys;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TQuerys;
end;

procedure TdsgvQuerys.SetDocument(const Value: TDocument);
begin
  inherited;

  if FDocument <> nil then
  begin
    cxdbmQueryText.DataBinding.DataSource := Document.DataSetWrap.DataSource;
    cxdbmQueryText.DataBinding.DataField := 'QueryText';

    FdsgvQueryParameters.SetDocument(Document.QueryParameters);
  end
  else
  begin
    cxdbmQueryText.DataBinding.DataSource := nil;
    FdsgvQueryParameters.SetDocument(nil);
  end;

end;

end.
