unit SPEditView2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  System.Actions, Vcl.ActnList, cxTextEdit;

type
  TFrame1 = class(TFrame)
    Label1: TLabel;
    cxTextEdit1: TcxTextEdit;
    Button1: TButton;
    ActionList: TActionList;
    actViewCSE: TAction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
