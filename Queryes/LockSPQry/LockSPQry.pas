unit LockSPQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TLockSPW = class(TDSWrap)
  private
    FIDEducationLevel: TParamWrap;
    FLocked: TParamWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property IDEducationLevel: TParamWrap read FIDEducationLevel;
    property Locked: TParamWrap read FLocked;
  end;

  TQryLockSP = class(TQueryBase)
  private
    FW: TLockSPW;
    function GetW: TLockSPW;
    { Private declarations }
  public
    procedure LockAll(AIDEducationLevel: Integer);
    class procedure Lock_All(AIDEdLvlArr: TArray<Integer>); static;
    procedure UnLockAll(AIDEducationLevel: Integer);
    property W: TLockSPW read GetW;
    { Public declarations }
  end;

implementation

uses
  StrHelper;

constructor TLockSPW.Create(AOwner: TComponent);
begin
  inherited;
  FLocked := TParamWrap.Create(Self, 'Locked');
  FIDEducationLevel := TParamWrap.Create(Self, 'IDEducationLevel');
end;

function TQryLockSP.GetW: TLockSPW;
begin
  if FW = nil then
    FW := TLockSPW.Create(FDQuery);

  Result := FW;
end;

procedure TQryLockSP.LockAll(AIDEducationLevel: Integer);
begin
  FDQuery.ExecSQL('', [1, AIDEducationLevel], [ftInteger, ftInteger]);
end;

class procedure TQryLockSP.Lock_All(AIDEdLvlArr: TArray<Integer>);
var
  AIDEdLvl: Integer;
  Q: TQryLockSP;
begin
  Assert(Length(AIDEdLvlArr) > 0);
  Q := TQryLockSP.Create(nil);
  try
    for AIDEdLvl in AIDEdLvlArr do
      Q.LockAll(AIDEdLvl);
  finally
    FreeAndNil(Q);
  end;
end;

procedure TQryLockSP.UnLockAll(AIDEducationLevel: Integer);
begin
  FDQuery.ExecSQL('', [0, AIDEducationLevel], [ftInteger, ftInteger]);
end;

{$R *.dfm}

end.
