unit FDDumbQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TDumbW = class;

  TQueryFDDumb = class(TQueryBase)
    DataSource: TDataSource;
  private
    FW: TDumbW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TDumbW read FW;
    { Public declarations }
  end;

  TDumbW = class(TDSWrap)
  private
    FID: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateID(AID: Integer);
    property ID: TFieldWrap read FID;
  end;

implementation

constructor TQueryFDDumb.Create(AOwner: TComponent);
begin
  inherited;
  FW := TDumbW.Create(FDQuery);
  FW.TryOpen;
end;

constructor TDumbW.Create(AOwner: TComponent);
begin
  inherited;
  FID := TFieldWrap.Create(Self, 'ID', '', True);
end;

{$R *.dfm}

procedure TDumbW.UpdateID(AID: Integer);
begin
  TryEdit;
  ID.F.AsInteger := AID;
  TryPost;
end;

end.
