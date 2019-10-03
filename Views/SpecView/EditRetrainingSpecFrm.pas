unit EditRetrainingSpecFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EditSpecFrm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxDBExtLookupComboBox;

type
  TfrmEditRetrainingSpec = class(TfrmEditSpec)
  private
    { Private declarations }
  protected
    procedure Check; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmEditRetrainingSpec.Check;
begin
  if Speciality.IsEmpty then
    raise Exception.Create('�� ������ ������������ ����������� ��������������');

  if ShortSpeciality.IsEmpty then
    raise Exception.Create('�� ������ ���������� ����������� ��������������');
end;

end.
