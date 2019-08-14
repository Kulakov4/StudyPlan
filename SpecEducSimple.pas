unit SpecEducSimple;

interface

uses
  EssenceEx, System.Classes, K_Params, Data.DB;

type
  TSpecEducSimple = class(TEssenceEx2)
  private
    FIDParam: T_KParam;
    function GetAnnotation: TField;
    function GetData: TField;
    function GetIDAREA: TField;
    function GetIDChair: TField;
    function GetIDEducation: TField;
    function GetIDQualification: TField;
    function GetIDSpeciality: TField;
    function GetIDStudyPlanStandart: TField;
    function GetMonths: TField;
    function GetMOUNT_OF_YEAR: TField;
    function GetYear: TField;
    function GetYears: TField;
  public
    constructor Create(AOwner: TComponent); override;
    class function CreateRetrainingPlan(AIDSpeciality, AYear, AYears, AMonths,
        AIDChair, AIDQualification: Integer; AData: Cardinal; AIDArea: Integer):
        Integer; static;
    property Annotation: TField read GetAnnotation;
    property Data: TField read GetData;
    property IDAREA: TField read GetIDAREA;
    property IDChair: TField read GetIDChair;
    property IDEducation: TField read GetIDEducation;
    property IDParam: T_KParam read FIDParam;
    property IDQualification: TField read GetIDQualification;
    property IDSpeciality: TField read GetIDSpeciality;
    property IDStudyPlanStandart: TField read GetIDStudyPlanStandart;
    property Months: TField read GetMonths;
    property MOUNT_OF_YEAR: TField read GetMOUNT_OF_YEAR;
    property Year: TField read GetYear;
    property Years: TField read GetYears;
  end;

implementation

uses
  System.SysUtils;

constructor TSpecEducSimple.Create(AOwner: TComponent);
begin
  inherited;
  Wrap.ImmediateCommit := True;
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'se.ID_SPECIALITYEDUCATION';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;
  SequenceName := 'cdb_dat_study_process.s_SPECIALITYEDUCATIONS_id';

  with FSQLSelectOperator do
  begin
    Fields.Add('se.ID_SPECIALITYEDUCATION');
    Fields.Add('se.IDSPECIALITY');
    Fields.Add('se.IDEDUCATION');
    Fields.Add('se.YEAR');
    Fields.Add('se.MOUNT_OF_YEAR');
    Fields.Add('se.ENABLE_SPECIALITYEDUCATION');
    Fields.Add('se.LOCKED');
    Fields.Add('se.YEARS');
    Fields.Add('se.MONTHS');
    Fields.Add('se.IDCHAIR');
    Fields.Add('se.DATA_');
    Fields.Add('se.IDSTUDYPLANSTANDART');
    Fields.Add('se.ANNOTATION');
    Fields.Add('se.IDQUALIFICATION');
    Fields.Add('se.IDAREA');

    Tables.Add('SPECIALITYEDUCATIONS se');
  end;

  FIDParam := T_KParam.Create(Params, 'se.ID_SPECIALITYEDUCATION');
  FIDParam.ParamName := 'ID_SPECIALITYEDUCATION';

  UpdatingTableName := 'SPECIALITYEDUCATIONS';

  UpdatingFieldNames.Add('IDSPECIALITY');
  UpdatingFieldNames.Add('IDEDUCATION');
  UpdatingFieldNames.Add('YEAR');
  UpdatingFieldNames.Add('MOUNT_OF_YEAR');
  UpdatingFieldNames.Add('ENABLE_SPECIALITYEDUCATION');
  UpdatingFieldNames.Add('LOCKED');
  UpdatingFieldNames.Add('YEARS');
  UpdatingFieldNames.Add('MONTHS');
  UpdatingFieldNames.Add('IDCHAIR');
  UpdatingFieldNames.Add('DATA_');
  UpdatingFieldNames.Add('IDSTUDYPLANSTANDART');
  UpdatingFieldNames.Add('ANNOTATION');
  UpdatingFieldNames.Add('IDQUALIFICATION');
  UpdatingFieldNames.Add('IDAREA');
end;

class function TSpecEducSimple.CreateRetrainingPlan(AIDSpeciality, AYear,
    AYears, AMonths, AIDChair, AIDQualification: Integer; AData: Cardinal;
    AIDArea: Integer): Integer;
var
  AMountOfYear: Integer;
  Q: TSpecEducSimple;
begin
  Assert(AIDSpeciality > 0);
  Assert(AYear > 0);
  Assert((AYears + AMonths) > 0);
  Assert(AIDChair > 0);
  Assert(AIDQualification > 0);

  // Рассчитываем целое число лет.
  AMountOfYear := AYears;
  if AMonths >= 6 then
    Inc(AMountOfYear);

  // Если кол - во лет посчитали как 0 то пусть план будет на год
//  if AMountOfYear = 0 then
//    AMountOfYear := 1;

  Q := TSpecEducSimple.Create(nil);
  try
    Q.IDParam.ParamValue := 0;
    Q.Refresh;
    Q.DS.Append;

    Q.IDSpeciality.AsInteger := AIDSpeciality;
    Q.IDEducation.AsInteger := 28; // Дневная (переподготовка)
    Q.MOUNT_OF_YEAR.AsInteger := AMountOfYear;
    Q.Year.AsInteger := AYear;
    Q.Years.AsInteger := AYears;
    Q.Months.AsInteger := AMonths;
    Q.IDStudyPlanStandart.AsInteger := 3; // Без стандарта
    Q.IDChair.AsInteger := AIDChair;
    Q.Annotation.AsString := '';
    Q.IDQualification.AsInteger := AIDQualification;
    Q.Data.AsInteger := AData;
    if AIDArea > 0 then
      Q.IDAREA.AsInteger := AIDArea;

    Q.DS.Post;

    Assert(Q.DS.RecordCount = 1);
    Result := Q.Wrap.PKValue;
  finally
    FreeAndNil(Q);
  end;
end;

function TSpecEducSimple.GetAnnotation: TField;
begin
  Result := Field('Annotation');
end;

function TSpecEducSimple.GetData: TField;
begin
  Result := Field('DATA_');
end;

function TSpecEducSimple.GetIDAREA: TField;
begin
  Result := Field('IDAREA');
end;

function TSpecEducSimple.GetIDChair: TField;
begin
  Result := Field('IDChair');
end;

function TSpecEducSimple.GetIDEducation: TField;
begin
  Result := Field('IDEducation');
end;

function TSpecEducSimple.GetIDQualification: TField;
begin
  Result := Field('IDQualification');
end;

function TSpecEducSimple.GetIDSpeciality: TField;
begin
  Result := Field('IDSpeciality');
end;

function TSpecEducSimple.GetIDStudyPlanStandart: TField;
begin
  Result := Field('IDStudyPlanStandart');
end;

function TSpecEducSimple.GetMonths: TField;
begin
  Result := Field('Months');
end;

function TSpecEducSimple.GetMOUNT_OF_YEAR: TField;
begin
  Result := Field('MOUNT_OF_YEAR');
end;

function TSpecEducSimple.GetYear: TField;
begin
  Result := Field('Year');
end;

function TSpecEducSimple.GetYears: TField;
begin
  Result := Field('Years');
end;

end.
