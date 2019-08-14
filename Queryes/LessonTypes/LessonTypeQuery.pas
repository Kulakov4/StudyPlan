unit LessonTypeQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TLessonTypeW = class;

  TQueryLessonType = class(TQueryBase)
  private
    FW: TLessonTypeW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function SearchBy(AIDStudyPlan, AIDSpecialitySession: Integer; ATestResult:
        Integer = -1): Integer;
    function SearchBySP(AIDStudyPlan: Integer; ATestResult: Integer = -1): Integer;
    function SearchByPK(AIDLessonType: Integer; ATestResult: Integer = -1): Integer;
    property W: TLessonTypeW read FW;
    { Public declarations }
  end;

  TLessonTypeW = class(TDSWrap)
  private
    FID_LessonType: TFieldWrap;
    FIDStudyPlan: TFieldWrap;
    FIDType: TFieldWrap;
    FData: TFieldWrap;
    FIDSpecialitySession: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property ID_LessonType: TFieldWrap read FID_LessonType;
    property IDStudyPlan: TFieldWrap read FIDStudyPlan;
    property IDType: TFieldWrap read FIDType;
    property Data: TFieldWrap read FData;
    property IDSpecialitySession: TFieldWrap read FIDSpecialitySession;
  end;

implementation

constructor TLessonTypeW.Create(AOwner: TComponent);
begin
  inherited;
  FID_LessonType := TFieldWrap.Create(Self, 'ID_LessonType');
  PKFieldName := FID_LessonType.FieldName;
  FIDStudyPlan := TFieldWrap.Create(Self, 'IDStudyPlan');
  FIDType := TFieldWrap.Create(Self, 'IDType');
  FData := TFieldWrap.Create(Self, 'Data');
  FIDSpecialitySession := TFieldWrap.Create(Self, 'IDSpecialitySession');
end;

constructor TQueryLessonType.Create(AOwner: TComponent);
begin
  inherited;
  FW := TLessonTypeW.Create(FDQuery);
end;

function TQueryLessonType.SearchBy(AIDStudyPlan, AIDSpecialitySession: Integer;
    ATestResult: Integer = -1): Integer;
begin
  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0', Format('%s=:%s', [W.IDStudyPlan.FieldName,
    W.IDStudyPlan.FieldName]));

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('1=1', Format('%s=:%s',
    [W.IDSpecialitySession.FieldName, W.IDSpecialitySession.FieldName]));

  SetParamType(W.IDStudyPlan.FieldName);
  SetParamType(W.IDSpecialitySession.FieldName);

  Result := W.Load([W.IDStudyPlan.FieldName, W.IDSpecialitySession.FieldName],
    [AIDStudyPlan, AIDSpecialitySession], ATestResult);
end;

function TQueryLessonType.SearchBySP(AIDStudyPlan: Integer; ATestResult:
    Integer = -1): Integer;
begin
  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0', Format('%s=:%s', [W.IDStudyPlan.FieldName,
    W.IDStudyPlan.FieldName]));

  SetParamType(W.IDStudyPlan.FieldName);

  Result := W.Load([W.IDStudyPlan.FieldName], [AIDStudyPlan], ATestResult);
end;

function TQueryLessonType.SearchByPK(AIDLessonType: Integer; ATestResult:
    Integer = -1): Integer;
begin
  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0', Format('%s=:%s', [W.PKFieldName,
    W.PKFieldName]));

  SetParamType(W.PKFieldName);

  Result := W.Load([W.PKFieldName], [AIDLessonType], ATestResult);
end;

{$R *.dfm}

end.
