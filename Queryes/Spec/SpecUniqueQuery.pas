unit SpecUniqueQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TQueryUniqueSpec = class(TQueryBase)
  private
    { Private declarations }
  protected
    function FilterByChiper(AChiperIsNull: Boolean; const AFieldName: String):
        Integer;
  public
    { Public declarations }
  end;

implementation

uses
  StrHelper, System.StrUtils;

{$R *.dfm}

function TQueryUniqueSpec.FilterByChiper(AChiperIsNull: Boolean; const
    AFieldName: String): Integer;
var
  ASQL: string;
  AStipulation: string;
begin
  Assert(not AFieldName.IsEmpty);

  ASQL := ReplaceInSQL(SQL, AFieldName, 0);

  AStipulation := Format('%s is %s null', ['Chiper_Speciality',
    IfThen(AChiperIsNull, '', 'not')]);
  FDQuery.SQL.Text := ReplaceInSQL(ASQL, AStipulation, 1);

  FDQuery.Open;

  Result := FDQuery.RecordCount;
end;

end.
