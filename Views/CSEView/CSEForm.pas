unit CSEForm;

interface

uses
  DocumentView, CSEServiceInterface;

type
  TCSEForm = class(TDocument)
  public
    class function ShowModal(CSEServiceI: ICSEService): Boolean; static;
  end;

implementation

uses
  GridViewForm, MyDir, System.UITypes, Vcl.Dialogs, ViewCSE, System.SysUtils;

class function TCSEForm.ShowModal(CSEServiceI: ICSEService): Boolean;
var
  F: TfrmGridView;
begin
  F := TfrmGridView.Create(nil, 'Структура учебного плана',
    TMyDir.AppDataDirFile('NewCSEForm.ini'), [mbOk], 500);
  try
    F.GridViewClass := TViewCSEFrame;
    (F.GridView as TViewCSEFrame).CSEServiceI := CSEServiceI;

    Result := F.ShowModal = mrOK;

  finally
    FreeAndNil(F);
  end;

end;

end.
