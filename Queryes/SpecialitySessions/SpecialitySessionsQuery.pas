unit SpecialitySessionsQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TSpecialitySessionsW = class;
  TQuerySpecialitySessions = class(TQueryBase)
  private
    FW: TSpecialitySessionsW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    procedure SearchBySpecialityEducation(AIDSpecialityEducation: Integer);
    property W: TSpecialitySessionsW read FW;
    { Public declarations }
  end;

  TSpecialitySessionsW = class(TDSWrap)
  private
    FID_SpecialitySession: TFieldWrap;
    FIDSpecialityEducation: TFieldWrap;
    FLevel: TFieldWrap;
    FSession: TFieldWrap;
    FSession_in_level: TFieldWrap;
    FLevel_Year: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property ID_SpecialitySession: TFieldWrap read FID_SpecialitySession;
    property IDSpecialityEducation: TFieldWrap read FIDSpecialityEducation;
    property Level: TFieldWrap read FLevel;
    property Session: TFieldWrap read FSession;
    property Session_in_level: TFieldWrap read FSession_in_level;
    property Level_Year: TFieldWrap read FLevel_Year;
  end;

implementation

constructor TSpecialitySessionsW.Create(AOwner: TComponent);
begin
  inherited;
  FID_SpecialitySession := TFieldWrap.Create(Self, 'ID_SpecialitySession');
  PKFieldName := FID_SpecialitySession.FieldName;
  FIDSpecialityEducation := TFieldWrap.Create(Self, 'IDSpecialityEducation');
  FLevel := TFieldWrap.Create(Self, 'Level_');
  FSession := TFieldWrap.Create(Self, 'Session_');
  FSession_in_level := TFieldWrap.Create(Self, 'Session_in_level');
  FLevel_Year := TFieldWrap.Create(Self, 'Level_Year');
end;

constructor TQuerySpecialitySessions.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSpecialitySessionsW.Create(FDQuery);
end;

procedure TQuerySpecialitySessions.SearchBySpecialityEducation(
    AIDSpecialityEducation: Integer);
begin
  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0', Format('%s=:%s',
    [W.IDSpecialityEducation.FieldName,
    W.IDSpecialityEducation.FieldName]));
  SetParamType(W.IDSpecialityEducation.FieldName);

  W.Load([W.IDSpecialityEducation.FieldName], [AIDSpecialityEducation]);
end;

{$R *.dfm}

end.
