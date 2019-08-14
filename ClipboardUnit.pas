unit ClipboardUnit;

interface

uses
  System.Classes;

type
  TClb = class(TObject)
  private
  public
    class function GetRowsAsArray: TArray<String>; static;
  end;

implementation

uses Vcl.Clipbrd, System.SysUtils;

class function TClb.GetRowsAsArray: TArray<String>;
var
  i: Integer;
  S: string;
begin
  S := Clipboard.AsText.Trim;
  // Разбиваем текст на строки
  Result := S.Split([#13]);
  for i := Low(Result) to High(Result) do
  begin
    Result[i] := Result[i].Trim([#13, #10, ' ']);
  end;

end;

end.
