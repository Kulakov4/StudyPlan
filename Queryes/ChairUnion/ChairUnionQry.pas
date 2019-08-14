unit ChairUnionQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TChairUnionW = class;

  TQryChairUnion = class(TQueryBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TChairUnionW = class(TDSWrap)
  private
    FIDChair_Union: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property IDChair_Union: TFieldWrap read FIDChair_Union;
  end;

implementation

constructor TChairUnionW.Create(AOwner: TComponent);
begin
  inherited;
  FIDChair_Union := TFieldWrap.Create(Self, 'IDChair_Union');
end;

{$R *.dfm}

end.
