unit StudyPlanAdoption;

interface

uses
  EssenceEx, Specialitys, Data.DB, System.Classes, K_Params;

type
  TStudyPlanAdoption = class(TEssenceEx2)
  private
    FSpecialityParam: T_KParam;
    FSpecialitys: TSpecialitys;
    FYearParam: T_KParam;
    function GetAdoptionDate: TField;
    function GetProtocol: TField;
  protected
    procedure DoBeforePost(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property AdoptionDate: TField read GetAdoptionDate;
    property Protocol: TField read GetProtocol;
    property SpecialityParam: T_KParam read FSpecialityParam;
    property YearParam: T_KParam read FYearParam;
  end;

implementation

uses System.Variants, NotifyEvents;

constructor TStudyPlanAdoption.Create(AOwner: TComponent);
var
  Field: TStringField;
begin
  FSynonymFileName := 'StudyPlanAdoptionFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'spa.ID_StudyPlanAdoption';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.STUDYPLANADOPTION_SEQ';

  Wrap.ImmediateCommit := True;
  RefreshRecordAfterPost := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('spa.*');

    Tables.Add('STUDYPLANADOPTION spa');
  end;

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию

  // Создаём специальности
  FSpecialitys := TSpecialitysEx.Create(Self);
  FSpecialitys.BeginUpdate;
  FSpecialitys.ChiperSpecialityParam.Negative := True;
  FSpecialitys.ChiperSpecialityParam.ParamValue := NULL;
  FSpecialitys.EndUpdate();

  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'Speciality';
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
  DS.FieldByName('Speciality').OnGetText := OnLookupGetText;

  DS.FieldByName('Speciality').Index := 0;

  KeyFieldProviderFlags := [pfInKey, pfInUpdate];

  FYearParam := T_KParam.Create(Params, 'spa.year');
  FSpecialitys.YearParam.SameParam := FYearParam;

  FSpecialityParam := T_KParam.Create(Params, 'spa.IDSpeciality');
  FSpecialityParam.ParamName := 'IDSpeciality';

  TNotifyEventWrap.Create(DataSetWrap.BeforePost, DoBeforePost);
end;

procedure TStudyPlanAdoption.DoBeforePost(Sender: TObject);
begin
  Field('Year').Value := FYearParam.ParamValue;
end;

function TStudyPlanAdoption.GetAdoptionDate: TField;
begin
  Result := Field('AdoptionDate');
end;

function TStudyPlanAdoption.GetProtocol: TField;
begin
  Result := Field('Protocol');
end;

end.
