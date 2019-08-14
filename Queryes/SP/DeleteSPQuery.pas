unit DeleteSPQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TQryDeleteSP = class(TQueryBase)
  private
    { Private declarations }
  public
    class procedure Delete(const AIDSpecialityEducation: Integer); static;
    { Public declarations }
  end;

implementation

{$R *.dfm}

class procedure TQryDeleteSP.Delete(const AIDSpecialityEducation: Integer);
var
  Q: TQryDeleteSP;
begin
  Assert(AIDSpecialityEducation > 0);

  Q := TQryDeleteSP.Create(nil);
  try
    with Q.FDQuery do
    begin
      ParamByName('IDSpecialityEducation').AsInteger := AIDSpecialityEducation;
      ExecSQL;
      Connection.Commit;
    end;
  finally
    FreeAndNil(Q);
  end;
end;

end.
