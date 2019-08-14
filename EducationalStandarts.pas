unit EducationalStandarts;

interface

uses
  EssenceEx, Data.DB, Specialitys, StudyPlanStandarts, System.Classes, K_Params;

type
  TEducationalStandarts = class(TEssenceEx2)
  private
    FSpecialityParam: T_KParam;
    FSpecialitys: TSpecialitys;
    FStudyPlanStandartParam: T_KParam;
    FStudyPlanStandarts: TStudyPlanStandarts;
    function GetAdoptionDate: TField;
    function GetOrderNumber: TField;
    procedure OnStudyPlanStandartChange(Sender: TField);
  public
    constructor Create(AOwner: TComponent); override;
    property AdoptionDate: TField read GetAdoptionDate;
    property OrderNumber: TField read GetOrderNumber;
    property SpecialityParam: T_KParam read FSpecialityParam;
    property StudyPlanStandartParam: T_KParam read FStudyPlanStandartParam;
  end;

implementation

uses System.Variants;

constructor TEducationalStandarts.Create(AOwner: TComponent);
var
  Field: TStringField;
begin
  FSynonymFileName := 'EducationalStandartFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName :=
    'es.ID_EducationalStandart';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.EDUCATIONALSTANDARTS_SEQ';

  Wrap.ImmediateCommit := True;
  RefreshRecordAfterPost := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('es.*');

    Tables.Add('EducationalStandarts es');
  end;

  FStudyPlanStandartParam := T_KParam.Create(Params, 'es.IDStudyPlanStandart');
  FStudyPlanStandartParam.ParamName := 'IDStudyPlanStandart';

  FSpecialityParam := T_KParam.Create(Params, 'es.IDSpeciality');
  FSpecialityParam.ParamName := 'IDSpeciality';

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию

  // Создаём стандарты учебных планов
  FStudyPlanStandarts := TStudyPlanStandarts.Create(Self);
  FStudyPlanStandarts.Refresh;

  { Добавляем дополнительное, подстановочное поле }
  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'StudyPlanStandart';
    Size := 50;
    FieldKind := fkLookup;
    Name := DS.Name + FieldName;
    KeyFields := 'IDSTUDYPLANSTANDART';
    LookUpDataset := FStudyPlanStandarts.DS;
    LookUpKeyFields := 'ID_STUDYPLANSTANDART';
    LookUpResultField := 'StudyPlanStandart';
    DataSet := DS;
  end;

  // Создаём специальности
  FSpecialitys := TSpecialitysEx.Create(Self);
  FSpecialitys.BeginUpdate;
  FSpecialitys.ChiperSpecialityParam.Negative := True;
  FSpecialitys.ChiperSpecialityParam.ParamValue := NULL;
  FSpecialitys.EndUpdate();

  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'SPECIALITY';
    Size := 100;
    FieldKind := fkLookup;
    Name := DS.Name + FieldName;
    KeyFields := 'IDSPECIALITY';
    LookUpDataset := FSpecialitys.DS;
    LookUpKeyFields := 'ID_SPECIALITY';
    LookUpResultField := 'SpecialityWithChiper';
    DataSet := DS;
  end;

  // Исправляем глюк Lookup поля
  DS.FieldByName('StudyPlanStandart').OnGetText := OnLookupGetText;
  DS.FieldByName('Speciality').OnGetText := OnLookupGetText;

  DS.FieldByName('StudyPlanStandart').Index := 0;
  DS.FieldByName('SPECIALITY').Index := 1;
  DS.FieldByName('IDSTUDYPLANSTANDART').OnChange := OnStudyPlanStandartChange;

  KeyFieldProviderFlags := [pfInKey, pfInUpdate];

end;

function TEducationalStandarts.GetAdoptionDate: TField;
begin
  Result := Field('AdoptionDate');
end;

function TEducationalStandarts.GetOrderNumber: TField;
begin
  Result := Field('OrderNumber');
end;

procedure TEducationalStandarts.OnStudyPlanStandartChange(Sender: TField);
var
  V: Variant;
begin
  // Фильтруем спициальности, оставляя только те которые соответсвуют стандарту
  FSpecialitys.BeginUpdate;
  try
    FSpecialitys.ChiperSpecialityParam.Negative := True;
    FSpecialitys.ChiperSpecialityParam.ParamValue := NULL;
    if Sender.IsNull then
      V := null
    else
      V := Sender.Value;

    FSpecialitys.StudyPlanStandartParam.ParamValue := V;

  finally
    FSpecialitys.EndUpdate();
  end;

end;

end.
