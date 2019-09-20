unit SPOView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SPMainView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, TB2Item,
  cxDBExtLookupComboBox, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Vcl.StdCtrls, TB2Dock, TB2Toolbar,
  System.ImageList, Vcl.ImgList, cxImageList, System.Actions, Vcl.ActnList,
  cxLabel, cxDBLabel, cxCheckBox, cxDBEdit, Vcl.Menus;

type
  TViewSPO = class(TViewSPMain)
  private
    { Private declarations }
  protected
    procedure EditStudyPlan; override;
    function IsActionsEnabled: Boolean; override;
    function IsReadOnly: Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  EditStudyPlanForm, InsertEditMode, OptionsHelper;

{$R *.dfm}

procedure TViewSPO.EditStudyPlan;
var
  Afrm: TfrmEditStudyPlan;
begin
  Afrm := TfrmEditStudyPlan.Create(SPGroup);
  try
    Afrm.Mode := EditMode;
    Afrm.ShowModal;
  finally
    FreeAndNil(Afrm);
  end;
end;

function TViewSPO.IsActionsEnabled: Boolean;
begin
  Result := AccessLevel = alAdmin;
end;

function TViewSPO.IsReadOnly: Boolean;
begin
  Result := AccessLevel < alMethodist;
end;

end.
