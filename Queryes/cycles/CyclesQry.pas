unit CyclesQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TCycleW = class(TDSWrap)
  private
    FID_Cycle: TFieldWrap;
    FCycle: TFieldWrap;
    FShortCycle: TFieldWrap;
    FIDCycle_Type: TFieldWrap;
  protected
    property ID_Cycle: TFieldWrap read FID_Cycle;
    property Cycle: TFieldWrap read FCycle;
    property ShortCycle: TFieldWrap read FShortCycle;
    property IDCycle_Type: TFieldWrap read FIDCycle_Type;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TQueryCycles = class(TQueryBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

constructor TCycleW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Cycle := TFieldWrap.Create(Self, 'ID_Cycle', '', True);
  FCycle := TFieldWrap.Create(Self, 'Cycle', 'Наименование');
  FShortCycle := TFieldWrap.Create(Self, 'Short_Cycle', 'Сокращение');
  FIDCycle_Type := TFieldWrap.Create(Self, 'IDCycle_Type');
end;

{$R *.dfm}

end.
