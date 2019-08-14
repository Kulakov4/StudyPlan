unit YearsQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TYearsW = class;

  TQryYears = class(TQueryBase)
  private
    FW: TYearsW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TYearsW read FW;
    { Public declarations }
  end;

  TYearsW = class(TDSWrap)
  private
    FID_Year: TFieldWrap;
    FYear: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property ID_Year: TFieldWrap read FID_Year;
    property Year: TFieldWrap read FYear;
  end;

implementation

constructor TYearsW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Year := TFieldWrap.Create(Self, 'ID_Year', '', True);
  FYear := TFieldWrap.Create(Self, 'Year', 'Год');
end;

constructor TQryYears.Create(AOwner: TComponent);
begin
  inherited;
  FW := TYearsW.Create(FDQuery);
end;

{$R *.dfm}

end.
