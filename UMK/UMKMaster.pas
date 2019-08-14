unit UMKMaster;

interface

uses
  DocumentView, System.Classes, System.Generics.Collections, SPUnit, EssenceEx,
  K_Params, StudyPlanForUMK,
  ETP, Datasnap.DBClient, NotifyEvents, KDBClient, TeacherUnit, UMKDataModule,
  Word2000, DisciplineCompetence, Data.DB, StudyPlanInfo, EducationalStandarts,
  StudyPlanAdoption, UMKAdoption, DisciplineSoft, PreviousDisciplines;

type
  TUMKMaster = class(TDocument)
  private
    FChairMaster: TChairTeachersEx;
    FChairTeachers: TChairTeachersEx;
    FDisciplineCompetence: TDisciplineCompetence;
    FDisciplineSoft: TDisciplineSoft;
    FEducationalStandarts: TEducationalStandarts;
    FETPDictonary: TDictionary<Integer, TETP>;
    FIDStudyPlan: Integer;
    FPreviousDisciplines: TPreviousDisciplines;
    FSelectedStudyPlanForUMK: TKClientDataSet;
    FStudyPlanAdoption: TStudyPlanAdoption;
    FStudyPlanForUMK: TStudyPlanForUMK;
    FStudyPlanInfo: TStudyPlanInfo;
    FSubsequentDisciplines: TSubsequentDisciplines;
    FUMKAdoption: TUMKAdoption;
    FYear: Integer;
    procedure AfterChairTeacherChange(Sender: TObject);
    function GetChair: String;
    function GetCources: String;
    function GetDisciplineName: string;
    function GetEducationalStandarts: TEducationalStandarts;
    function GetEducationForms: String;
    function GetFileName: string;
    function GetFullSpeciality: String;
    function GetSemesters: String;
    function GetStudyPlanAdoption: TStudyPlanAdoption;
    function GetUMKAdoption: TUMKAdoption;
    function GetДатаУтвержденияОбразовательногоСтандарта: string;
    function GetДатаУтвержденияУМК: string;
    function GetДатаУтвержденияУчебногоПлана: string;
    function GetНомерОбразовательногоСтандарта: string;
    function GetПротоколУтвержденияУМК: string;
    function GetПротоколУтвержденияУчебногоПлана: string;
    function GetЦельДисциплины: String;
    function GetЧастьЦикла: String;
    procedure OnStudyPlanForUMKSelectionChange(Sender: TObject);
    procedure OnThematicPlanBookmark(Sender: TObject);
    procedure SetYear(const Value: Integer);
    procedure СодержаниеРазделовУчебнойДисциплины(ABookmarkData: TBookMarkData);
    procedure ВидыКонтроляИАттестации(ABookmarkData: TBookMarkData);
    procedure ВидыСРС(ABookmarkData: TBookMarkData);
    procedure ТематическийПлан(ABookmarkData: TBookMarkData);
    procedure КартаКомпетенций(ABookmarkData: TBookMarkData);
    procedure ОбразовательныеТехнологии(ABookmarkData: TBookMarkData);
    procedure ПереченьКомпетенций(ABookmarkData: TBookMarkData);
  protected
    procedure ПО(ABookmarkData: TBookMarkData);
    procedure ПредшествующиеДисциплины(ABookmarkData: TBookMarkData);
    procedure ПоследующиеДисциплины(ABookmarkData: TBookMarkData);
    property EducationalStandarts: TEducationalStandarts
      read GetEducationalStandarts;
    property StudyPlanAdoption: TStudyPlanAdoption read GetStudyPlanAdoption;
    property UMKAdoption: TUMKAdoption read GetUMKAdoption;
  public
    constructor Create(AOwner: TComponent; AIDDiscipline: Integer); reintroduce;
    destructor Destroy; override;
    function CheckSelectedETP: Boolean;
    procedure OnBookmark(Sender: TObject);
    procedure PrepareUMK(const AFileName: string);
    property Chair: String read GetChair;
    property ChairMaster: TChairTeachersEx read FChairMaster;
    property ChairTeachers: TChairTeachersEx read FChairTeachers;
    property Cources: String read GetCources;
    property DisciplineCompetence: TDisciplineCompetence
      read FDisciplineCompetence;
    property DisciplineName: string read GetDisciplineName;
    property DisciplineSoft: TDisciplineSoft read FDisciplineSoft;
    property EducationForms: String read GetEducationForms;
    property ETPDictonary: TDictionary<Integer, TETP> read FETPDictonary;
    property FileName: string read GetFileName;
    property FullSpeciality: String read GetFullSpeciality;
    property PreviousDisciplines: TPreviousDisciplines
      read FPreviousDisciplines;
    property SelectedStudyPlanForUMK: TKClientDataSet
      read FSelectedStudyPlanForUMK;
    property Semesters: String read GetSemesters;
    property StudyPlanForUMK: TStudyPlanForUMK read FStudyPlanForUMK;
    property StudyPlanInfo: TStudyPlanInfo read FStudyPlanInfo;
    property SubsequentDisciplines: TSubsequentDisciplines
      read FSubsequentDisciplines;
    property Year: Integer read FYear write SetYear;
    property ДатаУтвержденияОбразовательногоСтандарта: string
      read GetДатаУтвержденияОбразовательногоСтандарта;
    property ДатаУтвержденияУМК: string read GetДатаУтвержденияУМК;
    property ДатаУтвержденияУчебногоПлана: string
      read GetДатаУтвержденияУчебногоПлана;
    property НомерОбразовательногоСтандарта: string
      read GetНомерОбразовательногоСтандарта;
    property ПротоколУтвержденияУМК: string read GetПротоколУтвержденияУМК;
    property ПротоколУтвержденияУчебногоПлана: string
      read GetПротоколУтвержденияУчебногоПлана;
    property ЦельДисциплины: String read GetЦельДисциплины;
    property ЧастьЦикла: String read GetЧастьЦикла;
  end;

implementation

uses System.SysUtils, MultiSelectDataSetWrap, Word2010, System.Variants,
  ProgressBarForm, System.IOUtils, LanguageConstants, Word2010Ex, K_StrUtils,
  System.Math, Essence, System.StrUtils, MyDataAccess;

constructor TUMKMaster.Create(AOwner: TComponent; AIDDiscipline: Integer);
var
  AMySQLQuery: TMySQLQuery;
  ФИО: string;
begin
  Assert(AIDDiscipline > 0);
  inherited Create(AOwner);
  FETPDictonary := TDictionary<Integer, TETP>.Create();

  FIDStudyPlan := AIDDiscipline;

  FStudyPlanInfo := TStudyPlanInfo.Create(Self);
  FStudyPlanInfo.IDDisciplineParam.ParamValue := AIDDiscipline;
  FStudyPlanInfo.Refresh;
  Assert(FStudyPlanInfo.DS.RecordCount = 1);

  FDisciplineCompetence := TDisciplineCompetence.Create(Self, AIDDiscipline);

  FStudyPlanForUMK := TStudyPlanForUMK.Create(Self);
  FStudyPlanForUMK.YearParam.ParamValue := FStudyPlanInfo.Year.AsInteger;
  FStudyPlanForUMK.IDSpecialityParam.ParamValue :=
    FStudyPlanInfo.IDSpeciality.AsInteger;
  FStudyPlanForUMK.IDDisciplineNameParam.ParamValue :=
    FStudyPlanInfo.IDDisciplineName.AsInteger;
  FStudyPlanForUMK.Refresh;

  // Создаём клона в котором будут только выделенные записи
  FSelectedStudyPlanForUMK := TKClientDataSet.Create(Self);
  FSelectedStudyPlanForUMK.CloneCursor
    (FStudyPlanForUMK.Wrap.ClientDataSet, True);

  TNotifyEventWrap.Create(FStudyPlanForUMK.Wrap.MultiSelectDSWrap.
    OnSelectionChange, OnStudyPlanForUMKSelectionChange);

  AMySQLQuery := TMySQLQuery.Create(Self, 0);
  try

    AMySQLQuery.SQL.Text :=
      'select фл.Фамилия || '' '' || substr(фл.Имя,1,1)|| ''. '' || substr(фл.Отчество, 1, 1) || ''.'' ФИО '
      + 'from ФизическиеЛица фл ' +
      'where фл.Идентификатор =  AUDIT_BASE.AUTHORIZATION."ИДЕНТИФИКАТОРФЛ"';
    AMySQLQuery.Open;
    ФИО := AMySQLQuery.FieldByName('ФИО').AsString;
  finally
    FreeAndNil(AMySQLQuery);
  end;

  // Создаём преподавателей
  FChairTeachers := TChairTeachersEx.Create(Self);
  FChairTeachers.IDChairParam.ParamValue := FStudyPlanInfo.IDChair.AsInteger;
  FChairTeachers.Refresh;
  TNotifyEventWrap.Create(FChairTeachers.Wrap.AfterRecordChange,
    AfterChairTeacherChange);

  // Создаём зав кафедрами
  FChairMaster := TChairTeachersEx.Create(Self);
  FChairMaster.IDChairParam.ParamValue := FStudyPlanInfo.IDChair.AsInteger;
  FChairMaster.Refresh;

  if not FChairTeachers.DS.Locate('FIO', ФИО, []) then
    AfterChairTeacherChange(FChairTeachers);

  // Создаём софт для дисциплины
  FDisciplineSoft := TDisciplineSoft.Create(Self);
  FDisciplineSoft.YearParam.ParamValue := FStudyPlanInfo.Year.AsInteger;
  FDisciplineSoft.IDSpecialityParam.ParamValue :=
    FStudyPlanInfo.IDSpeciality.AsInteger;
  FDisciplineSoft.IDDisciplineNameParam.ParamValue :=
    FStudyPlanInfo.IDDisciplineName.AsInteger;
  FDisciplineSoft.Refresh;
  // Добавляем ПО "по умолчанию"
  FDisciplineSoft.AddDefaultSoftware;

  // Создаём "Предшествующие дисциплины"
  FPreviousDisciplines := TPreviousDisciplines.Create(Self);
  FPreviousDisciplines.YearParam.ParamValue := FStudyPlanInfo.Year.AsInteger;
  FPreviousDisciplines.IDSpecialityParam.ParamValue :=
    FStudyPlanInfo.IDSpeciality.AsInteger;
  FPreviousDisciplines.IDDisciplineNameParam.ParamValue :=
    FStudyPlanInfo.IDDisciplineName.AsInteger;
  FPreviousDisciplines.Refresh;

  // Создаём "Последующие дисциплины"
  FSubsequentDisciplines := TSubsequentDisciplines.Create(Self);
  FSubsequentDisciplines.YearParam.ParamValue := FStudyPlanInfo.Year.AsInteger;
  FSubsequentDisciplines.IDSpecialityParam.ParamValue :=
    FStudyPlanInfo.IDSpeciality.AsInteger;
  FSubsequentDisciplines.IDDisciplineNameParam.ParamValue :=
    FStudyPlanInfo.IDDisciplineName.AsInteger;
  FSubsequentDisciplines.Refresh;

  // Пока так. Потом надо переделать.
  FYear := 2016;
end;

destructor TUMKMaster.Destroy;
begin
  FreeAndNil(FETPDictonary);
  inherited;
end;

procedure TUMKMaster.AfterChairTeacherChange(Sender: TObject);
var
  S: string;
begin
  S := FChairTeachers.Field('ЗАВ_КАФ').AsString;
  if S <> '' then
    FChairMaster.Wrap.LocateByPK(S);
  // FChairMaster.ИдентификаторParam.ParamValue :=
  // Format('''%s''', [FChairTeachers.Field('ЗАВ_КАФ').AsString]);
end;

function TUMKMaster.CheckSelectedETP: Boolean;
var
  AETP: TETP;
  AIDDiscipline: Integer;
begin
  Result := True;
  SelectedStudyPlanForUMK.First;
  while not SelectedStudyPlanForUMK.Eof do
  begin
    AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
      .AsInteger;
    AETP := ETPDictonary[AIDDiscipline];
    if AETP.LessonThemes.DS.RecordCount = 0 then
    begin
      Result := False;
      System.Break;
    end;

    SelectedStudyPlanForUMK.Next;
  end;

end;

function TUMKMaster.GetChair: String;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;
  Result := SelectedStudyPlanForUMK.FieldByName('Кафедра').AsString;
end;

function TUMKMaster.GetCources: String;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;
  Result := SelectedStudyPlanForUMK.FieldByName('Курсы').AsString;
end;

function TUMKMaster.GetDisciplineName: string;
var
  Splitted: TArray<String>;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;
  Result := SelectedStudyPlanForUMK.FieldByName('FullDisciplineName').AsString;
  Splitted := Result.Split(['\']);
  Result := Splitted[Length(Splitted) - 1];
  Result := Result.Trim;
end;

function TUMKMaster.GetEducationalStandarts: TEducationalStandarts;
begin
  if FEducationalStandarts = nil then
    FEducationalStandarts := TEducationalStandarts.Create(Self);

  Result := FEducationalStandarts;
end;

function TUMKMaster.GetEducationForms: String;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  Result := SelectedStudyPlanForUMK.Wrap.GetColumnValues('EducationForm', ', ');
end;

function TUMKMaster.GetFileName: string;
begin
  Assert(FStudyPlanForUMK.DS.RecordCount > 0);

  Result := Format('\\rfagu\workprograms\%s\%s\%s.docx',
    [FStudyPlanInfo.Year.AsString, FStudyPlanForUMK.Field('SHORT_SPECIALITY')
    .AsString, FStudyPlanInfo.DisciplineName.AsString]);
end;

function TUMKMaster.GetFullSpeciality: String;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  Result := Format('%s %s',
    [SelectedStudyPlanForUMK.FieldByName('Chiper_speciality').AsString,
    SelectedStudyPlanForUMK.FieldByName('Speciality').AsString]);
end;

function TUMKMaster.GetSemesters: String;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;
  Result := SelectedStudyPlanForUMK.FieldByName('Семестры').AsString;
end;

function TUMKMaster.GetStudyPlanAdoption: TStudyPlanAdoption;
begin
  if FStudyPlanAdoption = nil then
    FStudyPlanAdoption := TStudyPlanAdoption.Create(Self);

  Result := FStudyPlanAdoption;
end;

function TUMKMaster.GetUMKAdoption: TUMKAdoption;
begin
  if FUMKAdoption = nil then
    FUMKAdoption := TUMKAdoption.Create(Self);

  Result := FUMKAdoption;
end;

function TUMKMaster.GetДатаУтвержденияОбразовательногоСтандарта: string;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;

  EducationalStandarts.BeginUpdate;
  EducationalStandarts.SpecialityParam.ParamValue :=
    StudyPlanForUMK.IDSpecialityParam.ParamValue;
  EducationalStandarts.StudyPlanStandartParam.ParamValue :=
    FSelectedStudyPlanForUMK.FieldByName('IDStudyPlanStandart').AsInteger;
  EducationalStandarts.EndUpdate(eukIfChange);

  Result := IfThen(FEducationalStandarts.DS.RecordCount > 0,
    FormatDateTime('dd mmmm yyyy г.',
    FEducationalStandarts.AdoptionDate.AsDateTime), '');
end;

function TUMKMaster.GetДатаУтвержденияУМК: string;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;

  UMKAdoption.BeginUpdate;
  UMKAdoption.YearParam.ParamValue := StudyPlanForUMK.YearParam.ParamValue;
  UMKAdoption.ChairParam.ParamValue := FSelectedStudyPlanForUMK.FieldByName
    ('IDChair').AsInteger;
  UMKAdoption.EndUpdate(eukIfChange);

  Result := IfThen(UMKAdoption.DS.RecordCount > 0,
    FormatDateTime('dd mmmm yyyy г.', UMKAdoption.AdoptionDate.AsDateTime), '')
end;

function TUMKMaster.GetДатаУтвержденияУчебногоПлана: string;
begin
  StudyPlanAdoption.BeginUpdate;
  StudyPlanAdoption.YearParam.ParamValue :=
    StudyPlanForUMK.YearParam.ParamValue;
  StudyPlanAdoption.SpecialityParam.ParamValue :=
    StudyPlanForUMK.IDSpecialityParam.ParamValue;
  StudyPlanAdoption.EndUpdate(eukIfChange);

  Result := IfThen(StudyPlanAdoption.DS.RecordCount > 0,
    FormatDateTime('dd mmmm yyyy г.',
    StudyPlanAdoption.AdoptionDate.AsDateTime), '');
end;

function TUMKMaster.GetНомерОбразовательногоСтандарта: string;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;

  EducationalStandarts.BeginUpdate;
  EducationalStandarts.SpecialityParam.ParamValue :=
    StudyPlanForUMK.IDSpecialityParam.ParamValue;
  EducationalStandarts.StudyPlanStandartParam.ParamValue :=
    FSelectedStudyPlanForUMK.FieldByName('IDStudyPlanStandart').AsInteger;
  EducationalStandarts.EndUpdate(eukIfChange);

  Result := IfThen(FEducationalStandarts.DS.RecordCount > 0,
    FEducationalStandarts.OrderNumber.AsString, '');
end;

function TUMKMaster.GetПротоколУтвержденияУМК: string;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;

  UMKAdoption.BeginUpdate;
  UMKAdoption.YearParam.ParamValue := StudyPlanForUMK.YearParam.ParamValue;
  UMKAdoption.ChairParam.ParamValue := FSelectedStudyPlanForUMK.FieldByName
    ('IDChair').AsInteger;
  UMKAdoption.EndUpdate(eukIfChange);

  Result := IfThen(UMKAdoption.DS.RecordCount > 0,
    UMKAdoption.Protocol.AsString, '');
end;

function TUMKMaster.GetПротоколУтвержденияУчебногоПлана: string;
begin
  StudyPlanAdoption.BeginUpdate;
  StudyPlanAdoption.YearParam.ParamValue :=
    StudyPlanForUMK.YearParam.ParamValue;
  StudyPlanAdoption.SpecialityParam.ParamValue :=
    StudyPlanForUMK.IDSpecialityParam.ParamValue;
  StudyPlanAdoption.EndUpdate(eukIfChange);

  Result := IfThen(StudyPlanAdoption.DS.RecordCount > 0,
    StudyPlanAdoption.Protocol.AsString, '');
end;

function TUMKMaster.GetЦельДисциплины: String;
begin
  Result := FStudyPlanInfo.Field('Purpose').AsString;
end;

function TUMKMaster.GetЧастьЦикла: String;
// var
// Splitted: TArray<String>;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;
  Result := SelectedStudyPlanForUMK.FieldByName('ЧастьЦикла').AsString;
  // Splitted := Result.Split(['\']);
  // if Length(Splitted) > 1 then
  // Result := Splitted[High(Splitted) - 1];
  // if Length(Splitted) > 1 then
  // Result := Format('%s (%s)', [Result, Splitted[1]]);
  Result := Result.Trim.ToLower;
end;

procedure TUMKMaster.OnBookmark(Sender: TObject);
var
  ABookmarkData: TBookMarkData;
  AIDDiscipline: Integer;
  ANotifyEventWrap: TNotifyEventWrap;
  ANotifyEventWrap2: TNotifyEventWrap;
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  AUMKDM: TUMKDM;
  OutputFileName: string;
  S: string;
  TemplateFileName: string;
begin
  ABookmarkData := Sender as TBookMarkData;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ПоследующиеДисциплины') then
  begin
    ПоследующиеДисциплины(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ПредшествующиеДисциплины') then
  begin
    ПредшествующиеДисциплины(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ПО') then
  begin
    ПО(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'Год') then
  begin
    S := IntToStr(Year);
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, S);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ЗаглавнымиНаименованиеДисциплины')
  then
  begin
    S := DisciplineName.ToUpper;
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, S);
  end;

  if ABookmarkData.BookmarkName.StartsWith('НаименованиеДисциплины') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, DisciplineName);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName,
    'ДатаУтвержденияОбразовательногоСтандарта') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ДатаУтвержденияОбразовательногоСтандарта);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'НомерОбразовательногоСтандарта')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      НомерОбразовательногоСтандарта);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ДатаУтвержденияУчебногоПлана')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ДатаУтвержденияУчебногоПлана);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ПротоколУтвержденияУчебногоПлана')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ПротоколУтвержденияУчебногоПлана);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ДатаУтвержденияУМК') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, ДатаУтвержденияУМК);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ПротоколУтвержденияУМК') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, ПротоколУтвержденияУМК);
  end;

  if ABookmarkData.BookmarkName.StartsWith('СпециальностьПолностью', True) then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, FullSpeciality);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'Курсы') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, Cources);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'Семестры') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, Semesters);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ФормыОбучения') or
    AnsiSameText(ABookmarkData.BookmarkName, 'ФормыОбучения2') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, EducationForms);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'Кафедра') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, Chair);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ДолжностьРазработчикаПолностью')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ChairTeachers.ДолжностьПолностью);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ИнициалыФамилияРазработчика')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ChairTeachers.ИнициалыФамилия);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ЗаведующийКафедройПолностью')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ChairMaster.ЗаведующийКафедройПолностью);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'КафедраРодПадеж') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ChairMaster.КафедраРодПадеж.AsString);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName,
    'ИнициалыФамилияЗаведующегоКафедрой') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ChairMaster.ИнициалыФамилия);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ЦельДисциплины') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, ЦельДисциплины.ToLower);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'СписокКомпетенций') then
  begin
    DisciplineCompetence.ProcessCompetenceList(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ПереченьКомпетенций') then
  begin
    ПереченьКомпетенций(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ЦиклДисциплины') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, ЧастьЦикла);
  end;
  (* *)
  if AnsiSameText(ABookmarkData.BookmarkName,
    'СодержаниеРазделовУчебнойДисциплины') then
  begin
    СодержаниеРазделовУчебнойДисциплины(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ВидыКонтроляИАттестации') then
  begin
    ВидыКонтроляИАттестации(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ТематическийПлан') then
  begin
    ТематическийПлан(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ВидыСРС') then
  begin
    ВидыСРС(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ОбразовательныеТехнологии') then
  begin
    ОбразовательныеТехнологии(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'КартаКомпетенций') then
  begin
    КартаКомпетенций(ABookmarkData);
  end;
  (* *)
end;

procedure TUMKMaster.OnStudyPlanForUMKSelectionChange(Sender: TObject);
var
  ADiscipline: Integer;
  AETP: TETP;
  AIDDiscipline: Integer;
  AOnSelectionChage: TOnSelectionChage;
  S: String;
begin
  AOnSelectionChage := Sender as TOnSelectionChage;

  AIDDiscipline := StrToInt(AOnSelectionChage.Value);

  // Если выделили ещё один учебный план
  if AOnSelectionChage.Checked then
  begin
    AETP := TETP.Create(Self, AIDDiscipline);
    AETP.Caption := StudyPlanForUMK.Caption;
    ETPDictonary.Add(AIDDiscipline, AETP);
  end
  else
  begin
    AETP := ETPDictonary.Items[AIDDiscipline];
    ETPDictonary.Remove(AIDDiscipline);
    FreeAndNil(AETP);
  end;

  S := '';
  For ADiscipline in ETPDictonary.Keys do
  begin
    S := Format('%s, %d', [S, ADiscipline]);
  end;
  if S <> '' then
  begin
    S := S.Substring(2);
    S := Format('ID_Discipline in (%s)', [S]);
  end
  else
    S := '0 = 0';

  FSelectedStudyPlanForUMK.Filter := S;
  FSelectedStudyPlanForUMK.Filtered := True;

end;

procedure TUMKMaster.OnThematicPlanBookmark(Sender: TObject);
var
  ABookmarkData: TBookMarkData;
  AETP: TETP;
  AIDDiscipline: Integer;
begin
  ABookmarkData := Sender as TBookMarkData;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ТематическийПлан') then
  begin

    AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
      .AsInteger;
    AETP := ETPDictonary[AIDDiscipline];

    AETP.ProcessThematicPlan(ABookmarkData);

    // ProcessThematicPlan(AETP, ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'Номер') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      SelectedStudyPlanForUMK.RecNo.ToString);
  end;

  if ABookmarkData.BookmarkName.StartsWith('ФормаОбучения', True) then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      SelectedStudyPlanForUMK.FieldByName('EducationForm').AsString);
  end;
end;

procedure TUMKMaster.PrepareUMK(const AFileName: string);
var
  ANotifyEventWrap: TNotifyEventWrap;
  TemplateFileName: string;
  ProgressBarThread: TProgressBarThread;
begin
  TemplateFileName := TPath.Combine(ExtractFilePath(ParamStr(0)),
    TLangConst.ШаблонУМК);

  ANotifyEventWrap := TNotifyEventWrap.Create(TUMKDM.Instance.OnBookmark,
    OnBookmark);
  ProgressBarThread := TProgressBarThread.Create();
  try
    TUMKDM.Instance.PrepareReport(TemplateFileName);
    try
      if not AFileName.IsEmpty then
        TUMKDM.Instance.Save(AFileName);
    finally
      TUMKDM.Instance.WA.Visible := True;
      TUMKDM.Instance.WA.Disconnect;
    end;

  finally
    ProgressBarThread.Terminate;
    ProgressBarThread.WaitFor;
    ProgressBarThread.Free;
    FreeAndNil(ANotifyEventWrap);
  end;
end;

procedure TUMKMaster.SetYear(const Value: Integer);
begin
  if FYear <> Value then
    FYear := Value;
end;

procedure TUMKMaster.СодержаниеРазделовУчебнойДисциплины(ABookmarkData
  : TBookMarkData);
var
  AETP: TETP;
  AIDDiscipline: Integer;
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  ABookmarkName: string;
  AClone: TClientDataSet;
  AClone2: TClientDataSet;
  AClone3: TClientDataSet;
  ANewRange: WordRange;
  AThemeQuestionType: string;
  Обычный: Style;
  СильноеВыделение: Style;
  Строгий: Style;
  AThemeRecNo: Integer;
  Q: string;
  x: Integer;
  y: Integer;
begin
  x := 0; y := 0;

  Обычный := ABookmarkData.Document.Styles.Item('Обычный');
  Assert(Обычный <> nil);

  Строгий := ABookmarkData.Document.Styles.Item('Строгий');
  Assert(Строгий <> nil);

  СильноеВыделение := ABookmarkData.Document.Styles.Item('Сильное выделение');
  Assert(СильноеВыделение <> nil);

  AThemeRecNo := 0; // Номер темы по порядку

  // ABookmarkData.Document.Application.Visible := True;
  SelectedStudyPlanForUMK.First;
  AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
    .AsInteger;
  AETP := ETPDictonary[AIDDiscipline];

  ABookmarkName := ABookmarkData.B.Name;
  AStart := ABookmarkData.B.Range.Start;
  // Получаем диапазон в начале закладки (до символа перехода на новый абзац)
  // Символ перехода на новый абзац так и останентся в конце диапазона закладки
  ARange := ABookmarkData.Document.Range(AStart, AStart);

  // Создаём клона по ДЕ - Оставляем только непустые ДЕ
  AClone2 := AETP.ThemeUnions.CreateNonEmptyClone;
  try
    AClone2.First;
    while not AClone2.Eof do
    begin
      // После предыдущего диапазона вставляет параграф
      ARange.InsertParagraphAfter;

      // Взяли новый диапазон
      ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
      ARange.ParagraphFormat.SpaceBefore := 6;
      ARange.InsertAfter(AClone2.FieldByName('ThemeUnion').AsString.Trim);
      ARange.Set_Style(Строгий);

      AClone := AETP.LessonThemes.CreateCloneByThemeUnion
        (AClone2.FieldByName('ID_ThemeUnion').AsInteger);
      try
        AClone.First;
        while not AClone.Eof do
        begin
          Inc(AThemeRecNo); // Увеличиваем номер темы
          // После предыдущего диапазона вставляе параграф
          ARange.InsertParagraphAfter;
          // Получаем новый диапазон
          ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
          ARange.ParagraphFormat.SpaceBefore := 6;
          ARange.Text := Format('Тема %d. %s',
            [AThemeRecNo, AClone.FieldByName('ThemeName').AsString.Trim]);
          ARange.Set_Style(СильноеВыделение);

          // Получаем все вопросы выбранной темы
          AClone3 := AETP.ThemeQuestions.CreateCloneByTheme
            (AClone.FieldByName('IDLessonTheme').AsInteger);
          try
            if AClone3.IsEmpty then
            begin
              // После предыдущего диапазона вставляет параграф
              ARange.InsertParagraphAfter;
              // Получаем новый диапазон
              ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
              // ARange.Select;
              // ARange.Document.Application.Selection.ClearFormatting;
              ARange.Text := 'Аудиторное изучение:';
              x := ARange.Start;
              y := ARange.End_;
              // ARange.Set_Style(Строгий);

              // Получаем новый диапазон
              ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
              ARange.Text := ' .......';
              ANewRange := ABookmarkData.Document.Range(x, y);
              ANewRange.Set_Style(Строгий);
              // ARange.Select;
              // ARange.Document.Application.Selection.ClearFormatting;

              // После предыдущего диапазона вставляе параграф
              ARange.InsertParagraphAfter;
              // Получаем новый диапазон
              ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
              // ARange.Select;
              // ARange.Document.Application.Selection.ClearFormatting;
              ARange.Text := 'Самостоятельное изучение:';
              x := ARange.Start;
              y := ARange.End_;

              // ARange.Set_Style(Строгий);

              // Получаем новый диапазон
              ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
              ARange.Text := ' .......';
              // ARange.Select;
              // ARange.Document.Application.Selection.ClearFormatting;
              ANewRange := ABookmarkData.Document.Range(x, y);
              ANewRange.Set_Style(Строгий);
            end
            else
            begin
              AThemeQuestionType := '';
              // Цикл по всем вопросам текущей темы
              while not AClone3.Eof do
              begin
                if AThemeQuestionType <> AClone3.FieldByName
                  ('ThemeQuestionType').AsString then
                begin
                  AThemeQuestionType :=
                    AClone3.FieldByName('ThemeQuestionType').AsString;
                  // После предыдущего диапазона вставляет параграф
                  ARange.InsertParagraphAfter;
                  // Получаем новый диапазон
                  ARange := ABookmarkData.Document.Range(ARange.End_,
                    ARange.End_);
                  // ARange.Select;
                  // ARange.Document.Application.Selection.ClearFormatting;
                  ARange.Text := Format('%s:', [AThemeQuestionType]);
                  x := ARange.Start;
                  y := ARange.End_;
                  // ARange.Set_Style(Строгий);

                end;

                // Получаем новый диапазон
                ARange := ABookmarkData.Document.Range(ARange.End_,
                  ARange.End_);
                // Добавляем в конец точку, если её не было
                Q := AClone3.FieldByName('ThemeQuestion').AsString;
                Q := Q.Trim([' ', '.']) + '.';
                ARange.Text := Format(' %s', [Q]);
                // ARange.Select;
                // ARange.Document.Application.Selection.ClearFormatting;

                ANewRange := ABookmarkData.Document.Range(x, y);
                ANewRange.Set_Style(Строгий);

                AClone3.Next;
              end;
            end;
          finally
            FreeAndNil(AClone3);
          end;

          AClone.Next;
        end;
      finally
        FreeAndNil(AClone);
      end;
      AClone2.Next;
    end;
  finally
    FreeAndNil(AClone2);
  end;

  ARange := ABookmarkData.Document.Range(AStart, ARange.End_);
  ARange2 := ARange;
  ARange.Bookmarks.Add(ABookmarkName, ARange2);
end;

procedure TUMKMaster.ВидыКонтроляИАттестации(ABookmarkData: TBookMarkData);
var
  AETP: TETP;
  AIDDiscipline: Integer;
  AClone: TClientDataSet;
  AMergeCells: TList<TMergeCells>;
  AMergeCols: TList<Integer>;
  ARange: WordRange;
  S: string;
  T: Table;
  Обычный: Style;
  СильноеВыделение: Style;
  Строгий: Style;
  AMergeRows: TList<Integer>;
  I: Integer;
  AThemeUnionRecNo: Integer;
  AWordTable: TWordTable;
begin
  Обычный := ABookmarkData.Document.Styles.Item('Обычный');
  Assert(Обычный <> nil);

  Строгий := ABookmarkData.Document.Styles.Item('Строгий');
  Assert(Строгий <> nil);

  СильноеВыделение := ABookmarkData.Document.Styles.Item('Сильное выделение');
  Assert(СильноеВыделение <> nil);

  AThemeUnionRecNo := 0; // Номер ДЕ по порядку

  // ABookmarkData.Document.Application.Visible := True;

  AMergeRows := TList<Integer>.Create();
  AMergeCols := TList<Integer>.Create();
  try

    SelectedStudyPlanForUMK.First;
    AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
      .AsInteger;
    AETP := ETPDictonary[AIDDiscipline];

    if ABookmarkData.B.Range.Tables.Count = 0 then
      raise Exception.Create
        (TLangConst.ОшибкаПриОбработкеВидовИКонтроляАттестации);

    // Получаем первую таблицу из закладки
    T := ABookmarkData.B.Range.Tables.Item(1);
    Assert(T <> nil);

    AMergeCells := TList<TMergeCells>.Create();
    AWordTable := TWordTable.Create(T);
    try

      AETP.LessonThemes.BeginUpdate;
      try
        AETP.LessonThemes.TotalHourParam.Operator := '>';
        AETP.LessonThemes.TotalHourParam.ParamValue := 0;
      finally
        AETP.LessonThemes.EndUpdate();
      end;

      Assert(AETP.LessonThemes.DS.RecordCount > 0);
      AETP.DisciplineSemestrs.DS.First;

      // ЧастьЦикла по семестрам/сессиям
      while not AETP.DisciplineSemestrs.DS.Eof do
      begin
        AClone := AETP.ThemeUnions.CreateCloneBySessionUnion
          (AETP.DisciplineSemestrs.PKValue);
        try
          // Фильтруем ДЕ: оставляем только с часами
          S := AClone.Filter;
          S := Format('(%s) and ([ВСЕГО] > 0)', [S]);
          AClone.Filtered := False;
          AClone.Filter := S;
          AClone.Filtered := True;
          AClone.First;

          AMergeCols.Clear;
          // ЧастьЦикла по всем ДЕ
          while not AClone.Eof do
          begin
            Inc(AThemeUnionRecNo); // Увеличиваем номер ДЕ

            // Добавляем новую строку в конец таблицы
            T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

            // Заполняем номер ДЕ
            T.Cell(T.Rows.Count, 1).Range.Text :=
              Format('%d', [AThemeUnionRecNo]);

            // Заполняем номер семестра/курса
            if AClone.RecNo = 1 then
              T.Cell(T.Rows.Count, 2).Range.Text :=
                Format('%d', [AETP.DisciplineSemestrs.Field('SessionOrder')
                .AsInteger]);

            // Заполняем виды контроля

            T.Cell(T.Rows.Count, 3).Range.Text := 'Текущий контроль';

            AWordTable.SetText(T.Rows.Count, 4,
              AETP.ThemeUnionControl.ToString
              (AClone.FieldByName('ID_ThemeUnion').AsInteger));

            if AClone.RecordCount > 1 then
              AMergeCols.Add(T.Rows.Count);

            AClone.Next;
          end;
        finally
          FreeAndNil(AClone);
        end;

        // Добавляем новую строку в конец таблицы
        T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

        // Запоминаем, что эту строку будем объединять
        AMergeRows.Add(T.Rows.Count);

        T.Cell(T.Rows.Count, 1).Range.Text :=
          Format('Промежуточная аттестация: %s',
          [AETP.DisciplineSemestrs.Field('КонтрольнТочки').AsString]);

        if AMergeCols.Count > 1 then
        begin
          // Объединяем ячейки по вертикали
          T.Cell(AMergeCols[0], 2)
            .Merge(T.Cell(AMergeCols[AMergeCols.Count - 1], 2));
        end;
        AMergeCols.Clear;

        AETP.DisciplineSemestrs.DS.Next; // Переход к следующему семестру
      end;

      for I := 0 to AMergeRows.Count - 1 do
      begin
        ARange := ABookmarkData.Document.Range(T.Cell(AMergeRows[I], 1)
          .Range.Start, T.Cell(AMergeRows[I], T.Columns.Count).Range.End_);
        // Объединяем все ячейки строки в одну строку
        ARange.Cells.Merge;
        ARange := T.Cell(AMergeRows[I], 1).Range;
        ARange.Set_Style(СильноеВыделение);
        ARange.ParagraphFormat.Alignment := wdAlignParagraphLeft;
      end;

      ARange := ABookmarkData.Document.Range(T.Cell(1, 1).Range.Start,
        T.Cell(1, T.Columns.Count).Range.End_);
      ARange.Set_Style(Строгий);
    finally
      FreeAndNil(AMergeCells);
      FreeAndNil(AWordTable);
    end;

  finally
    FreeAndNil(AMergeRows);
    FreeAndNil(AMergeCols);
  end;
end;

procedure TUMKMaster.ВидыСРС(ABookmarkData: TBookMarkData);
var
  AClone: TClientDataSet;
  ADisciplineSemestrs: TDisciplineSemestrs;
  AETP, AETP2: TETP;
  AIDDiscipline: Integer;
  AThemeUnionRecNo: Integer;
  T: Table;
  AMergeCells: TList<TMergeCells>;
  AWordTable: TWordTable;
  I: Integer;
  Ok: Boolean;
  СтильСтрогий: String;
begin
  if ABookmarkData.B.Range.Tables.Count = 0 then
    raise Exception.Create(TLangConst.ОшибкаПриОбработкеВидовСРС);

  // Получаем первую таблицу из закладки
  T := ABookmarkData.B.Range.Tables.Item(1);
  Assert(T <> nil);
  AWordTable := TWordTable.Create(T);
  AMergeCells := TList<TMergeCells>.Create();
  try

    СтильСтрогий := TLangConst.СтильТекстТаблицы + ',' +
      TLangConst.СтильСтрогий;

    // Добавляем новую строку - для форм убучения
    T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

    // Запоминаем, что в этой колонке надо будет объединить ячейки
    AMergeCells.Add(TMergeCells.Create(T, СтильСтрогий, wdAlignParagraphCenter,
      1, 2, 1, 1, wdCellAlignVerticalCenter));
    AMergeCells.Add(TMergeCells.Create(T, СтильСтрогий, wdAlignParagraphLeft, 1,
      2, 2, 2, wdCellAlignVerticalCenter));

    SelectedStudyPlanForUMK.First;
    while not SelectedStudyPlanForUMK.Eof do
    begin
      // Получаем первую дисциплину среди выделенных дисциплин
      AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
        .AsInteger;
      // Получаем тем. план по этой дисциплине
      AETP := ETPDictonary[AIDDiscipline];

      // Добавляем новый столбец
      T.Cell(T.Rows.Count, T.Columns.Count).Range.Columns.Add(EmptyParam);

      // Заполняем форму обучения
      AWordTable.SetText(T.Rows.Count, T.Columns.Count,
        AETP.StudyPlanInfo2.UMK.AsString, СтильСтрогий);

      // Переходим к следующему учебному плану
      SelectedStudyPlanForUMK.Next;
    end;

    // Заполняем ячейку "Часы"
    AWordTable.SetText(1, 3, 'Часы', СтильСтрогий);
    if T.Columns.Count > 3 then
      // Запоминаем, что в этой строке надо будет объединить ячейки
      AMergeCells.Add(TMergeCells.Create(T, СтильСтрогий,
        wdAlignParagraphCenter, 1, 1, 3, T.Columns.Count));

    SelectedStudyPlanForUMK.First;
    // Получаем первую дисциплину среди выделенных дисциплин
    AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
      .AsInteger;
    // Получаем тем. план по этой дисциплине
    AETP := ETPDictonary[AIDDiscipline];

    AThemeUnionRecNo := 0;

    // Получаем семестры/курсы по дисциплине
    ADisciplineSemestrs := AETP.DisciplineSemestrs;
    ADisciplineSemestrs.Wrap.MyBookmark.Save(ADisciplineSemestrs.KeyFieldName,
      True, True);
    try
      ADisciplineSemestrs.DS.First;
      // ЧастьЦикла по всем семестрам/курсам дисциплины
      while not ADisciplineSemestrs.DS.Eof do
      begin
        // Добавляем новую строку - для семестра
        // T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

        // Заполняем имя и номер семестра/курса
        // AWordTable.SetText(T.Rows.Count, 1,
        // Format('%s №%d', [Capitalize(ADisciplineSemestrs.Field('SessionName')
        // .AsString), ADisciplineSemestrs.Field('SessionOrder').AsInteger]));

        // Запоминаем, что в этой строке надо будет объединить ячейки
        // AMergeCells.Add(TMergeCells.Create(T, TLangConst.СтильТекстТаблицы + ','
        // + TLangConst.СтильСильноеВыделение));

        // Создаём клона - выбираем разделы семестра/курса
        AClone := AETP.ThemeUnions.CreateCloneBySessionUnion
          (ADisciplineSemestrs.PKValue);
        try
          // Фильтруем разделы: оставляем только с часами
          // AClone.Filtered := False;
          AClone.Filter := Format('(%s) and ([ВСЕГО] > 0)', [AClone.Filter]);
          AClone.Filtered := True;
          AClone.First;

          while not AClone.Eof do
          begin
            Inc(AThemeUnionRecNo); // Увеличиваем номер раздела

            // Добавляем новую строку в конец таблицы
            T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

            // номер раздела
            AWordTable.SetText(T.Rows.Count, 1, AThemeUnionRecNo.ToString,
              TLangConst.СтильТекстТаблицы, wdAlignParagraphCenter,
              wdTextOrientationHorizontal, wdCellAlignVerticalCenter);

            // Виды СРС
            AWordTable.SetText(T.Rows.Count, 2,
              AETP.ThemeUnionIndependentWork.ToString
              (AClone.FieldByName('ID_ThemeUnion').AsInteger),
              TLangConst.СтильТекстТаблицы, wdAlignParagraphLeft);

            // Часы
            SelectedStudyPlanForUMK.First;
            I := 0;
            while not SelectedStudyPlanForUMK.Eof do
            begin
              // Получаем первую дисциплину среди выделенных дисциплин
              AIDDiscipline := SelectedStudyPlanForUMK.FieldByName
                ('ID_Discipline').AsInteger;
              // Получаем тем. план по этой дисциплине
              AETP2 := ETPDictonary[AIDDiscipline];

              // Ищем такую ДЕ в очередном учебном плане
              Ok := AETP2.ThemeUnions.DS.Locate('ThemeUnion',
                AClone.FieldByName('ThemeUnion').AsString, []);
              if Ok then
                AWordTable.SetText(T.Rows.Count, 3 + I,
                  AETP2.ThemeUnions.Field('Сам').AsString,
                  TLangConst.СтильТекстТаблицы, wdAlignParagraphCenter,
                  wdTextOrientationHorizontal, wdCellAlignVerticalCenter);

              // Переходим к следующему учебному плану
              SelectedStudyPlanForUMK.Next;
              Inc(I);
            end;
            AClone.Next;
          end;
        finally
          FreeAndNil(AClone);
        end;

        // Добавляем новую строку - итоги семестра
        // T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

        // заполняем итоги семестра
        // AWordTable.SetText(T.Rows.Count, 1, Format('Итого часов в семестре №%d',
        // [ADisciplineSemestrs.Field('SessionOrder').AsInteger]));

        // Последний столбец - сам. работы за семестр
        // AWordTable.SetText(T.Rows.Count, T.Columns.Count,
        // Format('%d', [ADisciplineSemestrs.Field('Сам').AsInteger]),
        // СтильСтрогий, wdAlignParagraphCenter);

        // Запоминаем, что в этой строке надо будет объединить ячейки
        // AMergeCells.Add(TMergeCells.Create(T, СтильСтрогий));
        // Последнюю колонку объединять не будем
        // AMergeCells[AMergeCells.Count - 1].EndColumn := T.Columns.Count - 1;

        // Переходим к следующему семестру/курсу
        ADisciplineSemestrs.DS.Next;
      end;

      while AMergeCells.Count > 0 do
      begin
        // Объединяем ячейки
        AMergeCells[0].Merge;
        AMergeCells[0].Free;
        AMergeCells.Delete(0);
      end;

      // Автоматически форматируем таблицу по содержимому
      T.AutoFitBehavior(wdAutoFitContent);

    finally
      ADisciplineSemestrs.Wrap.MyBookmark.Restore;
    end;
  finally
    FreeAndNil(AMergeCells);
    FreeAndNil(AWordTable);
  end;
end;

procedure TUMKMaster.ТематическийПлан(ABookmarkData: TBookMarkData);
var
  ANotifyEventWrap: TNotifyEventWrap;
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  AUMKDM: TUMKDM;
  TemplateFileName: string;
begin
  TemplateFileName := TPath.Combine(ExtractFilePath(ParamStr(0)),
    TLangConst.ШаблонТемПлана);

  // Создаём ещё одну копию модуля данных для UMK
  AUMKDM := TUMKDM.Create(Self);
  try
    // Подписываемся на события
    ANotifyEventWrap := TNotifyEventWrap.Create(AUMKDM.OnBookmark,
      OnThematicPlanBookmark);
    try
      ARange := ABookmarkData.B.Range;
      // Начальная позиция закладки
      AStart := ARange.Start;

      SelectedStudyPlanForUMK.First;
      while not SelectedStudyPlanForUMK.Eof do
      begin
        AUMKDM.PrepareReport(TemplateFileName);
        try

          AUMKDM.WA.Selection.WholeStory;
          AUMKDM.WA.Selection.Copy;

          ARange.Paste; // Вставляем очередной тематический план
          ARange.Bookmarks.Add(ABookmarkData.BookmarkName, ARange);
          // Ставим новую закладку

          // Получаем новый диапазон
          ARange2 := ABookmarkData.Document.Range(ARange.End_, ARange.End_);

          ARange := ARange2;

        finally
          AUMKDM.WD.Close(wdDoNotSaveChanges);
          AUMKDM.WA.Disconnect;
        end;
        SelectedStudyPlanForUMK.Next;
      end;
      ARange2 := ABookmarkData.Document.Range(AStart, ARange.End_);
      ARange2.Bookmarks.Add(ABookmarkData.BookmarkName, ARange2);
    finally
      FreeAndNil(ANotifyEventWrap);
    end;
  finally
    FreeAndNil(AUMKDM);
  end;

end;

procedure TUMKMaster.КартаКомпетенций(ABookmarkData: TBookMarkData);
var
  ANotifyEventWrap: TNotifyEventWrap;
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  AUMKDM: TUMKDM;
  TemplateFileName: string;
begin
  TemplateFileName := TPath.Combine(ExtractFilePath(ParamStr(0)),
    LanguageConstants.TLangConst.ШаблонКартыКомпетенций);

  // Создаём ещё одну копию модуля данных для UMK
  AUMKDM := TUMKDM.Create(Self);
  try
    // Подписываемся на события
    ANotifyEventWrap := TNotifyEventWrap.Create(AUMKDM.OnBookmark,
      DisciplineCompetence.OnBookmark);
    try
      ARange := ABookmarkData.B.Range;
      // Начальная позиция закладки
      AStart := ARange.Start;

      SelectedStudyPlanForUMK.First;
      // while not SelectedStudyPlanForUMK.Eof do
      // begin
      AUMKDM.PrepareReport(TemplateFileName);
      try

        AUMKDM.WA.Selection.WholeStory;
        AUMKDM.WA.Selection.Copy;

        ARange.Paste; // Вставляем карту компетенций
        ARange.Bookmarks.Add(ABookmarkData.BookmarkName, ARange);
        // Ставим новую закладку

        // Получаем новый диапазон
        ARange2 := ABookmarkData.Document.Range(ARange.End_, ARange.End_);

        ARange := ARange2;

      finally
        AUMKDM.WD.Close(wdDoNotSaveChanges);
        AUMKDM.WA.Disconnect;
      end;
      // SelectedStudyPlanForUMK.Next;
      // end;
      ARange2 := ABookmarkData.Document.Range(AStart, ARange.End_);
      ARange2.Bookmarks.Add(ABookmarkData.BookmarkName, ARange2);
    finally
      // Отписываемся от события
      FreeAndNil(ANotifyEventWrap);
    end;
  finally
    FreeAndNil(AUMKDM);
  end;

end;

procedure TUMKMaster.ОбразовательныеТехнологии(ABookmarkData: TBookMarkData);
var
  AClone: TClientDataSet;
  AETP: TETP;
  AIDDiscipline: Integer;
  AThemeUnionRecNo: Integer;
  AWordTable: TWordTable;
  T: Table;
begin
  if ABookmarkData.B.Range.Tables.Count = 0 then
    raise Exception.Create
      (TLangConst.ОшибкаПриОбработкеОразовательныхТехнологий);

  // Получаем первую таблицу из закладки
  T := ABookmarkData.B.Range.Tables.Item(1);
  Assert(T <> nil);
  AWordTable := TWordTable.Create(T);
  try
    // Получаем первую дисциплину среди выделенных дисциплин
    AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
      .AsInteger;
    // Получаем тем. план по этой дисциплине
    AETP := ETPDictonary[AIDDiscipline];

    AThemeUnionRecNo := 0;

    // Создаём клона - оставляем только не пустые разделы
    AClone := AETP.ThemeUnions.CreateNonEmptyClone;
    try
      AClone.First;
      while not AClone.Eof do
      begin
        Inc(AThemeUnionRecNo);
        // Увеличиваем номер раздела

        // Добавляем новую строку в конец таблицы
        T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

        // номер раздела
        AWordTable.SetText(T.Rows.Count, 1, Format('%d', [AThemeUnionRecNo]),
          TLangConst.СтильТекстТаблицы);

        // Виды учебной работы
        AWordTable.SetText(T.Rows.Count, 2,
          AETP.ThemeUnionEducationalWorks.ToString
          (AClone.FieldByName('ID_ThemeUnion').AsInteger),
          TLangConst.СтильТекстТаблицы);

        // Образовательные технологии
        AWordTable.SetText(T.Rows.Count, 3,
          AETP.THEMEUNIONTECHNOLOGIES.ToString
          (AClone.FieldByName('ID_ThemeUnion').AsInteger),
          TLangConst.СтильТекстТаблицы);

        // Особенности проведения занятий
        AWordTable.SetText(T.Rows.Count, 4,
          AETP.ThemeUnionLessonTheatures.ToString
          (AClone.FieldByName('ID_ThemeUnion').AsInteger),
          TLangConst.СтильТекстТаблицы);

        AClone.Next;
      end;
    finally
      FreeAndNil(AClone);
    end;
  finally
    FreeAndNil(AWordTable);
  end;
end;

procedure TUMKMaster.ПО(ABookmarkData: TBookMarkData);
var
  AWordTable: TWordTable;
  T: Table;
  x: Integer;
  y: Integer;
begin
  if ABookmarkData.B.Range.Tables.Count = 0 then
    raise Exception.Create(TLangConst.ОшибкаПриОбработкеПО);

  // Получаем первую таблицу из закладки
  T := ABookmarkData.B.Range.Tables.Item(1);
  Assert(T <> nil);
  AWordTable := TWordTable.Create(T);
  DisciplineSoft.Wrap.MyBookmark.Save(DisciplineSoft.KeyFieldName, True, True);
  try
    DisciplineSoft.DS.First;
    while not DisciplineSoft.DS.Eof do
    begin
      x := T.Rows.Count;
      y := 1;
      // Добавляем новую строку в конец таблицы
      T.Cell(x, y).Range.Rows.Add(EmptyParam);

      // Заполняем код и название компетенции
      AWordTable.SetText(T.Rows.Count, 1, DisciplineSoft.SoftwareName.AsString,
        TLangConst.СтильТекстТаблицы);

      DisciplineSoft.DS.Next;
    end;
  finally
    FreeAndNil(AWordTable);
    DisciplineSoft.Wrap.MyBookmark.Restore;
  end;
end;

procedure TUMKMaster.ПредшествующиеДисциплины(ABookmarkData: TBookMarkData);
var
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  ABookmarkName: string;
  АбзацМаркированногоСписка: Style;
begin
  if FPreviousDisciplines.DS.RecordCount = 0 then
    Exit;

  АбзацМаркированногоСписка := ABookmarkData.Document.Styles.Item
    ('Абзац маркированного списка');
  Assert(АбзацМаркированногоСписка <> nil);

  ABookmarkName := ABookmarkData.B.Name;
  AStart := ABookmarkData.B.Range.Start;
  ARange := ABookmarkData.Document.Range(AStart, AStart);

  ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
  // ARange.ParagraphFormat.SpaceBefore := 6;
  // ARange.InsertParagraphAfter;

  FPreviousDisciplines.DS.First;
  while not FPreviousDisciplines.DS.Eof do
  begin
    ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
    // ARange.ParagraphFormat.SpaceBefore := 6;
    ARange.InsertParagraphAfter;

    ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
    ARange.Text := FPreviousDisciplines.DisciplineName.AsString.Trim;
    ARange.Set_Style(АбзацМаркированногоСписка);
    ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
    FPreviousDisciplines.DS.Next;
  end;

  ARange := ABookmarkData.Document.Range(AStart, ARange.End_);
  ARange2 := ARange;
  ARange.Bookmarks.Add(ABookmarkName, ARange2);
end;

procedure TUMKMaster.ПереченьКомпетенций(ABookmarkData: TBookMarkData);
var
  ACompetence: TCompetence;
  T: Table;
  x: Integer;
  y: Integer;
begin
  if ABookmarkData.B.Range.Tables.Count = 0 then
    raise Exception.Create(TLangConst.ОшибкаПриОбработкеПеречняКомпетенций);

  // Получаем первую таблицу из закладки
  T := ABookmarkData.B.Range.Tables.Item(1);
  Assert(T <> nil);

  ACompetence := DisciplineCompetence.Competence;
  ACompetence.Wrap.MyBookmark.Save(ACompetence.KeyFieldName, True, True);
  try
    ACompetence.DS.First;
    while not ACompetence.DS.Eof do
    begin
      x := T.Rows.Count;
      y := 3;
      // Добавляем новую строку в конец таблицы
      T.Cell(x, y).Range.Rows.Add(EmptyParam);

      // Заполняем код и название компетенции
      T.Cell(T.Rows.Count, 1).Range.Text :=
        Format('%s %s', [ACompetence.Field('Code').AsString,
        ACompetence.Field('Description').AsString]);

      ACompetence.DS.Next;
    end;
  finally
    ACompetence.Wrap.MyBookmark.Restore;
  end;
end;

procedure TUMKMaster.ПоследующиеДисциплины(ABookmarkData: TBookMarkData);
var
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  ABookmarkName: string;
  АбзацМаркированногоСписка: Style;
begin
  if FSubsequentDisciplines.DS.RecordCount = 0 then
    Exit;

  АбзацМаркированногоСписка := ABookmarkData.Document.Styles.Item
    ('Абзац маркированного списка');
  Assert(АбзацМаркированногоСписка <> nil);

  ABookmarkName := ABookmarkData.B.Name;
  AStart := ABookmarkData.B.Range.Start;
  ARange := ABookmarkData.Document.Range(AStart, AStart);

  ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
  // ARange.ParagraphFormat.SpaceBefore := 6;
  // ARange.InsertParagraphAfter;

  FSubsequentDisciplines.DS.First;
  while not FSubsequentDisciplines.DS.Eof do
  begin
    ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
    // ARange.ParagraphFormat.SpaceBefore := 6;
    ARange.InsertParagraphAfter;

    ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
    ARange.Text := FSubsequentDisciplines.DisciplineName.AsString.Trim;
    ARange.Set_Style(АбзацМаркированногоСписка);
    ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
    FSubsequentDisciplines.DS.Next;
  end;

  ARange := ABookmarkData.Document.Range(AStart, ARange.End_);
  ARange2 := ARange;
  ARange.Bookmarks.Add(ABookmarkName, ARange2);
end;

end.
