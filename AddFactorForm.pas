unit AddFactorForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewFormEx, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, dxSkinsCore, dxSkinsDefaultPainters,
  cxPropertiesStore, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Vcl.ActnList,
  cxControls, cxContainer, cxEdit, cxCheckBox, cxClasses;

type
  TfrmAddFactor = class(TfrmViewEx)
    cxcbOverride: TcxCheckBox;
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); reintroduce;
    { Public declarations }
  end;

implementation

{$R *.dfm}

constructor TfrmAddFactor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, 'Добавление критерия', 'FactorsForm');
end;

end.
