unit FireDACDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TFireDACDM = class(TDataModule)
    FDConnection: TFDConnection;
    fdqLogin: TFDQuery;
    procedure FDConnectionAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

  TFDCon = class(TObject)
  private
    class var Instance: TFDCon;

  var
    FDM: TFireDACDM;
  public
    destructor Destroy; override;
    class function NewInstance: TObject; override;
    property DM: TFireDACDM read FDM;
  end;

implementation

uses
  System.Contnrs, CommissionOptions, ConnectionSettings;

var
  SingletonList: TObjectList;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

destructor TFDCon.Destroy;
begin
  FreeAndNil(FDM);
  inherited;
end;

class function TFDCon.NewInstance: TObject;
begin
  if Assigned(Instance) then
  begin
    Result := Instance;
    Exit;
  end;

  Instance := TFDCon(inherited NewInstance);
  Instance.FDM := TFireDACDM.Create(nil);
  Instance.FDM.FDConnection.Open;
  SingletonList.Add(Instance);
  Result := Instance;
end;

constructor TFireDACDM.Create(AOwner: TComponent);
begin
  inherited;
  FDConnection.Params.Database := '(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.71)(PORT = 1521)))(CONNECT_DATA = (SERVICE_NAME = ORCL)))';
end;

procedure TFireDACDM.FDConnectionAfterConnect(Sender: TObject);
begin
  Assert(StudyProcessOptions <> nil);
  fdqLogin.ParamByName('username').AsString := StudyProcessOptions.UserName;
  fdqLogin.ParamByName('password').AsString := StudyProcessOptions.Password;
  fdqLogin.ExecSQL;
end;

initialization

SingletonList := TObjectList.Create(True);

finalization

FreeAndNil(SingletonList);

end.
