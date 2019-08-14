unit SPForUMKView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EssenceGridView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, TB2Dock, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls,
  cxContainer, cxTextEdit, cxDBEdit, cxLabel, DocumentView;

type
  TdsgvSPForUMK = class(TdsgvEssence)
    pnlTop: TPanel;
    cxLabel1: TcxLabel;
    cxdbteStudyPlanStandart: TcxDBTextEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxdbteChiperSpeciality: TcxDBTextEdit;
    cxdbteSpeciality: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    cxdbteDisciplineName: TcxDBTextEdit;
  private
    { Private declarations }
  public
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TdsgvSPForUMK.SetDocument(const Value: TDocument);
begin

  inherited;

  if FDocument <> nil then
  begin
    cxdbteDisciplineName.DataBinding.DataSource := Esscence.DataSetWrap.DataSource;
    cxdbteDisciplineName.DataBinding.DataField := 'FullDisciplineName';

    cxdbteStudyPlanStandart.DataBinding.DataSource := Esscence.DataSetWrap.DataSource;
    cxdbteStudyPlanStandart.DataBinding.DataField := 'StudyPlanStandart';

    cxdbteChiperSpeciality.DataBinding.DataSource := Esscence.DataSetWrap.DataSource;
    cxdbteChiperSpeciality.DataBinding.DataField := 'chiper_speciality';

    cxdbteSpeciality.DataBinding.DataSource := Esscence.DataSetWrap.DataSource;
    cxdbteSpeciality.DataBinding.DataField := 'speciality';
  end
  else
  begin
  end;

end;

end.
