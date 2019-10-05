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
    FSHORT_SPECIALITY: TFieldWrap;
    FSpeciality: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Save(ASpecInt: ISpec; AMode: TMode);
    property Chiper_Speciality: TFieldWrap read FChiper_Speciality;
    property ID_Speciality: TFieldWrap read FID_Speciality;
    property SHORT_SPECIALITY: TFieldWrap read FSHORT_SPECIALITY;
    property Speciality: TFieldWrap read FSpeciality;
  end;

  TQrySpec = class(TQueryBase)
  private
    FW: TSpecW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function FilterByChiper(AChiperIsNull: Boolean; const AFieldName: String):
        Integer;
    procedure Save(ASpecInt: ISpec; AMode: TMode);
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
end;

function TQrySpec.FilterByChiper(AChiperIsNull: Boolean; const AFieldName:
    String): Integer;
var
  ASQL: string;
  AStipulation: string;
begin
  Assert(not AFieldName.IsEmpty);

  ASQL := ReplaceInSQL(SQL, AFieldName, 0);

  AStipulation := Format('%s is %s null', [W.Chiper_Speciality.FieldName,
    IfThen(AChiperIsNull, '', 'not')]);
  FDQuery.SQL.Text := ReplaceInSQL(ASQL, AStipulation, 1);

  FDQuery.Open;

  Result := FDQuery.RecordCount;
end;

procedure TQrySpec.Save(ASpecInt: ISpec; AMode: TMode);
begin
  W.Save(ASpecInt, AMode);
end;

{$R *.dfm}

end.
