unit StudyPlanForUMK;

interface

uses
  EssenceEx, System.Classes, K_Params;

type
  TStudyPlanForUMK = class(TEssenceEx2)
  private
    FIDDisciplineNameParam: T_KFunctionParam;
    FYearParam: T_KFunctionParam;
    FIDSpecialityParam: T_KFunctionParam;
    function GetCaption: string;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    property Caption: string read GetCaption;
    property IDDisciplineNameParam: T_KFunctionParam read FIDDisciplineNameParam;
    property YearParam: T_KFunctionParam read FYearParam;
    property IDSpecialityParam: T_KFunctionParam read FIDSpecialityParam;
  end;

implementation

uses SysUtils;

constructor TStudyPlanForUMK.Create(AOwner: TComponent);
begin
  inherited;
  FSynonymFileName := 'SPForUMK.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'spumk.ID_Discipline';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  with FSQLSelectOperator do
  begin
    Fields.Add('spumk.*');
{
    Fields.Add('spumk.ID_Discipline');
    Fields.Add('spumk.FullDisciplineName');
    Fields.Add('spumk.chiper_speciality');
    Fields.Add('spumk.speciality');
    Fields.Add('spumk.IDStudyPlanStandart');
    Fields.Add('spumk.StudyPlanStandart');
    Fields.Add('spumk.EducationForm');
    Fields.Add('spumk.ЛетОбучения');
    Fields.Add('spumk.ВсегоЧасов');
    Fields.Add('spumk.Лекций');
    Fields.Add('spumk.Лабораторных');
    Fields.Add('spumk.Семинаров');
    Fields.Add('spumk.Зачёты');
    Fields.Add('spumk.Экзамены');
    Fields.Add('spumk.Курсовые');
    Fields.Add('spumk.Курсы');
    Fields.Add('spumk.Семестры');
    Fields.Add('spumk.IDChair');
    Fields.Add('spumk.Кафедра');
    Fields.Add('spumk.ЧастьЦикла');
}
    Tables.Add('TABLE (CDB_DAT_UMK.UMKPack.GetStudyPlanForUMK(:Year, :IDSpeciality, :IDDisciplineName)) spumk');

  end;
  FYearParam := T_KFunctionParam.Create(Params, 'Year');
  FIDSpecialityParam := T_KFunctionParam.Create(Params, 'IDSpeciality');
  FIDDisciplineNameParam := T_KFunctionParam.Create(Params, 'IDDisciplineName');
end;

function TStudyPlanForUMK.GetCaption: string;
begin
  Result := '';
  if DS.RecordCount > 0 then
    Result := Format('%s (%s)', [Field('EducationForm').AsString, Field('ЛетОбучения').AsString])
end;

end.
