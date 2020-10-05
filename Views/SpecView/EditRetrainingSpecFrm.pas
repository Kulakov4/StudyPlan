unit EditRetrainingSpecFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EditSpecFrm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxDBExtLookupComboBox;

type
  TfrmEditRetrainingSpec = class(TfrmEditSpec)
    procedure cxlcbSpecialityPropertiesChange(Sender: TObject);
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
    raise Exception.Create('Не задано наименование направления переподготовки');

  if ShortSpeciality.IsEmpty then
    raise Exception.Create('Не задано сокращение направления переподготовки');
end;

procedure TfrmEditRetrainingSpec.cxlcbSpecialityPropertiesChange
  (Sender: TObject);
begin
  inherited;
  cxlcbSpeciality.PostEditValue;

  if cxlcbSpeciality.Text = '' then
    Exit;

  // Если есть специальность, соответствующая названию
  if SpecEditI.SpecSearchByChiperAndName('', cxlcbSpeciality.Text) = 1 then
  begin
    cxteShortSpeciality.Text := SpecEditI.SpecW.SHORT_SPECIALITY.F.AsString;
  end
  else
  begin
    cxteShortSpeciality.Text := '';
  end;
end;

end.
