unit AllCompetenceGridView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EssenceGridView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, TB2Dock, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls;

type
  TdsgvAllCompetence = class(TdsgvEssence)
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    { Public declarations }
  end;


implementation

{$R *.dfm}

constructor TdsgvAllCompetence.Create(AOwner: TComponent; AParent: TWinControl;
    AAlign: TAlign = alClient);
begin
  inherited;
  tbdEssenceTop.Visible := False;
end;

end.
