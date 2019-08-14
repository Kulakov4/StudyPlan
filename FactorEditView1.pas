unit FactorEditView1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewEx, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxDBEdit, cxLabel, Vcl.StdCtrls,
  Vcl.ExtCtrls, StudyPlanFactors, CustomFactorEditView, DocumentView;

type
  TviewFactorEditName = class(TviewCustomFactorEdit)
    pnlFactor: TPanel;
    cxlbl1: TcxLabel;
    cxdbteFactorName: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxdbteFactorDescription: TcxDBTextEdit;
  private
    { Private declarations }
  public
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

implementation

uses
  DB;

{$R *.dfm}

procedure TviewFactorEditName.SetDocument(const Value: TDocument);
begin
  inherited;

  if FDocument <> nil then
  begin
    cxdbteFactorName.DataBinding.DataSource := Document.DataSetWrap.DataSource;
    cxdbteFactorName.DataBinding.DataField := 'FactorName';

    cxdbteFactorDescription.DataBinding.DataSource :=
      Document.DataSetWrap.DataSource;
    cxdbteFactorDescription.DataBinding.DataField := 'Description';

  end
  else
  begin
    cxdbteFactorName.DataBinding.DataSource := nil;
    cxdbteFactorDescription.DataBinding.DataSource := nil;
  end;

end;

end.
