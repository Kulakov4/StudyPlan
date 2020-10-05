unit VOView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SPMainView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, TB2Item,
  cxDBExtLookupComboBox, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Vcl.StdCtrls, TB2Dock, TB2Toolbar,
  System.ImageList, Vcl.ImgList, cxImageList, System.Actions, Vcl.ActnList,
  cxLabel, cxDBLabel, cxCheckBox, cxDBEdit, Vcl.Menus, SPViewInterface;

type
  TViewVO = class(TViewSPMain)
  private
    { Private declarations }
  protected
    procedure CreateStudyPlan; override;
    procedure EditStudyPlan; override;
    function IsActionsEnabled: Boolean; override;
    function IsReadOnly: Boolean; override;
  public
    property SPViewI;
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

implementation

uses
  EditStudyPlanForm, InsertEditMode, OptionsHelper;

{$R *.dfm}

constructor TViewVO.Create(AOwner: TComponent);
begin
  inherited;
  if Screen.Width < 1920 then
    cxdbelcbSpeciality.Width := 591;
end;

procedure TViewVO.CreateStudyPlan;
var
  Afrm: TfrmEditStudyPlan;
begin
  Afrm := TfrmEditStudyPlan.Create(Self, SPViewI.GetSPEditInterface, InsertMode);
  try
    Afrm.IDEducationLevel := 2; // Бакалавриат (планы для специалитета не создаём)
    Afrm.ShowModal;
  finally
    FreeAndNil(Afrm);
  end;
end;

procedure TViewVO.EditStudyPlan;
var
  Afrm: TfrmEditStudyPlan;
begin
  Afrm := TfrmEditStudyPlan.Create(Self, SPViewI.GetSPEditInterface, EditMode);
  try
    Afrm.ShowModal;
  finally
    FreeAndNil(Afrm);
  end;
end;

function TViewVO.IsActionsEnabled: Boolean;
begin
  Result := AccessLevel = alAdmin;
end;

function TViewVO.IsReadOnly: Boolean;
begin
  Result := AccessLevel < alMethodist;
end;

end.
