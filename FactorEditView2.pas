unit FactorEditView2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewEx, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxLabel, cxCheckBox, Vcl.ExtCtrls,
  CustomFactorEditView, StudyPlanFactors, QuerysView, DocumentView;

type
  TviewFactorEditQuery = class(TviewCustomFactorEdit)
    pnlQuery: TPanel;
    cxcbQueryLink: TcxCheckBox;
    pnlQueryBottom: TPanel;
  private
    FdsgvQuerys: TdsgvQuerys;
    FQuerys: TQuerys;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    property Querys: TQuerys read FQuerys;
    { Public declarations }
  end;

implementation

uses
  DB;

{$R *.dfm}

constructor TviewFactorEditQuery.Create(AOwner: TComponent;
  AParent: TWinControl; AAlign: TAlign = alClient);
begin
  inherited;
  FQuerys := TQuerys.Create(Self);
  FdsgvQuerys := TdsgvQuerys.Create(Self, pnlQueryBottom);
end;

procedure TviewFactorEditQuery.SetDocument(const Value: TDocument);
begin
  inherited;

  if FDocument <> nil then
  begin
    FdsgvQuerys.SetDocument(Querys);

    if Document.DS.State in [dsEdit, dsBrowse] then
    begin
      if not Document.Field('IDQuery').IsNull then
      begin
        Querys.DataSetWrap.LocateAndCheck(Querys.KeyFieldName,
          Document.Field('IDQuery').Value, []);
      end;
      cxcbQueryLink.Checked := not Document.Field('IDQuery').IsNull;
    end;

  end
  else
  begin
    FdsgvQuerys.SetDocument(nil);
  end;

end;

end.
