unit EdLvlQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TEdLvlW = class;

  TQryEdLvl = class(TQueryBase)
  private
    FW: TEdLvlW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function Search(APKValues: TArray<Variant>; AExcludePK: Integer; ATestResult:
        Integer = -1): Integer;
    property W: TEdLvlW read FW;
    { Public declarations }
  end;

  TEdLvlW = class(TDSWrap)
  private
    FID_Education_Level: TFieldWrap;
    FEducation_Level: TFieldWrap;
    FShort_Education_Level: TFieldWrap;
    FOrd: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property ID_Education_Level: TFieldWrap read FID_Education_Level;
    property Education_Level: TFieldWrap read FEducation_Level;
    property Short_Education_Level: TFieldWrap read FShort_Education_Level;
    property Ord: TFieldWrap read FOrd;
  end;

implementation

uses
  System.StrUtils;

constructor TEdLvlW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Education_Level := TFieldWrap.Create(Self, 'ID_Education_Level',
    '', True);
  FEducation_Level := TFieldWrap.Create(Self, 'Education_Level');
  FShort_Education_Level := TFieldWrap.Create(Self, 'Short_Education_Level');
  FOrd := TFieldWrap.Create(Self, 'Ord');
end;

constructor TQryEdLvl.Create(AOwner: TComponent);
begin
  inherited;
  FW := TEdLvlW.Create(FDQuery);
end;

function TQryEdLvl.Search(APKValues: TArray<Variant>; AExcludePK: Integer;
    ATestResult: Integer = -1): Integer;
var
  S: string;
  V: Variant;
begin
  Assert(Length(APKValues) > 0);
  Assert(AExcludePK > 0);

  S := '';
  for V in APKValues do
  begin
    S := S + IfThen(S.IsEmpty, '', ',') + VarToStr(V);
  end;

  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s in (%s)', [W.ID_Education_Level.FieldName, S]));

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('1=1',
    Format('%s <> :%s', [W.ID_Education_Level.FieldName,
    W.ID_Education_Level.FieldName]));

  SetParamType(W.ID_Education_Level.FieldName);


  Result := W.Load([W.ID_Education_Level.FieldName], [AExcludePK], ATestResult);
end;

{$R *.dfm}

end.
