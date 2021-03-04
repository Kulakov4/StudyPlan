unit CycleTypesQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TCycleTypeW = class(TDSWrap)
  private
    FCycleType: TFieldWrap;
    FID_Cycle_Type: TFieldWrap;
    FOrd: TFieldWrap;
    FShortCycleType: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property CycleType: TFieldWrap read FCycleType;
    property ID_Cycle_Type: TFieldWrap read FID_Cycle_Type;
    property Ord: TFieldWrap read FOrd;
    property ShortCycleType: TFieldWrap read FShortCycleType;
  end;

  TQueryCycleTypes = class(TQueryBase)
  private
    FW: TCycleTypeW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TCycleTypeW read FW;
    { Public declarations }
  end;

implementation

constructor TCycleTypeW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Cycle_Type := TFieldWrap.Create(Self, 'ct.ID_Cycle_Type', 'Код', True);
  FCycleType := TFieldWrap.Create(Self, 'ct.CycleType', 'Цикл');
  FShortCycleType := TFieldWrap.Create(Self, 'ct.ShortCycleType', 'Сокращение');
  FOrd := TFieldWrap.Create(Self, 'ct.Ord', 'Порядок');
end;

constructor TQueryCycleTypes.Create(AOwner: TComponent);
begin
  inherited;
  FW := TCycleTypeW.Create(FDQuery);
end;

{$R *.dfm}

end.
