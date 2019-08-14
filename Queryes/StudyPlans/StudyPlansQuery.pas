unit StudyPlansQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TStudyPlansW = class;

  TQueryStudyPlans = class(TQueryBase)
  private
    FW: TStudyPlansW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function SearchByCycleSpecialityEducation(AIDCycleSpecialityEducation
      : Integer; ATestResult: Integer = -1): Integer;
    function SearchByIDStudyPlan(AIDStudyPlan: Integer;
      ATestResult: Integer = -1): Integer;
    function SearchByIDSpecEd(AIDSpecialityEducation: Integer;
      ATestResult: Integer = -1): Integer;
    property W: TStudyPlansW read FW;
    { Public declarations }
  end;

  TStudyPlansW = class(TDSWrap)
  private
    FIDCycleSpecialityEducation: TFieldWrap;
    FIDDisciplineName: TFieldWrap;
    FTotal: TFieldWrap;
    FID_StudyPlan: TFieldWrap;
    FLectures: TFieldWrap;
    FSeminars: TFieldWrap;
    FLabworks: TFieldWrap;
    FIDChair: TFieldWrap;
    FIDSPECIALITYEDUCATION: TFieldWrap;
    FOrder: TFieldWrap;
    function GetIDCycleSpecialityEducationParam: TFDParam;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    property IDCycleSpecialityEducation: TFieldWrap
      read FIDCycleSpecialityEducation;
    property IDDisciplineName: TFieldWrap read FIDDisciplineName;
    property IDCycleSpecialityEducationParam: TFDParam
      read GetIDCycleSpecialityEducationParam;
    property Total: TFieldWrap read FTotal;
    property ID_StudyPlan: TFieldWrap read FID_StudyPlan;
    property Lectures: TFieldWrap read FLectures;
    property Seminars: TFieldWrap read FSeminars;
    property Labworks: TFieldWrap read FLabworks;
    property IDChair: TFieldWrap read FIDChair;
    property IDSPECIALITYEDUCATION: TFieldWrap read FIDSPECIALITYEDUCATION;
    property Order: TFieldWrap read FOrder;
  end;

implementation

uses
  StrHelper;

constructor TStudyPlansW.Create(AOwner: TComponent);
begin
  inherited;
  FID_StudyPlan := TFieldWrap.Create(Self, 'ID_StudyPlan');
  PKFieldName := FID_StudyPlan.FieldName;
  FIDCycleSpecialityEducation := TFieldWrap.Create(Self,
    'IDCycleSpecialityEducation');
  FIDDisciplineName := TFieldWrap.Create(Self, 'IDDisciplineName');
  FTotal := TFieldWrap.Create(Self, 'Total');
  FLectures := TFieldWrap.Create(Self, 'Lectures');
  FSeminars := TFieldWrap.Create(Self, 'Seminars');
  FLabworks := TFieldWrap.Create(Self, 'Labworks');
  FIDChair := TFieldWrap.Create(Self, 'IDChair');
  FOrder := TFieldWrap.Create(Self, 'Order_');

  // По этому полю есть фильтр
  FIDSPECIALITYEDUCATION := TFieldWrap.Create(Self, 'IDSPECIALITYEDUCATION');
end;

function TStudyPlansW.GetIDCycleSpecialityEducationParam: TFDParam;
begin
  Result := FDDataSet.ParamByName('IDCycleSpecialityEducation');
end;

constructor TQueryStudyPlans.Create(AOwner: TComponent);
begin
  inherited;
  FW := TStudyPlansW.Create(FDQuery);
end;

function TQueryStudyPlans.SearchByCycleSpecialityEducation
  (AIDCycleSpecialityEducation: Integer; ATestResult: Integer = -1): Integer;
begin
  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.IDCycleSpecialityEducation.FieldName,
    W.IDCycleSpecialityEducation.FieldName]));
  SetParamType(W.IDCycleSpecialityEducation.FieldName);

  Result := W.Load([W.IDCycleSpecialityEducation.FieldName],
    [AIDCycleSpecialityEducation], ATestResult);
end;

function TQueryStudyPlans.SearchByIDStudyPlan(AIDStudyPlan: Integer;
  ATestResult: Integer = -1): Integer;
begin
  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s=:%s', [W.ID_StudyPlan.FieldName, W.ID_StudyPlan.FieldName]));
  SetParamType(W.ID_StudyPlan.FieldName);

  Result := W.Load([W.ID_StudyPlan.FieldName], [AIDStudyPlan], ATestResult);
end;

function TQueryStudyPlans.SearchByIDSpecEd(AIDSpecialityEducation: Integer;
  ATestResult: Integer = -1): Integer;
begin
  Assert(AIDSpecialityEducation > 0);

  FDQuery.SQL.Text := Uncomment(SQL, W.IDSPECIALITYEDUCATION.FieldName);

  SetParamType(W.IDSPECIALITYEDUCATION.FieldName);

  Result := W.Load([W.IDSPECIALITYEDUCATION.FieldName],
    [AIDSpecialityEducation], ATestResult);
end;

{$R *.dfm}

end.
