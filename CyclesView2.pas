unit CyclesView2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EssenceGridView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, TB2Dock, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls, CSE,
  GridComboBox, TB2Toolbar, DocumentView, cxNavigator;

type
  TdsgvCycles = class(TdsgvEssence)
    tbCycleTypes: TTBToolbar;
  private
    FgcbvCycleTypes: TcxGridComboBoxView;
    function GetDocument: TCycles;
    { Private declarations }
  protected
    property Document: TCycles read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

implementation
uses cxDropDownEdit;
{$R *.dfm}

constructor TdsgvCycles.Create(AOwner: TComponent; AParent: TWinControl;
    AAlign: TAlign = alClient);
begin
  inherited;
  FgcbvCycleTypes := TcxGridComboBoxView.Create(Self, tbCycleTypes);
  FgcbvCycleTypes.Init(lsFixedList, 'cycletype', 400);
end;

function TdsgvCycles.GetDocument: TCycles;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TCycles;
end;

procedure TdsgvCycles.SetDocument(const Value: TDocument);
begin
  inherited;

  if (FDocument <> nil) then
  begin
    if Document.CycleType.Master <> nil then
    begin
      FgcbvCycleTypes.Enabled := True;
      FgcbvCycleTypes.SetDocument(Document.CycleType.Master.DataSetWrap)
    end
    else
      FgcbvCycleTypes.Enabled := False;
  end
  else
  begin
    FgcbvCycleTypes.SetDocument(nil);
  end;
end;

end.
