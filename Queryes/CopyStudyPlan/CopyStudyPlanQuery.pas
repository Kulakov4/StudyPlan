unit CopyStudyPlanQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TQueryCopyStudyPlan = class(TQueryBase)
  private
    { Private declarations }
  public
    class procedure Copy(AIDArray: TArray<Integer>; AYear: Integer); static;
    { Public declarations }
  end;

implementation

{$R *.dfm}

class procedure TQueryCopyStudyPlan.Copy(AIDArray: TArray<Integer>;
  AYear: Integer);
var
  AID: Integer;
  Q: TQueryCopyStudyPlan;
begin
  Assert(Length(AIDArray) > 0);
  Assert(AYear > 0);

  Q := TQueryCopyStudyPlan.Create(nil);
  try
    for AID in AIDArray do
    begin

      with Q.FDQuery do
      begin
        ParamByName('ID_SpecialityEducation').AsInteger := AID;
        ParamByName('Year').AsInteger := AYear;
        ExecSQL;
        Connection.Commit;
      end;

    end;
  finally
    FreeAndNil(Q);
  end;

end;

end.
