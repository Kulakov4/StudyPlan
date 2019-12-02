unit SpecChiperUniqueQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpecUniqueQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TSpecChiperW = class(TDSWrap)
  private
    FChiper_Speciality: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property Chiper_Speciality: TFieldWrap read FChiper_Speciality;
  end;

  TQrySpecChiper = class(TQueryUniqueSpec)
  private
    FChiperIsNull: Boolean;
    FW: TSpecChiperW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AChiperIsNull: Boolean); reintroduce;
    procedure AfterConstruction; override;
    property W: TSpecChiperW read FW;
    { Public declarations }
  end;

implementation

{$R *.dfm}

constructor TQrySpecChiper.Create(AOwner: TComponent; AChiperIsNull: Boolean);
begin
  inherited Create(AOwner);
  FChiperIsNull := AChiperIsNull;
  FW := TSpecChiperW.Create(FDQuery);
end;

procedure TQrySpecChiper.AfterConstruction;
begin
  inherited;
  FilterByChiper(FChiperIsNull, W.Chiper_Speciality.FieldName);
end;

constructor TSpecChiperW.Create(AOwner: TComponent);
begin
  inherited;
  FChiper_Speciality := TFieldWrap.Create(Self, 'Chiper_Speciality', 'Код', True);
end;

end.
