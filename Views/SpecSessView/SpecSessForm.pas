unit SpecSessForm;

interface

uses
  SpecSessServiceInterface;

type
  TSpecSessForm = class(TObject)
  public
    class function ShowModal(SpecSessServiceI: ISpecSessService): Boolean; static;
  end;

implementation

uses
  GridViewForm, MyDir, Vcl.Dialogs, SpecSessView, System.SysUtils,
  System.UITypes;

class function TSpecSessForm.ShowModal(SpecSessServiceI: ISpecSessService):
    Boolean;
var
  F: TfrmGridView;
begin
  F := TfrmGridView.Create(nil, '������ / ��������',
    TMyDir.AppDataDirFile('NewSessionForm.ini'), [mbOk], 500);
  try
    F.GridViewClass := TViewSpecSess;
    (F.GridView as TViewSpecSess).SpecSessServiceI := SpecSessServiceI;

    // �������� ��� ������� ������ OK
    F.OKAction := (F.GridView as TViewSpecSess).actSave;

    Result := F.ShowModal = mrOK;
  finally
    FreeAndNil(F);
  end;
end;

end.
