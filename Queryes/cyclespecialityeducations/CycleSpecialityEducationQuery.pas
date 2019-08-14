unit CycleSpecialityEducationQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, NotifyEvents;

type
  TCycleSpecialityEducationW = class;

  TQueryCycleSpecialityEducations = class(TQueryBase)
  private
    FW: TCycleSpecialityEducationW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function SearchBySpecialityEducation(AIDSpecialityEducation: Integer;
      ATestResult: Integer = -1): Integer;
    property W: TCycleSpecialityEducationW read FW;
    { Public declarations }
  end;

  TCycleSpecialityEducationW = class(TDSWrap)
  private
    FID_CycleSpecialityEducation: TFieldWrap;
    FIDCycle: TFieldWrap;
    FIDSpecialityEducation: TFieldWrap;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure AppendEmptyCycle(AIDSpecialityEducation: Integer);
    property ID_CycleSpecialityEducation: TFieldWrap
      read FID_CycleSpecialityEducation;
    property IDCycle: TFieldWrap read FIDCycle;
    property IDSpecialityEducation: TFieldWrap read FIDSpecialityEducation;
  end;

implementation

constructor TCycleSpecialityEducationW.Create(AOwner: TComponent);
begin
  inherited;
  FID_CycleSpecialityEducation := TFieldWrap.Create(Self,
    'ID_CycleSpecialityEducation');
  PKFieldName := FID_CycleSpecialityEducation.FieldName;
  FIDCycle := TFieldWrap.Create(Self, 'IDCycle');
  FIDSpecialityEducation := TFieldWrap.Create(Self, 'IDSpecialityEducation');
end;

procedure TCycleSpecialityEducationW.AppendEmptyCycle(AIDSpecialityEducation
  : Integer);
begin
  Assert(AIDSpecialityEducation > 0);
  TryAppend;
  IDCycle.F.AsInteger := 0;
  IDSpecialityEducation.F.AsInteger := AIDSpecialityEducation;
  TryPost;
end;

constructor TQueryCycleSpecialityEducations.Create(AOwner: TComponent);
begin
  inherited;
  FW := TCycleSpecialityEducationW.Create(FDQuery);
end;

function TQueryCycleSpecialityEducations.SearchBySpecialityEducation
  (AIDSpecialityEducation: Integer; ATestResult: Integer = -1): Integer;
begin
  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.IDSpecialityEducation.FieldName,
    W.IDSpecialityEducation.FieldName]));
  SetParamType(W.IDSpecialityEducation.FieldName);

  Result := W.Load([W.IDSpecialityEducation.FieldName],
    [AIDSpecialityEducation], ATestResult);
end;

{$R *.dfm}

end.
