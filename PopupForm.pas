unit PopupForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxDropDownEdit, DocumentView;

type
  TfrmPopupForm = class(TForm)
  private
    FCloseOnEscape: Boolean;
    FView: TView;
    FViewClass: TViewClass;
    function GetPopupWindow: TcxCustomEditPopupWindow;
    procedure SetViewClass(const Value: TViewClass);
    { Private declarations }
  protected
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    property PopupWindow: TcxCustomEditPopupWindow read GetPopupWindow;
  public
    constructor Create(AOwner: TComponent); override;
    property CloseOnEscape: Boolean read FCloseOnEscape write FCloseOnEscape;
    property View: TView read FView;
    property ViewClass: TViewClass read FViewClass write SetViewClass;
    { Public declarations }
  end;


implementation

{$R *.dfm}

constructor TfrmPopupForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCloseOnEscape := True;
end;

procedure TfrmPopupForm.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do
    if (FCloseOnEscape) and // разрешено закрывать окно по Esc
      (CharCode = VK_ESCAPE) and // была нажата клавиша Escape
      (KeyDataToShiftState(KeyData) = []) then // сдвиговые клавиши не тронуты
    begin
      PopupWindow.CloseUp;
    end;

  inherited;
end;

function TfrmPopupForm.GetPopupWindow: TcxCustomEditPopupWindow;
var
  PopupWindow: TCustomForm;
begin
  PopupWindow := GetParentForm(Self);
  Result := PopupWindow as TcxCustomEditPopupWindow;
end;

procedure TfrmPopupForm.SetViewClass(const Value: TViewClass);
begin
  if FViewClass <> Value then
  begin
    FViewClass := Value;
    FreeAndNil(FView);
    FView := FViewClass.Create(nil, Self);
  end;
end;

end.
