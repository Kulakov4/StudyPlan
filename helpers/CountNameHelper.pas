unit CountNameHelper;

interface

type
  ��������� = class(TObject)
  private
  public
    class function �������(const �����: Cardinal; const ����, ���, ����: string):
        string; static;
  end;

implementation

class function ���������.�������(const �����: Cardinal; const ����, ���, ����:
    string): string;
var
  x: Cardinal;
begin
  Result := ����;
  x := ����� mod 100;

  if (x >= 10) and (x <= 20) then
    Exit;

  x := ����� mod 10;
  if (x >= 5) then
    Exit;

  if x = 1 then
    Result := ����
  else
    Result := ���;
end;

end.
