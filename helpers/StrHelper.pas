unit StrHelper;

interface

function DeleteDoubleSpace(const S: string): String;
function GetWords(const S: String): String;

function Uncomment(ASQL, AComment: string): string;

function ReplaceInSQL(const ASQL: String; const AStipulation: String;
  ANumber: Integer): String;

implementation

uses System.SysUtils;

function DeleteDoubleSpace(const S: string): String;
var
  SS: string;
begin
  Result := S;
  repeat
    SS := Result;
    Result := SS.Replace('  ', ' ', [rfReplaceAll]);
  until Result = SS;
end;

function GetWords(const S: String): String;
var
  m: TArray<String>;
  s2: string;
  s1: string;
begin
  Result := '';
  s1 := S.Trim();

  m := s1.Split([' ', '/', '-']);

  for s1 in m do
  begin
    s2 := s1.Trim;
    if s2.IsEmpty then
      Continue;
    Result := Format('%s'#13'%s', [Result, s2]);
  end;
  Result := Result.Trim([#13]);
end;

function Uncomment(ASQL, AComment: string): string;
var
  ABegin: string;
  AEnd: string;
  i: Integer;
begin
  Assert(not ASQL.IsEmpty);
  Assert(not AComment.IsEmpty);

  ABegin := '/*' + AComment;
  AEnd := AComment + '*/';

  Result := ASQL;

  i := Result.IndexOf(ABegin);
  Assert(i >= 0);

  Result := Result.Replace(ABegin, '');

  i := Result.IndexOf(AEnd);
  Assert(i >= 0);

  Result := Result.Replace(AEnd, '');
end;

function ReplaceInSQL(const ASQL: String; const AStipulation: String;
  ANumber: Integer): String;
var
  ATemplate: string;
  lp: Integer;
  p: Integer;
begin
  Assert(not ASQL.IsEmpty);
  Assert(not AStipulation.IsEmpty);

  ATemplate := Format('%d=%d', [ANumber, ANumber]);
  p := ASQL.IndexOf(ATemplate);
  Assert(p >= 0);
  lp := ASQL.LastIndexOf(ATemplate);
  // Только одно вхождение !
  Assert(lp = p);

  Result := ASQL.Replace(ATemplate, AStipulation);
end;

end.
