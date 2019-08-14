unit SessTypeQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TSessTypeW = class(TDSWrap)
  private
    FID_SessionType: TFieldWrap;
    FSessionType: TFieldWrap;
    FShort_SessionType: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property ID_SessionType: TFieldWrap read FID_SessionType;
    property SessionType: TFieldWrap read FSessionType;
    property Short_SessionType: TFieldWrap read FShort_SessionType;
  end;

  TQrySessType = class(TQueryBase)
  private
    FW: TSessTypeW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TSessTypeW read FW;
    { Public declarations }
  end;

implementation

constructor TSessTypeW.Create(AOwner: TComponent);
begin
  inherited;
  FID_SessionType := TFieldWrap.Create(Self, 'ID_SessionType', '', True);
  FSessionType := TFieldWrap.Create(Self, 'SessionType', 'Тип сессии');
  FShort_SessionType := TFieldWrap.Create(Self, 'Short_SessionType', 'Сокращение');
end;

constructor TQrySessType.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSessTypeW.Create(FDQuery);
end;

{$R *.dfm}

end.
