unit FactorEditView3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CustomFactorEditView, FactorRulesView,
  DocumentView, Vcl.StdCtrls;

type
  TviewFactorEditRules = class(TviewCustomFactorEdit)
    gbRules: TGroupBox;
  private
    FdsgvFactorRules: TdsgvFactorRules;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

implementation

{$R *.dfm}

constructor TviewFactorEditRules.Create(AOwner: TComponent; AParent:
    TWinControl; AAlign: TAlign = alClient);
begin
  inherited;
  FdsgvFactorRules := TdsgvFactorRules.Create(Self, gbRules);
end;

procedure TviewFactorEditRules.SetDocument(const Value: TDocument);
begin
  inherited;

  if FDocument <> nil then
  begin
    FdsgvFactorRules.SetDocument(Document.FactorRules);
  end
  else
  begin
    FdsgvFactorRules.SetDocument(nil);
  end;

end;

end.
