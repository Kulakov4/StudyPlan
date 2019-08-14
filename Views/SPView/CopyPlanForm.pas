unit CopyPlanForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, cxLabel, cxTextEdit, cxMaskEdit, cxSpinEdit;

type
  TfrmCopyPlan = class(TForm)
    cxseYear: TcxSpinEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
  private
    function GetYear: Integer;
    procedure SetYear(const Value: Integer);
    { Private declarations }
  public
    property Year: Integer read GetYear write SetYear;
    { Public declarations }
  end;

implementation

{$R *.dfm}

function TfrmCopyPlan.GetYear: Integer;
begin
  Result := cxseYear.Value;
end;

procedure TfrmCopyPlan.SetYear(const Value: Integer);
begin
  cxseYear.Value := Value;
end;

end.
