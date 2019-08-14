unit ParameterValuesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EssenceGridView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, TB2Dock, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls,
  cxNavigator;

type
  TdsgvParameterValues = class(TdsgvEssence)
    procedure cx_dbbtvcxg1DBBandedTableView1EditValueChanged(Sender:
        TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
  private
    { Private declarations }
  protected
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn); override;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    { Public declarations }
  end;

implementation

uses
  cxTextEdit;

{$R *.dfm}

constructor TdsgvParameterValues.Create(AOwner: TComponent; AParent:
    TWinControl; AAlign: TAlign = alClient);
begin
  inherited;
  DataSetControls_View.AllowDelete := False;
  DataSetControls_View.AllowInsert := False;
end;

procedure TdsgvParameterValues.cx_dbbtvcxg1DBBandedTableView1EditValueChanged(
    Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  Esscence.DataSetWrap.Post;
end;

procedure TdsgvParameterValues.InitColumn(AcxGridDBBandedColumn :
    TcxGridDBBandedColumn);
begin
  if AnsiSameText(AcxGridDBBandedColumn.DataBinding.FieldName, 'ParameterName')
  then
  begin
    AcxGridDBBandedColumn.PropertiesClass := TcxTextEditProperties;
    (AcxGridDBBandedColumn.Properties as TcxTextEditProperties).ReadOnly := True;
    (AcxGridDBBandedColumn.Properties as TcxTextEditProperties).IncrementalSearch := True;
    AcxGridDBBandedColumn.Editing := False;
  end;

  if AnsiSameText(AcxGridDBBandedColumn.DataBinding.FieldName, 'ParameterValue')
  then
  begin
    AcxGridDBBandedColumn.PropertiesClass := TcxTextEditProperties;
    // Это почему-то не работает
    (AcxGridDBBandedColumn.Properties as TcxTextEditProperties).ImmediatePost := True;
  end;

end;

end.
