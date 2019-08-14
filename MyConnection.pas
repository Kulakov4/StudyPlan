unit MyConnection;

interface

uses DBServConnectionPooler, SqlExpr, Data.DBXOracle, Data.FMTBcd, Data.DB;
type
  TMyDBServerConnection = class(TDBServerConnection)
  private
    FMainConnection: Boolean;
  protected
    function CreateConnection: TSQLConnection; override;
    function IsFree(const Int: IUnknown): Boolean; override;
  public
  end;

implementation

uses SysUtils, Windows, classes, PersistentSequence;

function TMyDBServerConnection.CreateConnection: TSQLConnection;
var
  AInitSession: TStringList;
  i: Integer;
//  APassword: TPassword;
begin
  Result := TSQLConnection.Create(nil);
  with Result do
  begin
    SQLHourGlass := True;
    Name := Format('sqlconnection_%d', [Sequence.NextValue]);
    ConnectionName := 'OracleConnection';
    DriverName := 'Oracle';
    LibraryName := 'dbexpora.dll';
    VendorLib := 'oci.dll';
    GetDriverFunc := 'getSQLDriverORACLE';
    Params.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SQLConnection.ini');

{
    APassword := TPassword.Create(nil, 'Однажды в студёную зимнюю пору я из лесу вышел');
    try
      APassword.EncodedPassword := Params.Values['password'];
      Params.Values['password'] := APassword.Password;
    finally
      KFreeAndNil(APassword);
    end;
}
    LoginPrompt := False;
    Open;
    AInitSession := TStringList.Create;
    try
      AInitSession.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'InitSession.sql');
      for i := 0 to AInitSession.Count - 1 do
      begin
        Execute(AInitSession.Strings[i], nil);
      end;
    finally
      FreeAndNil(AInitSession);
    end;
  end; // with
end;

function TMyDBServerConnection.IsFree(const Int: IUnknown): Boolean;
begin

  if (FClientCount = 0) and (Int = nil) then
  begin
    Result := True; // Это будет главное соединение
    FMainConnection := True;
  end
  else
  begin
    Result := ( (Int = nil) and FMainConnection ) or
    ( (Int <> nil) and (not FMainConnection) );
  end;

  if (not FMainConnection) and (Result = True) then
    Sleep(0); 
end;


end.

