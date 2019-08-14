unit AbitConnector;

interface

uses
  System.SyncObjs, System.Generics.Collections;

type
  IAbiturientsConnector = interface(IInterface)
    procedure AddListener(AStudyPlanId: Integer);
  end;

function AbiturientsConnector: IAbiturientsConnector;

implementation

uses
  Windows, AsuSoftConnector, System.SysUtils, CommissionOptions;

type
  TAbiturientsConnector = class(TAsuSoftConnector, IAbiturientsConnector)
    private
      FRefCount: Integer;
    public
      constructor Create();
      function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
      function _AddRef: Integer; stdcall;
      function _Release: Integer; stdcall;
      procedure AddListener(AStudyPlanId: Integer);
      procedure FindAbiturient(AAbiturientId: Integer);
      function GetProcessParameters: string; override;
  end;

constructor TAbiturientsConnector.Create();
begin
  Self.FProgramName := 'Abiturients';
  inherited;
end;

procedure TAbiturientsConnector.AddListener(AStudyPlanId: Integer);
begin
  RequestData.Add('action', 'addlistener');
  RequestData.Add('idstudyplan', AStudyPlanId);
  SendData;
end;

procedure TAbiturientsConnector.FindAbiturient(AAbiturientId: Integer);
begin
  RequestData.Add('action', 'findabiturient');
  RequestData.Add('idabiturient', AAbiturientId);
  SendData;
end;

function TAbiturientsConnector.GetProcessParameters: string;
begin
//  Result := TUserAccess.GetUserPasswordString();
  Result := Format('/username=%s /password=%s',
     [
     StudyProcessOptions.UserName,
     StudyProcessOptions.Password
     ]
  );
end;

function TAbiturientsConnector.QueryInterface(const IID: TGUID; out Obj):
    HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TAbiturientsConnector._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TAbiturientsConnector._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

var
  Lock: TCriticalSection;
  _AbiturientsConnector: IAbiturientsConnector;

function AbiturientsConnector: IAbiturientsConnector;
begin
  Lock.Acquire;
  try
    if not(Assigned(_AbiturientsConnector)) then
      _AbiturientsConnector := TAbiturientsConnector.Create();
    Result := _AbiturientsConnector;
  finally
    Lock.Release;
  end;
end;

initialization
  Lock := TCriticalSection.Create;

finalization
  Lock.Free;

end.
