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
    function Get����������������������������������������: string;
    function Get������������������: string;
    function Get����������������������������: string;
    function Get������������������������������: string;
    function Get����������������������: string;
    function Get��������������������������������: string;
    function Get��������������: String;
    function Get����������: String;
    procedure OnStudyPlanForUMKSelectionChange(Sender: TObject);
    procedure OnThematicPlanBookmark(Sender: TObject);
    procedure SetYear(const Value: Integer);
    procedure �����������������������������������(ABookmarkData: TBookMarkData);
    procedure �����������������������(ABookmarkData: TBookMarkData);
    procedure �������(ABookmarkData: TBookMarkData);
    procedure ����������������(ABookmarkData: TBookMarkData);
    procedure ����������������(ABookmarkData: TBookMarkData);
    procedure �������������������������(ABookmarkData: TBookMarkData);
    procedure �������������������(ABookmarkData: TBookMarkData);
  protected
    procedure ��(ABookmarkData: TBookMarkData);
    procedure ������������������������(ABookmarkData: TBookMarkData);
    procedure ���������������������(ABookmarkData: TBookMarkData);
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
    property ����������������������������������������: string
      read Get����������������������������������������;
    property ������������������: string read Get������������������;
    property ����������������������������: string
      read Get����������������������������;
    property ������������������������������: string
      read Get������������������������������;
    property ����������������������: string read Get����������������������;
    property ��������������������������������: string
      read Get��������������������������������;
    property ��������������: String read Get��������������;
    property ����������: String read Get����������;
  end;

implementation

uses System.SysUtils, MultiSelectDataSetWrap, Word2010, System.Variants,
  ProgressBarForm, System.IOUtils, LanguageConstants, Word2010Ex, K_StrUtils,
  System.Math, Essence, System.StrUtils, MyDataAccess;

constructor TUMKMaster.Create(AOwner: TComponent; AIDDiscipline: Integer);
var
  AMySQLQuery: TMySQLQuery;
  ���: string;
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

  // ������ ����� � ������� ����� ������ ���������� ������
  FSelectedStudyPlanForUMK := TKClientDataSet.Create(Self);
  FSelectedStudyPlanForUMK.CloneCursor
    (FStudyPlanForUMK.Wrap.ClientDataSet, True);

  TNotifyEventWrap.Create(FStudyPlanForUMK.Wrap.MultiSelectDSWrap.
    OnSelectionChange, OnStudyPlanForUMKSelectionChange);

  AMySQLQuery := TMySQLQuery.Create(Self, 0);
  try

    AMySQLQuery.SQL.Text :=
      'select ��.������� || '' '' || substr(��.���,1,1)|| ''. '' || substr(��.��������, 1, 1) || ''.'' ��� '
      + 'from �������������� �� ' +
      'where ��.������������� =  AUDIT_BASE.AUTHORIZATION."���������������"';
    AMySQLQuery.Open;
    ��� := AMySQLQuery.FieldByName('���').AsString;
  finally
    FreeAndNil(AMySQLQuery);
  end;

  // ������ ��������������
  FChairTeachers := TChairTeachersEx.Create(Self);
  FChairTeachers.IDChairParam.ParamValue := FStudyPlanInfo.IDChair.AsInteger;
  FChairTeachers.Refresh;
  TNotifyEventWrap.Create(FChairTeachers.Wrap.AfterRecordChange,
    AfterChairTeacherChange);

  // ������ ��� ���������
  FChairMaster := TChairTeachersEx.Create(Self);
  FChairMaster.IDChairParam.ParamValue := FStudyPlanInfo.IDChair.AsInteger;
  FChairMaster.Refresh;

  if not FChairTeachers.DS.Locate('FIO', ���, []) then
    AfterChairTeacherChange(FChairTeachers);

  // ������ ���� ��� ����������
  FDisciplineSoft := TDisciplineSoft.Create(Self);
  FDisciplineSoft.YearParam.ParamValue := FStudyPlanInfo.Year.AsInteger;
  FDisciplineSoft.IDSpecialityParam.ParamValue :=
    FStudyPlanInfo.IDSpeciality.AsInteger;
  FDisciplineSoft.IDDisciplineNameParam.ParamValue :=
    FStudyPlanInfo.IDDisciplineName.AsInteger;
  FDisciplineSoft.Refresh;
  // ��������� �� "�� ���������"
  FDisciplineSoft.AddDefaultSoftware;

  // ������ "�������������� ����������"
  FPreviousDisciplines := TPreviousDisciplines.Create(Self);
  FPreviousDisciplines.YearParam.ParamValue := FStudyPlanInfo.Year.AsInteger;
  FPreviousDisciplines.IDSpecialityParam.ParamValue :=
    FStudyPlanInfo.IDSpeciality.AsInteger;
  FPreviousDisciplines.IDDisciplineNameParam.ParamValue :=
    FStudyPlanInfo.IDDisciplineName.AsInteger;
  FPreviousDisciplines.Refresh;

  // ������ "����������� ����������"
  FSubsequentDisciplines := TSubsequentDisciplines.Create(Self);
  FSubsequentDisciplines.YearParam.ParamValue := FStudyPlanInfo.Year.AsInteger;
  FSubsequentDisciplines.IDSpecialityParam.ParamValue :=
    FStudyPlanInfo.IDSpeciality.AsInteger;
  FSubsequentDisciplines.IDDisciplineNameParam.ParamValue :=
    FStudyPlanInfo.IDDisciplineName.AsInteger;
  FSubsequentDisciplines.Refresh;

  // ���� ���. ����� ���� ����������.
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
  S := FChairTeachers.Field('���_���').AsString;
  if S <> '' then
    FChairMaster.Wrap.LocateByPK(S);
  // FChairMaster.�������������Param.ParamValue :=
  // Format('''%s''', [FChairTeachers.Field('���_���').AsString]);
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
  Result := SelectedStudyPlanForUMK.FieldByName('�������').AsString;
end;

function TUMKMaster.GetCources: String;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;
  Result := SelectedStudyPlanForUMK.FieldByName('�����').AsString;
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
  Result := SelectedStudyPlanForUMK.FieldByName('��������').AsString;
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

function TUMKMaster.Get����������������������������������������: string;
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
    FormatDateTime('dd mmmm yyyy �.',
    FEducationalStandarts.AdoptionDate.AsDateTime), '');
end;

function TUMKMaster.Get������������������: string;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;

  UMKAdoption.BeginUpdate;
  UMKAdoption.YearParam.ParamValue := StudyPlanForUMK.YearParam.ParamValue;
  UMKAdoption.ChairParam.ParamValue := FSelectedStudyPlanForUMK.FieldByName
    ('IDChair').AsInteger;
  UMKAdoption.EndUpdate(eukIfChange);

  Result := IfThen(UMKAdoption.DS.RecordCount > 0,
    FormatDateTime('dd mmmm yyyy �.', UMKAdoption.AdoptionDate.AsDateTime), '')
end;

function TUMKMaster.Get����������������������������: string;
begin
  StudyPlanAdoption.BeginUpdate;
  StudyPlanAdoption.YearParam.ParamValue :=
    StudyPlanForUMK.YearParam.ParamValue;
  StudyPlanAdoption.SpecialityParam.ParamValue :=
    StudyPlanForUMK.IDSpecialityParam.ParamValue;
  StudyPlanAdoption.EndUpdate(eukIfChange);

  Result := IfThen(StudyPlanAdoption.DS.RecordCount > 0,
    FormatDateTime('dd mmmm yyyy �.',
    StudyPlanAdoption.AdoptionDate.AsDateTime), '');
end;

function TUMKMaster.Get������������������������������: string;
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

function TUMKMaster.Get����������������������: string;
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

function TUMKMaster.Get��������������������������������: string;
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

function TUMKMaster.Get��������������: String;
begin
  Result := FStudyPlanInfo.Field('Purpose').AsString;
end;

function TUMKMaster.Get����������: String;
// var
// Splitted: TArray<String>;
begin
  Assert(SelectedStudyPlanForUMK.RecordCount > 0);
  SelectedStudyPlanForUMK.First;
  Result := SelectedStudyPlanForUMK.FieldByName('����������').AsString;
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

  if AnsiSameText(ABookmarkData.BookmarkName, '���������������������') then
  begin
    ���������������������(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '������������������������') then
  begin
    ������������������������(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '��') then
  begin
    ��(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '���') then
  begin
    S := IntToStr(Year);
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, S);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '��������������������������������')
  then
  begin
    S := DisciplineName.ToUpper;
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, S);
  end;

  if ABookmarkData.BookmarkName.StartsWith('����������������������') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, DisciplineName);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName,
    '����������������������������������������') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ����������������������������������������);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '������������������������������')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ������������������������������);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '����������������������������')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ����������������������������);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '��������������������������������')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ��������������������������������);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '������������������') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, ������������������);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '����������������������') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, ����������������������);
  end;

  if ABookmarkData.BookmarkName.StartsWith('����������������������', True) then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, FullSpeciality);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '�����') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, Cources);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '��������') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, Semesters);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '�������������') or
    AnsiSameText(ABookmarkData.BookmarkName, '�������������2') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, EducationForms);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '�������') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, Chair);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '������������������������������')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ChairTeachers.������������������);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '���������������������������')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ChairTeachers.���������������);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '���������������������������')
  then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ChairMaster.���������������������������);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '���������������') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ChairMaster.���������������.AsString);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName,
    '����������������������������������') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      ChairMaster.���������������);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '��������������') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, ��������������.ToLower);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '�����������������') then
  begin
    DisciplineCompetence.ProcessCompetenceList(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '�������������������') then
  begin
    �������������������(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '��������������') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, ����������);
  end;
  (* *)
  if AnsiSameText(ABookmarkData.BookmarkName,
    '�����������������������������������') then
  begin
    �����������������������������������(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '�����������������������') then
  begin
    �����������������������(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '����������������') then
  begin
    ����������������(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '�������') then
  begin
    �������(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '�������������������������') then
  begin
    �������������������������(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '����������������') then
  begin
    ����������������(ABookmarkData);
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

  // ���� �������� ��� ���� ������� ����
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

  if AnsiSameText(ABookmarkData.BookmarkName, '����������������') then
  begin

    AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
      .AsInteger;
    AETP := ETPDictonary[AIDDiscipline];

    AETP.ProcessThematicPlan(ABookmarkData);

    // ProcessThematicPlan(AETP, ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '�����') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      SelectedStudyPlanForUMK.RecNo.ToString);
  end;

  if ABookmarkData.BookmarkName.StartsWith('�������������', True) then
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
    TLangConst.���������);

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

procedure TUMKMaster.�����������������������������������(ABookmarkData
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
  �������: Style;
  ����������������: Style;
  �������: Style;
  AThemeRecNo: Integer;
  Q: string;
  x: Integer;
  y: Integer;
begin
  x := 0; y := 0;

  ������� := ABookmarkData.Document.Styles.Item('�������');
  Assert(������� <> nil);

  ������� := ABookmarkData.Document.Styles.Item('�������');
  Assert(������� <> nil);

  ���������������� := ABookmarkData.Document.Styles.Item('������� ���������');
  Assert(���������������� <> nil);

  AThemeRecNo := 0; // ����� ���� �� �������

  // ABookmarkData.Document.Application.Visible := True;
  SelectedStudyPlanForUMK.First;
  AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
    .AsInteger;
  AETP := ETPDictonary[AIDDiscipline];

  ABookmarkName := ABookmarkData.B.Name;
  AStart := ABookmarkData.B.Range.Start;
  // �������� �������� � ������ �������� (�� ������� �������� �� ����� �����)
  // ������ �������� �� ����� ����� ��� � ���������� � ����� ��������� ��������
  ARange := ABookmarkData.Document.Range(AStart, AStart);

  // ������ ����� �� �� - ��������� ������ �������� ��
  AClone2 := AETP.ThemeUnions.CreateNonEmptyClone;
  try
    AClone2.First;
    while not AClone2.Eof do
    begin
      // ����� ����������� ��������� ��������� ��������
      ARange.InsertParagraphAfter;

      // ����� ����� ��������
      ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
      ARange.ParagraphFormat.SpaceBefore := 6;
      ARange.InsertAfter(AClone2.FieldByName('ThemeUnion').AsString.Trim);
      ARange.Set_Style(�������);

      AClone := AETP.LessonThemes.CreateCloneByThemeUnion
        (AClone2.FieldByName('ID_ThemeUnion').AsInteger);
      try
        AClone.First;
        while not AClone.Eof do
        begin
          Inc(AThemeRecNo); // ����������� ����� ����
          // ����� ����������� ��������� �������� ��������
          ARange.InsertParagraphAfter;
          // �������� ����� ��������
          ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
          ARange.ParagraphFormat.SpaceBefore := 6;
          ARange.Text := Format('���� %d. %s',
            [AThemeRecNo, AClone.FieldByName('ThemeName').AsString.Trim]);
          ARange.Set_Style(����������������);

          // �������� ��� ������� ��������� ����
          AClone3 := AETP.ThemeQuestions.CreateCloneByTheme
            (AClone.FieldByName('IDLessonTheme').AsInteger);
          try
            if AClone3.IsEmpty then
            begin
              // ����� ����������� ��������� ��������� ��������
              ARange.InsertParagraphAfter;
              // �������� ����� ��������
              ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
              // ARange.Select;
              // ARange.Document.Application.Selection.ClearFormatting;
              ARange.Text := '���������� ��������:';
              x := ARange.Start;
              y := ARange.End_;
              // ARange.Set_Style(�������);

              // �������� ����� ��������
              ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
              ARange.Text := ' .......';
              ANewRange := ABookmarkData.Document.Range(x, y);
              ANewRange.Set_Style(�������);
              // ARange.Select;
              // ARange.Document.Application.Selection.ClearFormatting;

              // ����� ����������� ��������� �������� ��������
              ARange.InsertParagraphAfter;
              // �������� ����� ��������
              ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
              // ARange.Select;
              // ARange.Document.Application.Selection.ClearFormatting;
              ARange.Text := '��������������� ��������:';
              x := ARange.Start;
              y := ARange.End_;

              // ARange.Set_Style(�������);

              // �������� ����� ��������
              ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
              ARange.Text := ' .......';
              // ARange.Select;
              // ARange.Document.Application.Selection.ClearFormatting;
              ANewRange := ABookmarkData.Document.Range(x, y);
              ANewRange.Set_Style(�������);
            end
            else
            begin
              AThemeQuestionType := '';
              // ���� �� ���� �������� ������� ����
              while not AClone3.Eof do
              begin
                if AThemeQuestionType <> AClone3.FieldByName
                  ('ThemeQuestionType').AsString then
                begin
                  AThemeQuestionType :=
                    AClone3.FieldByName('ThemeQuestionType').AsString;
                  // ����� ����������� ��������� ��������� ��������
                  ARange.InsertParagraphAfter;
                  // �������� ����� ��������
                  ARange := ABookmarkData.Document.Range(ARange.End_,
                    ARange.End_);
                  // ARange.Select;
                  // ARange.Document.Application.Selection.ClearFormatting;
                  ARange.Text := Format('%s:', [AThemeQuestionType]);
                  x := ARange.Start;
                  y := ARange.End_;
                  // ARange.Set_Style(�������);

                end;

                // �������� ����� ��������
                ARange := ABookmarkData.Document.Range(ARange.End_,
                  ARange.End_);
                // ��������� � ����� �����, ���� � �� ����
                Q := AClone3.FieldByName('ThemeQuestion').AsString;
                Q := Q.Trim([' ', '.']) + '.';
                ARange.Text := Format(' %s', [Q]);
                // ARange.Select;
                // ARange.Document.Application.Selection.ClearFormatting;

                ANewRange := ABookmarkData.Document.Range(x, y);
                ANewRange.Set_Style(�������);

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

procedure TUMKMaster.�����������������������(ABookmarkData: TBookMarkData);
var
  AETP: TETP;
  AIDDiscipline: Integer;
  AClone: TClientDataSet;
  AMergeCells: TList<TMergeCells>;
  AMergeCols: TList<Integer>;
  ARange: WordRange;
  S: string;
  T: Table;
  �������: Style;
  ����������������: Style;
  �������: Style;
  AMergeRows: TList<Integer>;
  I: Integer;
  AThemeUnionRecNo: Integer;
  AWordTable: TWordTable;
begin
  ������� := ABookmarkData.Document.Styles.Item('�������');
  Assert(������� <> nil);

  ������� := ABookmarkData.Document.Styles.Item('�������');
  Assert(������� <> nil);

  ���������������� := ABookmarkData.Document.Styles.Item('������� ���������');
  Assert(���������������� <> nil);

  AThemeUnionRecNo := 0; // ����� �� �� �������

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
        (TLangConst.������������������������������������������);

    // �������� ������ ������� �� ��������
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

      // ���������� �� ���������/�������
      while not AETP.DisciplineSemestrs.DS.Eof do
      begin
        AClone := AETP.ThemeUnions.CreateCloneBySessionUnion
          (AETP.DisciplineSemestrs.PKValue);
        try
          // ��������� ��: ��������� ������ � ������
          S := AClone.Filter;
          S := Format('(%s) and ([�����] > 0)', [S]);
          AClone.Filtered := False;
          AClone.Filter := S;
          AClone.Filtered := True;
          AClone.First;

          AMergeCols.Clear;
          // ���������� �� ���� ��
          while not AClone.Eof do
          begin
            Inc(AThemeUnionRecNo); // ����������� ����� ��

            // ��������� ����� ������ � ����� �������
            T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

            // ��������� ����� ��
            T.Cell(T.Rows.Count, 1).Range.Text :=
              Format('%d', [AThemeUnionRecNo]);

            // ��������� ����� ��������/�����
            if AClone.RecNo = 1 then
              T.Cell(T.Rows.Count, 2).Range.Text :=
                Format('%d', [AETP.DisciplineSemestrs.Field('SessionOrder')
                .AsInteger]);

            // ��������� ���� ��������

            T.Cell(T.Rows.Count, 3).Range.Text := '������� ��������';

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

        // ��������� ����� ������ � ����� �������
        T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

        // ����������, ��� ��� ������ ����� ����������
        AMergeRows.Add(T.Rows.Count);

        T.Cell(T.Rows.Count, 1).Range.Text :=
          Format('������������� ����������: %s',
          [AETP.DisciplineSemestrs.Field('��������������').AsString]);

        if AMergeCols.Count > 1 then
        begin
          // ���������� ������ �� ���������
          T.Cell(AMergeCols[0], 2)
            .Merge(T.Cell(AMergeCols[AMergeCols.Count - 1], 2));
        end;
        AMergeCols.Clear;

        AETP.DisciplineSemestrs.DS.Next; // ������� � ���������� ��������
      end;

      for I := 0 to AMergeRows.Count - 1 do
      begin
        ARange := ABookmarkData.Document.Range(T.Cell(AMergeRows[I], 1)
          .Range.Start, T.Cell(AMergeRows[I], T.Columns.Count).Range.End_);
        // ���������� ��� ������ ������ � ���� ������
        ARange.Cells.Merge;
        ARange := T.Cell(AMergeRows[I], 1).Range;
        ARange.Set_Style(����������������);
        ARange.ParagraphFormat.Alignment := wdAlignParagraphLeft;
      end;

      ARange := ABookmarkData.Document.Range(T.Cell(1, 1).Range.Start,
        T.Cell(1, T.Columns.Count).Range.End_);
      ARange.Set_Style(�������);
    finally
      FreeAndNil(AMergeCells);
      FreeAndNil(AWordTable);
    end;

  finally
    FreeAndNil(AMergeRows);
    FreeAndNil(AMergeCols);
  end;
end;

procedure TUMKMaster.�������(ABookmarkData: TBookMarkData);
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
  ������������: String;
begin
  if ABookmarkData.B.Range.Tables.Count = 0 then
    raise Exception.Create(TLangConst.��������������������������);

  // �������� ������ ������� �� ��������
  T := ABookmarkData.B.Range.Tables.Item(1);
  Assert(T <> nil);
  AWordTable := TWordTable.Create(T);
  AMergeCells := TList<TMergeCells>.Create();
  try

    ������������ := TLangConst.����������������� + ',' +
      TLangConst.������������;

    // ��������� ����� ������ - ��� ���� ��������
    T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

    // ����������, ��� � ���� ������� ���� ����� ���������� ������
    AMergeCells.Add(TMergeCells.Create(T, ������������, wdAlignParagraphCenter,
      1, 2, 1, 1, wdCellAlignVerticalCenter));
    AMergeCells.Add(TMergeCells.Create(T, ������������, wdAlignParagraphLeft, 1,
      2, 2, 2, wdCellAlignVerticalCenter));

    SelectedStudyPlanForUMK.First;
    while not SelectedStudyPlanForUMK.Eof do
    begin
      // �������� ������ ���������� ����� ���������� ���������
      AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
        .AsInteger;
      // �������� ���. ���� �� ���� ����������
      AETP := ETPDictonary[AIDDiscipline];

      // ��������� ����� �������
      T.Cell(T.Rows.Count, T.Columns.Count).Range.Columns.Add(EmptyParam);

      // ��������� ����� ��������
      AWordTable.SetText(T.Rows.Count, T.Columns.Count,
        AETP.StudyPlanInfo2.UMK.AsString, ������������);

      // ��������� � ���������� �������� �����
      SelectedStudyPlanForUMK.Next;
    end;

    // ��������� ������ "����"
    AWordTable.SetText(1, 3, '����', ������������);
    if T.Columns.Count > 3 then
      // ����������, ��� � ���� ������ ���� ����� ���������� ������
      AMergeCells.Add(TMergeCells.Create(T, ������������,
        wdAlignParagraphCenter, 1, 1, 3, T.Columns.Count));

    SelectedStudyPlanForUMK.First;
    // �������� ������ ���������� ����� ���������� ���������
    AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
      .AsInteger;
    // �������� ���. ���� �� ���� ����������
    AETP := ETPDictonary[AIDDiscipline];

    AThemeUnionRecNo := 0;

    // �������� ��������/����� �� ����������
    ADisciplineSemestrs := AETP.DisciplineSemestrs;
    ADisciplineSemestrs.Wrap.MyBookmark.Save(ADisciplineSemestrs.KeyFieldName,
      True, True);
    try
      ADisciplineSemestrs.DS.First;
      // ���������� �� ���� ���������/������ ����������
      while not ADisciplineSemestrs.DS.Eof do
      begin
        // ��������� ����� ������ - ��� ��������
        // T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

        // ��������� ��� � ����� ��������/�����
        // AWordTable.SetText(T.Rows.Count, 1,
        // Format('%s �%d', [Capitalize(ADisciplineSemestrs.Field('SessionName')
        // .AsString), ADisciplineSemestrs.Field('SessionOrder').AsInteger]));

        // ����������, ��� � ���� ������ ���� ����� ���������� ������
        // AMergeCells.Add(TMergeCells.Create(T, TLangConst.����������������� + ','
        // + TLangConst.���������������������));

        // ������ ����� - �������� ������� ��������/�����
        AClone := AETP.ThemeUnions.CreateCloneBySessionUnion
          (ADisciplineSemestrs.PKValue);
        try
          // ��������� �������: ��������� ������ � ������
          // AClone.Filtered := False;
          AClone.Filter := Format('(%s) and ([�����] > 0)', [AClone.Filter]);
          AClone.Filtered := True;
          AClone.First;

          while not AClone.Eof do
          begin
            Inc(AThemeUnionRecNo); // ����������� ����� �������

            // ��������� ����� ������ � ����� �������
            T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

            // ����� �������
            AWordTable.SetText(T.Rows.Count, 1, AThemeUnionRecNo.ToString,
              TLangConst.�����������������, wdAlignParagraphCenter,
              wdTextOrientationHorizontal, wdCellAlignVerticalCenter);

            // ���� ���
            AWordTable.SetText(T.Rows.Count, 2,
              AETP.ThemeUnionIndependentWork.ToString
              (AClone.FieldByName('ID_ThemeUnion').AsInteger),
              TLangConst.�����������������, wdAlignParagraphLeft);

            // ����
            SelectedStudyPlanForUMK.First;
            I := 0;
            while not SelectedStudyPlanForUMK.Eof do
            begin
              // �������� ������ ���������� ����� ���������� ���������
              AIDDiscipline := SelectedStudyPlanForUMK.FieldByName
                ('ID_Discipline').AsInteger;
              // �������� ���. ���� �� ���� ����������
              AETP2 := ETPDictonary[AIDDiscipline];

              // ���� ����� �� � ��������� ������� �����
              Ok := AETP2.ThemeUnions.DS.Locate('ThemeUnion',
                AClone.FieldByName('ThemeUnion').AsString, []);
              if Ok then
                AWordTable.SetText(T.Rows.Count, 3 + I,
                  AETP2.ThemeUnions.Field('���').AsString,
                  TLangConst.�����������������, wdAlignParagraphCenter,
                  wdTextOrientationHorizontal, wdCellAlignVerticalCenter);

              // ��������� � ���������� �������� �����
              SelectedStudyPlanForUMK.Next;
              Inc(I);
            end;
            AClone.Next;
          end;
        finally
          FreeAndNil(AClone);
        end;

        // ��������� ����� ������ - ����� ��������
        // T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

        // ��������� ����� ��������
        // AWordTable.SetText(T.Rows.Count, 1, Format('����� ����� � �������� �%d',
        // [ADisciplineSemestrs.Field('SessionOrder').AsInteger]));

        // ��������� ������� - ���. ������ �� �������
        // AWordTable.SetText(T.Rows.Count, T.Columns.Count,
        // Format('%d', [ADisciplineSemestrs.Field('���').AsInteger]),
        // ������������, wdAlignParagraphCenter);

        // ����������, ��� � ���� ������ ���� ����� ���������� ������
        // AMergeCells.Add(TMergeCells.Create(T, ������������));
        // ��������� ������� ���������� �� �����
        // AMergeCells[AMergeCells.Count - 1].EndColumn := T.Columns.Count - 1;

        // ��������� � ���������� ��������/�����
        ADisciplineSemestrs.DS.Next;
      end;

      while AMergeCells.Count > 0 do
      begin
        // ���������� ������
        AMergeCells[0].Merge;
        AMergeCells[0].Free;
        AMergeCells.Delete(0);
      end;

      // ������������� ����������� ������� �� �����������
      T.AutoFitBehavior(wdAutoFitContent);

    finally
      ADisciplineSemestrs.Wrap.MyBookmark.Restore;
    end;
  finally
    FreeAndNil(AMergeCells);
    FreeAndNil(AWordTable);
  end;
end;

procedure TUMKMaster.����������������(ABookmarkData: TBookMarkData);
var
  ANotifyEventWrap: TNotifyEventWrap;
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  AUMKDM: TUMKDM;
  TemplateFileName: string;
begin
  TemplateFileName := TPath.Combine(ExtractFilePath(ParamStr(0)),
    TLangConst.��������������);

  // ������ ��� ���� ����� ������ ������ ��� UMK
  AUMKDM := TUMKDM.Create(Self);
  try
    // ������������� �� �������
    ANotifyEventWrap := TNotifyEventWrap.Create(AUMKDM.OnBookmark,
      OnThematicPlanBookmark);
    try
      ARange := ABookmarkData.B.Range;
      // ��������� ������� ��������
      AStart := ARange.Start;

      SelectedStudyPlanForUMK.First;
      while not SelectedStudyPlanForUMK.Eof do
      begin
        AUMKDM.PrepareReport(TemplateFileName);
        try

          AUMKDM.WA.Selection.WholeStory;
          AUMKDM.WA.Selection.Copy;

          ARange.Paste; // ��������� ��������� ������������ ����
          ARange.Bookmarks.Add(ABookmarkData.BookmarkName, ARange);
          // ������ ����� ��������

          // �������� ����� ��������
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

procedure TUMKMaster.����������������(ABookmarkData: TBookMarkData);
var
  ANotifyEventWrap: TNotifyEventWrap;
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  AUMKDM: TUMKDM;
  TemplateFileName: string;
begin
  TemplateFileName := TPath.Combine(ExtractFilePath(ParamStr(0)),
    LanguageConstants.TLangConst.����������������������);

  // ������ ��� ���� ����� ������ ������ ��� UMK
  AUMKDM := TUMKDM.Create(Self);
  try
    // ������������� �� �������
    ANotifyEventWrap := TNotifyEventWrap.Create(AUMKDM.OnBookmark,
      DisciplineCompetence.OnBookmark);
    try
      ARange := ABookmarkData.B.Range;
      // ��������� ������� ��������
      AStart := ARange.Start;

      SelectedStudyPlanForUMK.First;
      // while not SelectedStudyPlanForUMK.Eof do
      // begin
      AUMKDM.PrepareReport(TemplateFileName);
      try

        AUMKDM.WA.Selection.WholeStory;
        AUMKDM.WA.Selection.Copy;

        ARange.Paste; // ��������� ����� �����������
        ARange.Bookmarks.Add(ABookmarkData.BookmarkName, ARange);
        // ������ ����� ��������

        // �������� ����� ��������
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
      // ������������ �� �������
      FreeAndNil(ANotifyEventWrap);
    end;
  finally
    FreeAndNil(AUMKDM);
  end;

end;

procedure TUMKMaster.�������������������������(ABookmarkData: TBookMarkData);
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
      (TLangConst.������������������������������������������);

  // �������� ������ ������� �� ��������
  T := ABookmarkData.B.Range.Tables.Item(1);
  Assert(T <> nil);
  AWordTable := TWordTable.Create(T);
  try
    // �������� ������ ���������� ����� ���������� ���������
    AIDDiscipline := SelectedStudyPlanForUMK.FieldByName('ID_Discipline')
      .AsInteger;
    // �������� ���. ���� �� ���� ����������
    AETP := ETPDictonary[AIDDiscipline];

    AThemeUnionRecNo := 0;

    // ������ ����� - ��������� ������ �� ������ �������
    AClone := AETP.ThemeUnions.CreateNonEmptyClone;
    try
      AClone.First;
      while not AClone.Eof do
      begin
        Inc(AThemeUnionRecNo);
        // ����������� ����� �������

        // ��������� ����� ������ � ����� �������
        T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

        // ����� �������
        AWordTable.SetText(T.Rows.Count, 1, Format('%d', [AThemeUnionRecNo]),
          TLangConst.�����������������);

        // ���� ������� ������
        AWordTable.SetText(T.Rows.Count, 2,
          AETP.ThemeUnionEducationalWorks.ToString
          (AClone.FieldByName('ID_ThemeUnion').AsInteger),
          TLangConst.�����������������);

        // ��������������� ����������
        AWordTable.SetText(T.Rows.Count, 3,
          AETP.THEMEUNIONTECHNOLOGIES.ToString
          (AClone.FieldByName('ID_ThemeUnion').AsInteger),
          TLangConst.�����������������);

        // ����������� ���������� �������
        AWordTable.SetText(T.Rows.Count, 4,
          AETP.ThemeUnionLessonTheatures.ToString
          (AClone.FieldByName('ID_ThemeUnion').AsInteger),
          TLangConst.�����������������);

        AClone.Next;
      end;
    finally
      FreeAndNil(AClone);
    end;
  finally
    FreeAndNil(AWordTable);
  end;
end;

procedure TUMKMaster.��(ABookmarkData: TBookMarkData);
var
  AWordTable: TWordTable;
  T: Table;
  x: Integer;
  y: Integer;
begin
  if ABookmarkData.B.Range.Tables.Count = 0 then
    raise Exception.Create(TLangConst.��������������������);

  // �������� ������ ������� �� ��������
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
      // ��������� ����� ������ � ����� �������
      T.Cell(x, y).Range.Rows.Add(EmptyParam);

      // ��������� ��� � �������� �����������
      AWordTable.SetText(T.Rows.Count, 1, DisciplineSoft.SoftwareName.AsString,
        TLangConst.�����������������);

      DisciplineSoft.DS.Next;
    end;
  finally
    FreeAndNil(AWordTable);
    DisciplineSoft.Wrap.MyBookmark.Restore;
  end;
end;

procedure TUMKMaster.������������������������(ABookmarkData: TBookMarkData);
var
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  ABookmarkName: string;
  �������������������������: Style;
begin
  if FPreviousDisciplines.DS.RecordCount = 0 then
    Exit;

  ������������������������� := ABookmarkData.Document.Styles.Item
    ('����� �������������� ������');
  Assert(������������������������� <> nil);

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
    ARange.Set_Style(�������������������������);
    ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
    FPreviousDisciplines.DS.Next;
  end;

  ARange := ABookmarkData.Document.Range(AStart, ARange.End_);
  ARange2 := ARange;
  ARange.Bookmarks.Add(ABookmarkName, ARange2);
end;

procedure TUMKMaster.�������������������(ABookmarkData: TBookMarkData);
var
  ACompetence: TCompetence;
  T: Table;
  x: Integer;
  y: Integer;
begin
  if ABookmarkData.B.Range.Tables.Count = 0 then
    raise Exception.Create(TLangConst.������������������������������������);

  // �������� ������ ������� �� ��������
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
      // ��������� ����� ������ � ����� �������
      T.Cell(x, y).Range.Rows.Add(EmptyParam);

      // ��������� ��� � �������� �����������
      T.Cell(T.Rows.Count, 1).Range.Text :=
        Format('%s %s', [ACompetence.Field('Code').AsString,
        ACompetence.Field('Description').AsString]);

      ACompetence.DS.Next;
    end;
  finally
    ACompetence.Wrap.MyBookmark.Restore;
  end;
end;

procedure TUMKMaster.���������������������(ABookmarkData: TBookMarkData);
var
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  ABookmarkName: string;
  �������������������������: Style;
begin
  if FSubsequentDisciplines.DS.RecordCount = 0 then
    Exit;

  ������������������������� := ABookmarkData.Document.Styles.Item
    ('����� �������������� ������');
  Assert(������������������������� <> nil);

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
    ARange.Set_Style(�������������������������);
    ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
    FSubsequentDisciplines.DS.Next;
  end;

  ARange := ABookmarkData.Document.Range(AStart, ARange.End_);
  ARange2 := ARange;
  ARange.Bookmarks.Add(ABookmarkName, ARange2);
end;

end.
