unit CopyFactorsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewFormEx, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, dxSkinsCore, dxSkinsDefaultPainters,
  cxPropertiesStore, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxControls,
  cxContainer, cxEdit, TB2Item, cxCheckBox, TB2Dock, TB2Toolbar, cxClasses;

type
  TfrmCopyStudyPlanFactors = class(TfrmViewEx)
    tbdTop: TTBDock;
    tbSPFCopy: TTBToolbar;
    cxcbOverride: TcxCheckBox;
    tbciOverride: TTBControlItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
