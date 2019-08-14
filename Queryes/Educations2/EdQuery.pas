unit EdQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TEdW = class;

  TQueryEd = class(TQueryBase)
  private
    FW: TEdW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TEdW read FW;
    { Public declarations }
  end;

  TEdW = class(TDSWrap)
  private
    FID_Education: TFieldWrap;
    FEducation: TFieldWrap;
    FEducation_Order: TFieldWrap;
    FShort_Education: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property ID_Education: TFieldWrap read FID_Education;
    property Education: TFieldWrap read FEducation;
    property Education_Order: TFieldWrap read FEducation_Order;
    property Short_Education: TFieldWrap read FShort_Education;
  end;

implementation

constructor TEdW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Education := TFieldWrap.Create(Self, 'ID_Education', '', True);
  FEducation := TFieldWrap.Create(Self, 'Education', 'Наименование');
  FShort_Education := TFieldWrap.Create(Self, 'Short_Education', 'Сокращение');
  FEducation_Order := TFieldWrap.Create(Self, 'Education_Order');
end;

constructor TQueryEd.Create(AOwner: TComponent);
begin
  inherited;
  FW := TEdW.Create(FDQuery);
end;

{$R *.dfm}

end.
