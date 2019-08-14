unit FactorRulesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataSetView_2, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls, DataSetControlsView,
  DocumentView, StudyPlanFactors, TB2Dock, cxButtonEdit, EssenceGridView,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TdsgvFactorRules = class(TdsgvEssence)
  private
    { Private declarations }
  protected
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn); override;
    procedure OnParameterNameButtonClick(Sender: TObject; AButtonIndex: Integer);
  public
    { Public declarations }
  end;

implementation

uses
  ViewFormEx;

{$R *.dfm}

procedure TdsgvFactorRules.InitColumn(AcxGridDBBandedColumn:
    TcxGridDBBandedColumn);
begin
  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'ParameterName' ) then
  begin
    AcxGridDBBandedColumn.Position.ColIndex := 1;
    AcxGridDBBandedColumn.PropertiesClass := TcxButtonEditProperties;
    (AcxGridDBBandedColumn.Properties as TcxButtonEditProperties).ReadOnly := True;
    (AcxGridDBBandedColumn.Properties as TcxButtonEditProperties).OnButtonClick := OnParameterNameButtonClick;
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'RuleDescription' ) then
  begin
    AcxGridDBBandedColumn.Position.ColIndex := 0
  end;

  if AnsiSameText( AcxGridDBBandedColumn.DataBinding.FieldName, 'QUERYPARAMETERNAME' ) then
  begin
    AcxGridDBBandedColumn.Position.ColIndex := 0
  end;
end;

procedure TdsgvFactorRules.OnParameterNameButtonClick(Sender: TObject;
    AButtonIndex: Integer);
var
  AParameters: TParameters;
  //AQueryParameter: string;
  frmParameters: TfrmViewEx;
begin
  frmParameters := TfrmViewEx.Create(Self, 'Справочник параметров',
    'ParametersForm');
  AParameters := TParameters.Create(Self);
  try
    AParameters.Refresh;
    if not Esscence.Field('IDPARAMETER').IsNull then
      AParameters.DataSetWrap.LocateByPK( Esscence.Field('IDPARAMETER').Value );

    frmParameters.ViewClass := TdsgvEssence;
    frmParameters.View.SetDocument(AParameters);

    if frmParameters.ShowModal = mrOk then
    begin
      try
        if Esscence.DS.State = dsBrowse then
          Esscence.DS.Edit;

        Esscence.Field('IDPARAMETER').Value :=
          AParameters.Field('ID_Parameter').Value;
        Esscence.Field('parametername').Value :=
          AParameters.Field('ParameterName').Value;

        Esscence.DS.Post
      except
        raise;
        Esscence.DS.Cancel;
      end;
    end
    else
      Esscence.DS.Cancel;
  finally
    AParameters.Free;
    frmParameters.Free;
  end;
end;

end.
