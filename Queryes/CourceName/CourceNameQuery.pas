unit CourceNameQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TCourceNameW = class;

  TQueryCourceName = class(TQueryBase)
  private
    FW: TCourceNameW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function Search(AEnabled: Boolean = True): Integer;
    function SearchCourceName(AEnabled: Boolean = True): Integer;
    property W: TCourceNameW read FW;
    { Public declarations }
  end;

  TCourceNameW = class(TDSWrap)
  private
    FChiper_Speciality: TFieldWrap;
    FID_Speciality: TFieldWrap;
    FSHORT_SPECIALITY: TFieldWrap;
    FEnable_Speciality: TFieldWrap;
    FSPECIALITY_ACCESS: TFieldWrap;
    FSpeciality: TFieldWrap;
    FCalcSpeciality: TFieldWrap;
    procedure DoAfterOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Append(const ASpeciality, AShortSpeciality: String; AIDChair:
        Integer);
    procedure FilterByChair(const AIDChair: Integer);
    procedure UpdateShortCaption(const AShortSpeciality: string);
    property Chiper_Speciality: TFieldWrap read FChiper_Speciality;
    property ID_Speciality: TFieldWrap read FID_Speciality;
    property SHORT_SPECIALITY: TFieldWrap read FSHORT_SPECIALITY;
    property Enable_Speciality: TFieldWrap read FEnable_Speciality;
    property SPECIALITY_ACCESS: TFieldWrap read FSPECIALITY_ACCESS;
    property Speciality: TFieldWrap read FSpeciality;
    property CalcSpeciality: TFieldWrap read FCalcSpeciality;
  end;

implementation

uses
  System.Math, NotifyEvents;

constructor TQueryCourceName.Create(AOwner: TComponent);
begin
  inherited;
  FW := TCourceNameW.Create(FDQuery);
  FDQuery.CachedUpdates := True;
  FDQuery.UpdateOptions.AutoIncFields := W.PKFieldName;
  FDQuery.UpdateOptions.RefreshMode := rmOnDemand;
end;

function TQueryCourceName.Search(AEnabled: Boolean = True): Integer;
begin

  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s is not null', [W.Chiper_Speciality.FieldName]));

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('1=1',
    Format('%s = :%s', [W.Enable_Speciality.FieldName, W.Enable_Speciality.FieldName]));

  SetParamType(W.Enable_Speciality.FieldName);

  Result := W.Load([W.Enable_Speciality.FieldName], [ IfThen(AEnabled, 1, 0) ]);
end;

function TQueryCourceName.SearchCourceName(AEnabled: Boolean = True): Integer;
begin
  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s is null', [W.Chiper_Speciality.FieldName]));

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('1=1',
    Format('%s = :%s', [W.Enable_Speciality.FieldName, W.Enable_Speciality.FieldName]));

  SetParamType(W.Enable_Speciality.FieldName);

  Result := W.Load([W.Enable_Speciality.FieldName], [IfThen(AEnabled, 1, 0)]);
end;

constructor TCourceNameW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Speciality := TFieldWrap.Create(Self, 'ID_Speciality');
  PKFieldName := FID_Speciality.FieldName;

  FSpeciality := TFieldWrap.Create(Self, 'Speciality', 'Наименование');
  FSHORT_SPECIALITY := TFieldWrap.Create(Self, 'SHORT_SPECIALITY', 'Сокращение');
  FSPECIALITY_ACCESS := TFieldWrap.Create(Self, 'SPECIALITY_ACCESS');
  FChiper_Speciality := TFieldWrap.Create(Self, 'Chiper_Speciality', 'Код');
  FEnable_Speciality := TFieldWrap.Create(Self, 'Enable_Speciality');
  FCalcSpeciality := TFieldWrap.Create(Self, 'CalcSpeciality', 'Наименование и код');

  TNotifyEventWrap.Create(AfterOpen, DoAfterOpen, EventList);
end;

procedure TCourceNameW.Append(const ASpeciality, AShortSpeciality: String;
    AIDChair: Integer);
begin
  Assert(not ASpeciality.IsEmpty);

  TryAppend;
  Speciality.F.Value := ASpeciality;
  SHORT_SPECIALITY.F.Value := AShortSpeciality;
  SPECIALITY_ACCESS.F.Value := AIDChair;
  TryPost;

//  Assert(ID_Speciality.F.AsInteger <> 0);
end;

procedure TCourceNameW.DoAfterOpen(Sender: TObject);
begin
  // Это вычисляемое в запросе поле
  CalcSpeciality.F.ProviderFlags := [];
end;

procedure TCourceNameW.FilterByChair(const AIDChair: Integer);
begin
  Assert(AIDChair > 0);

  DataSet.Filter := Format('%s = %d', [SPECIALITY_ACCESS.FieldName, AIDChair]);
  DataSet.Filtered := True;
end;

procedure TCourceNameW.UpdateShortCaption(const AShortSpeciality: string);
begin
  Assert(not AShortSpeciality.IsEmpty);

  if SHORT_SPECIALITY.F.AsString = AShortSpeciality then
    Exit;

  TryEdit;
  SHORT_SPECIALITY.F.AsString := AShortSpeciality;
  TryPost;
end;

{$R *.dfm}

end.
