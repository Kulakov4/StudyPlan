unit SpecEdBaseFormQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TSpecEdBaseFormW = class;

  TQrySpecEdBaseForm = class(TQueryBase)
  private
    FW: TSpecEdBaseFormW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function SearchByPK(APKValue: Integer; ATestResult: Integer = -1): Integer;
    property W: TSpecEdBaseFormW read FW;
    { Public declarations }
  end;

  TSpecEdBaseFormW = class(TDSWrap)
  private
    FIDEDUCATIONBASEFORM: TFieldWrap;
    FID_SPECIALITYEDUCATION: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property IDEDUCATIONBASEFORM: TFieldWrap read FIDEDUCATIONBASEFORM;
    property ID_SPECIALITYEDUCATION: TFieldWrap read FID_SPECIALITYEDUCATION;
  end;

implementation

constructor TSpecEdBaseFormW.Create(AOwner: TComponent);
begin
  inherited;
  FID_SPECIALITYEDUCATION := TFieldWrap.Create(Self, 'ID_SPECIALITYEDUCATION',
    '', True);

  FIDEDUCATIONBASEFORM := TFieldWrap.Create(Self, 'IDEDUCATIONBASEFORM');
end;

constructor TQrySpecEdBaseForm.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSpecEdBaseFormW.Create(FDQuery);
end;

function TQrySpecEdBaseForm.SearchByPK(APKValue: Integer; ATestResult: Integer
    = -1): Integer;
begin
//  Assert(APKValue > 0);

  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.PKFieldName, W.PKFieldName]));

  SetParamType(W.PKFieldName);

  Result := W.Load([W.PKFieldName], [APKValue]);

  if ATestResult >= 0 then
    Assert(Result = ATestResult);
end;

{$R *.dfm}

end.
