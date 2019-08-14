unit LibConnector;

interface

uses
  System.SyncObjs
  ,System.Generics.Collections
  ;

type
  ILibraryConnector = interface(IInterface)
    procedure FindBooks;
  end;

function LibraryConnector: ILibraryConnector;

implementation

uses
  Windows, AsuSoftConnector, System.SysUtils, CommissionOptions;

type
  TLibraryConnector = class(TAsuSoftConnector, ILibraryConnector)
    private
      FRefCount: Integer;
    public
      constructor Create();
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
      procedure FindBooks;
      function GetProcessParameters: string; override;
  end;

constructor TLibraryConnector.Create();
begin
  Self.FProgramName := 'Library';
  inherited;
end;

procedure TLibraryConnector.FindBooks;
begin
  RequestData.Add('action', 'findbooks');
  SendData;
end;

function TLibraryConnector.GetProcessParameters: string;
begin
//  Result := TUserAccess.GetUserPasswordString();
  Result := String.Format('/username=%s /password=%s',
     [
     StudyProcessOptions.UserName,
     StudyProcessOptions.Password
     ]
  );
end;

function TLibraryConnector.QueryInterface(const IID: TGUID; out Obj):
    HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TLibraryConnector._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TLibraryConnector._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

var
  Lock: TCriticalSection;
  _LibraryConnector: ILibraryConnector;

function LibraryConnector: ILibraryConnector;
begin
  Lock.Acquire;
  try
    if not(Assigned(_LibraryConnector)) then
      _LibraryConnector := TLibraryConnector.Create();
    Result := _LibraryConnector;
  finally
    Lock.Release;
  end;
end;

initialization
  Lock := TCriticalSection.Create;

finalization
  Lock.Free;

end.
