unit SPUnit;

interface

uses KDBClient, EssenceEx, DocumentView, K_Params, SS, LessonTypes,
  NotifyEvents, CSE, SpecEducation, DisciplineNames,
  DBRecordHolder, SQLTools, KParamsCollection, Chairs, HourViewTypes,
  Winapi.Windows, Winapi.Messages, System.Classes, Data.DB,
  System.Generics.Collections;

const
  WM_AttachViews = WM_USER + 125;

type
  TStudyPlanCDS = class(TKClientDataSet)
  private
    FCheckedOnly: Boolean;
    FIDDisciplineName: Integer;
    FSpecialitySessions: TDataSet;
    FSumFields: TDictionary<Integer, String>;
    function GetAudSum: TField;
    function GetLabSum: TField;
    function GetLecSum: TField;
    function GetSemSum: TField;
    function GetCurrentRecordIsCategory: Boolean;
    function GetID_StudyPlan: TField;
    function GetLabWorks: TField;
    function GetLectures: TField;
    function GetSelfSum: TField;
    function GetAllSelf: TField;
    function GetAutoSelfHours: TField;
    function GetControlPointSum: TField;
    function GetSeminars: TField;
    function GetTotal: TField;
    procedure SetCheckedOnly(const Value: Boolean);
  protected
    procedure RecreateDataSet(ASpecialitySessions, ALessonTypes: TDataSet);
  public
    property AudSum: TField read GetAudSum;
    property LabSum: TField read GetLabSum;
    property LecSum: TField read GetLecSum;
    property SemSum: TField read GetSemSum;
    property CheckedOnly: Boolean read FCheckedOnly write SetCheckedOnly;
    property CurrentRecordIsCategory: Boolean read GetCurrentRecordIsCategory;
    property ID_StudyPlan: TField read GetID_StudyPlan;
    property LabWorks: TField read GetLabWorks;
    property Lectures: TField read GetLectures;
    property SelfSum: TField read GetSelfSum;
    property AllSelf: TField read GetAllSelf;
    property AutoSelfHours: TField read GetAutoSelfHours;
    property ControlPointSum: TField read GetControlPointSum;
    property Seminars: TField read GetSeminars;
    property SpecialitySessions: TDataSet read FSpecialitySessions;
    property Total: TField read GetTotal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function encodeFieldName(AFieldName: string;
      var ALessonType, ALevel, ASession: Integer): Boolean;
    function getFieldName(ALessonType, ALevel, ASessionInLevel
      : Integer): string;
    procedure LocateToLastDiscipline;
    procedure SaveCurrentDiscipline;
    procedure SetCheched(AIDDisciplineNameList: TStringList);
    procedure UpdateCode;
  end;

  // TSPViewType = (spCredits = 0, spHour = 1);

  TStudyPlanQuery = class(TEssenceEx2)
  private
    FCycleSpecialityEducationParam: T_KInParam;
    FIDSpecialityEducationParam: T_KParam;
    FSQLRefreshOperator: TSQLSelectOperator;
  protected
  public
    property CycleSpecialityEducationParam: T_KInParam
      read FCycleSpecialityEducationParam;
    property IDSpecialityEducationParam: T_KParam
      read FIDSpecialityEducationParam;
    property SQLRefreshOperator: TSQLSelectOperator read FSQLRefreshOperator;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TStudyPlanQueryRefresh = class;

  TStudyPlan = class(TDocument)
  private
    FAfterEditEvent: TNotifyEventWrap;
    FBeforePostEvent: TNotifyEventWrap;
    FAfterInsertEvent: TNotifyEventWrap;
    FBeforeDeleteEvent: TNotifyEventWrap;
    FChairs: TChairs;
    FCSE: TCSE;
    FDetailCSE: TCSE;
    // FMasterCSE: TCSE;
    FDisciplineNames: TDisciplineNames;
    FFields: TList<String>;
    // FHourViewTypes: THourViewTypes;
    // FDisciplineTypes: TDisciplineTypes;
    FLessonTypes: TLessonTypes;
    FMultiSelect: Boolean;
    FOnEditEvents: TNotifyEvents;
    FRecordHolder: TRecordHolder;
    FSpecialitySessions: TSpecialitySessions;
    FStudyPlanCDS: TStudyPlanCDS;
    FStudyPlanQuery: TStudyPlanQuery;
    FStudyPlanQueryRefresh: TStudyPlanQueryRefresh;
    FWindowHandle: HWND;
    procedure BeforeStudyPlanCDSDelete(Sender: TObject);
    procedure DeleteFromStudyPlan(AIDStudyPlan: Integer);
    function GetIDSpecEducation: Integer;
    procedure RefreshSelfHours;
    procedure UpdateStudyPlan;
    procedure WndProc(var Msg: TMessage);
    // property DetailCSE: TCSE read FDetailCSE;
  protected
    procedure AfterStudyPlanCDSInsert(Sender: TObject);
    procedure AfterStudyPlanCDSEdit(Sender: TObject);
    procedure BeforeStudyPlanCDSPost(Sender: TObject);
    procedure OnLessonTypeFieldGetText(AField: TField; var Text: string;
      DisplayText: Boolean);
    procedure OnLessonTypeFieldSetText(AField: TField; const Text: string);
    procedure OnSpecialitySessionsQueryChange(Sender: TObject);
    procedure OnStudyPlanQueryChange(Sender: TObject);
    procedure UpdateLessonType(AFieldName: string;
      AOldValue, ANewValue: Variant);
  public
    property Chairs: TChairs read FChairs;
    property LessonTypes: TLessonTypes read FLessonTypes;
    property SpecialitySessions: TSpecialitySessions read FSpecialitySessions;
    property StudyPlanCDS: TStudyPlanCDS read FStudyPlanCDS;
    property StudyPlanQuery: TStudyPlanQuery read FStudyPlanQuery;
    property CSE: TCSE read FCSE;
    // property MasterCSE: TCSE read FMasterCSE;
    property DisciplineNames: TDisciplineNames read FDisciplineNames;
    property IDSpecEducation: Integer read GetIDSpecEducation;
    // property HourViewTypes: THourViewTypes read FHourViewTypes;
    // property DisciplineTypes: TDisciplineTypes read FDisciplineTypes;
    property MultiSelect: Boolean read FMultiSelect write FMultiSelect;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    procedure DoOnMasterChange(AIDSpecialityEducation, AIDEducation,
        AIDEDUCATIONLEVEL: Integer);
    procedure Refresh;
  end;

  TStudyPlanQueryRefresh = class(TEssenceEx)
  private
    FCycleSpecialityEducationParam: T_KParam;
    // FDisciplineTypeParam: T_KParam;
    FDisciplineNameParam: T_KParam;
    FStudyPlanQuery: TStudyPlanQuery;
  public
    constructor Create(AOwner: TStudyPlanQuery); reintroduce;
    property CycleSpecialityEducationParam: T_KParam
      read FCycleSpecialityEducationParam;
    // property DisciplineTypeParam: T_KParam read FDisciplineTypeParam;
    property DisciplineNameParam: T_KParam read FDisciplineNameParam;
  end;

implementation

uses DBClient, DateUtils, MyDataAccess, Variants, SqlExpr, Essence,
  StrUtils, CommissionOptions, System.SysUtils;

constructor TStudyPlanQuery.Create(AOwner: TComponent);
var
  i: Integer;
  // V: Variant;
begin
  inherited;
  FSQLRefreshOperator := TSQLSelectOperator.Create();

  with FSQLSelectOperator do
  begin
    Clear;
    Pragma := '/*+ LEADING(cse) INDEX(cse) ' + ' USE_NL(cse, sp) INDEX(sp) ' +
      ' USE_NL(cse, cy) INDEX(cy) ' + ' USE_NL(sp, p)   INDEX(p) ' +
      ' USE_NL(sp, dn) INDEX(dn) ' + ' USE_NL(sp, ct) INDEX(ct) ' +
      ' USE_NL(sp, lt) INDEX(lt) ' + ' USE_NL(lt, ss) INDEX(ss) ' + '*/';

    Fields.Add('sp.id_studyplan');
    Fields.Add('-sp.id_studyplan id_cyclespecialityeducation');
    Fields.Add('cse.ORDER_ CSE_ORD');
    Fields.Add
      ('CDB_DAT_STUDY_PROCESS.STUDYPLANPACK.GETSTUDYPLANCODE(sp.id_studyplan) code');

    // Fields.Add('cy.short_cycle');
    // Fields.Add('cse.id_cyclespecialityeducation');
    // Fields.Add('cse.IDParent');
    // Fields.Add('trim(to_char(cse.ORDER_, ''000000'')) || ''-''||cy.cycle cycle');
    // Fields.Add('ct.short_cycletype');
    // Fields.Add('ct.ord cycletype_ord');
    Fields.Add('подр.наименование department');
    Fields.Add('dn.disciplinename');
    Fields.Add('sp.idcyclespecialityeducation');
    Fields.Add('sp.iddisciplinename');

    Fields.Add('cast(sp.total2 as number(9,1)) total2');
    Fields.Add('cast(sp.total as number(9,1)) total');
    Fields.Add('cast(sp.lectures as number(9,1)) lectures');
    Fields.Add('cast(sp.seminars as number(9,1)) seminars');
    Fields.Add('cast(sp.labworks as number(9,1)) labworks');

    Fields.Add('sp.idchair');
    Fields.Add('sp.mark');
    Fields.Add('sp.is_option');
    Fields.Add('sp.position');
    Fields.Add('sp.professional_module');
    Fields.Add('sp.IDHOURVIEWTYPE');
    Fields.Add('sp.AutoSelfHours');
    Fields.Add('cph.hour CONTROLPOINTSHOUR');

    Fields.Add('lt.id_lessontype');
    Fields.Add('lt.idtype');

    Fields.Add('lt.DATA');

    Fields.Add('ss.level_');
    Fields.Add('ss.session_in_level session_');

    Tables.Add('CYCLESPECIALITYEDUCATIONS cse');

    Joins.Add('JOIN studyplans sp');
    Joins.WhereCondition.Add
      ('sp.idcyclespecialityeducation = cse.id_cyclespecialityeducation');

    Joins.Add('join disciplinenames dn');
    Joins.WhereCondition.Add('sp.iddisciplinename = dn.id_disciplinename');

    Joins.Add('join chairs ch');
    Joins.WhereCondition.Add('sp.idchair = ch.id_chair');

    Joins.Add('left join Подразделения подр');
    Joins.WhereCondition.Add
      ('ch.ИдентификаторПодразделения = подр.Идентификатор');

    Joins.Add('left join lessontypes lt');
    Joins.WhereCondition.Add('lt.idstudyplan = sp.id_studyplan');

    Joins.Add('left join cdb_dat_study_process.CONTROLPOINTSHOUR2 cph');
    Joins.WhereCondition.Add
      ('cph.IDEDUCATION = :IDEDUCATION and cph.IDEDUCATIONLEVEL = :IDEDUCATIONLEVEL and cph.IDLESSONTYPE = LT.IDTYPE');

    Joins.Add('left join specialitysessions ss');
    Joins.WhereCondition.Add
      ('lt.idspecialitysession = ss.id_specialitysession');

    OrderClause.Add('sp.id_studyplan'); // Сортируем по коду
    {
      if CycleSpecialityEducationParam <> nil then
      begin
      Params.UpdateSourceSQL;
      BeginUpdate;
      V := CycleSpecialityEducationParam.ParamValue;
      CycleSpecialityEducationParam.ParamValue := '';
      CycleSpecialityEducationParam.ParamValue := V;
      EndUpdate(eukNone);
      end;
    }
    FSQLRefreshOperator.Assign(FSQLSelectOperator);
    FSQLRefreshOperator.OrderClause.Clear;
    FSQLRefreshOperator.Joins.Delete(6);
    FSQLRefreshOperator.Joins.Delete(5);
    FSQLRefreshOperator.Joins.Delete(4);
    for i := 1 to 6 do
    begin
      FSQLRefreshOperator.Fields.Delete(FSQLRefreshOperator.Fields.Count - 1);
    end;
  end;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'sp.ID_StudyPlan';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  FCycleSpecialityEducationParam := T_KInParam.Create(Params,
    'cse.id_cyclespecialityeducation');

  FIDSpecialityEducationParam := T_KParam.Create(Params,
    'cse.idspecialityeducation');
  FIDSpecialityEducationParam.ParamName := 'idspecialityeducation';
end;

constructor TStudyPlan.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // Список полей которые мы будем копировать из запроса в набор данных в памяти
  FFields := TList<String>.Create;
  FFields.Add('id_studyplan');
  FFields.Add('id_cyclespecialityeducation');
  // FFields.Add('CSE_ORD');
  FFields.Add('Code');
  FFields.Add('iddisciplinename');
  FFields.Add('disciplinename');
  FFields.Add('idcyclespecialityeducation');
  FFields.Add('total');
  FFields.Add('total2');
  FFields.Add('lectures');
  FFields.Add('seminars');
  FFields.Add('labworks');
  FFields.Add('idchair');
  FFields.Add('mark');
  FFields.Add('is_option');
  FFields.Add('Position');
  FFields.Add('department');
  FFields.Add('Professional_Module');
  FFields.Add('IDHourViewType');
  FFields.Add('AutoSelfHours');

  FWindowHandle := System.Classes.AllocateHWnd(WndProc);

  FOnEditEvents := TNotifyEvents.Create(Self);

  FStudyPlanCDS := TStudyPlanCDS.Create(Self); // таблица уч. план

  FChairs := TChairs.Create(Self);
  FChairs.Refresh;

  // ********************************************************
  // DetailCSE
  // ********************************************************
  FDetailCSE := TCSE.Create(Self);
  // FDetailCSE.SpecialityEducationParam.Master := FSpecEducation;

  // ********************************************************
  // SpecialitySessions
  // ********************************************************
  FSpecialitySessions := TSpecialitySessions.Create(Self); // сессии
  // FSpecialitySessions.SpecialityEducationParam.Master := FSpecEducation;

  // ********************************************************
  // StudyPlanQuery
  // ********************************************************
  FStudyPlanQuery := TStudyPlanQuery.Create(Self); // запрос уч. план
  // FStudyPlanQuery.IDSpecialityEducationParam.Master := FSpecEducation;

  TNotifyEventWrap.Create(FStudyPlanQuery.AfterRefreshDataSet,
    OnStudyPlanQueryChange);
  FStudyPlanQueryRefresh := TStudyPlanQueryRefresh.Create(FStudyPlanQuery);

  // ********************************************************
  // CSE
  // ********************************************************
  FCSE := TCSE.Create(Self);
  FCSE.DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;
  // FCSE.SpecialityEducationParam.Master := FSpecEducation;

  // Реагируем на изменение структуры учебного плана
  TNotifyEventWrap.Create(FCSE.Wrap.AfterPost, OnStudyPlanQueryChange);
  TNotifyEventWrap.Create(FCSE.Wrap.AfterDelete, OnStudyPlanQueryChange);

  FLessonTypes := TLessonTypes.Create(Self); // Типы занятий
  FLessonTypes.Refresh;

  FDisciplineNames := TDisciplineNamesForStudyPlans.Create(Self);

  FRecordHolder := TRecordHolder.Create();

  (*
    // Открываем запросы
    FCSE.Refresh;
    FDetailCSE.Refresh;
    FSpecialitySessions.Refresh;
    FStudyPlanQuery.Refresh;
  *)
end;

destructor TStudyPlan.Destroy;
begin
  FreeAndNil(FFields);
  FreeAndNil(FRecordHolder);
  inherited;
  FreeAndNil(FOnEditEvents);
end;

procedure TStudyPlan.AfterStudyPlanCDSInsert(Sender: TObject);
begin
  FRecordHolder.Attach(StudyPlanCDS); // Запоминаем поля до редактирования
end;

procedure TStudyPlan.AfterStudyPlanCDSEdit(Sender: TObject);
begin
  FRecordHolder.Attach(StudyPlanCDS); // Запоминаем поля до редактирования
end;

procedure TStudyPlan.BeforeStudyPlanCDSDelete(Sender: TObject);
begin
  if (StudyPlanCDS.RecordCount > 0) and
    (StudyPlanCDS.FieldByName('ID_STUDYPLAN').AsInteger > 0) then
    DeleteFromStudyPlan(StudyPlanCDS.FieldByName('ID_STUDYPLAN').AsInteger);
end;

procedure TStudyPlan.BeforeStudyPlanCDSPost(Sender: TObject);
begin
  UpdateStudyPlan;
end;

procedure TStudyPlan.DeleteFromStudyPlan(AIDStudyPlan: Integer);
var
  ASQLQuery: TMySQLQuery;
begin
  ASQLQuery := TMySQLQuery.Create(nil, 0);
  try
    with ASQLQuery do
    begin
      SQL.Add('delete from STUDYPLANS');
      SQL.Add(Format('where id_studyplan=%d', [AIDStudyPlan]));
      ExecSQL();
    end;
  finally
    FreeAndNil(ASQLQuery);
  end;
end;

procedure TStudyPlan.DoOnMasterChange(AIDSpecialityEducation, AIDEducation,
    AIDEDUCATIONLEVEL: Integer);
begin
//  Assert(AIDSpecialityEducation > 0);
//  Assert(AIDEducation > 0);
//  Assert(AIDEDUCATIONLEVEL > 0);

  FCSE.BeginUpdate;
  FCSE.SpecialityEducationParam.ParamValue := AIDSpecialityEducation;
  FCSE.EndUpdate;

  FDetailCSE.BeginUpdate;
  FDetailCSE.SpecialityEducationParam.ParamValue := AIDSpecialityEducation;
  FDetailCSE.EndUpdate;

  FSpecialitySessions.BeginUpdate;
  FSpecialitySessions.SpecialityEducationParam.ParamValue :=
    AIDSpecialityEducation;
  FSpecialitySessions.EndUpdate;

  FStudyPlanQuery.BeginUpdate;
  FStudyPlanQuery.MySQLQuery.ParamByName('IDEDUCATION').AsInteger :=
    AIDEducation;
  FStudyPlanQuery.MySQLQuery.ParamByName('IDEDUCATIONLEVEL').AsInteger :=
    AIDEDUCATIONLEVEL;
  FStudyPlanQuery.IDSpecialityEducationParam.ParamValue :=
    AIDSpecialityEducation;
  FStudyPlanQuery.EndUpdate;
end;

function TStudyPlan.GetIDSpecEducation: Integer;
begin
  Result := SpecialitySessions.SpecialityEducationParam.ParamValue;
end;

procedure TStudyPlan.OnLessonTypeFieldGetText(AField: TField; var Text: string;
  DisplayText: Boolean);
begin
  inherited;
  if AField.Value = 0 then
    Text := ''
  else
    Text := AField.AsString;
end;

procedure TStudyPlan.OnLessonTypeFieldSetText(AField: TField;
  const Text: string);
begin
  UpdateLessonType(AField.FieldName, AField.Value, Text);

  AField.AsString := Text;
end;

// Изменились данные о сессиях учебного плана
// Будем заново создавать структуру ClientDataSet

procedure TStudyPlan.OnSpecialitySessionsQueryChange(Sender: TObject);
begin
  if not FSpecialitySessions.DS.Active then
    Exit;
  (*
    FStudyPlanCDS.Wrap.DetachViews;
    // Отсоединяем представления от документа чтобы не тормозило

    // Изменился набор студентов. Надо пересоздать поля для представления
    FStudyPlanCDS.RecreateDataSet(FSpecialitySessions.DS, FLessonTypes.DS);
  *)
end;

// Обновился результат запроса, выбирающего данные для учебного плана
// Будем заново копировать все записи

procedure TStudyPlan.OnStudyPlanQueryChange(Sender: TObject);
var
  ASPDataSet: TDataSet;
  AIDStudyPlan: Integer;
  ASpecialitySessions: TDataSet;
  ALessonTypes: TDataSet;
  AFieldName: string;
  F: TField;

  ADataValue: Integer;
  AIDType: Integer;
  CycleValues: string;
  i: Integer;
  S: string;

begin
  FStudyPlanCDS.Wrap.DetachViews;
  // Отсоединяем представления от документа чтобы не тормозило
  try
    FStudyPlanCDS.SaveCurrentDiscipline;

    // Изменился набор студентов. Надо пересоздать поля для представления
    FStudyPlanCDS.RecreateDataSet(FSpecialitySessions.DS, FLessonTypes.DS);

    ASpecialitySessions := FSpecialitySessions.DataSetWrap.DataSet;
    ALessonTypes := FLessonTypes.DataSetWrap.DataSet;

    ASpecialitySessions.First;
    while not ASpecialitySessions.Eof do // цикл по сессиям
    begin
      ALessonTypes.First;
      while not ALessonTypes.Eof do
      begin
        AFieldName := FStudyPlanCDS.getFieldName
          (ALessonTypes.FieldByName('ID_DisciplineType').AsInteger,
          ASpecialitySessions.FieldByName('Level_').AsInteger,
          ASpecialitySessions.FieldByName('Session_in_level').AsInteger);

        F := FStudyPlanCDS.FindField(AFieldName);
        if Assigned(F) then
        begin
          F.OnSetText := nil;
          F.OnChange := nil;
          F.OnGetText := nil;
        end;

        ALessonTypes.Next;
      end;
      ASpecialitySessions.Next;
    end;

    FreeAndNil(FBeforePostEvent);
    FreeAndNil(FAfterInsertEvent);
    FreeAndNil(FAfterEditEvent);
    FreeAndNil(FBeforeDeleteEvent);

    FStudyPlanCDS.Wrap.DisableEvents := True; // Отключаем все события
    try
      FStudyPlanCDS.Wrap.MyBookmark.Save('id_studyplan', False, True);

      try
        // делаем все поля доступными для изменения
        FStudyPlanCDS.Wrap.SetFieldsReadOnly(False);
        FStudyPlanCDS.EmptyDataSet; // Очищаем всё

        ASPDataSet := FStudyPlanQuery.DataSetWrap.DataSet;
        ASPDataSet.First;
        while not ASPDataSet.Eof do
        begin
          with FStudyPlanCDS do
          begin
            AIDStudyPlan := ASPDataSet.FieldByName('id_studyplan').AsInteger;

            if ID_StudyPlan.AsInteger <> AIDStudyPlan then
            begin
              Append; // Добавляем новую запись
              // Копируем значения общих полей из запроса
              for S in FFields do
              begin
                FieldByName(S).Value := ASPDataSet.FieldByName(S).Value;
              end;
              // Дисциплины должны при сортировке быть перед циклами
              FieldByName('CSE_ORD').Value := -1;
              // общее число ауд. занятий
              AudSum.AsInteger := Lectures.AsInteger + Seminars.AsInteger +
                LabWorks.AsInteger;
            end
            else
              Edit;

            ControlPointSum.AsInteger := ControlPointSum.AsInteger +
              ASPDataSet.FieldByName('ControlPointsHour').AsInteger;

            // общее число сам работ
            AllSelf.AsInteger := Total.AsInteger - AudSum.AsInteger -
              ControlPointSum.AsInteger;

            AIDType := ASPDataSet.FieldByName('IDTYPE').AsInteger;
            if AIDType > 0 then
            begin
              // Заполняем план по семестрам
              AFieldName := getFieldName(AIDType,
                ASPDataSet.FieldByName('LEVEL_').AsInteger,
                ASPDataSet.FieldByName('SESSION_').AsInteger);

              ADataValue := ASPDataSet.FieldByName('DATA').AsInteger;

              FieldByName(AFieldName).Value := ADataValue;

              // Если это поле участвует в сумме
              if FSumFields.ContainsKey(AIDType) then
              begin
                S := FSumFields[AIDType];
                // Добавляем число часов к нужной нам сумме
                FieldByName(S).AsInteger := FieldByName(S).AsInteger +
                  ADataValue;
              end;
            end;
            Post;
          end;
          ASPDataSet.Next;
        end;

        i := 0;
        while True do
        begin
          if i = 0 then
            // Ищем циклы 0-го уровня
            FDetailCSE.ParentParam.ParamValue := NULL
          else
          begin
            // Ищем циклы первого, второго и т.д. уровня
            CycleValues := FDetailCSE.Wrap.GetColumnValues
              ('id_cyclespecialityeducation');
            FDetailCSE.ParentParam.ParamValue := CycleValues;
          end;
          Inc(i);

          FDetailCSE.Refresh;
          if FDetailCSE.DS.RecordCount = 0 then
            // Если нет больше дочерних уровней
            break;

          FDetailCSE.DS.First;
          while not FDetailCSE.DS.Eof do
          begin

            with FStudyPlanCDS do
            begin
              Append;
              FieldByName('id_studyplan').AsInteger := -1;
              FieldByName('id_cyclespecialityeducation').AsInteger :=
                FDetailCSE.DS.FieldByName('id_cyclespecialityeducation')
                .AsInteger;
              FieldByName('idcyclespecialityeducation').AsInteger :=
                FDetailCSE.DS.FieldByName('idcyclespecialityeducation')
                .AsInteger;;
              FieldByName('CSE_ORD').AsInteger :=
                FDetailCSE.DS.FieldByName('order_').AsInteger;
              FieldByName('Position').AsInteger := 0;
              // В качестве кода будем использовать короткое название цикла
              FieldByName('Code').AsString :=
                FDetailCSE.DS.FieldByName('short_cycle').AsString;
              FieldByName('DisciplineName').AsString :=
                FDetailCSE.DS.FieldByName('cycle').AsString;

              Post;

              FDetailCSE.DS.Next;
            end;
          end;
        end;

        // Если доступ на запись не нужен
        if StudyProcessOptions.AccessLevel >= 20 then
        begin
          // Делаем все поля доступными только для чтения
          FStudyPlanCDS.Wrap.SetFieldsReadOnly(True);
          FStudyPlanCDS.FieldByName('Checked').ReadOnly := False;
        end;
      finally
        FStudyPlanCDS.Wrap.MyBookmark.Restore;
      end;
    finally
      FStudyPlanCDS.Wrap.DisableEvents := False; // Включаем все события
    end;

    // Подписываемся на событие BeforePost
    FBeforePostEvent := TNotifyEventWrap.Create(FStudyPlanCDS.Wrap.BeforePost,
      BeforeStudyPlanCDSPost);

    // Подписываемся на событие AfterInsert
    FAfterInsertEvent := TNotifyEventWrap.Create(FStudyPlanCDS.Wrap.AfterInsert,
      AfterStudyPlanCDSInsert);
    FAfterInsertEvent.Index := 0; // Хотим первыми получать это событие

    // Подписываемся на событие AfterEdit;
    FAfterEditEvent := TNotifyEventWrap.Create(FStudyPlanCDS.Wrap.AfterEdit,
      AfterStudyPlanCDSEdit);

    // Подписываем на событие BeforeDelete
    FBeforeDeleteEvent := TNotifyEventWrap.Create
      (FStudyPlanCDS.Wrap.BeforeDelete, BeforeStudyPlanCDSDelete);

    ASpecialitySessions.First;
    while not ASpecialitySessions.Eof do // цикл по сессиям
    begin
      ALessonTypes.First;
      while not ALessonTypes.Eof do
      begin
        AIDType := ALessonTypes.FieldByName('ID_DisciplineType').AsInteger;
        AFieldName := FStudyPlanCDS.getFieldName(AIDType,
          ASpecialitySessions.FieldByName('Level_').AsInteger,
          ASpecialitySessions.FieldByName('Session_in_level').AsInteger);

        FStudyPlanCDS.FieldByName(AFieldName).OnSetText :=
          OnLessonTypeFieldSetText;
        FStudyPlanCDS.FieldByName(AFieldName).OnGetText :=
          OnLessonTypeFieldGetText;

        ALessonTypes.Next;
      end;
      ASpecialitySessions.Next;
    end;

    // FStudyPlanCDS.IndexFieldNames := 'cse_ord;cycletype_ord;position;disciplinename';
    FStudyPlanCDS.IndexFieldNames := 'cse_ord;position;disciplinename';
  finally
    // Будем присоединять представление к документу чуть позже
    PostMessage(FWindowHandle, WM_AttachViews, 0, 0);
    // FStudyPlanCDS.Wrap.AttachViews; // Присоединяем представления к документу
  end;

  // FStudyPlanCDS.LocateToLastDiscipline;
end;

procedure TStudyPlan.Refresh;
begin
  OnStudyPlanQueryChange(Self);
end;

procedure TStudyPlan.RefreshSelfHours;
var
  ASQLQuery: TMySQLQuery;
  AFieldName: string;
begin
  ASQLQuery := TMySQLQuery.Create(Self, 0);
  try

    // Нужно обновить часы для сам работы
    with ASQLQuery.SQL do
    begin
      Clear;
      Add('select lt.data, ss.level_, ss.session_in_level');
      Add('from lessontypes lt');
      Add('join specialitysessions ss on LT.IDSPECIALITYSESSION = SS.ID_SPECIALITYSESSION');
      Add('where lt.idstudyplan = :idstudyplan and LT.IDTYPE = :idtype');
    end;

    with ASQLQuery do
    begin
      Params.ParamByName('idstudyplan').Value :=
        FStudyPlanCDS.ID_StudyPlan.Value;
      Params.ParamByName('idtype').Value := 22; // сам. раб.
    end;

    ASQLQuery.Open(); // Выполняем запрос
    while not ASQLQuery.Eof do
    begin
      AFieldName := FStudyPlanCDS.getFieldName(22,
        ASQLQuery.FieldByName('level_').AsInteger,
        ASQLQuery.FieldByName('session_in_level').AsInteger);

      FStudyPlanCDS.FieldByName(AFieldName).Value :=
        ASQLQuery.FieldByName('Data').Value;

      ASQLQuery.Next;
    end;
  finally
    FreeAndNil(ASQLQuery);
  end;
end;

procedure TStudyPlan.UpdateLessonType(AFieldName: string;
  AOldValue, ANewValue: Variant);
var
  ALessonType: Integer;
  ALevel: Integer;
  ASessionInLevel: Integer;
  OldValue: Integer;
  NewValue: Integer;
  ASQLQuery: TMySQLQuery;
  AIDSpecialityEducation: Integer;
  ANewValueStr: string;
  AFormatSettings: TFormatSettings;
  S: string;
begin
  AIDSpecialityEducation := FSpecialitySessions.SpecialityEducationParam.
    ParamValue;

  // Получаем тип занятия, курс и номер сессии в курсе
  FStudyPlanCDS.encodeFieldName(AFieldName, ALessonType, ALevel,
    ASessionInLevel);

  if ANewValue <> NULL then
    NewValue := ANewValue
  else
    NewValue := 0;

  if AOldValue <> NULL then
    OldValue := AOldValue
  else
    OldValue := 0;

  if pos(',', ANewValue) > 0 then
  begin
    AFormatSettings.DecimalSeparator := '.';
    ANewValueStr := FloatToStr(ANewValue, AFormatSettings)
  end
  else
    ANewValueStr := VarToStr(ANewValue);

  ASQLQuery := TMySQLQuery.Create(nil, 0);
  try
    // Небыло, но добавили
    if (NewValue <> 0) and (OldValue = 0) then
      with ASQLQuery.SQL, FStudyPlanCDS do
      begin
        Add('Insert into LessonTypes');
        Add('(IDSTUDYPLAN, IDTYPE, DATA, IDSPECIALITYSESSION)');
        Add('values (');
        Add(ID_StudyPlan.AsString + ',');
        Add(IntToStr(ALessonType) + ',');
        Add(VarToStr(ANewValue) + ',');
        Add('(');
        Add('select ID_SPECIALITYSESSION');
        Add('from SPECIALITYSESSIONS');
        Add('where');
        Add('level_=' + IntToStr(ALevel) + ' and ');
        Add('IDSpecialityEducation = ' + IntToStr(AIDSpecialityEducation)
          + ' and ');
        Add('SESSION_IN_LEVEL = ' + IntToStr(ASessionInLevel));
        Add('))');
      end;

    // Было, но удалили
    if (OldValue <> 0) and (NewValue = 0) then
      with ASQLQuery.SQL, FStudyPlanCDS do
      begin
        Add('delete from lessontypes');
        Add('where id_lessontype = ');
        Add('( select /*+RULE*/ id_lessontype');
        Add('from lessontypes lt,');
        Add('SPECIALITYSESSIONS ss');
        Add('where');
        Add('idstudyplan=' + ID_StudyPlan.AsString + ' and');
        Add('idtype=' + IntToStr(ALessonType) + ' and');
        Add('lt.idspecialitysession = ss.ID_SPECIALITYSESSION and');
        Add('ss.level_=' + IntToStr(ALevel) + ' and ');
        Add('ss.idspecialityeducation = ' + IntToStr(AIDSpecialityEducation)
          + ' and ');
        Add('ss.SESSION_IN_LEVEL=' + IntToStr(ASessionInLevel));
        Add(')');
      end;

    // Было, изменили, но не удалили
    if (OldValue <> NewValue) and (OldValue <> 0) and (NewValue <> 0) then
      with ASQLQuery.SQL, FStudyPlanCDS do
      begin
        Add('update lessontypes');
        Add('set DATA = ' + ANewValueStr);
        Add('where id_lessontype = ');
        Add('( select id_lessontype');
        Add('from lessontypes lt,');
        Add('SPECIALITYSESSIONS ss');
        Add('where');
        Add('idstudyplan = ' + ID_StudyPlan.AsString + ' and');
        Add('idtype=' + IntToStr(ALessonType) + ' and');
        Add('lt.idspecialitysession=ss.ID_SPECIALITYSESSION and');
        Add('ss.level_=' + IntToStr(ALevel) + ' and ');
        Add('ss.idspecialityeducation = ' + IntToStr(AIDSpecialityEducation)
          + ' and ');
        Add('ss.SESSION_IN_LEVEL=' + IntToStr(ASessionInLevel));
        Add(')');
      end;

    if ASQLQuery.SQL.Count > 0 then
    begin
      ASQLQuery.ExecSQL(); // Выполняем запрос

      with FStudyPlanCDS do
      begin
        // Если изменилось то поле, которое участвует в сумме
        if FSumFields.ContainsKey(ALessonType) then
        begin
          S := FSumFields[ALessonType];
          FieldByName(S).AsInteger := FieldByName(S).AsInteger + NewValue
            - OldValue;
        end;
      end;
      RefreshSelfHours;
    end;
  finally
    FreeAndNil(ASQLQuery);
  end;
end;

procedure TStudyPlan.UpdateStudyPlan;
var
  ASQLQuery: TMySQLQuery;
  ASQLInsertRecord: TSQLInsertRecord;
  AFieldList: TStringList;
  i: Integer;
  ASQLUpdateOperator: TSQLUpdateOperator;
  ASQL: string;
  F: TField;
  ATableName: string;
  NeedRefresh: Boolean;
begin
  if FStudyPlanCDS.FieldByName('id_studyplan').AsInteger = -1 then
    Exit; // Изменилась запись о цикле!

  NeedRefresh := False;
  ASQL := '';
  ATableName := 'STUDYPLANS';

  AFieldList := TStringList.Create;
  try
    AFieldList.Add('IDCYCLESPECIALITYEDUCATION');
    AFieldList.Add('IDDISCIPLINENAME');
    AFieldList.Add('TOTAL');
    AFieldList.Add('TOTAL2');
    AFieldList.Add('LECTURES');
    AFieldList.Add('SEMINARS');
    AFieldList.Add('LABWORKS');
    AFieldList.Add('IDCHAIR');
    AFieldList.Add('MARK');
    AFieldList.Add('IS_OPTION');
    AFieldList.Add('POSITION');
    AFieldList.Add('PROFESSIONAL_MODULE');
    AFieldList.Add('IDHOURVIEWTYPE');
    AFieldList.Add('AutoSelfHours');

    if FStudyPlanCDS.FieldByName('id_studyplan').AsInteger = 0 then
    begin
      NeedRefresh := True;
      ASQLInsertRecord := TSQLInsertRecord.Create(ATableName);
      try
        for i := 0 to AFieldList.Count - 1 do
        begin
          if not VarIsNull(FStudyPlanCDS[AFieldList[i]]) then
            TFieldValue.Create(ASQLInsertRecord.FieldValues, AFieldList[i],
              FStudyPlanCDS[AFieldList[i]]);
        end;
        ASQL := ASQLInsertRecord.SQL;
      finally
        FreeAndNil(ASQLInsertRecord);
      end;
    end
    else
    begin
      ASQLUpdateOperator := TSQLUpdateOperator.Create(ATableName);
      try
        for i := 0 to AFieldList.Count - 1 do
        begin
          if FRecordHolder.Field[AFieldList[i]] <> FStudyPlanCDS.FieldByName
            (AFieldList[i]).NewValue then
          begin
            TFieldValue.Create(ASQLUpdateOperator.FieldValues, AFieldList[i],
              FStudyPlanCDS[AFieldList[i]]);
            NeedRefresh := pos('ID', AFieldList[i]) = 1;
          end;
        end;
        ASQLUpdateOperator.WhereClause.Add(Format('id_studyplan=%d',
          [FStudyPlanCDS.FieldByName('id_studyplan').AsInteger]));
        if ASQLUpdateOperator.FieldValues.Count > 0 then
          ASQL := ASQLUpdateOperator.SQL;
      finally
        FreeAndNil(ASQLUpdateOperator);
      end;
    end;
  finally
    FreeAndNil(AFieldList);
  end;

  if ASQL <> '' then
  begin
    ASQLQuery := TMySQLQuery.Create(nil, 0);
    try
      ASQLQuery.SQL.Add(ASQL);
      with FStudyPlanCDS do
      begin
        ASQLQuery.ExecSQL(False);

        Assert(state in [dsInsert, dsEdit]);

        if NeedRefresh then
        begin
          // Выбираем добавленную запись
          FStudyPlanQueryRefresh.BeginUpdate;
          try
            FStudyPlanQueryRefresh.CycleSpecialityEducationParam.ParamValue :=
              FieldByName('IDCYCLESPECIALITYEDUCATION').AsInteger;
            FStudyPlanQueryRefresh.DisciplineNameParam.ParamValue :=
              FieldByName('IDDISCIPLINENAME').AsInteger;
          finally
            FStudyPlanQueryRefresh.EndUpdate();
          end;
          for i := 0 to FStudyPlanQueryRefresh.DataSetWrap.DataSet.
            FieldCount - 1 do
          begin
            F := FindField(FStudyPlanQueryRefresh.DataSetWrap.DataSet.Fields[i]
              .FieldName);

            if (F <> nil) then
              F.Value := FStudyPlanQueryRefresh.DataSetWrap.DataSet.
                Fields[i].Value;
          end;
        end;

        // Обновляем сумму аудиторных занятий
        AudSum.Value := Lectures.Value + Seminars.Value + LabWorks.Value;
        // Обновляем общее число сам. работ
        AllSelf.Value := Total.Value - AudSum.Value - ControlPointSum.Value;

        // Возможно распределение сам. работ изменилось.
        RefreshSelfHours;

        UpdateCode;
      end;
    finally
      FreeAndNil(ASQLQuery);
    end;
  end;

end;

procedure TStudyPlan.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_AttachViews then
      try
        FStudyPlanCDS.Wrap.AttachViews;
        FStudyPlanCDS.LocateToLastDiscipline;
      except
        ;
      end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

constructor TStudyPlanCDS.Create(AOwner: TComponent);
begin
  inherited;
  FSumFields := TDictionary<Integer, String>.Create;
end;

destructor TStudyPlanCDS.Destroy;
begin
  FreeAndNil(FSumFields);
  inherited;
end;

function TStudyPlanCDS.encodeFieldName(AFieldName: string;
  var ALessonType, ALevel, ASession: Integer): Boolean;
var
  ACount: Integer;
  i: Integer;
  i1, i2: Integer;
  AKeyWordList: TStringList;
  AStart: Integer;
  Number: Integer;
begin
  Result := False;
  AKeyWordList := TStringList.Create;
  try
    AKeyWordList.Add('Type');
    AKeyWordList.Add('Level');
    AKeyWordList.Add('Session');

    for i := 0 to AKeyWordList.Count - 1 do
    begin
      i1 := PosEx(AKeyWordList[i], AFieldName);
      if i1 <= 0 then
        Exit;
      i2 := PosEx('_', AFieldName + '_', i1);
      if i2 <= 0 then
        Exit;

      AStart := i1 + AKeyWordList[i].Length;
      ACount := i2 - AStart;
      Number := StrToInt(AnsiMidStr(AFieldName, AStart, ACount));

      case i of
        0:
          ALessonType := Number;
        1:
          ALevel := Number;
        2:
          ASession := Number;
      else
        Exit;
      end;
    end;

  finally
    FreeAndNil(AKeyWordList);
  end;
  Result := True;
end;

function TStudyPlanCDS.GetAudSum: TField;
begin
  Result := FieldByName('AudSum');
end;

function TStudyPlanCDS.GetLabSum: TField;
begin
  Result := FieldByName('LabSum');
end;

function TStudyPlanCDS.GetLecSum: TField;
begin
  Result := FieldByName('LecSum');
end;

function TStudyPlanCDS.GetSemSum: TField;
begin
  Result := FieldByName('SemSum');
end;

function TStudyPlanCDS.GetCurrentRecordIsCategory: Boolean;
var
  F: TField;
begin
  F := FindField('id_studyplan');
  Result := (F = nil) or (F.AsInteger < 0);
end;

function TStudyPlanCDS.getFieldName(ALessonType, ALevel, ASessionInLevel
  : Integer): string;
begin
  Result := Format('Type%d_Level%d_Session%d',
    [ALessonType, ALevel, ASessionInLevel]);
end;

function TStudyPlanCDS.GetID_StudyPlan: TField;
begin
  Result := FieldByName('ID_StudyPlan');
end;

function TStudyPlanCDS.GetLabWorks: TField;
begin
  Result := FieldByName('LabWorks');
end;

function TStudyPlanCDS.GetLectures: TField;
begin
  Result := FieldByName('Lectures');
end;

function TStudyPlanCDS.GetSelfSum: TField;
begin
  Result := FieldByName('SelfSum');
end;

function TStudyPlanCDS.GetAllSelf: TField;
begin
  Result := FieldByName('Self');
end;

function TStudyPlanCDS.GetAutoSelfHours: TField;
begin
  Result := FieldByName('AutoSelfHours');
end;

function TStudyPlanCDS.GetControlPointSum: TField;
begin
  Result := FieldByName('ControlPointSum');
end;

function TStudyPlanCDS.GetSeminars: TField;
begin
  Result := FieldByName('Seminars');
end;

function TStudyPlanCDS.GetTotal: TField;
begin
  Result := FieldByName('Total');
end;

procedure TStudyPlanCDS.LocateToLastDiscipline;
begin
  // Пытаемся найти дисциплину с таким же названием что и прежде
  if FIDDisciplineName <> 0 then
  begin
    Locate('IDDisciplineName', FIDDisciplineName, []);
    FIDDisciplineName := 0;
  end;

end;

procedure TStudyPlanCDS.RecreateDataSet(ASpecialitySessions,
  ALessonTypes: TDataSet);
var
  AFieldName: string;
begin
  DisableControls;
  // Wrap.DetachViews; // Отсоединяем представления от документа чтобы не тормозило
  try
    FSpecialitySessions := ASpecialitySessions;
    SaveCurrentDiscipline;

    Close;

    Wrap.MultiSelectDSWrap.KeyFieldName := 'id_studyplan'; // Это первичный ключ

    Fields.Clear;

    with FieldDefs do
    begin
      Clear;
      Add('id_studyplan', ftinteger); // Код записи учебного плана
      Add('Checked', ftinteger); // Выбрана-ли эта запись учебного плана
      Add('id_cyclespecialityeducation', ftinteger); // Код цикла
      Add('CSE_ORD', ftinteger); // Порядковый номер цикла
      Add('Code', ftString, 20); // Код дисциплины или цикла
      // Add('short_cycle', ftString, 10); // Короткое название цикла
      // Add('cycle', ftString, 100); // Полное название цикла

      // Add('short_cycletype', ftString, 10); // Короткое название типа дисциплины
      // Add('cycletype_ord', ftInteger); // Порядок типа дисциплины (Базовая Федеральня, Профиль ФиК)

      Add('iddisciplinename', ftinteger); // Код дисциплины
      Add('disciplinename', ftString, 200); // Название дисциплины
      Add('idcyclespecialityeducation', ftinteger); // Код родительского цикла
      Add('total', ftinteger); // Всего часов
      // Add('total_in_week', ftString); // Всего часов
      Add('total2', ftFloat); // Всего зачётных едениц (трудоёкость)
      Add('AudSum', ftinteger); // Всего часов
      Add('ControlPointSum', ftinteger); // Сумма часов за контрольные точки
      Add('Self', ftinteger); // Часов для самостоятельной работы
      Add('SelfSum', ftinteger); // Сумма часов для самостоятельной работы
      Add('lectures', ftinteger); // Всего лекций
      Add('LecSum', ftinteger); // Сумма лекций по семестрам
      Add('seminars', ftinteger); // Всего семинаров
      Add('SemSum', ftinteger); // Сумма семинаров по семестрам
      Add('labworks', ftinteger); // Всего лабораторных
      Add('LabSum', ftinteger); // Сумма лабораторных по семестрам
      Add('idchair', ftinteger); // код кафедры
      Add('mark', ftString, 3); // Пометка
      Add('is_option', ftinteger); // Дисциплина по выбору студента
      Add('position', ftinteger); // Позиция дисциплины в цикле
      Add('department', ftString, 100); // Название кафедры
      Add('Professional_Module', ftinteger);
      // Является ли дисциплина к.т. проф. модуля
      Add('IDHOURVIEWTYPE', ftinteger); // В каком виде отображать поле "Всего"
      Add('AutoSelfHours', ftinteger);
      // Автоматический пересчёт часов для сам. работ

      // Добавляем стобцы для каждой сессии специальности
      ASpecialitySessions.First;
      while not ASpecialitySessions.Eof do // цикл по сессиям
      begin
        ALessonTypes.First;
        while not ALessonTypes.Eof do
        begin
          AFieldName :=
            getFieldName(ALessonTypes.FieldByName('ID_DisciplineType')
            .AsInteger, ASpecialitySessions.FieldByName('Level_').AsInteger,
            ASpecialitySessions.FieldByName('Session_in_level').AsInteger);

          Add(AFieldName, ftFloat);
          ALessonTypes.Next;
        end;
        ASpecialitySessions.Next;
      end;

    end;

    CreateDataSet; // Создаём набор данных заново

    FSumFields.Clear;
    FSumFields.Add(1, LecSum.FieldName);
    FSumFields.Add(2, LabSum.FieldName);
    FSumFields.Add(3, SemSum.FieldName);
    FSumFields.Add(22, SelfSum.FieldName);

    Close;
    Wrap.CreateDefaultFields;

    // FieldByName('total_in_week').FieldKind := fkCalculated;
    // OnCalcFields := OnCalculateFields;

    IndexFieldNames := 'id_studyplan'; // Сортируем по коду учебного плана
    Open;
  finally
    // Wrap.AttachViews;
    EnableControls;
  end;
end;

procedure TStudyPlanCDS.SaveCurrentDiscipline;
begin
  if not IsEmpty then
    FIDDisciplineName := FieldByName('IDDisciplineName').AsInteger
    // else
    // FIDDisciplineName := 0;
end;

procedure TStudyPlanCDS.SetCheched(AIDDisciplineNameList: TStringList);
var
  AIDDisciplineName: Integer;
  i: Integer;
begin
  Wrap.MyBookmark.Save('id_studyplan', True, True);
  try
    for i := 0 to AIDDisciplineNameList.Count - 1 do
    begin
      AIDDisciplineName := StrToIntDef(AIDDisciplineNameList[i], 0);
      if AIDDisciplineName = 0 then
        Continue;

      if Locate('IDDisciplineName', AIDDisciplineName, []) then
      begin
        Edit;
        FieldByName('Checked').AsInteger := 1;
        Post;
      end;
    end;
  finally
    Wrap.MyBookmark.Restore;
  end;
end;

procedure TStudyPlanCDS.SetCheckedOnly(const Value: Boolean);
begin
  if FCheckedOnly <> Value then
  begin
    FCheckedOnly := Value;

    if FCheckedOnly then
    begin
      Filter := 'Checked=1';
      Filtered := True;
    end
    else
    begin
      Filtered := False;
      Filter := '';
    end;
  end;
end;

procedure TStudyPlanCDS.UpdateCode;
var
  AMYSQLQuery: TMySQLQuery;
begin
  AMYSQLQuery := TMySQLQuery.Create(Self, 0);
  try
    AMYSQLQuery.SQL.Text :=
      Format('select CDB_DAT_STUDY_PROCESS.STUDYPLANPACK.GETSTUDYPLANCODE(%d) code from dual',
      [FieldByName('ID_STUDYPLAN').AsInteger]);
    AMYSQLQuery.Open;
    FieldByName('Code').AsString := AMYSQLQuery.Fields[0].AsString;
  finally
    FreeAndNil(AMYSQLQuery);
  end;

  // if not (Trim(FieldByName('short_cycle').AsString) = '') then
  // AShortCycle := FieldByName('short_cycle').AsString + '.'
  // else
  // AShortCycle := '';
  {
    if not (Trim(FieldByName('short_cycletype').AsString) = '') then
    AShortCycleType := FieldByName('short_cycletype').AsString + '.'
    else
    AShortCycleType := '';
  }
  // FieldByName('Code').AsString := AShortCycle + AShortCycleType;
end;

constructor TStudyPlanQueryRefresh.Create(AOwner: TStudyPlanQuery);
begin
  inherited Create(AOwner);
  FStudyPlanQuery := AOwner;

  FSQLSelectOperator.Assign(AOwner.FSQLRefreshOperator);

  FCycleSpecialityEducationParam := T_KParam.Create(Params,
    'sp.idcyclespecialityeducation');

  FDisciplineNameParam := T_KParam.Create(Params, 'sp.IDDISCIPLINENAME');
end;

end.
