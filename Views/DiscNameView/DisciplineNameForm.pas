unit DisciplineNameForm;

interface

uses
  DiscNameViewInterface;

type
  TDisciplineNameForm = class(TObject)
  public
    class function ShowModal(DiscNameViewI: IDiscNameView): Boolean; static;
  end;

implementation

uses
  GridViewForm, MyDir, Vcl.Dialogs, DiscNameView, System.SysUtils,
  System.UITypes;

class function TDisciplineNameForm.ShowModal(DiscNameViewI: IDiscNameView):
    Boolean;
var
  F: TfrmGridView;
begin
  F := TfrmGridView.Create(nil, 'Дисциплины',
    TMyDir.AppDataDirFile('DisciplineNameForm.ini'), [mbOk]);
  try
    F.GridViewClass := TViewDiscName;
    (F.GridView as TViewDiscName).DiscNameViewI := DiscNameViewI;
    Result := F.ShowModal = mrOK;
  finally
    FreeAndNil(F);
  end;
end;

end.
