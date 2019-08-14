unit SPQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TSPW = class;

  TQrySP = class(TQueryBase)
  private
    FW: TSPW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function Search(AIDSpecialityEducation: Integer): Integer;
    property W: TSPW read FW;
    { Public declarations }
  end;

  TSPW = class(TDSWrap)
  private
    FIDSpecialityEducation: TFieldWrap;
    FID_StudyPlan: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property IDSpecialityEducation: TFieldWrap read FIDSpecialityEducation;
    property ID_StudyPlan: TFieldWrap read FID_StudyPlan;
  end;

implementation

constructor TSPW.Create(AOwner: TComponent);
begin
  inherited;
  FID_StudyPlan := TFieldWrap.Create(Self, 'ID_StudyPlan', '', True);
  FIDSpecialityEducation := TFieldWrap.Create(Self, 'IDSpecialityEducation');
end;

constructor TQrySP.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSPW.Create(FDQuery);
end;

function TQrySP.Search(AIDSpecialityEducation: Integer): Integer;
begin
  Assert(AIDSpecialityEducation > 0);

  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.IDSpecialityEducation.FieldName, W.IDSpecialityEducation.FieldName]));

  SetParamType(W.IDSpecialityEducation.FieldName);

  Result := W.Load([W.IDSpecialityEducation.FieldName], [W.IDSpecialityEducation.FieldName]);
end;

{$R *.dfm}

end.
