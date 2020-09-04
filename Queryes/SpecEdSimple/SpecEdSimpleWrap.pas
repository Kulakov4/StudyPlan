unit SpecEdSimpleWrap;

interface

uses
  DSWrap, SpecEdSimpleInt, System.Classes, InsertEditMode;

type
  TSpecEdSimpleW = class(TDSWrap)
  private
    FAnnotation: TFieldWrap;
    FPortal: TFieldWrap;
    FData: TFieldWrap;
    FEnable_SpecialityEducation: TFieldWrap;
    FIDChair: TFieldWrap;
    FIDArea: TFieldWrap;
    FLocked: TFieldWrap;
    FIDEducation: TFieldWrap;
    FIDEducation2: TFieldWrap;
    FIDEducationLevel: TFieldWrap;
    FIDQualification: TFieldWrap;
    FIDSpeciality: TFieldWrap;
    FIDStudyPlanStandart: TFieldWrap;
    FID_SPECIALITYEDUCATION: TFieldWrap;
    FMount_of_year: TFieldWrap;
    FYears: TFieldWrap;
    FYear: TFieldWrap;
    FMonths: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Save(ASpecEdSimple: ISpecEdSimple; AMode: TMode;
      ASpecialityIDQualification: Integer);
    property Annotation: TFieldWrap read FAnnotation;
    property Portal: TFieldWrap read FPortal;
    property Data: TFieldWrap read FData;
    property Enable_SpecialityEducation: TFieldWrap read
        FEnable_SpecialityEducation;
    property IDChair: TFieldWrap read FIDChair;
    property IDArea: TFieldWrap read FIDArea;
    property Locked: TFieldWrap read FLocked;
    property IDEducation: TFieldWrap read FIDEducation;
    property IDEducation2: TFieldWrap read FIDEducation2;
    property IDEducationLevel: TFieldWrap read FIDEducationLevel;
    property IDQualification: TFieldWrap read FIDQualification;
    property IDSpeciality: TFieldWrap read FIDSpeciality;
    property IDStudyPlanStandart: TFieldWrap read FIDStudyPlanStandart;
    property ID_SPECIALITYEDUCATION: TFieldWrap read FID_SPECIALITYEDUCATION;
    property Mount_of_year: TFieldWrap read FMount_of_year;
    property Years: TFieldWrap read FYears;
    property Year: TFieldWrap read FYear;
    property Months: TFieldWrap read FMonths;
  end;

implementation

uses
  System.Math, System.Variants;

constructor TSpecEdSimpleW.Create(AOwner: TComponent);
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
  FAnnotation := TFieldWrap.Create(Self, 'Annotation', 'Примечание');
  FYears := TFieldWrap.Create(Self, 'Years');
  FMonths := TFieldWrap.Create(Self, 'Months');
  FIDQualification := TFieldWrap.Create(Self, 'IDQualification');
  FIDArea := TFieldWrap.Create(Self, 'IDArea');
  FLocked := TFieldWrap.Create(Self, 'Locked');
  FPortal := TFieldWrap.Create(Self, 'PORTAL');
  FEnable_SpecialityEducation := TFieldWrap.Create(Self, 'Enable_SpecialityEducation');
end;

procedure TSpecEdSimpleW.Save(ASpecEdSimple: ISpecEdSimple; AMode: TMode;
  ASpecialityIDQualification: Integer);
var
  ASpecEdSimpleEx: ISpecEdSimpleEx;
begin
  if AMode = EditMode then
    TryEdit
  else
    TryAppend;

  Year.F.AsInteger := ASpecEdSimple.Year;
  IDEducation2.F.AsInteger := ASpecEdSimple.IDEducation2;
  IDEducationLevel.F.AsInteger := ASpecEdSimple.IDEducationLevel;
  IDChair.F.AsInteger := ASpecEdSimple.IDChair;
  IDSpeciality.F.AsInteger := ASpecEdSimple.IDSpeciality;
  IDStudyPlanStandart.F.AsInteger := ASpecEdSimple.IDStandart;

  // Если квалификация выбрана как в специальности
  if ASpecialityIDQualification = ASpecEdSimple.IDQualification then
    IDQualification.F.AsInteger := 0
  else
    IDQualification.F.AsInteger := ASpecEdSimple.IDQualification;

  Years.F.AsInteger := ASpecEdSimple.Years;
  Months.F.AsInteger := ASpecEdSimple.Months;
  Annotation.F.AsString := ASpecEdSimple.Annotation;
  Enable_SpecialityEducation.F.AsInteger := IfThen(ASpecEdSimple.IsEnabled, 1, 0);
  Locked.F.AsInteger := IfThen(ASpecEdSimple.Locked, 1, 0);
  Portal.F.AsInteger := IfThen(ASpecEdSimple.Portal, 1, 0);

  ASpecEdSimple.QueryInterface(ISpecEdSimpleEx, ASpecEdSimpleEx);
  // Заполняем идентификатор сферы для переподготовки
  if ASpecEdSimpleEx <> nil then
  begin
    if ASpecEdSimpleEx.IDArea > 0 then
      IDArea.F.AsInteger := ASpecEdSimpleEx.IDArea
    else
      IDArea.F.Value := NULL;
  end;

  try
    TryPost;
    Assert(ID_SPECIALITYEDUCATION.F.AsInteger > 0);
  except
    TryCancel;
    raise;
  end;
end;

end.
