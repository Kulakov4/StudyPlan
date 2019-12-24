unit SpecQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, SpecInt,
  InsertEditMode;

type
  TSpecW = class(TDSWrap)
  private
    FChiper_Speciality: TFieldWrap;
    FID_Speciality: TFieldWrap;
    FQUALIFICATION_ID: TFieldWrap;
    FSHORT_SPECIALITY: TFieldWrap;
    FSpeciality: TFieldWrap;
    FSPECIALITY_ACCESS: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Save(ASpecInt: ISpec; AMode: TMode);
    procedure UpdateShortSpeciality(const AShortSpeciality: String);
    property Chiper_Speciality: TFieldWrap read FChiper_Speciality;
    property ID_Speciality: TFieldWrap read FID_Speciality;
    property QUALIFICATION_ID: TFieldWrap read FQUALIFICATION_ID;
    property SHORT_SPECIALITY: TFieldWrap read FSHORT_SPECIALITY;
    property Speciality: TFieldWrap read FSpeciality;
    property SPECIALITY_ACCESS: TFieldWrap read FSPECIALITY_ACCESS;
  end;

  TQrySpec = class(TQueryBase)
  private
    FW: TSpecW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function SearchByChiper(const AChiper: string): Integer;
    function SearchByChiperAndName(const AChiper, ASpeciality: string): Integer;
    procedure Save(ASpecInt: ISpec; AMode: TMode);
    function SearchByID(AIDSpeciality: Integer): Integer;
    property W: TSpecW read FW;
    { Public declarations }
  end;

implementation

uses
  StrHelper, System.StrUtils;

constructor TSpecW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Speciality := TFieldWrap.Create(Self, 'ID_Speciality', '', True);
  FSpeciality := TFieldWrap.Create(Self, 'Speciality', 'Наименование');
  FChiper_Speciality := TFieldWrap.Create(Self, 'Chiper_Speciality', 'Код');
  FSHORT_SPECIALITY := TFieldWrap.Create(Self, 'SHORT_SPECIALITY',
    'Сокращение');
  FQUALIFICATION_ID := TFieldWrap.Create(Self, 'QUALIFICATION_ID');
  FSPECIALITY_ACCESS := TFieldWrap.Create(Self, 'SPECIALITY_ACCESS');
end;

procedure TSpecW.Save(ASpecInt: ISpec; AMode: TMode);
begin
  Assert(ASpecInt <> nil);

  if AMode = EditMode then
    TryEdit
  else
    TryAppend;
  try
    Chiper_Speciality.F.AsString := ASpecInt.ChiperSpeciality;
    Speciality.F.AsString := ASpecInt.Speciality;
    SHORT_SPECIALITY.F.AsString := ASpecInt.ShortSpeciality;
    SPECIALITY_ACCESS.F.AsInteger := ASpecInt.IDChair;
    TryPost;
  except
    TryCancel;
    raise;
  end;
end;

procedure TSpecW.UpdateShortSpeciality(const AShortSpeciality: String);
begin
  TryEdit;
  try
    SHORT_SPECIALITY.F.AsString := AShortSpeciality;
    TryPost;
  except
    TryCancel;
    raise;
  end;
end;

constructor TQrySpec.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSpecW.Create(FDQuery);
  FDQuery.UpdateOptions.CheckRequired := False;
  FDQuery.UpdateOptions.KeyFields := W.PKFieldName;
  FDQuery.UpdateOptions.AutoIncFields := W.PKFieldName;
//  FDQuery.UpdateOptions.RefreshMode := rmAll;
end;

function TQrySpec.SearchByChiper(const AChiper: string): Integer;
begin
  Assert(not AChiper.IsEmpty);

  Result := SearchEx([TParamrec.Create(W.Chiper_Speciality.FieldName, AChiper,
    ftWideString, True)]);
end;

function TQrySpec.SearchByChiperAndName(const AChiper,
  ASpeciality: string): Integer;
var
  V: Variant;
begin
  Assert(not ASpeciality.IsEmpty);

  if AChiper.Trim.IsEmpty then
    V := Null
  else
    V := AChiper.Trim;

  Result := SearchEx([TParamrec.Create(W.Chiper_Speciality.FullName, V,
    ftWideString, True), TParamrec.Create(W.Speciality.FullName, ASpeciality,
    ftWideString, True)]);
end;

procedure TQrySpec.Save(ASpecInt: ISpec; AMode: TMode);
begin
  W.Save(ASpecInt, AMode);
end;

function TQrySpec.SearchByID(AIDSpeciality: Integer): Integer;
begin
  Assert(AIDSpeciality > 0);

  Result := SearchEx([TParamrec.Create(W.ID_Speciality.FullName,
    AIDSpeciality)]);
end;

{$R *.dfm}

end.
