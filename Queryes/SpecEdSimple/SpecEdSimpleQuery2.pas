unit SpecEdSimpleQuery2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TSpecEdSimpleW2 = class;

  TQrySpecEdSimple2 = class(TQueryBase)
  private
    FW: TSpecEdSimpleW2;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function SearchByPK(APKValue: Integer; ATestResult: Integer = -1): Integer;
    property W: TSpecEdSimpleW2 read FW;
    { Public declarations }
  end;

  TSpecEdSimpleW2 = class(TDSWrap)
  private
    FAnnotation: TFieldWrap;
    FData: TFieldWrap;
    FIDChair: TFieldWrap;
    FIDEducation: TFieldWrap;
    FIDEducationType: TFieldWrap;
    FIDEducation2: TFieldWrap;
    FIDEducationLevel: TFieldWrap;
    FIDSpeciality: TFieldWrap;
    FIDStudyPlanStandart: TFieldWrap;
    FID_SPECIALITYEDUCATION: TFieldWrap;
    FMount_of_year: TFieldWrap;
    FYear: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property Annotation: TFieldWrap read FAnnotation;
    property Data: TFieldWrap read FData;
    property IDChair: TFieldWrap read FIDChair;
    property IDEducation: TFieldWrap read FIDEducation;
    property IDEducationType: TFieldWrap read FIDEducationType;
    property IDEducation2: TFieldWrap read FIDEducation2;
    property IDEducationLevel: TFieldWrap read FIDEducationLevel;
    property IDSpeciality: TFieldWrap read FIDSpeciality;
    property IDStudyPlanStandart: TFieldWrap read FIDStudyPlanStandart;
    property ID_SPECIALITYEDUCATION: TFieldWrap read FID_SPECIALITYEDUCATION;
    property Mount_of_year: TFieldWrap read FMount_of_year;
    property Year: TFieldWrap read FYear;
  end;

implementation

constructor TSpecEdSimpleW2.Create(AOwner: TComponent);
begin
  inherited;
  FID_SPECIALITYEDUCATION := TFieldWrap.Create(Self, 'ID_SPECIALITYEDUCATION',
    '', True);
  FIDSpeciality := TFieldWrap.Create(Self, 'IDSpeciality');
  FData := TFieldWrap.Create(Self, 'DATA_');
  FIDChair := TFieldWrap.Create(Self, 'IDChair');
  FIDEducation2 := TFieldWrap.Create(Self, 'IDEducation2');
  FIDEducation := TFieldWrap.Create(Self, 'IDEducation');
  FYear := TFieldWrap.Create(Self, 'Year');
  FMount_of_year := TFieldWrap.Create(Self, 'Mount_of_year');
  FIDStudyPlanStandart := TFieldWrap.Create(Self, 'IDStudyPlanStandart');
  FIDEducationLevel := TFieldWrap.Create(Self, 'IDEducationLevel');
  FIDEducationType := TFieldWrap.Create(Self, 'IDEducationType');
  FAnnotation := TFieldWrap.Create(Self, 'Annotation', 'Примечание');
end;

{ TODO -oKulakov -cnew_category : Удалить этот запрос, если он нигде не используется }
constructor TQrySpecEdSimple2.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSpecEdSimpleW2.Create(FDQuery);
end;

function TQrySpecEdSimple2.SearchByPK(APKValue: Integer; ATestResult: Integer =
    -1): Integer;
begin
  Assert(APKValue > 0);

  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.PKFieldName, W.PKFieldName]));

  SetParamType(W.PKFieldName);

  Result := W.Load([W.PKFieldName], [APKValue]);

  if ATestResult >= 0 then
    Assert(Result = ATestResult);
end;

{$R *.dfm}

end.
