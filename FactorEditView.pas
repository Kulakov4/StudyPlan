unit FactorEditView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewEx, StudyPlanFactors, DocumentView,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, cxDBEdit, cxLabel,
  Vcl.ExtCtrls, Vcl.StdCtrls, Menus, cxButtons,
  dxSkinsdxNavBarPainter, dxNavBarCollns, cxClasses, dxNavBarBase, dxNavBar,
  cxSplitter, QuerysView, cxMaskEdit, cxDropDownEdit, cxCheckBox, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, TB2Dock, TB2Toolbar,
  CustomFactorEditView, FactorEditView1, FactorEditView2, FactorEditView3;

type
  TviewFactorEdit = class(TviewCustomFactorEdit)
    pnlMain: TPanel;
    dxNavBar1: TdxNavBar;
    dxnvbrgrpNavBar1Group1: TdxNavBarGroup;
    dxnvbrtmNavBar1Item1: TdxNavBarItem;
    cxs1: TcxSplitter;
    dxnvbrtmNavBar1Item2: TdxNavBarItem;
    tbdTop: TTBDock;
    dxnvbrtmNavBar1Item3: TdxNavBarItem;
    procedure dxnvbrtmNavBar1Item1Click(Sender: TObject);
    procedure dxnvbrtmNavBar1Item2Click(Sender: TObject);
    procedure dxnvbrtmNavBar1Item3Click(Sender: TObject);
  private
    FviewFactorEditName: TviewFactorEditName;
    FviewFactorEditQuery: TviewFactorEditQuery;
    FviewFactorEditRules: TviewFactorEditRules;
    { Private declarations }
  protected
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    property viewFactorEditName: TviewFactorEditName read FviewFactorEditName;
    property viewFactorEditQuery: TviewFactorEditQuery read FviewFactorEditQuery;
    property viewFactorEditRules: TviewFactorEditRules read FviewFactorEditRules;
    { Public declarations }
  end;

implementation

uses
  DB;

{$R *.dfm}

constructor TviewFactorEdit.Create(AOwner: TComponent; AParent: TWinControl;
    AAlign: TAlign = alClient);
begin
  inherited;
  FviewFactorEditName := TviewFactorEditName.Create(Self, pnlMain);
  FviewFactorEditQuery := TviewFactorEditQuery.Create(Self, pnlMain);
  FviewFactorEditRules := TviewFactorEditRules.Create(Self, pnlMain);

  FviewFactorEditName.BringToFront;
end;

procedure TviewFactorEdit.dxnvbrtmNavBar1Item1Click(Sender: TObject);
begin
  FviewFactorEditName.BringToFront;
end;

procedure TviewFactorEdit.dxnvbrtmNavBar1Item2Click(Sender: TObject);
begin
  FviewFactorEditQuery.BringToFront;
end;

procedure TviewFactorEdit.dxnvbrtmNavBar1Item3Click(Sender: TObject);
begin
  FviewFactorEditRules.BringToFront;
end;

procedure TviewFactorEdit.SetDocument(const Value: TDocument);
begin
  inherited;
  FviewFactorEditName.SetDocument(Value);
  FviewFactorEditQuery.SetDocument(Value);
  FviewFactorEditRules.SetDocument(Value);
end;

end.
