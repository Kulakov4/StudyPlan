unit SpecEducationGridComboBoxView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridComboBox, cxGraphics, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, cxCheckBox, dxSkinsCore, dxSkinsDefaultPainters,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TSpecEducationGridComboBox_View = class(TcxGridComboBoxView)
    RepositoryBandedTableViewColumn1: TcxGridDBBandedColumn;
  private
    FIsRetraining: Boolean;
    { Private declarations }
  protected
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn); override;
  public
    property IsRetraining: Boolean read FIsRetraining write FIsRetraining;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TSpecEducationGridComboBox_View.InitColumn(AcxGridDBBandedColumn:
    TcxGridDBBandedColumn);
begin
  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'speciality' ) then
  begin
    AcxGridDBBandedColumn.Options.CellMerging := True;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'CHIPER_SPECIALITY' ) then
  begin
    AcxGridDBBandedColumn.Visible := not IsRetraining;
    AcxGridDBBandedColumn.MinWidth := 100;
    AcxGridDBBandedColumn.Options.CellMerging := True;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'mount_of_year' ) then
  begin
    AcxGridDBBandedColumn.Visible := false;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'QUALIFICATION' ) then
  begin
    AcxGridDBBandedColumn.Visible := false;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'DATA_' ) then
  begin
    AcxGridDBBandedColumn.Visible := false;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'speciality_ex' ) then
  begin
    AcxGridDBBandedColumn.Visible := false;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'StudyPlanStandart' ) then
  begin
    AcxGridDBBandedColumn.Visible := not IsRetraining;
    AcxGridDBBandedColumn.MinWidth := 80;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'Annotation' ) then
  begin
    AcxGridDBBandedColumn.Visible := not IsRetraining;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'Education' ) then
  begin
    AcxGridDBBandedColumn.MinWidth := 265;
  end;

end;

end.
