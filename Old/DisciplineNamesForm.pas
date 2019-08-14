unit DisciplineNamesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ViewForm, ExtCtrls, StdCtrls;

type
  TfrmDisciplineNames = class(TfrmView)
    btnOk: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmDisciplineNames.FormCreate(Sender: TObject);
begin
  inherited;
  pnlMain.Anchors := [akTop, akBottom, akRight, akLeft];
end;

end.
