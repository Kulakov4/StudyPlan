unit GridViewForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  cxClasses, cxPropertiesStore, GridFrame, Vcl.ActnList;

type
  TfrmGridView = class(TForm)
    pnlMain: TPanel;
    cxbtnOK: TcxButton;
    cxpsViewForm: TcxPropertiesStore;
    cxbtnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FGridView: TfrmGrid;
    FGridViewClass: TGridViewClass;
    FOKAction: TAction;
    procedure SetGridViewClass(const Value: TGridViewClass);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; const ACaption, AStorageFileName:
        string; MsgDlgButtons: TMsgDlgButtons; AWidth: Cardinal = 0; AHeight:
        Cardinal = 0); reintroduce;
    procedure AfterConstruction; override;
    property GridView: TfrmGrid read FGridView;
    property GridViewClass: TGridViewClass read FGridViewClass
      write SetGridViewClass;
    property OKAction: TAction read FOKAction write FOKAction;
    { Public declarations }
  end;

implementation

{$R *.dfm}

constructor TfrmGridView.Create(AOwner: TComponent; const ACaption,
    AStorageFileName: string; MsgDlgButtons: TMsgDlgButtons; AWidth: Cardinal =
    0; AHeight: Cardinal = 0);
begin
  inherited Create(AOwner);
  OKAction := nil;
  Caption := ACaption;
  cxpsViewForm.StorageName := AStorageFileName;

  // Если кнопка отмена нам не нужна
  if not (mbCancel in MsgDlgButtons) then
  begin
    cxbtnOk.Left := cxbtnCancel.Left;
    cxbtnCancel.Visible := False;
  end;

  if AWidth > 0 then
    Width := AWidth;

  if AHeight > 0 then
    Height := AHeight;
end;

procedure TfrmGridView.AfterConstruction;
begin
  inherited;

  cxpsViewForm.RestoreFrom;
end;

procedure TfrmGridView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cxpsViewForm.StoreTo();

  if (ModalResult = mrOK) and (OKAction <> nil) and (OKAction.Enabled) then
  try
    // Пытаемся сохранить
    OKAction.Execute;
  except
    Action := caNone;
    raise;
  end;
end;

procedure TfrmGridView.SetGridViewClass(const Value: TGridViewClass);
begin
  if FGridViewClass = Value then
    Exit;

  FGridViewClass := Value;
  FreeAndNil(FGridView);
  FGridView := FGridViewClass.Create(nil);
  FGridView.Place(pnlMain);
end;

end.
