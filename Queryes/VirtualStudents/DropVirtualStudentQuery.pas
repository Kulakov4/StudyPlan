unit DropVirtualStudentQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TQueryDropVirtualStudent = class(TQueryBase)
  private
    { Private declarations }
  public
    class procedure Execute(AIDGroup: Integer); static;
    { Public declarations }
  end;

var
  QueryDropVirtualStudent: TQueryDropVirtualStudent;

implementation

{$R *.dfm}

class procedure TQueryDropVirtualStudent.Execute(AIDGroup: Integer);
var
  Q: TQueryDropVirtualStudent;
begin
  Assert(AIDGroup > 0);

  Q := TQueryDropVirtualStudent.Create(nil);
  try
    With Q.FDQuery do
    begin
      ParamByName('ID_Group').AsInteger := AIDGroup;
      ExecSQL;
    end;
  finally
    FreeAndNil(Q);
  end;
end;

end.
