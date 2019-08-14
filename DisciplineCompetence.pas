unit DisciplineCompetence;

interface

uses
  NotifyEvents, EssenceEx, System.Classes, K_Params, DocumentView, Data.DB,
  System.Generics.Collections, SQLTools, Winapi.Messages, Winapi.Windows,
  Datasnap.DBClient, UMKDataModule, StudyPlanInfo, DisciplineLessonTypes;

type
  TIDCompetencePartName = (cpnKnow = 1, cpnAble = 2, cpnPossess = 3);
  TIDCompetenceLevelName = (clnThreshold = 1, clnIncreased = 2);

  TCompetenceLevelNames = class(TEssenceEx2)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TCompetencePartNames = class(TEssenceEx2)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TBaseCompetence = class(TEssenceEx2)
  private
    FIDSpecialityParam: T_KParam;
    FYearParam: T_KParam;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    property IDSpecialityParam: T_KParam read FIDSpecialityParam;
    property YearParam: T_KParam read FYearParam;
  end;

  TAllCompetence = class(TBaseCompetence)
  private
    procedure AfterOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TBaseDisciplineCompetence = class(TBaseCompetence)
  private
    FIDDisciplineNameParam: T_KParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDDisciplineNameParam: T_KParam read FIDDisciplineNameParam;
  end;

  TCompetence = class(TBaseDisciplineCompetence)
  private
    procedure AfterInsert(Sender: TObject);
    procedure SetReadOnly(Sender: TObject);
  protected
    procedure CreateIndex; override;
    procedure MyOnRefreshApplyUpdates(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TCompetenceParts = class(TBaseDisciplineCompetence)
  private
    FCompetencePartNames: TCompetencePartNames;
    FDefaultCompetencePartName: TIDCompetencePartName;
    FIDCompetenceParam: T_KParam;
    procedure AddDisciplineLink;
    procedure AfterCancel(Sender: TObject);
    procedure AfterInsert(Sender: TObject);
    procedure AfterPost(Sender: TObject);
  protected
    procedure CreateIndex; override;
    function CreateRefreshRecordSQL: TSQLSelectOperator; override;
  public
    constructor Create(AOwner: TComponent); override;
    property DefaultCompetencePartName: TIDCompetencePartName
      read FDefaultCompetencePartName write FDefaultCompetencePartName;
    property IDCompetenceParam: T_KParam read FIDCompetenceParam;
  end;

  TCompetencePartDetail = class(TBaseDisciplineCompetence)
  private
    FCompetenceLevelNames: TCompetenceLevelNames;
    FDefaultCompetenceLevelName: TIDCompetenceLevelName;
    FIDCompetencePartParam: T_KParam;
    procedure AfterCancel(Sender: TObject);
    procedure AfterInsert(Sender: TObject);
  protected
    procedure CreateIndex; override;
  public
    constructor Create(AOwner: TComponent); override;
    property DefaultCompetenceLevelName: TIDCompetenceLevelName
      read FDefaultCompetenceLevelName write FDefaultCompetenceLevelName;
    property IDCompetencePartParam: T_KParam read FIDCompetencePartParam;
  end;

  TDisciplineCompetence = class(TDocument)
  private
    FCompetence: TCompetence;
    FCompetencePart: TCompetenceParts;
    FCompetencePartDetail: TCompetencePartDetail;
    FDataSet: TDataSet;
    FDisciplineLessonTypes: TDisciplineLessonTypes;
    FStudyPlanInfo: TStudyPlanInfo;
    procedure AfterDSStateChange(Sender: TObject);
    function GetDisciplineName: string;
    function GetIsAllSave: Boolean;
    function GetIsAddKnowEnabled: Boolean;
    function GetIsAddThresholdEnabled: Boolean;
    function GetPurpose: String;
    function GetTask: String;
  protected
  public
    constructor Create(AOwner: TComponent; AIDDiscipline: Integer); reintroduce;
    procedure AddCompetence(AllCompetence: TAllCompetence);
    procedure OnBookmark(Sender: TObject);
    procedure PrepareReport;
    // procedure ProcessThematicPlan(AETP: TETP; ABookmarkData: TBookMarkData);
    procedure ProcessCompetenceCard(ABookmarkData: TBookMarkData);
    procedure ProcessCompetenceList(ABookmarkData: TBookMarkData);
    property Competence: TCompetence read FCompetence;
    property CompetencePart: TCompetenceParts read FCompetencePart;
    property CompetencePartDetail: TCompetencePartDetail
      read FCompetencePartDetail;
    property DataSet: TDataSet read FDataSet;
    property DisciplineName: string read GetDisciplineName;
    property IsAllSave: Boolean read GetIsAllSave;
    property IsAddKnowEnabled: Boolean read GetIsAddKnowEnabled;
    property IsAddThresholdEnabled: Boolean read GetIsAddThresholdEnabled;
    property Purpose: String read GetPurpose;
    property StudyPlanInfo: TStudyPlanInfo read FStudyPlanInfo;
    property Task: String read GetTask;
  end;

  TCompetencePartDisciplines = class(TEssenceEx2)
  private
    FIDCompetencePartParam: T_KParam;
    FIDDisciplineNameParam: T_KParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDCompetencePartParam: T_KParam read FIDCompetencePartParam;
    property IDDisciplineNameParam: T_KParam read FIDDisciplineNameParam;
  end;

  TCompetencePartDetailEx = class(TBaseDisciplineCompetence)
  private
    FIDCompetenceParam: T_KParam;
  protected
    procedure CreateIndex; override;
  public
    constructor Create(AOwner: TComponent); override;
    property IDCompetenceParam: T_KParam read FIDCompetenceParam;
  end;

implementation

uses Sysutils, DataSetWrap, DBRecordHolder, System.IOUtils, LanguageConstants,
  Word2010, System.Variants;

constructor TCompetence.Create(AOwner: TComponent);
begin
  inherited;
  // FTableName := 'xxx'; // Таблица, которую будем редактировать

  Wrap.ImmediateCommit := True;

  // Мы ничего не будем добавлять в таблицу компетенций.
  // Добавление будет фиктивное
  Provider.BeforeUpdateRecord := MyOnRefreshApplyUpdates;

  FSynonymFileName := 'CompetenceFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'c.ID_Competence';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Distinct := True;

    Fields.Add('c.ID_Competence');
    Fields.Add('c.code');
    Fields.Add('c.description');

    OrderClause.Add('c.code')
  end;
  TNotifyEventWrap.Create(Wrap.AfterOpen, SetReadOnly);
  TNotifyEventWrap.Create(Wrap.AfterInsert, AfterInsert);
  TNotifyEventWrap.Create(Wrap.AfterPost, SetReadOnly);
  TNotifyEventWrap.Create(Wrap.AfterCancel, SetReadOnly);
end;

procedure TCompetence.AfterInsert(Sender: TObject);
begin
  // Делаем все поля доступными для изменения
  Wrap.SetFieldsReadOnly(False);
end;

procedure TCompetence.SetReadOnly(Sender: TObject);
begin
  // Делаем все поля только для чтения
  Wrap.SetFieldsReadOnly(True);
end;

procedure TCompetence.CreateIndex;
begin
  ClientDataSet.AddIndex('idxOrder', 'code', []);
  ClientDataSet.IndexName := 'idxOrder';
end;

procedure TCompetence.MyOnRefreshApplyUpdates(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
var
  ACompetenceParts: TCompetenceParts;
  AKey: Integer;
  // S: string;
begin
  // Саму компетенцию на стороне сервера трогать не будем
  Applied := True;

  // При удалении компетенции с клиента будем на сервере удалять связанные с ней компоненты
  if UpdateKind = ukDelete then
  begin
    AKey := DeltaDS.FieldByName(KeyFieldName).OldValue;

    ACompetenceParts := TCompetenceParts.Create(Self);
    try
      ACompetenceParts.IDDisciplineNameParam.ParamValue :=
        IDDisciplineNameParam.ParamValue;
      ACompetenceParts.IDSpecialityParam.ParamValue :=
        IDSpecialityParam.ParamValue;
      ACompetenceParts.YearParam.ParamValue := YearParam.ParamValue;
      ACompetenceParts.IDCompetenceParam.ParamValue := AKey;
      ACompetenceParts.Refresh;

      // Удаляем все части компетенции связанные с дисциплиной
      while not ACompetenceParts.DS.eof do
      begin
        ACompetenceParts.DS.Delete;
      end;

    finally
      FreeAndNil(ACompetenceParts);
    end;
  end;
end;

constructor TBaseCompetence.Create(AOwner: TComponent);
begin
  inherited;
  with FSQLSelectOperator do
  begin
    Tables.Add('competence c');
  end;

  FYearParam := T_KParam.Create(Params, 'c.Year');
  FYearParam.ParamName := 'Year';

  FIDSpecialityParam := T_KParam.Create(Params, 'c.IDSpeciality');
  FIDSpecialityParam.ParamName := 'IDSpeciality';

  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterMySQLQueryOpen);

  Wrap.ImmediateCommit := True;
  KeyFieldProviderFlags := [pfInKey, pfInUpdate];
end;

constructor TCompetenceParts.Create(AOwner: TComponent);
var
  Field: TStringField;
begin
  inherited;

  FDefaultCompetencePartName := cpnKnow;

  // Будем обновлять запись после сохранения
  RefreshRecordAfterPost := True;

  // Будем сразу-же сохранять запись на стороне сервера
  Wrap.ImmediateCommit := True;

  // Будем сами заполнять первичный ключ
  SequenceName := 'cdb_dat_study_process.S_COMPETENCEPARTS';

  // Таблица, которую будем редактировать
  UpdatingTableName := 'COMPETENCEPARTS';

  // Заполняем поля, которые будем обновлять
  UpdatingFieldNames.Add('IDCompetence');
  UpdatingFieldNames.Add('IDCOMPETENCEPARTNAME');
  UpdatingFieldNames.Add('CompetencePartDescription');
  UpdatingFieldNames.Add('order_');

  FSynonymFileName := 'CompetencePartFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'cp.ID_CompetencePart';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Distinct := True;

    Fields.Add('cp.ID_CompetencePart');
    Fields.Add('cp.IDCompetence');
    Fields.Add('CP.IDCOMPETENCEPARTNAME');
    // Fields.Add('CPN.COMPETENCEPARTNAME');
    Fields.Add('CPN.COMPETENCEPARTNAMEORDER');
    Fields.Add('cp.CompetencePartDescription');
    Fields.Add('cp.order_');

    // Сортировать будем на стороне клиента
    // OrderClause.Add('CP.IDCOMPETENCE');
    // OrderClause.Add('CPN.COMPETENCEPARTNAMEORDER');
    // OrderClause.Add('CP.ORDER_');
  end;

  FIDCompetenceParam := T_KParam.Create(Params, 'cp.IDCompetence');
  FIDCompetenceParam.ParamName := 'IDCompetence';

  FCompetencePartNames := TCompetencePartNames.Create(Self);
  FCompetencePartNames.Refresh;

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию

  { Добавляем дополнительное, подстановочное поле }
  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'COMPETENCEPARTNAME';
    Size := 100;
    FieldKind := fkLookup;
    Name := DS.Name + FieldName;
    KeyFields := 'IDCompetencePartName';
    LookUpDataset := FCompetencePartNames.DS;
    LookUpKeyFields := 'ID_CompetencePartName';
    LookUpResultField := 'COMPETENCEPARTNAME';
    DataSet := DS;
  end;

  TNotifyEventWrap.Create(Wrap.AfterCancel, AfterCancel);
  TNotifyEventWrap.Create(Wrap.AfterPost, AfterPost);
  TNotifyEventWrap.Create(Wrap.AfterInsert, AfterInsert);
end;

procedure TCompetenceParts.AddDisciplineLink;
var
  ACompetencePartDisciplines: TCompetencePartDisciplines;
begin
  // Будем добавлять дисциплину связанную с компонентом компетенции
  ACompetencePartDisciplines := TCompetencePartDisciplines.Create(Self);
  try
    ACompetencePartDisciplines.BeginUpdate;
    ACompetencePartDisciplines.IDCompetencePartParam.ParamValue := PKValue;
    ACompetencePartDisciplines.IDDisciplineNameParam.ParamValue :=
      IDDisciplineNameParam.ParamValue;
    ACompetencePartDisciplines.EndUpdate();

    // Если с компонентом компетенции наша дисциплина ещё не связана
    if ACompetencePartDisciplines.DS.RecordCount = 0 then
    begin
      ACompetencePartDisciplines.DS.Insert;
      ACompetencePartDisciplines.Field('IDCompetencePart').AsInteger := PKValue;
      ACompetencePartDisciplines.Field('IDDisciplineName').AsInteger :=
        IDDisciplineNameParam.ParamValue;
      ACompetencePartDisciplines.DS.Post;
    end;
  finally
    FreeAndNil(ACompetencePartDisciplines);
  end;
end;

procedure TCompetenceParts.AfterCancel(Sender: TObject);
begin
  ClientDataSet.CancelUpdates;
end;

procedure TCompetenceParts.AfterInsert(Sender: TObject);
begin
  Field('IDCOMPETENCEPARTNAME').AsInteger :=
    Integer(FDefaultCompetencePartName);
end;

procedure TCompetenceParts.AfterPost(Sender: TObject);
begin
  // Добавляем ссылку на дисциплину
  AddDisciplineLink;
end;

procedure TCompetenceParts.CreateIndex;
begin
  ClientDataSet.AddIndex('idxOrder',
    'IDCOMPETENCE;COMPETENCEPARTNAMEORDER;ORDER_', []);
  ClientDataSet.IndexName := 'idxOrder';
end;

function TCompetenceParts.CreateRefreshRecordSQL: TSQLSelectOperator;
var
  AID: Variant;
  APKFieldName: string;
  ASQLSelectOperator: TSQLSelectOperator;
  F: TField;
  AWhereClause: string;
  x: Integer;
begin
  APKFieldName := KeyFieldName;
  if (APKFieldName <> '') and (not DataSetWrap.DataSet.FieldByName(APKFieldName)
    .IsNull) then
  begin
    F := DataSetWrap.DataSet.FieldByName(APKFieldName);
    AID := F.Value;

    // Создаём запрос выбирающий текущую запись
    ASQLSelectOperator := TSQLSelectOperator.Create();
    // Формируем запрос выбирающий текущую запись
    ASQLSelectOperator.Assign(FSQLSelectOperator);

    // Удаляем join связывающий с дисциплинами
    ASQLSelectOperator.Joins.Delete(2);

    ASQLSelectOperator.OrderClause.Clear;
    ASQLSelectOperator.WhereClause.Clear;

    x := AID;
    AWhereClause := Format('%s = %d',
      [DataSetWrap.MultiSelectDSWrap.FullKeyFieldName, x]);

    ASQLSelectOperator.WhereClause.Add(AWhereClause);
    Result := ASQLSelectOperator;
  end
  else
    Result := nil;
end;

constructor TDisciplineCompetence.Create(AOwner: TComponent;
  AIDDiscipline: Integer);
begin
  inherited Create(AOwner);
  Assert(AIDDiscipline > 0);

  FDisciplineLessonTypes := TDisciplineLessonTypes.Create(Self);
  FDisciplineLessonTypes.IDDisciplineParam.ParamValue := AIDDiscipline;
  FDisciplineLessonTypes.Refresh;

  FStudyPlanInfo := TStudyPlanInfo.Create(Self);
  FStudyPlanInfo.IDDisciplineParam.ParamValue := AIDDiscipline;
  FStudyPlanInfo.Refresh;
  Assert(FStudyPlanInfo.DS.RecordCount = 1);

  FCompetence := TCompetence.Create(Self);
  FCompetence.IDDisciplineNameParam.ParamValue :=
    FStudyPlanInfo.SPIDDisciplineName.AsInteger;
  FCompetence.YearParam.ParamValue := FStudyPlanInfo.Year.AsInteger;
  FCompetence.IDSpecialityParam.ParamValue :=
    FStudyPlanInfo.IDSpeciality.AsInteger;
  FCompetence.Refresh;

  FCompetencePart := TCompetenceParts.Create(Self);
  FCompetencePart.IDDisciplineNameParam.ParamValue :=
    FStudyPlanInfo.SPIDDisciplineName.AsInteger;
  FCompetencePart.YearParam.ParamValue := FStudyPlanInfo.Year.AsInteger;
  FCompetencePart.IDSpecialityParam.ParamValue :=
    FStudyPlanInfo.IDSpeciality.AsInteger;
  FCompetencePart.Refresh;

  FCompetencePartDetail := TCompetencePartDetail.Create(Self);
  FCompetencePartDetail.IDDisciplineNameParam.ParamValue :=
    FStudyPlanInfo.SPIDDisciplineName.AsInteger;
  FCompetencePartDetail.YearParam.ParamValue := FStudyPlanInfo.Year.AsInteger;
  FCompetencePartDetail.IDSpecialityParam.ParamValue :=
    FStudyPlanInfo.IDSpeciality.AsInteger;
  FCompetencePartDetail.Refresh;

  TNotifyEventWrap.Create(FCompetencePartDetail.Wrap.AfterInsert,
    AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetencePartDetail.Wrap.AfterEdit,
    AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetencePartDetail.Wrap.AfterCancel,
    AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetencePartDetail.Wrap.AfterPost,
    AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetencePartDetail.Wrap.AfterClose,
    AfterDSStateChange);

  TNotifyEventWrap.Create(FCompetencePart.Wrap.AfterInsert, AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetencePart.Wrap.AfterEdit, AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetencePart.Wrap.AfterCancel, AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetencePart.Wrap.AfterPost, AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetencePart.Wrap.AfterClose, AfterDSStateChange);

  TNotifyEventWrap.Create(FCompetence.Wrap.AfterInsert, AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetence.Wrap.AfterEdit, AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetence.Wrap.AfterCancel, AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetence.Wrap.AfterPost, AfterDSStateChange);
  TNotifyEventWrap.Create(FCompetence.Wrap.AfterClose, AfterDSStateChange);

  FDataSet := nil;
end;

procedure TDisciplineCompetence.AddCompetence(AllCompetence: TAllCompetence);
var
  ARecordHolder: TRecordHolder;
begin
  if AllCompetence.DS.RecordCount = 0 then
    Exit;

  // Ищем такую компетенцию в списке компетенций дисциплины
  if Competence.DS.Locate(Competence.KeyFieldName, AllCompetence.PKValue, [])
  then
    raise Exception.Create
      ('Выбранная компетенция уже есть в списке компетенций дисциплины');

  // Запоминаем запись из справочника
  ARecordHolder := TRecordHolder.Create(AllCompetence.DS);
  try
    Competence.DS.Insert;
    ARecordHolder.Put(Competence.DS);
    Competence.DS.Post;
  finally
    FreeAndNil(ARecordHolder);
  end;
end;

procedure TDisciplineCompetence.AfterDSStateChange(Sender: TObject);
begin
  FDataSet := (Sender as TDataSetWrap).DataSet;
  // Сообщаем представлениям о том, что какой-то датасет перешёл в состояние вставки или редактирования
  Views.UpdateViews;
end;

function TDisciplineCompetence.GetDisciplineName: string;
begin
  Result := FStudyPlanInfo.Field('DISCIPLINENAME').AsString;
end;

function TDisciplineCompetence.GetIsAllSave: Boolean;
begin
  // Если всё сохранено
  Result := (FDataSet = nil) or (FDataSet.State in [dsBrowse]);
end;

function TDisciplineCompetence.GetIsAddKnowEnabled: Boolean;
begin
  Result := IsAllSave and (Competence.DS.RecordCount > 0) and
    (Competence.DS.State in [dsBrowse]);
end;

function TDisciplineCompetence.GetIsAddThresholdEnabled: Boolean;
begin
  Result := IsAllSave and (CompetencePart.DS.RecordCount > 0) and
    (CompetencePart.DS.State in [dsBrowse]);
end;

function TDisciplineCompetence.GetPurpose: String;
begin
  Result := FStudyPlanInfo.Field('Purpose').AsString;
end;

function TDisciplineCompetence.GetTask: String;
begin
  Result := FStudyPlanInfo.Field('Task').AsString;
end;

procedure TDisciplineCompetence.OnBookmark(Sender: TObject);
var
  ABookmarkData: TBookMarkData;
begin
  ABookmarkData := Sender as TBookMarkData;

  if AnsiSameText(ABookmarkData.BookmarkName, 'НаименованиеДисциплины10') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, DisciplineName);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ЦельДисциплины10') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, Purpose);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ЗадачиДисциплины10') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, Task);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'КартаКомпетенций') then
  begin
    ProcessCompetenceCard(ABookmarkData);
  end;
end;

procedure TDisciplineCompetence.PrepareReport;
var
  ANotifyEventWrap: TNotifyEventWrap;
  TemplateFileName: string;
begin
  TemplateFileName := TPath.Combine(ExtractFilePath(ParamStr(0)),
    TLangConst.ШаблонКартыКомпетенций);

  ANotifyEventWrap := TNotifyEventWrap.Create(TUMKDM.Instance.OnBookmark,
    OnBookmark);
  try
    TUMKDM.Instance.PrepareReport(TemplateFileName);
    try

    finally
      TUMKDM.Instance.WA.Visible := True;
      TUMKDM.Instance.WA.Disconnect;
    end;

  finally
    FreeAndNil(ANotifyEventWrap);
  end;

end;

procedure TDisciplineCompetence.ProcessCompetenceCard(ABookmarkData
  : TBookMarkData);
var
  ACOMPETENCELEVELNAME: string;
  ACompetencePartDetailEx: TCompetencePartDetailEx;
  T: Table;
  ARange: WordRange;
  ARange2: WordRange;
  r: Integer;
  S: string;
  Строгий, СильноеВыделение: Style;
begin
  Строгий := ABookmarkData.Document.Styles.Item('Строгий');
  Assert(Строгий <> nil);
  СильноеВыделение := ABookmarkData.Document.Styles.Item('Сильное выделение');
  Assert(СильноеВыделение <> nil);

  if ABookmarkData.B.Range.Tables.Count = 0 then
    raise Exception.Create(TLangConst.ОшибкаПриОбработкеКартыКомпетенций);

  // Получаем первую таблицу из закладки
  T := ABookmarkData.B.Range.Tables.Item(1);
  Assert(T <> nil);

  Competence.Wrap.MyBookmark.Save(Competence.KeyFieldName, True, True);
  CompetencePart.Wrap.MyBookmark.Save(CompetencePart.KeyFieldName, True, True);
  try
    ACompetencePartDetailEx := TCompetencePartDetailEx.Create(nil);
    try
      Competence.DS.First;
      while not Competence.DS.eof do
      begin
        // Добавляем новую строку в конец таблицы
        T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

        r := T.Rows.Count;
        // Меняем ориентацию текста
        T.Cell(r, 1).Range.Orientation := wdTextOrientationHorizontal;
        // Меняем выравнивание параграфа по горизонтали
        T.Cell(r, 1).Range.ParagraphFormat.Alignment := wdAlignParagraphLeft;
        // Меняем выравнивание в ячейке по вертикали
        T.Cell(r, 1).VerticalAlignment := wdCellAlignVerticalTop;

        // Заполняем колонку "Индекс компетенции"
        T.Cell(r, 1).Range.Text := Competence.Field('Code').AsString;

        // Заполняем колонку "Формулировка"
        S := Competence.Field('Description').AsString;
        if S.Length > 0 then
        begin
          // ch := S[1];
          // StringUtil

          // Меняем ориентацию текста
          T.Cell(r, 2).Range.Orientation := wdTextOrientationHorizontal;
          // Меняем выравнивание параграфа по горизонтали
          T.Cell(r, 2).Range.ParagraphFormat.Alignment := wdAlignParagraphLeft;
          // Меняем выравнивание в ячейке по вертикали
          T.Cell(r, 2).VerticalAlignment := wdCellAlignVerticalTop;

          T.Cell(r, 2).Range.Text := S;
        end;

        // Получаем компоненты компетенции
        CompetencePart.BeginUpdate;
        CompetencePart.IDCompetenceParam.ParamValue := Competence.PKValue;
        CompetencePart.EndUpdate();

        ARange := T.Cell(r, 3).Range;
        // Меняем ориентацию текста
        T.Cell(r, 3).Range.Orientation := wdTextOrientationHorizontal;
        // Меняем выравнивание параграфа по горизонтали
        T.Cell(r, 3).Range.ParagraphFormat.Alignment := wdAlignParagraphLeft;
        // Меняем выравнивание в ячейке по вертикали
        T.Cell(r, 3).VerticalAlignment := wdCellAlignVerticalTop;

        CompetencePart.DS.First;
        while not CompetencePart.DS.eof do
        begin
          S := Format('%s ', [CompetencePart.Field('COMPETENCEPARTNAME')
            .AsString]);
          ARange.Text := S;

          ARange.Set_Style(Строгий);

          S := Format(': %s', [CompetencePart.Field('CompetencePartDescription')
            .AsString]);

          ARange := ABookmarkData.Document.Range(ARange.End_ - 1,
            ARange.End_ - 1);

          ARange.Text := S;
          ARange.InsertParagraphAfter;
          ARange.Select;
          ARange.Document.Application.Selection.ClearFormatting;

          CompetencePart.DS.Next;
          ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
        end;

        // Заполняем технологии формирования компетенции (4-й столбец)
        // Меняем ориентацию текста
        T.Cell(r, 4).Range.Orientation := wdTextOrientationHorizontal;
        // Меняем выравнивание параграфа по горизонтали
        T.Cell(r, 4).Range.ParagraphFormat.Alignment := wdAlignParagraphLeft;
        // Меняем выравнивание в ячейке по вертикали
        T.Cell(r, 4).VerticalAlignment := wdCellAlignVerticalTop;

        ARange := T.Cell(r, 4).Range;
        ARange := ABookmarkData.Document.Range(ARange.End_ - 1,
          ARange.End_ - 1);

        S := Format('%s', [FDisciplineLessonTypes.Field('ShortLessonTypes')
          .AsString]);
        S := S.ToLower;

        ARange.Text := S;
        ARange.Set_Style(СильноеВыделение);

        // Подготавливаем столбец Форма оценочных средств для заполнения (5-й столбец)
        // Меняем ориентацию текста
        T.Cell(r, 5).Range.Orientation := wdTextOrientationHorizontal;
        // Меняем выравнивание параграфа по горизонтали
        T.Cell(r, 5).Range.ParagraphFormat.Alignment := wdAlignParagraphLeft;
        // Меняем выравнивание в ячейке по вертикали
        T.Cell(r, 5).VerticalAlignment := wdCellAlignVerticalTop;

        // Заполняем уровни освоения компетенции (6-й столбец)
        // Меняем ориентацию текста
        T.Cell(r, 6).Range.Orientation := wdTextOrientationHorizontal;
        // Меняем выравнивание параграфа по горизонтали
        T.Cell(r, 6).Range.ParagraphFormat.Alignment := wdAlignParagraphLeft;
        // Меняем выравнивание в ячейке по вертикали
        T.Cell(r, 6).VerticalAlignment := wdCellAlignVerticalTop;

        ARange2 := T.Cell(r, 6).Range;
        ARange2 := ABookmarkData.Document.Range(ARange2.End_ - 1,
          ARange2.End_ - 1);

        // Получаем уровни освоения компетенции
        ACompetencePartDetailEx.BeginUpdate;
        ACompetencePartDetailEx.FIDDisciplineNameParam.ParamValue :=
          Competence.IDDisciplineNameParam.ParamValue;
        ACompetencePartDetailEx.IDSpecialityParam.ParamValue :=
          Competence.IDSpecialityParam.ParamValue;
        ACompetencePartDetailEx.YearParam.ParamValue :=
          Competence.YearParam.ParamValue;
        ACompetencePartDetailEx.IDCompetenceParam.ParamValue :=
          Competence.PKValue;
        ACompetencePartDetailEx.EndUpdate();

        ACompetencePartDetailEx.DS.First;
        ACOMPETENCELEVELNAME := '';
        while not ACompetencePartDetailEx.DS.eof do
        begin
          S := Format('%s ',
            [ACompetencePartDetailEx.Field('COMPETENCELEVELNAME').AsString]);

          // Если уровень освоения компетенции изменился
          if S <> ACOMPETENCELEVELNAME then
          begin
            ARange2.Text := S;
            ARange2.Set_Style(СильноеВыделение);

            if ACOMPETENCELEVELNAME <> '' then
              ARange2.InsertParagraphBefore;
            ACOMPETENCELEVELNAME := S;

            ARange2.InsertParagraphAfter;
            // ARange2.Select;
            // Sleep(3000);

          end;
          // else
          // ARange2.InsertParagraphAfter;


          // ARange2.Select;
          // Sleep(3000);

          ARange2 := ABookmarkData.Document.Range(ARange2.End_, ARange2.End_);

          // Знать, уметь, Владеть, Иметь практический опыт
          S := Format('%s: ',
            [ACompetencePartDetailEx.Field('COMPETENCEPARTNAME').AsString]);
          ARange2.Text := S;
          ARange2.Set_Style(Строгий);

          // ARange2.Select;
          // Sleep(3000);

          // Что должен знать уметь владеть
          S := Format(' %s',
            [ACompetencePartDetailEx.Field('CompetencePartDetail').AsString]);

          ARange2 := ABookmarkData.Document.Range(ARange2.End_, ARange2.End_);
          ARange2.Text := S;
          ARange2.InsertParagraphAfter;
          ARange2.Select;
          ARange2.Document.Application.Selection.ClearFormatting;

          ACompetencePartDetailEx.DS.Next;
          ARange2 := ABookmarkData.Document.Range(ARange2.End_, ARange2.End_);
        end;

        // Переходим к следующей компетенции
        Competence.DS.Next;
      end;

    finally;
      FreeAndNil(ACompetencePartDetailEx);
    end;

    CompetencePart.BeginUpdate;
    CompetencePart.IDCompetenceParam.SetUnassigned;
    CompetencePart.EndUpdate();

    // CompetencePartDetail.BeginUpdate;
    // CompetencePartDetail.IDCompetencePartParam.SetUnassigned;
    // CompetencePartDetail.EndUpdate();
  finally
    // CompetencePartDetail.Wrap.MyBookmark.Restore;
    CompetencePart.Wrap.MyBookmark.Restore;
    Competence.Wrap.MyBookmark.Restore;
  end;

end;

procedure TDisciplineCompetence.ProcessCompetenceList(ABookmarkData
  : TBookMarkData);
var
  ABookmarkName: string;
  ARange: WordRange;
  ARange2: WordRange;
  AStart: Integer;
  S: string;
  АбзацМаркированногоСписка: Style;
begin
  АбзацМаркированногоСписка := ABookmarkData.Document.Styles.Item
    ('Абзац маркированного списка');

  Assert(АбзацМаркированногоСписка <> nil);

  ABookmarkName := ABookmarkData.B.Name;

  AStart := ABookmarkData.B.Range.Start;
  ARange := ABookmarkData.Document.Range(AStart, ABookmarkData.B.Range.End_);

  Competence.Wrap.MyBookmark.Save(Competence.KeyFieldName, True, True);
  try
    Competence.DS.First;
    while not Competence.DS.eof do
    begin
      S := Format('%s - %s', [Competence.Field('Description').AsString,
        Competence.Field('Code').AsString]);

      ARange.Text := S;
      ARange.Set_Style(АбзацМаркированногоСписка);
      Competence.DS.Next;
      if not Competence.DS.eof then
      begin
        ARange.InsertParagraphAfter;
        ARange := ABookmarkData.Document.Range(ARange.End_, ARange.End_);
      end;
    end;
  finally
    Competence.Wrap.MyBookmark.Restore;
  end;

  // Создаём новую закладку с тем-же именем на этом месте
  ARange := ABookmarkData.Document.Range(AStart, ARange.End_);
  ARange2 := ARange;
  ARange.Bookmarks.Add(ABookmarkName, ARange2);
end;

constructor TCompetencePartDetail.Create(AOwner: TComponent);
var
  Field: TStringField;
  // IntField: TIntegerField;
begin
  inherited;

  FDefaultCompetenceLevelName := clnThreshold;

  // Будем сами заполнять первичный ключ
  SequenceName := 'cdb_dat_study_process.S_COMPETENCEPARTDETAILS';

  // Будем сразу-же сохранять
  Wrap.ImmediateCommit := True;

  // Таблица, которую будем редактировать
  UpdatingTableName := 'COMPETENCEPARTDETAILS';

  // Заполняем поля, которые будем обновлять
  UpdatingFieldNames.Add('IDCompetencePart');
  UpdatingFieldNames.Add('IDCompetenceLevelName');
  UpdatingFieldNames.Add('CompetencePartDetail');
  UpdatingFieldNames.Add('order_');

  FSynonymFileName := 'CompetencePartDetailFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName :=
    'cpdt.ID_CompetencePartDetail';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Distinct := True;

    Fields.Add('cpdt.ID_CompetencePartDetail');
    Fields.Add('cpdt.IDCompetencePart');
    Fields.Add('cpdt.IDCompetenceLevelName');
    // Fields.Add('CLN.COMPETENCELEVELNAME');
    Fields.Add('cpdt.CompetencePartDetail');
    Fields.Add('CLN.COMPETENCELEVELNAMEORDER');
    Fields.Add('cpdt.order_');

    Joins.Add('join COMPETENCEPARTDETAILS cpdt');
    Joins.WhereCondition.Add('cpdt.IDCompetencePart = CP.ID_COMPETENCEPART');

    Joins.Add('join COMPETENCELEVELNAMES cln');
    Joins.WhereCondition.Add
      ('cpdt.IDCompetenceLevelName = cln.ID_CompetenceLevelName');

    // OrderClause.Clear;
    // Сортировать будем на стороне клиента по индексу
    // OrderClause.Add('cpdt.IDCompetencePart');
    // OrderClause.Add('CLN.COMPETENCELEVELNAMEORDER');
    // OrderClause.Add('cpdt.order_');

    TNotifyEventWrap.Create(Wrap.AfterInsert, AfterInsert);
    TNotifyEventWrap.Create(Wrap.AfterCancel, AfterCancel);
  end;

  FIDCompetencePartParam := T_KParam.Create(Params, 'cpdt.IDCompetencePart');
  FIDCompetencePartParam.ParamName := 'IDCompetencePart';

  FCompetenceLevelNames := TCompetenceLevelNames.Create(Self);
  FCompetenceLevelNames.Refresh;

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию

  { Добавляем дополнительное, подстановочное поле }
  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'COMPETENCELEVELNAME';
    Size := 100;
    FieldKind := fkLookup;
    Name := DS.Name + FieldName;
    KeyFields := 'IDCompetenceLevelName';
    LookUpDataset := FCompetenceLevelNames.DS;
    LookUpKeyFields := 'ID_CompetenceLevelName';
    LookUpResultField := 'COMPETENCELEVELNAME';
    DataSet := DS;
  end;
  (*
    { Добавляем дополнительное, подстановочное поле }
    IntField := TIntegerField.Create(DataSetWrap.DataSet);
    with Field do
    begin
    FieldName := 'COMPETENCELEVELNAMEORDER';
    Size := 10;
    FieldKind := fkLookup;
    Name := DS.Name + FieldName;
    KeyFields := 'IDCompetenceLevelName';
    LookUpDataset := FCompetenceLevelNames.DS;
    LookUpKeyFields := 'ID_CompetenceLevelName';
    LookUpResultField := 'COMPETENCELEVELNAMEORDER';
    DataSet := DS;
    end;


    TNotifyEventWrap.Create( Wrap.BeforePost, BeforePost );
  *)
end;

procedure TCompetencePartDetail.AfterCancel(Sender: TObject);
begin
  Wrap.ClientDataSet.CancelUpdates;
end;

procedure TCompetencePartDetail.AfterInsert(Sender: TObject);
begin
  Field('IDCompetenceLevelName').AsInteger :=
    Integer(FDefaultCompetenceLevelName);
end;

procedure TCompetencePartDetail.CreateIndex;
begin
  ClientDataSet.AddIndex('idxOrder',
    'IDCompetencePart;COMPETENCELEVELNAMEORDER;ORDER_', []);
  ClientDataSet.IndexName := 'idxOrder';
end;

constructor TCompetenceLevelNames.Create(AOwner: TComponent);
begin
  inherited;
  DataSetWrap.MultiSelectDSWrap.KeyFieldName := 'ID_CompetenceLevelName';

  with FSQLSelectOperator do
  begin
    Fields.Add('*');

    Tables.Add('CompetenceLevelNames'.ToUpper);

    OrderClause.Add('competenceLevelNameOrder');
  end;

end;

constructor TCompetencePartNames.Create(AOwner: TComponent);
begin
  inherited;
  DataSetWrap.MultiSelectDSWrap.KeyFieldName := 'ID_CompetencePartName';

  with FSQLSelectOperator do
  begin
    Fields.Add('*');

    Tables.Add('CompetencePartNames'.ToUpper);

    OrderClause.Add('CompetencePartNameOrder');
  end;

end;

constructor TCompetencePartDisciplines.Create(AOwner: TComponent);
begin
  inherited;
  // Будем сами заполнять первичный ключ
  SequenceName := 'cdb_dat_study_process.S_COMPETENCEPARTDISCIPLINES';
  // будем сразу сохранять
  Wrap.ImmediateCommit := True;

  DataSetWrap.MultiSelectDSWrap.KeyFieldName := 'ID_COMPETENCEPARTDISCIPLINE';

  with FSQLSelectOperator do
  begin
    Fields.Add('*');

    Tables.Add('COMPETENCEPARTDISCIPLINES'.ToUpper);
  end;

  FIDCompetencePartParam := T_KParam.Create(Params, 'IDCompetencePart');
  FIDCompetencePartParam.ParamName := 'IDCompetencePart';

  FIDDisciplineNameParam := T_KParam.Create(Params, 'IDDisciplineName');
  FIDDisciplineNameParam.ParamName := 'IDDisciplineName';

  KeyFieldProviderFlags := [pfInKey, pfInUpdate];
end;

constructor TBaseDisciplineCompetence.Create(AOwner: TComponent);
begin
  inherited;
  with FSQLSelectOperator do
  begin
    Joins.Add('join COMPETENCEPARTS cp');
    Joins.WhereCondition.Add('CP.IDCOMPETENCE = C.ID_COMPETENCE');

    Joins.Add('join competencepartnames cpn');
    Joins.WhereCondition.Add
      ('CP.IDCOMPETENCEPARTNAME = CPN.ID_COMPETENCEPARTNAME');

    Joins.Add('join COMPETENCEPARTDISCIPLINES cpd');
    Joins.WhereCondition.Add('CPD.IDCOMPETENCEPART = CP.ID_COMPETENCEPART');
  end;

  FIDDisciplineNameParam := T_KParam.Create(Params, 'CPD.IDDISCIPLINENAME');
  FIDDisciplineNameParam.ParamName := 'IDDISCIPLINENAME';
  FIDDisciplineNameParam.ParameterList := FSQLSelectOperator.Joins.on[2];
end;

constructor TAllCompetence.Create(AOwner: TComponent);
begin
  inherited;
  // Таблица, которую будем редактировать
  UpdatingTableName := 'XXX';
  // FTableName := '';

  FSynonymFileName := 'AllCompetenceFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'c.ID_Competence';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('c.ID_Competence');
    Fields.Add('c.Code');
    Fields.Add('c.Description');

    OrderClause.Add('c.Code');
  end;

  Wrap.ImmediateCommit := False;
  TNotifyEventWrap.Create(Wrap.AfterOpen, AfterOpen);
end;

procedure TAllCompetence.AfterOpen(Sender: TObject);
var
  I: Integer;
begin
  // Делаем все поля только для чтения
  for I := 0 to DS.FieldCount - 1 do
  begin
    DS.Fields[I].ReadOnly := True;
  end;
end;

constructor TCompetencePartDetailEx.Create(AOwner: TComponent);
begin
  inherited;
  // Этот запрос используется только в отчёте
  // FTableName := 'XXX'; // редактировать ничего не будем

  // не будем обновлять поля
  UpdatingFieldNames.Clear;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName :=
    'cpdt.ID_CompetencePartDetail';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Distinct := True;

    Fields.Add('cpdt.ID_CompetencePartDetail');
    Fields.Add('cpdt.IDCompetencePart');
    Fields.Add('cpdt.IDCompetenceLevelName');
    Fields.Add('cpdt.CompetencePartDetail');
    Fields.Add('CLN.COMPETENCELEVELNAMEORDER');
    Fields.Add('cpdt.order_');

    // добавляем недостающие поля
    Fields.Add('C.ID_COMPETENCE');
    Fields.Add('cln.CompetenceLevelName');
    Fields.Add('cpn.CompetencePartNameOrder');
    Fields.Add('cpn.CompetencePartName');
    Fields.Add('CPN.COMPETENCEPARTNAMEORDER');

    Joins.Add('join COMPETENCEPARTDETAILS cpdt');
    Joins.WhereCondition.Add('cpdt.IDCompetencePart = CP.ID_COMPETENCEPART');

    Joins.Add('join COMPETENCELEVELNAMES cln');
    Joins.WhereCondition.Add
      ('cpdt.IDCompetenceLevelName = cln.ID_CompetenceLevelName');

    OrderClause.Clear;
    // Сортировать будем на стороне сервера
    OrderClause.Add('C.ID_COMPETENCE');
    OrderClause.Add('cln.CompetenceLevelNameOrder');
    OrderClause.Add('cpn.CompetencePartNameOrder');
    OrderClause.Add('cpdt.order_');
  end;

  FIDCompetenceParam := T_KParam.Create(Params, 'cp.IDCompetence');
  FIDCompetenceParam.ParamName := 'IDCompetence';
end;

procedure TCompetencePartDetailEx.CreateIndex;
begin
  // На стороне клиента сортировки не будет
end;

end.
