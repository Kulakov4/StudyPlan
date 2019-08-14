unit SpecEdQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, DBRecordHolder;

type
  TSpecEdW = class;

  TQuerySpecEd = class(TQueryBase)
  private
    FW: TSpecEdW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function Search(AYear, AIDEducationType: Integer): Integer;
    function SearchRetraining(AYear: Integer): Integer;
    property W: TSpecEdW read FW;
    { Public declarations }
  end;

  TSpecEdW = class(TDSWrap)
  private
    FData: TFieldWrap;
    FSpecialityEx: TFieldWrap;
    FIDChair: TFieldWrap;
    FEducation: TFieldWrap;
    FSpeciality: TFieldWrap;
    FEducation_Order: TFieldWrap;
    FIDEducationLevel: TFieldWrap;
    FIDEducation2: TFieldWrap;
    FIDEDUCATIONTYPE: TFieldWrap;
    FIDSpeciality: TFieldWrap;
    FIDStudyPlanStandart: TFieldWrap;
    FID_SPECIALITYEDUCATION: TFieldWrap;
    FMount_of_year: TFieldWrap;
    FCHIPER_SPECIALITY: TFieldWrap;
    FYear: TFieldWrap;
    FAnnotation: TFieldWrap;
    FENABLE_SPECIALITYEDUCATION: TFieldWrap;
    FLocked: TFieldWrap;
    FPeriod: TFieldWrap;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    function RestoreBookmark: Boolean; override;
    property Data: TFieldWrap read FData;
    property SpecialityEx: TFieldWrap read FSpecialityEx;
    property IDChair: TFieldWrap read FIDChair;
    property Education: TFieldWrap read FEducation;
    property Speciality: TFieldWrap read FSpeciality;
    property Education_Order: TFieldWrap read FEducation_Order;
    property IDEducationLevel: TFieldWrap read FIDEducationLevel;
    property IDEducation2: TFieldWrap read FIDEducation2;
    property IDEDUCATIONTYPE: TFieldWrap read FIDEDUCATIONTYPE;
    property IDSpeciality: TFieldWrap read FIDSpeciality;
    property IDStudyPlanStandart: TFieldWrap read FIDStudyPlanStandart;
    property ID_SPECIALITYEDUCATION: TFieldWrap read FID_SPECIALITYEDUCATION;
    property Mount_of_year: TFieldWrap read FMount_of_year;
    property CHIPER_SPECIALITY: TFieldWrap read FCHIPER_SPECIALITY;
    property Year: TFieldWrap read FYear;
    property Annotation: TFieldWrap read FAnnotation;
    property ENABLE_SPECIALITYEDUCATION: TFieldWrap
      read FENABLE_SPECIALITYEDUCATION;
    property Locked: TFieldWrap read FLocked;
    property Period: TFieldWrap read FPeriod;
  end;

implementation

constructor TSpecEdW.Create(AOwner: TComponent);
begin
  inherited;
  FID_SPECIALITYEDUCATION := TFieldWrap.Create(Self, 'ID_SPECIALITYEDUCATION',
    '', True);
  FIDSpeciality := TFieldWrap.Create(Self, 'IDSpeciality');
  FData := TFieldWrap.Create(Self, 'DATA_');
  FIDChair := TFieldWrap.Create(Self, 'IDChair');
  FIDEducation2 := TFieldWrap.Create(Self, 'IDEducation2');
  FYear := TFieldWrap.Create(Self, 'Year');
  FMount_of_year := TFieldWrap.Create(Self, 'Mount_of_year');
  FIDStudyPlanStandart := TFieldWrap.Create(Self, 'IDStudyPlanStandart');
  FIDEducationLevel := TFieldWrap.Create(Self, 'IDEducationLevel');
  FIDEDUCATIONTYPE := TFieldWrap.Create(Self, 'IDEDUCATIONTYPE');
  FLocked := TFieldWrap.Create(Self, 'Locked', '����.');

  FSpeciality := TFieldWrap.Create(Self, 'Speciality',
    '����������� ����������');
  FCHIPER_SPECIALITY := TFieldWrap.Create(Self, 'CHIPER_SPECIALITY', '���');
  FPeriod := TFieldWrap.Create(Self, 'Period', '���� ��������');
  FSpecialityEx := TFieldWrap.Create(Self, 'speciality_ex');
  FEducation := TFieldWrap.Create(Self, 'Education', '����� ��������');
  FEducation_Order := TFieldWrap.Create(Self, 'Education_Order');
  FAnnotation := TFieldWrap.Create(Self, 'Annotation', '����������');
  FENABLE_SPECIALITYEDUCATION := TFieldWrap.Create(Self,
    'ENABLE_SPECIALITYEDUCATION');

  // -- ��� ���� �� ����������
  FIDEDUCATIONTYPE := TFieldWrap.Create(Self, 'IDEDUCATIONTYPE');
end;

function TSpecEdW.RestoreBookmark: Boolean;
begin
  Assert(RecHolder <> nil);

  TryLocate([IDSpeciality.FieldName, IDEducation2.FieldName, Period.FieldName],
    [RecHolder.Field[IDSpeciality.FieldName],
    RecHolder.Field[IDEducation2.FieldName],
    RecHolder.Field[Period.FieldName]]);
end;

constructor TQuerySpecEd.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSpecEdW.Create(FDQuery);
end;

function TQuerySpecEd.Search(AYear, AIDEducationType: Integer): Integer;
begin
  Assert(AYear > 0);
  Assert(AIDEducationType > 0);

  FDQuery.SQL.Text := SQL; // ��������������� �������������� SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.Year.FieldName, W.Year.FieldName]));

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('1=1',
    Format('%s=:%s', [W.IDEDUCATIONTYPE.FieldName,
    W.IDEDUCATIONTYPE.FieldName]));

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('2=2',
    Format('%s=:%s', [W.ENABLE_SPECIALITYEDUCATION.FieldName,
    W.ENABLE_SPECIALITYEDUCATION.FieldName]));

  SetParamType(W.Year.FieldName);
  SetParamType(W.IDEDUCATIONTYPE.FieldName);
  SetParamType(W.ENABLE_SPECIALITYEDUCATION.FieldName);

  Result := W.Load([W.Year.FieldName, W.IDEDUCATIONTYPE.FieldName,
    W.ENABLE_SPECIALITYEDUCATION.FieldName], [AYear, AIDEducationType, 1]);
end;

function TQuerySpecEd.SearchRetraining(AYear: Integer): Integer;
begin
  Assert(AYear > 0);

  FDQuery.SQL.Text := SQL; // ��������������� �������������� SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.Year.FieldName, W.Year.FieldName]));

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('1=1',
    Format('%s=:%s', [W.IDEducationLevel.FieldName,
    W.IDEducationLevel.FieldName]));

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('2=2',
    Format('%s=:%s', [W.ENABLE_SPECIALITYEDUCATION.FieldName,
    W.ENABLE_SPECIALITYEDUCATION.FieldName]));

  SetParamType(W.Year.FieldName);
  SetParamType(W.IDEducationLevel.FieldName);
  SetParamType(W.ENABLE_SPECIALITYEDUCATION.FieldName);

  Result := W.Load([W.Year.FieldName, W.IDEducationLevel.FieldName,
    W.ENABLE_SPECIALITYEDUCATION.FieldName], [AYear, 5, 1]);
  // 5 - �������������� !!!
end;

{$R *.dfm}

end.
