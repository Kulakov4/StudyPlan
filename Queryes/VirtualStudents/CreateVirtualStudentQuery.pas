unit CreateVirtualStudentQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TQueryCreateVirtualStudent = class(TQueryBase)
  private
    { Private declarations }
  public
    class procedure Execute(AIDGroup, AIDSpecialityEducation: Integer); static;
    { Public declarations }
  end;

implementation

{$R *.dfm}

class procedure TQueryCreateVirtualStudent.Execute(AIDGroup,
    AIDSpecialityEducation: Integer);
var
  Q: TQueryCreateVirtualStudent;
begin
  Assert(AIDGroup > 0);
  Assert(AIDSpecialityEducation > 0);

  Q := TQueryCreateVirtualStudent.Create(nil);
  try
    With Q.FDQuery do
    begin
      ParamByName('ID_Group').AsInteger := AIDGroup;
      ParamByName('ID_SpecialityEducation').AsInteger := AIDSpecialityEducation;
      ExecSQL;
    end;
  finally
    FreeAndNil(Q);
  end;
end;

end.
