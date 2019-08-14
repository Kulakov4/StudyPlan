unit CopyProgressForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxProgressBar, cxLabel, Menus, Vcl.StdCtrls, cxButtons;

type
  TfrmCopyProgress = class(TForm)
    cxpbCopy: TcxProgressBar;
    cxlblErrorCount: TcxLabel;
    cxbtnClose: TcxButton;
    procedure cxbtnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FErrorCount: Integer;
    procedure SetErrorCount(const Value: Integer);
    { Private declarations }
  public
    property ErrorCount: Integer read FErrorCount write SetErrorCount;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmCopyProgress.cxbtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCopyProgress.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCopyProgress.SetErrorCount(const Value: Integer);
begin
  FErrorCount := Value;
  cxlblErrorCount.Caption := Format('Количество ошибок: %d', [FErrorCount]);
end;

end.
