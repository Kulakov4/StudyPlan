unit CalcOfHourReportDocument;

interface

uses DocumentView, classes, Years, Chairs, Education, Level, Specialitys;

type
  TCalcOfHourReportDocument = class(TDocument)
  private
    FChairs: TChairs;
    FEducation: TEducation;
    FLevel: TLevel;
    FYear: TYears;
  public
    constructor Create(AOwner: TComponent); override;
    property Chairs: TChairs read FChairs;
    property Education: TEducation read FEducation;
    property Level: TLevel read FLevel;
    property Year: TYears read FYear;
  end;

implementation

constructor TCalcOfHourReportDocument.Create(AOwner: TComponent);
begin
  inherited;
  // ���
  FYear := TYears.Create(Self);
  FYear.Refresh;

  // ����� ��������
  FEducation := TEducation.Create(Self);
  FEducation.Refresh;

  // ����
  FLevel := TLevel.Create(Self);
  FLevel.LevelYearParam.Master := FYear;
  FLevel.SpecialityEducationParam.Master := FEducation;
  FLevel.Refresh;

  // �������
  FChairs := TChairs.Create(Self);
  FChairs.DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;
  FChairs.Refresh ; 

end;

end.
