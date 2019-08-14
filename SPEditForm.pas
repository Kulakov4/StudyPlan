unit SPEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ViewForm, ExtCtrls, Menus, cxLookAndFeelPainters, StdCtrls,
  cxButtons, cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters,
  cxClasses, cxPropertiesStore;

type
  TfrmSPEdit = class(TfrmView)
    cxButton1: TcxButton;
    cxButton2: TcxButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSPEdit: TfrmSPEdit;

implementation

{$R *.dfm}

end.
