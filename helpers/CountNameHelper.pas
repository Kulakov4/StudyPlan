unit CountNameHelper;

interface

type
  Склонение = class(TObject)
  private
  public
    class function Выбрать(const Число: Cardinal; const Один, Два, Пять: string):
        string; static;
  end;

implementation

class function Склонение.Выбрать(const Число: Cardinal; const Один, Два, Пять:
    string): string;
var
  x: Cardinal;
begin
  Result := Пять;
  x := Число mod 100;

  if (x >= 10) and (x <= 20) then
    Exit;

  x := Число mod 10;
  if (x >= 5) then
    Exit;

  if x = 1 then
    Result := Один
  else
    Result := Два;
end;

end.
