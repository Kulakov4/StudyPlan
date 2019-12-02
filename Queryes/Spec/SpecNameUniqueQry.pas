unit SpecNameUniqueQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SpecUniqueQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TSpecNameUniqueW = class(TDSWrap)
  private
    FSpeciality: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property Speciality: TFieldWrap read FSpeciality;
  end;

  TQrySpecName = class(TQueryUniqueSpec)
  private
    FChiperIsNull: Boolean;
    FW: TSpecNameUniqueW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AChiperIsNull: Boolean); reintroduce;
    procedure AfterConstruction; override;
    property W: TSpecNameUniqueW read FW;
    { Public declarations }
  end;

implementation

{$R *.dfm}

constructor TQrySpecName.Create(AOwner: TComponent; AChiperIsNull: Boolean);
begin
  inherited Create(AOwner);
  FW := TSpecNameUniqueW.Create(FDQuery);
  FChiperIsNull := AChiperIsNull;
end;

procedure TQrySpecName.AfterConstruction;
begin
  inherited;
  FilterByChiper(FChiperIsNull, W.Speciality.FieldName);
end;

constructor TSpecNameUniqueW.Create(AOwner: TComponent);
begin
  inherited;
  FSpeciality := TFieldWrap.Create(Self, 'Speciality', 'Наименование', True);
end;

end.
