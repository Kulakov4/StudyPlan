unit AdmissionView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataSetView_2, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls, SpecEducation, DocumentView,
  cxLabel, EssenceGridView, TB2Dock, cxNavigator;

type
  TdsgvAdmission = class(TdsgvEssence)
    cxgdbbcYear: TcxGridDBBandedColumn;
    cxgdbbcID: TcxGridDBBandedColumn;
    procedure cxgdbbcIDGetCellHint(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; ACellViewInfo: TcxGridTableDataCellViewInfo; const
        AMousePos: TPoint; var AHintText: TCaption; var AIsHintMultiLine: Boolean;
        var AHintTextRect: TRect);
  private
    { Private declarations }
  protected
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn); override;
  public
    { Public declarations }
  end;

implementation

uses
  cxCheckBox;

{$R *.dfm}

procedure TdsgvAdmission.cxgdbbcIDGetCellHint(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; ACellViewInfo: TcxGridTableDataCellViewInfo;
    const AMousePos: TPoint; var AHintText: TCaption; var AIsHintMultiLine:
    Boolean; var AHintTextRect: TRect);
begin
  AHintText := '';
end;

procedure TdsgvAdmission.InitColumn(AcxGridDBBandedColumn:
    TcxGridDBBandedColumn);
begin
  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'speciality' ) then
  begin
    AcxGridDBBandedColumn.Options.CellMerging := True;
    AcxGridDBBandedColumn.PropertiesClass := TcxLabelProperties;
    with AcxGridDBBandedColumn.Properties as TcxLabelProperties do
    begin
      Alignment.Vert := taVCenter;
      WordWrap := True;
    end;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'chiper_speciality' ) then
  begin
    AcxGridDBBandedColumn.MinWidth := 100;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'locked' ) then
  begin
    AcxGridDBBandedColumn.PropertiesClass := TcxCheckBoxProperties;
    with AcxGridDBBandedColumn.Properties as TcxCheckBoxProperties do
    begin
      ImmediatePost := True;
      ValueChecked := 1;
      ValueUnchecked := 0;
    end;
  end;
end;

end.
