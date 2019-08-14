unit ChairsQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TChairsW = class;

  TQueryChairs = class(TQueryBase)
  private
    FW: TChairsW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function Search(AEnabled: Boolean = True): Integer;
    property W: TChairsW read FW;
    { Public declarations }
  end;

  TChairsW = class(TDSWrap)
  private
    FEnable_Chair: TFieldWrap;
    FShort_Name: TFieldWrap;
    FID_CHAIR: TFieldWrap;
    FShortening: TFieldWrap;
    FНаименование: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property Enable_Chair: TFieldWrap read FEnable_Chair;
    property Short_Name: TFieldWrap read FShort_Name;
    property ID_CHAIR: TFieldWrap read FID_CHAIR;
    property Shortening: TFieldWrap read FShortening;
    property Наименование: TFieldWrap read FНаименование;
  end;

implementation

uses
  System.Math, NotifyEvents;

constructor TQueryChairs.Create(AOwner: TComponent);
begin
  inherited;
  FW := TChairsW.Create(FDQuery);

end;

function TQueryChairs.Search(AEnabled: Boolean = True): Integer;
begin
  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.Enable_Chair.FieldName, W.Enable_Chair.FieldName]));

  SetParamType(W.Enable_Chair.FieldName);

  Result := W.Load([W.Enable_Chair.FieldName], [IfThen(AEnabled, 1, 0)]);
end;

constructor TChairsW.Create(AOwner: TComponent);
begin
  inherited;
  FShort_Name := TFieldWrap.Create(Self, 'SHORT_NAME', 'Кафедра');
  FID_CHAIR := TFieldWrap.Create(Self, 'ID_CHAIR', '', True);
  FНаименование := TFieldWrap.Create(Self, 'Наименование', 'Наименование');

  FEnable_Chair := TFieldWrap.Create(Self, 'Enable_Chair');
  FShortening := TFieldWrap.Create(Self, 'Shortening');
end;

{$R *.dfm}

end.
