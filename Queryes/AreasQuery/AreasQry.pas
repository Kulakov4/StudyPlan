unit AreasQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TAreasW = class;

  TQryAreas = class(TQueryBase)
  private
    FW: TAreasW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TAreasW read FW;
    { Public declarations }
  end;

  TAreasW = class(TDSWrap)
  private
    FID_AREA: TFieldWrap;
    FAREA: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Append(const AArea: String);
    property ID_AREA: TFieldWrap read FID_AREA;
    property AREA: TFieldWrap read FAREA;
  end;

implementation

constructor TAreasW.Create(AOwner: TComponent);
begin
  inherited;
  FID_AREA := TFieldWrap.Create(Self, 'ID_AREA', '', True);
  FAREA := TFieldWrap.Create(Self, 'AREA', 'Сфера');
end;

procedure TAreasW.Append(const AArea: String);
begin
  Assert(not AArea.IsEmpty);
  TryAppend;
  AREA.F.AsString := AArea;
  TryPost;
end;

constructor TQryAreas.Create(AOwner: TComponent);
begin
  inherited;
  FW := TAreasW.Create(FDQuery);
  FDQuery.UpdateOptions.CheckRequired := False;
  FDQuery.UpdateOptions.AutoIncFields := W.PKFieldName;
  FDQuery.CachedUpdates := True;
end;

{$R *.dfm}

end.
