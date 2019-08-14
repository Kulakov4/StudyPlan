unit ThemeUnionControlsView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EssenceGridView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, TB2Dock,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  Vcl.ExtCtrls;

type
  TdsgvThemeUnionControls = class(TdsgvEssence)
  private
    { Private declarations }
  protected
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TdsgvThemeUnionControls.InitColumn(AcxGridDBBandedColumn:
    TcxGridDBBandedColumn);
begin

  AcxGridDBBandedColumn.Options.Sorting := False;
  AcxGridDBBandedColumn.Options.Moving := False;
  AcxGridDBBandedColumn.Options.VertSizing := False;
  AcxGridDBBandedColumn.Options.Grouping := False;
  AcxGridDBBandedColumn.Options.Filtering := False;

end;

end.
