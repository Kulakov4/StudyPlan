unit SpecialitysGridComboBoxView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GridComboBoxViewEx, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinsDefaultPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, Data.DB, cxDBData, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox, cxNavigator;

type
  TcxSpecialitysGridCBViewEx = class(TcxGridCBViewEx)
  private
    { Private declarations }
  protected
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn); override;
  public
    { Public declarations }
  end;

var
  cxSpecialitysGridCBViewEx: TcxSpecialitysGridCBViewEx;

implementation

{$R *.dfm}

procedure TcxSpecialitysGridCBViewEx.InitColumn(AcxGridDBBandedColumn:
    TcxGridDBBandedColumn);
begin;
  if AnsiSameText('Chiper_speciality', AcxGridDBBandedColumn.DataBinding.FieldName) then
  begin
    AcxGridDBBandedColumn.MinWidth := 100;
  end;

end;

end.
