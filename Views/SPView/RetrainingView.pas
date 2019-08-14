unit RetrainingView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SPMainView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, TB2Item,
  cxDBExtLookupComboBox, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Vcl.StdCtrls, TB2Dock, TB2Toolbar,
  System.ImageList, Vcl.ImgList, cxImageList, System.Actions, Vcl.ActnList,
  cxLabel, cxDBLabel, cxCheckBox, cxDBEdit;

type
  TViewRetraining = class(TViewSPMain)
    tbArea: TTBToolbar;
    TBControlItem5: TTBControlItem;
    Label1: TLabel;
    cxdblcbArea: TcxDBLookupComboBox;
  private
    { Private declarations }
  protected
    procedure EditStudyPlan; override;
    procedure Init; override;
    function IsActionsEnabled: Boolean; override;
    function IsReadOnly: Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  InsertEditMode, EditRetrainingPlanForm, DBLookupComboBoxHelper, OptionsHelper;

{$R *.dfm}

procedure TViewRetraining.EditStudyPlan;
var
  Afrm: TfrmEditRetrainingPlan;
begin
  Afrm := TfrmEditRetrainingPlan.Create(SPGroup);
  try
    Afrm.Mode := EditMode;
    Afrm.ShowModal;
  finally
    FreeAndNil(Afrm);
  end;
end;

procedure TViewRetraining.Init;
begin
  inherited;
  ViewSpecEdPopup.clChiper_Speciality.Visible := False;

  // Сфера
  cxdblcbArea.Enabled := False;
  TDBLCB.Init(cxdblcbArea, SPGroup.qSpecEdSimple.DataSource,
    SPGroup.qSpecEdSimple.W.IDArea.FieldName, SPGroup.qAreas.DataSource,
    SPGroup.qAreas.W.AREA, lsEditFixedList);
end;

function TViewRetraining.IsActionsEnabled: Boolean;
begin
  Result := AccessLevel >= alManager;
end;

function TViewRetraining.IsReadOnly: Boolean;
begin
  Result := AccessLevel < alManager;
end;

end.
