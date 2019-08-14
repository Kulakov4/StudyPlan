unit ETP;

interface

uses
  EssenceEx, K_Params, System.Classes, DocumentView, Data.DB, Datasnap.DBClient,
  System.Generics.Collections, OrderEssence, Windows, Messages, NotifyEvents,
  DBRecordHolder, System.IOUtils, LanguageConstants, UMKDataModule,
  StudyPlanInfo, ControlNames, ThemeUnionControls, ThemeUnionIndependentWork,
  IndependentWork, DragHelper, ThemeUnionEducationalWorks, EducationalWorks,
  LessonFeatures, ThemeUnionLessonFeatures, THEMEUNIONTECHNOLOGIES,
  technologies, RearrangeUnit, ETPCatalog, ThemeUnionDetails, ThemeQuestions,
  ThemeQuestionTypes;

const
  WM_AfterHourChange = WM_USER + 111;
  WM_OnDataChange = WM_USER + 112;

type

  TChangedHourData = class(TObject)
  public
    FieldName: string;
    IDThemeUnion: Integer;
    Value: Integer;
    constructor Create(AIDThemeUnion, AValue: Integer; AFieldName: string);
  end;

  TDisciplineSemestrs = class(TEssenceEx2)
  private
    FIDDisciplineParam: T_KFunctionParam;
    procedure OnSessionUnionCalc(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property IDDisciplineParam: T_KFunctionParam read FIDDisciplineParam;
  end;

  TLessonThemes = class(TOrderEssence)
  private
    FErrorThemeName: string;
    FIDDisciplineParam: T_KFunctionParam;
    FLastIDThemeUnion: Integer;
    FLabParam: T_KParam;
    FLecParam: T_KParam;
    FSamParam: T_KParam;
    FSemParam: T_KParam;
    FTotalHourParam: T_KParam;
    procedure BeforeLessonThemesUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure DeleteLessonTheme(const KeyFieldName: String;
      DeltaDS: TCustomClientDataSet);
    function GetIDThemeUnion: TField;
    function GetIsSynchronisedWithMaster: Boolean;
    function GetThemeName: TField;
    function GetThemeOrder: TField;
    procedure OnCalcFields(Sender: TObject);
    procedure InsertOrUpdateLessonTheme(const KeyFieldName: string;
      const FieldNames: Array of String; DeltaDS: TCustomClientDataSet;
      const UpdateKind: TUpdateKind);
    procedure InsertOrUpdateLessonThemeHours(const AIDType: Integer;
      const AFieldName: string; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind);
  protected
    procedure AddSameRecordBeforePost; override;
    function CreateCloneForOrder(AID: Integer): TClientDataSet; override;
    procedure CreateIndex; override;
    procedure DoAfterInsert(Sender: TObject);
    procedure DoOnUpdateOrder(ARecOrder: TRecOrder); override;
    procedure DoPrepareUpdateOrderBeforeInsert; override;
    function GetFilterExpression(AIDThemeUnion: Integer): String;
    function GetOrderField: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AppendRows(AKey: Integer; AValues: TArray<String>);
    procedure CascadeDelete(AIDMaster: Integer); override;
    procedure CopyFrom(ASource: TLessonThemes;
      ASourceIDThemeUnion, ADestIDThemeUnion: Integer);
    function CreateCloneByThemeUnion(AIDThemeUnion: Integer): TClientDataSet;
    // function FindNearestLessonThemeOrder(AIDThemeUnion: Integer;
    // AFirst: Boolean): Integer;
    function IsOK: Boolean;
    procedure MoveDSRecord(AStartDrag: TStartDrag;
      ADropDrag: TDropDrag); override;
    property ErrorThemeName: string read FErrorThemeName;
    // procedure MoveLessonTheme(AStartDrag: TStartDragEx; ADropDrag: TDropDragEx);
    property IDDisciplineParam: T_KFunctionParam read FIDDisciplineParam;
    property IDThemeUnion: TField read GetIDThemeUnion;
    property LastIDThemeUnion: Integer read FLastIDThemeUnion
      write FLastIDThemeUnion;
    property IsSynchronisedWithMaster: Boolean read GetIsSynchronisedWithMaster;
    property LabParam: T_KParam read FLabParam;
    property LecParam: T_KParam read FLecParam;
    property SemParam: T_KParam read FSemParam;
    property SamParam: T_KParam read FSamParam;
    property ThemeName: TField read GetThemeName;
    property ThemeOrder: TField read GetThemeOrder;
    property TotalHourParam: T_KParam read FTotalHourParam;
  end;

  TThemeUnions = class(TOrderEssence)
  private
    FIDDisciplineParam: T_KFunctionParam;
    FLastIDSessionUnion: Integer;
    function GetIDSessionUnion: TField;
    function GetThemeUnion: TField;
    function GetThemeUnionOrder: TField;
  protected
    procedure AddSameRecordBeforePost; override;
    function CreateCloneForOrder(AID: Integer): TClientDataSet; override;
    procedure CreateIndex; override;
    procedure DoAfterInsert(Sender: TObject);
    procedure DoOnUpdateOrder(ARecOrder: TRecOrder); override;
    function GetFilterExpression(AIDSessionUnion: Integer): String;
    function GetOrderField: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AppendRows(AKey: Integer; AValues: TArray<String>);
    function CreateCloneBySessionUnion(AIDSessionUnion: Integer)
      : TClientDataSet;
    function CreateNonEmptyClone: TClientDataSet;
    procedure MoveDSRecord(AStartDrag: TStartDrag;
      ADropDrag: TDropDrag); override;
    property IDDisciplineParam: T_KFunctionParam read FIDDisciplineParam;
    property IDSessionUnion: TField read GetIDSessionUnion;
    property LastIDSessionUnion: Integer read FLastIDSessionUnion
      write FLastIDSessionUnion;
    property ThemeUnion: TField read GetThemeUnion;
    property ThemeUnionOrder: TField read GetThemeUnionOrder;
  end;

  TETPCopyData = class(TDocument)
  private
    FIDDiscipline: Integer;
    procedure SetIDDiscipline(const Value: Integer);
  public
    property IDDiscipline: Integer read FIDDiscipline write SetIDDiscipline;
  end;

  TETP = class(TDocument)
  private
    FAfterUpdate: TNotifyEventsEx;
    FBeforeUpdate: TNotifyEventsEx;
    FCaption: string;
    FCatalogs: TList<TETPCatalog>;
    FChangedHour: TList<TChangedHourData>;
    FControlNames: TControlNames;
    FDeletedIDThemeUnion: Integer;
    FDetails: TList<TEssenceEx2>;
    FThemeUnions: TThemeUnions;
    FDisciplineSemestrs: TDisciplineSemestrs;
    FEducationalWorks: TEducationalWorks;
    FIndependentWork: TIndependentWork;
    FLessonFeatures: TLessonFeatures;
    FLessonThemes: TLessonThemes;
    FOnDataChangeReseive: Boolean;
    FStudyPlanInfo2: TStudyPlanInfo2;
    FTechnologies: TTechnologies;
    FThemeQuestions: TThemeQuestions;
    FThemeQuestionTypes: TThemeQuestionTypes;
    FThemeUnionControl: TThemeUnionControl;
    FThemeUnionEducationalWorks: TThemeUnionEducationalWorks;
    FThemeUnionIndependentWork: TThemeUnionIndependentWork;
    FThemeUnionLessonTheatures: TThemeUnionLessonTheatures;
    FTHEMEUNIONTECHNOLOGIES: TTHEMEUNIONTECHNOLOGIES;
    FWindowHandle: HWND;
    procedure AddOnChangeHourEvent;
    class var FCopyData: TETPCopyData;
    procedure AfterLessonThemeOpen(Sender: TObject);
    procedure AfterThemeUnionsDelete(Sender: TObject);
    procedure BeforeThemeUnionsDelete(Sender: TObject);
    procedure BeforeLessonThemeInsert(Sender: TObject);
    procedure BeforeThemeUnionInsert(Sender: TObject);
    procedure BeforeThemeUnionsUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
    procedure DropOnChangeHourEvent;
    function GetChangeCount: Int64;
    function GetCopyData: TETPCopyData;
    function GetIsCopyEnabled: Boolean;
    function GetIsEmpty: Boolean;
    function GetIsPasteEnabled: Boolean;
    function GetIsThemeUnionEmpty: Boolean;
    procedure OnChangeHours(Sender: TField);
    procedure UpdateHour;
    procedure WndProc(var Msg: TMessage);
  protected
    procedure CopyThemeUnionsFrom(ASource: TETP;
      ASplitData: TObjectList<TSplitData>);
    function HaveSameUnions(ASource: TETP): Boolean;
    procedure OnDataChangeMessage(var Message: TMessage);
      message WM_OnDataChange;
  public
    constructor Create(AOwner: TComponent; AIDDiscipline: Integer);
      reintroduce; overload;
    destructor Destroy; override;
    procedure ApplyUpdates;
    procedure CancelUpdates;
    procedure Copy;
    procedure DeleteThemeUnion;
    procedure DoOnDataChange(Sender: TObject; Field: TField);
    function HaveSameCopyDataUnions: Boolean;
    procedure OnBookmark(Sender: TObject);
    procedure Paste;
    procedure PrepareReport;
    procedure ProcessThematicPlan(ABookmarkData: TBookMarkData);
    property AfterUpdate: TNotifyEventsEx read FAfterUpdate;
    property BeforeUpdate: TNotifyEventsEx read FBeforeUpdate;
    property Caption: string read FCaption write FCaption;
    // procedure FindNearestLessonTheme(AStartDrag: TStartDrag;
    // ADropDrag: TDropDrag);
    property ChangeCount: Int64 read GetChangeCount;
    property ControlNames: TControlNames read FControlNames;
    property ThemeUnions: TThemeUnions read FThemeUnions;
    property DisciplineSemestrs: TDisciplineSemestrs read FDisciplineSemestrs;
    property CopyData: TETPCopyData read GetCopyData;
    property EducationalWorks: TEducationalWorks read FEducationalWorks;
    property IndependentWork: TIndependentWork read FIndependentWork;
    property IsCopyEnabled: Boolean read GetIsCopyEnabled;
    property IsEmpty: Boolean read GetIsEmpty;
    property IsPasteEnabled: Boolean read GetIsPasteEnabled;
    property IsThemeUnionEmpty: Boolean read GetIsThemeUnionEmpty;
    property LessonFeatures: TLessonFeatures read FLessonFeatures;
    property LessonThemes: TLessonThemes read FLessonThemes;
    property StudyPlanInfo2: TStudyPlanInfo2 read FStudyPlanInfo2;
    property technologies: TTechnologies read FTechnologies;
    property ThemeQuestions: TThemeQuestions read FThemeQuestions;
    property ThemeQuestionTypes: TThemeQuestionTypes read FThemeQuestionTypes;
    property ThemeUnionControl: TThemeUnionControl read FThemeUnionControl;
    property ThemeUnionEducationalWorks: TThemeUnionEducationalWorks
      read FThemeUnionEducationalWorks;
    property ThemeUnionIndependentWork: TThemeUnionIndependentWork
      read FThemeUnionIndependentWork;
    property ThemeUnionLessonTheatures: TThemeUnionLessonTheatures
      read FThemeUnionLessonTheatures;
    property THEMEUNIONTECHNOLOGIES: TTHEMEUNIONTECHNOLOGIES
      read FTHEMEUNIONTECHNOLOGIES;
  end;

  TLessonThemes1 = class(TEssenceEx2)
  private
    FIDLessonThemeParam: T_KParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDLessonThemeParam: T_KParam read FIDLessonThemeParam;
  end;

  TLessonThemeHours = class(TEssenceEx2)
  private
    FIDDisciplineParam: T_KParam;
    FIDLessonThemeParam: T_KParam;
    FIDTypeParam: T_KParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDDisciplineParam: T_KParam read FIDDisciplineParam;
    property IDLessonThemeParam: T_KParam read FIDLessonThemeParam;
    property IDTypeParam: T_KParam read FIDTypeParam;
  end;

type

  TSPDisciplines = class(TEssenceEx2)
  private
    FIDStudyPlanParam: T_KParam;
    function GetIDDisciplineName: TField;
    function GetIDSpeciality: TField;
    function GetYear: TField;
  public
    constructor Create(AOwner: TComponent); override;
    property IDDisciplineName: TField read GetIDDisciplineName;
    property IDSpeciality: TField read GetIDSpeciality;
    property IDStudyPlanParam: T_KParam read FIDStudyPlanParam;
    property Year: TField read GetYear;
  end;

  TControlPointsHour = class(TEssenceEx2)
  private
    FIDDisciplineParam: T_KFunctionParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDDisciplineParam: T_KFunctionParam read FIDDisciplineParam;
  end;

  TLessonHourSum = class(TEssenceEx2)
  private
    FIDDisciplineParam: T_KFunctionParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDDisciplineParam: T_KFunctionParam read FIDDisciplineParam;
  end;

  TTotalLessonHourSum = class(TLessonHourSum)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses System.SysUtils, System.Variants, MyDataAccess, Word2010,
  Word2010Ex;

const
  FieldNames: array [0 .. 3] of string = ('Лек', 'Лаб', 'Сем', 'Сам');

constructor TDisciplineSemestrs.Create(AOwner: TComponent);
var
  Field: TStringField;
begin
  inherited;
  FSynonymFileName := 'DisciplineSemestrsFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'ID_SessionUnion';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('*');

    Tables.Add('TABLE( CDB_DAT_UMK.UMKPACK.GetDisciplineSemestrs(0) )');
  end;

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию

  { Добавляем дополнительное, вычисляемое поле }
  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'SessionUnionEx';
    Size := 100;
    FieldKind := fkCalculated;
    Name := DataSetWrap.DataSet.Name + FieldName;
    DataSet := DataSetWrap.DataSet;
    Index := 1;
  end;
  TNotifyEventWrap.Create(Wrap.OnCalcFields, OnSessionUnionCalc);

  with FSQLSelectOperator do
  begin
    Tables[0] :=
      'TABLE( CDB_DAT_UMK.UMKPACK.GetDisciplineSemestrs(:IDDiscipline) )';
  end;

  FIDDisciplineParam := T_KFunctionParam.Create(Params, 'IDDiscipline');
end;

procedure TDisciplineSemestrs.OnSessionUnionCalc(Sender: TObject);
begin
  Field('SessionUnionEx').AsString :=
    Format('%d %s (%s)', [Field('SessionOrder').AsInteger,
    Field('SessionName').AsString, Field('КонтрольнТочки').AsString]);
end;

constructor TETP.Create(AOwner: TComponent; AIDDiscipline: Integer);
begin
  inherited Create(AOwner);
  Assert(AIDDiscipline > 0);

  FOnDataChangeReseive := True;

  FBeforeUpdate := TNotifyEventsEx.Create(Self);
  FAfterUpdate := TNotifyEventsEx.Create(Self);

  FChangedHour := TList<TChangedHourData>.Create;

  FWindowHandle := System.Classes.AllocateHWnd(WndProc);

  // Семестры в которых преподаётся дисциплина
  FDisciplineSemestrs := TDisciplineSemestrs.Create(Self);
  FDisciplineSemestrs.IDDisciplineParam.ParamValue := AIDDiscipline;
  FDisciplineSemestrs.Refresh;

  // Дидактические единицы по дисциплине
  FThemeUnions := TThemeUnions.Create(Self);
  FThemeUnions.Provider.BeforeUpdateRecord := BeforeThemeUnionsUpdateRecord;
  FThemeUnions.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeUnions.ClientDataSet.Wrap.DataSource.OnDataChange := DoOnDataChange;
  FThemeUnions.Refresh;
  with TNotifyEventWrap.Create(FThemeUnions.Wrap.BeforeInsert,
    BeforeThemeUnionInsert) do
    Index := 0; // Хотим первыми получать уведомление

  TNotifyEventWrap.Create(FThemeUnions.Wrap.BeforeDelete,
    BeforeThemeUnionsDelete);
  TNotifyEventWrap.Create(FThemeUnions.Wrap.AfterDelete,
    AfterThemeUnionsDelete);

  // Электронно-тематический план
  FLessonThemes := TLessonThemes.Create(Self);
  FLessonThemes.IDDisciplineParam.ParamValue := AIDDiscipline;
  TNotifyEventWrap.Create(FLessonThemes.Wrap.AfterOpen, AfterLessonThemeOpen);
  FLessonThemes.ClientDataSet.Wrap.DataSource.OnDataChange := DoOnDataChange;
  FLessonThemes.Refresh;
  with TNotifyEventWrap.Create(FLessonThemes.Wrap.BeforeInsert,
    BeforeLessonThemeInsert) do
    Index := 0; // Хотим первыми получать уведомление

  // Текущий контроль по ДЕ
  FThemeUnionControl := TThemeUnionControl.Create(Self);
  FThemeUnionControl.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeUnionControl.ClientDataSet.Wrap.DataSource.OnDataChange :=
    DoOnDataChange;
  FThemeUnionControl.Refresh;

  // Сам работа студента по ДЕ
  FThemeUnionIndependentWork := TThemeUnionIndependentWork.Create(Self);
  FThemeUnionIndependentWork.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeUnionIndependentWork.ClientDataSet.Wrap.DataSource.OnDataChange :=
    DoOnDataChange;
  FThemeUnionIndependentWork.Refresh;

  // Виды учебной работы по ДЕ
  FThemeUnionEducationalWorks := TThemeUnionEducationalWorks.Create(Self);
  FThemeUnionEducationalWorks.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeUnionEducationalWorks.ClientDataSet.Wrap.DataSource.OnDataChange :=
    DoOnDataChange;
  FThemeUnionEducationalWorks.Refresh;

  // особенности проведения занятий по ДЕ
  FThemeUnionLessonTheatures := TThemeUnionLessonTheatures.Create(Self);
  FThemeUnionLessonTheatures.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeUnionLessonTheatures.ClientDataSet.Wrap.DataSource.OnDataChange :=
    DoOnDataChange;
  FThemeUnionLessonTheatures.Refresh;

  // особенности проведения занятий по ДЕ
  FTHEMEUNIONTECHNOLOGIES := TTHEMEUNIONTECHNOLOGIES.Create(Self);
  FTHEMEUNIONTECHNOLOGIES.IDDisciplineParam.ParamValue := AIDDiscipline;
  FTHEMEUNIONTECHNOLOGIES.ClientDataSet.Wrap.DataSource.OnDataChange :=
    DoOnDataChange;
  FTHEMEUNIONTECHNOLOGIES.Refresh;

  // Вопросы по темам
  FThemeQuestions := TThemeQuestions.Create(Self);
  FThemeQuestions.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeQuestions.ClientDataSet.Wrap.DataSource.OnDataChange := DoOnDataChange;
  FThemeQuestions.Refresh;

  // Справочник топов вопросов
  FThemeQuestionTypes := TThemeQuestionTypes.Create(Self);
  FThemeQuestionTypes.Refresh;

  FThemeUnions.Wrap.MultiSelectDSWrap.UseInactiveStyle := False;

  FStudyPlanInfo2 := TStudyPlanInfo2.Create(Self);
  FStudyPlanInfo2.IDDisciplineParam.ParamValue := AIDDiscipline;
  FStudyPlanInfo2.Refresh;
  Assert(FStudyPlanInfo2.DS.RecordCount = 1);

  // Справочник видов сам. раб. студента
  FIndependentWork := TIndependentWork.Create(Self);
  FIndependentWork.Refresh;

  // Справочник текущего контроля
  FControlNames := TControlNames.Create(Self);
  FControlNames.Refresh;

  // Справочник видов учебной работы
  FEducationalWorks := TEducationalWorks.Create(Self);
  FEducationalWorks.Refresh;

  // Справочник особенностей проведения занятий
  FLessonFeatures := TLessonFeatures.Create(Self);
  FLessonFeatures.Refresh;

  // Справочник образовательных технологий занятий
  FTechnologies := TTechnologies.Create(Self);
  FTechnologies.Refresh;

  // Список справочников
  FCatalogs := TList<TETPCatalog>.Create;
  FCatalogs.Add(FControlNames);
  FCatalogs.Add(FIndependentWork);
  FCatalogs.Add(FEducationalWorks);
  FCatalogs.Add(FLessonFeatures);
  FCatalogs.Add(FTechnologies);

  // Список дочерних к ДЕ
  FDetails := TList<TEssenceEx2>.Create;
  FDetails.Add(FLessonThemes);
  FDetails.Add(FThemeUnionControl);
  FDetails.Add(FThemeUnionIndependentWork);
  FDetails.Add(FThemeUnionEducationalWorks);
  FDetails.Add(FThemeUnionLessonTheatures);
  FDetails.Add(FTHEMEUNIONTECHNOLOGIES);
  // Вопросы относятся к теме а не к ДЕ
  // FDetails.Add(FThemeQuestions);
end;

destructor TETP.Destroy;
begin
  DeallocateHWnd(FWindowHandle);
  FreeAndNil(FDetails);
  FreeAndNil(FCatalogs);
  FreeAndNil(FChangedHour);
  inherited;
end;

procedure TETP.AddOnChangeHourEvent;
var
  I: Integer;
begin
  for I := Low(FieldNames) to High(FieldNames) do
    LessonThemes.Field(FieldNames[I]).OnChange := OnChangeHours;
end;

procedure TETP.AfterLessonThemeOpen(Sender: TObject);
begin
  AddOnChangeHourEvent;
end;

procedure TETP.AfterThemeUnionsDelete(Sender: TObject);
var
  ADetail: TEssenceEx2;
begin
  Assert(FDeletedIDThemeUnion > 0);

  // Каскадно удаляем (пока на стороне клиента) все подчинённые ДЕ сущьности
  for ADetail in FDetails do
    ADetail.CascadeDelete(FDeletedIDThemeUnion);
end;

procedure TETP.BeforeThemeUnionsDelete(Sender: TObject);
begin
  FDeletedIDThemeUnion := FThemeUnions.PKValue;
end;

procedure TETP.ApplyUpdates;
var
  ACatalog: TETPCatalog;
  AChangedCatalogs: TList<TETPCatalog>;
  ANeedRefreshList: TList<TEssenceEx2>;
  ADetail: TEssenceEx2;
  AEssence: TEssenceEx2;
begin
  if not LessonThemes.IsOK then
    raise Exception.CreateFmt('Неверное распределение часов по темам.'#13#10 +
      'Общее число часов по теме «%s» равно 0', [LessonThemes.ErrorThemeName]);

  AChangedCatalogs := TList<TETPCatalog>.Create;
  ANeedRefreshList := TList<TEssenceEx2>.Create;
  try
    // Сначала сохраняем все записи в справочниках
    for ACatalog in FCatalogs do
    begin
      // Если в этот справочник вносились изменения
      if ACatalog.ClientDataSet.ChangeCount > 0 then
      begin
        ACatalog.ClientDataSet.ApplyUpdates(0);
        AChangedCatalogs.Add(ACatalog);
      end;
    end;

    // Сначала сохраняем ДЕ. Тут каскадно удалятся темы, тек. контроль и прочее
    if ThemeUnions.ChangeCount > 0 then
    begin
      ThemeUnions.ClientDataSet.ApplyUpdates(0);
      ANeedRefreshList.Add(ThemeUnions);
    end;

    // Сохраняем все дочерние элементы
    for ADetail in FDetails do
    begin
      if ADetail.ClientDataSet.ChangeCount > 0 then
      begin
        if ADetail.ClientDataSet.ApplyUpdates(0) > 0 then
          ADetail.ClientDataSet.CancelUpdates;

        ANeedRefreshList.Add(ADetail);
      end;
    end;

    // Теперь удаляем все неиспользуемые записи в изменившихся справочниках
    for ACatalog in AChangedCatalogs do
    begin
      ACatalog.DropUnused;
      ACatalog.Refresh;
    end;

    // берем данные из БД чтобы обновились "вычисляемые" поля
    for AEssence in ANeedRefreshList do
    begin
      AEssence.Refresh;
    end;
  finally
    FreeAndNil(AChangedCatalogs);
    FreeAndNil(ANeedRefreshList);
  end;
end;

procedure TETP.BeforeLessonThemeInsert(Sender: TObject);
begin
  // До того как произойдёт синхронизация ДЕ с темами, нужно запомнить на какой теме стоял курсор
  LessonThemes.LastIDThemeUnion := ThemeUnions.PKValue;
end;

procedure TETP.BeforeThemeUnionInsert(Sender: TObject);
begin
  // До того как произойдёт синхронизация Сессий с ДЕ, нужно запомнить на какой сессии стоял курсор
  ThemeUnions.LastIDSessionUnion := DisciplineSemestrs.PKValue;
end;

procedure TETP.BeforeThemeUnionsUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);

var
  ADetail: TEssenceEx2;
  AKey: Integer;
  AMySQLQuery: TMySQLQuery;
begin
  if (UpdateKind = ukDelete) then
  begin

    AMySQLQuery := TMySQLQuery.Create(Self, 0);
    try
      AKey := DeltaDS.FieldByName(ThemeUnions.KeyFieldName).OldValue;

      // Каскадно удаляем всё, то подчинено ДЕ
      for ADetail in FDetails do
      begin
        Assert(not ADetail.UpdatingTableName.IsEmpty);
        AMySQLQuery.SQL.Text := Format('delete from %s Where IDThemeUnion = %d',
          [ADetail.UpdatingTableName, AKey]);
        AMySQLQuery.ExecSQL();
      end;
    finally
      FreeAndNil(AMySQLQuery);
    end;
  end;
end;

procedure TETP.CancelUpdates;
var
  ACatalog: TETPCatalog;
  ADetail: TEssenceEx2;
  AEssence: TEssenceEx2;
  ANeedRefreshList: TList<TEssenceEx2>;
begin
  ANeedRefreshList := TList<TEssenceEx2>.Create;
  try
    // отменяем изменения в дочерних элементах
    for ADetail in FDetails do
    begin
      if ADetail.ClientDataSet.ChangeCount > 0 then
      begin
        ADetail.ClientDataSet.CancelUpdates;
        ANeedRefreshList.Add(ADetail);
      end;
    end;

    // Отменяем изменения в справочниках
    for ACatalog in FCatalogs do
    begin
      // Если в этот справочник вносились изменения
      if ACatalog.ClientDataSet.ChangeCount > 0 then
      begin
        ACatalog.ClientDataSet.CancelUpdates;
        ANeedRefreshList.Add(ACatalog);
      end;
    end;

    // Отменяем все сделанные изменения в ДЕ
    if ThemeUnions.ClientDataSet.ChangeCount > 0 then
    begin
      ThemeUnions.ClientDataSet.CancelUpdates;
      ANeedRefreshList.Add(ThemeUnions);
    end;

    // берем данные из БД чтобы обновились "вычисляемые" поля
    for AEssence in ANeedRefreshList do
    begin
      AEssence.Refresh;
    end;

  finally
    FreeAndNil(ANeedRefreshList);
  end;

end;

procedure TETP.Copy;
begin
  CopyData.IDDiscipline := DisciplineSemestrs.IDDisciplineParam.ParamValue;
end;

procedure TETP.CopyThemeUnionsFrom(ASource: TETP;
  ASplitData: TObjectList<TSplitData>);
var
  ARecordHolder: TRecordHolder;
  I: Integer;
  j: Integer;
  p: Integer;
begin
  ARecordHolder := TRecordHolder.Create();
  try
    ASource.ThemeUnions.DS.First;
    // Цикл по всем сессиям в которых нужно создать ДЕ
    for I := 0 to ASplitData.Count - 1 do
    begin
      p := ASplitData[I].Part;
      // Цикл по всем ДЕ i-ой сессии
      for j := 0 to p - 1 do
      begin
        Assert(not ASource.ThemeUnions.DS.Eof);

        // Запоминаем запись
        ARecordHolder.Attach(ASource.ThemeUnions.DS);

        // Меняем код сессии
        ARecordHolder.Field['IDSessionUnion'] := ASplitData[I].ID;

        // Добавляем такую-же ДЕ
        if not ThemeUnions.HaveSameRecord(ASource.ThemeUnions.ThemeUnion, True)
        then
          ThemeUnions.AddSameRecord(ARecordHolder);

        // Копируем темы
        LessonThemes.CopyFrom(ASource.LessonThemes, ASource.ThemeUnions.PKValue,
          ThemeUnions.PKValue);

        // Копируем текущий контроль
        ThemeUnionControl.CopyFrom(ASource.ThemeUnionControl,
          ASource.ThemeUnions.PKValue, ThemeUnions.PKValue);

        // Копируем сам. раб. студента
        ThemeUnionIndependentWork.CopyFrom(ASource.ThemeUnionIndependentWork,
          ASource.ThemeUnions.PKValue, ThemeUnions.PKValue);

        // Копируем виды учебной работы
        ThemeUnionEducationalWorks.CopyFrom(ASource.ThemeUnionEducationalWorks,
          ASource.ThemeUnions.PKValue, ThemeUnions.PKValue);

        // Копируем образовательные технологии
        THEMEUNIONTECHNOLOGIES.CopyFrom(ASource.THEMEUNIONTECHNOLOGIES,
          ASource.ThemeUnions.PKValue, ThemeUnions.PKValue);

        // Копируем особенности проведения занятий
        ThemeUnionLessonTheatures.CopyFrom(ASource.ThemeUnionLessonTheatures,
          ASource.ThemeUnions.PKValue, ThemeUnions.PKValue);

        // Переходим к следующей ДЕ
        ASource.ThemeUnions.DS.Next;
      end;
    end;
  finally
    FreeAndNil(ARecordHolder);
  end;

end;

procedure TETP.DeleteThemeUnion;
var
  AClone: TClientDataSet;
begin
  Assert(ThemeUnions.DS.RecordCount > 0);

  AClone := LessonThemes.CreateClone;
  try
    AClone.Filter := LessonThemes.GetFilterExpression(ThemeUnions.PKValue);
    AClone.Filtered := True;

    // Сначала удаляем ДЕ, т.к. если удалить все темы то курсор передвинется на другую ДЕ
    ThemeUnions.DS.Delete;

    // Удаляем все темы относящиеся к выбранному ДЕ
    while not AClone.Eof do
      AClone.Delete;
  finally
    FreeAndNil(AClone);
  end;

end;

procedure TETP.DoOnDataChange(Sender: TObject; Field: TField);
begin
  // Если предыдущее сообщение уже обработали
  if FOnDataChangeReseive then
  begin
    FOnDataChangeReseive := False;
    PostMessage(FWindowHandle, WM_OnDataChange, 0, 0);
  end;
  // Views.UpdateViews;
end;

procedure TETP.DropOnChangeHourEvent;
var
  I: Integer;
begin
  for I := Low(FieldNames) to High(FieldNames) do
    LessonThemes.Field(FieldNames[I]).OnChange := nil;
end;

function TETP.GetChangeCount: Int64;
var
  ADetail: TEssenceEx2;
begin
  Result := ThemeUnions.ChangeCount;

  for ADetail in FDetails do
  begin
    Inc(Result, ADetail.ChangeCount);
  end;
end;

function TETP.GetCopyData: TETPCopyData;
begin
  if FCopyData = nil then
    FCopyData := TETPCopyData.Create(nil);

  Result := FCopyData;
end;

function TETP.GetIsCopyEnabled: Boolean;
begin
  Result := (ChangeCount = 0) and (LessonThemes.DS.RecordCount > 0);
end;

function TETP.GetIsEmpty: Boolean;
begin
  Result := ThemeUnions.DS.IsEmpty or LessonThemes.DS.IsEmpty;
end;

function TETP.GetIsPasteEnabled: Boolean;
begin
  Result := (CopyData.IDDiscipline > 0) and
    (CopyData.IDDiscipline <> LessonThemes.IDDisciplineParam.ParamValue);
end;

function TETP.GetIsThemeUnionEmpty: Boolean;
var
  AClone: TClientDataSet;
begin
  AClone := LessonThemes.CreateClone;
  try
    AClone.Filter := LessonThemes.GetFilterExpression(ThemeUnions.PKValue);
    AClone.Filtered := True;
    Result := AClone.RecordCount = 0;
  finally
    FreeAndNil(AClone);
  end;
end;

function TETP.HaveSameUnions(ASource: TETP): Boolean;
begin
  Assert(ASource <> nil);
  Result := True;

  // Проверяем, созданы-ли такие-же ДЕ у нас
  ASource.ThemeUnions.DS.First;
  while not ASource.ThemeUnions.DS.Eof do
  begin
    if not ThemeUnions.HaveSameRecord(ASource.ThemeUnions.ThemeUnion) then
    begin
      Result := False;
      System.Break;
    end;
    ASource.ThemeUnions.DS.Next;
  end;
end;

function TETP.HaveSameCopyDataUnions: Boolean;
var
  ASource: TETP;
begin
  Assert(CopyData.IDDiscipline > 0);
  ASource := TETP.Create(Self, CopyData.IDDiscipline);
  try
    Result := HaveSameUnions(ASource);
  finally
    FreeAndNil(ASource);
  end;
end;

procedure TETP.OnBookmark(Sender: TObject);
var
  ABookmarkData: TBookMarkData;
begin
  ABookmarkData := Sender as TBookMarkData;

  if AnsiSameText(ABookmarkData.BookmarkName, 'ТематическийПлан') then
  begin
    ProcessThematicPlan(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, 'Номер') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, '1');
  end;

  if ABookmarkData.BookmarkName.StartsWith('ФормаОбучения', True) then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B,
      FStudyPlanInfo2.UMK.AsString);
  end;

end;

procedure TETP.OnChangeHours(Sender: TField);
var
  AClone: TClientDataSet;
  AOldValue: Integer;
  S: Integer;
begin
  AClone := LessonThemes.CreateCloneForOrder(LessonThemes.PKValue);
  try
    AOldValue := AClone.FieldByName(Sender.FieldName).AsInteger;
    AClone.First;
    S := 0;
    while not AClone.Eof do
    begin
      Inc(S, AClone.FieldByName(Sender.FieldName).AsInteger);
      AClone.Next;
    end;
  finally
    FreeAndNil(AClone);
  end;

  Dec(S, Integer(AOldValue));

  if not VarIsNull(Sender.NewValue) then
    Inc(S, Integer(Sender.NewValue));

  FChangedHour.Add(TChangedHourData.Create(LessonThemes.IDThemeUnion.AsInteger,
    S, Sender.FieldName));
  PostMessage(FWindowHandle, WM_AfterHourChange, 0, 0);
end;

procedure TETP.OnDataChangeMessage(var Message: TMessage);
begin
  inherited;
  FOnDataChangeReseive := True;
  if (Views <> nil) and (Assigned(LessonThemes.Field(FieldNames[0]).OnChange))
  then
    Views.UpdateViews;
end;

procedure TETP.Paste;
var
  AClone: TClientDataSet;
  ARearrange: TRearrange;
  ASplitData: TObjectList<TSplitData>;
  HaveSameThemeUnions: Boolean;
  Proportion: Double;
  Source: TETP;
begin
  Assert(CopyData.FIDDiscipline > 0);
  Assert(LessonThemes.IDDisciplineParam.ParamValue <> CopyData.FIDDiscipline);
  Assert(DisciplineSemestrs.DS.RecordCount > 0);

  // Создаём исходный тематический план
  Source := TETP.Create(Self, CopyData.FIDDiscipline);
  try
    Assert(Source.ThemeUnions.DS.RecordCount > 0);
    Assert(Source.LessonThemes.DS.RecordCount > 0);
    Assert(Source.DisciplineSemestrs.DS.RecordCount > 0);

    // Проверяем, созданы-ли такие-же ДЕ у нас
    HaveSameThemeUnions := True;
    Source.ThemeUnions.DS.First;
    while not Source.ThemeUnions.DS.Eof do
    begin
      if not ThemeUnions.HaveSameRecord(Source.ThemeUnions.ThemeUnion) then
      begin
        HaveSameThemeUnions := False;
        System.Break;
      end;
      Source.ThemeUnions.DS.Next;
    end;

    // Если у нас нет таких ДЕ
    if not HaveSameThemeUnions then
    begin
      // Удаляем все ДЕ
      while not ThemeUnions.DS.Eof do
        DeleteThemeUnion;
    end;

    DropOnChangeHourEvent;
    try
      LessonThemes.DS.DisableControls;
      ThemeUnions.DS.DisableControls;
      ASplitData := TObjectList<TSplitData>.Create();
      try

        // Если число сессий совпадает, то распределим ДЕ по сессиям тем-же образом
        if Source.DisciplineSemestrs.DS.RecordCount = DisciplineSemestrs.DS.RecordCount
        then
        begin
          Source.DisciplineSemestrs.DS.First;
          DisciplineSemestrs.DS.First;

          AClone := Source.ThemeUnions.CreateClone;
          try
            // Цикл по всем сессиям источника
            while not Source.DisciplineSemestrs.DS.Eof do
            begin
              AClone.Filter := Source.ThemeUnions.GetFilterExpression
                (Source.DisciplineSemestrs.PKValue);
              AClone.Filtered := True;

              ASplitData.Add(TSplitData.Create(DisciplineSemestrs.PKValue, 1,
                AClone.RecordCount));

              Source.DisciplineSemestrs.DS.Next;
              DisciplineSemestrs.DS.Next;
            end;
          finally
            FreeAndNil(AClone);
          end;

        end
        else
        begin
          // Если кол-во сессий в источнике не совпадает с приёмником.
          // Будем распределять ДЕ по сессиям иначе
          DisciplineSemestrs.DS.First;

          // Нужно составить таблицу распределения
          Proportion := 1 / DisciplineSemestrs.DS.RecordCount;
          // Цикл по всем сессиям в которых будем создавать ДЕ
          while not DisciplineSemestrs.DS.Eof do
          begin
            ASplitData.Add(TSplitData.Create(DisciplineSemestrs.PKValue,
              Proportion));
            DisciplineSemestrs.DS.Next;
          end;

          // Теперь будем распределять кол-во ДЕ по сессиям
          ARearrange := TRearrange.Create;
          try
            ARearrange.Split(Source.ThemeUnions.DS.RecordCount, ASplitData);
          finally
            ARearrange.Free;
          end;
        end;

        // Копируем дидактические еденицы с учётом распределения их по сессиям
        CopyThemeUnionsFrom(Source, ASplitData);
      finally
        FreeAndNil(ASplitData);
        ThemeUnions.DS.EnableControls;
        LessonThemes.DS.EnableControls;
      end;
    finally
      AddOnChangeHourEvent;
      // В конце вставки обновляем представления
      if Views <> nil then
        Views.UpdateViews;
    end;
  finally
    FreeAndNil(Source);
  end;
end;

procedure TETP.PrepareReport;
var
  ANotifyEventWrap: TNotifyEventWrap;
  TemplateFileName: string;
begin
  TemplateFileName := TPath.Combine(ExtractFilePath(ParamStr(0)),
    TLangConst.ШаблонТемПлана);

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

procedure TETP.ProcessThematicPlan(ABookmarkData: TBookMarkData);
const
  FieldsNames: array [0 .. 3] of String = ('Лек', 'Сем', 'Лаб', 'Сам');
var
  AClone: TClientDataSet;
  AClone2: TClientDataSet;
  AControlPointsHour: TControlPointsHour;
  ALessonHourSum: TLessonHourSum;
  AMergeCells: TList<TMergeCells>;
  NumRows: OleVariant;
  T: Table;
  ARange: WordRange;
  ATotalLessonHourSum: TTotalLessonHourSum;
  I: Integer;
  S: string;
  X: Integer;
  Строгий: Style;
  AThemeRecNo: Integer;
  AThemeUnionRecNo: Integer;
  AWordTable: TWordTable;
  MC: TMergeCells;
  СтильСильноеВыделение: string;
  СтильСтрогий: string;
  СтильТекстТаблицы: String;
begin
  Строгий := ABookmarkData.Document.Styles.Item('Строгий');
  Assert(Строгий <> nil);

  СтильСтрогий := TLangConst.СтильТекстТаблицы + ',' + TLangConst.СтильСтрогий;
  СтильСильноеВыделение := TLangConst.СтильТекстТаблицы + ',' +
    TLangConst.СтильСильноеВыделение;
  СтильТекстТаблицы := TLangConst.СтильТекстТаблицы;

  AThemeUnionRecNo := 0; // Номер ДЕ по порядку
  AThemeRecNo := 0; // Номер темы по порядку

  if ABookmarkData.B.Range.Tables.Count = 0 then
    raise Exception.Create(TLangConst.ОшибкаПриОбработкеТематическогоПлана);

  // Получаем первую таблицу из закладки
  T := ABookmarkData.B.Range.Tables.Item(1);
  Assert(T <> nil);

  ALessonHourSum := TLessonHourSum.Create(nil);
  AControlPointsHour := TControlPointsHour.Create(nil);
  ATotalLessonHourSum := TTotalLessonHourSum.Create(nil);
  try
    AControlPointsHour.IDDisciplineParam.ParamValue :=
      LessonThemes.IDDisciplineParam.ParamValue;
    AControlPointsHour.Refresh;

    ALessonHourSum.IDDisciplineParam.ParamValue :=
      LessonThemes.IDDisciplineParam.ParamValue;
    ALessonHourSum.Refresh;

    ATotalLessonHourSum.IDDisciplineParam.ParamValue :=
      LessonThemes.IDDisciplineParam.ParamValue;
    ATotalLessonHourSum.Refresh;

    AMergeCells := TList<TMergeCells>.Create();
    AWordTable := TWordTable.Create(T);
    try
      // Запоминаем текущую запись и блокируем всё
      DisciplineSemestrs.Wrap.MyBookmark.Save(DisciplineSemestrs.KeyFieldName,
        True, True);
      ThemeUnions.Wrap.MyBookmark.Save(ThemeUnions.KeyFieldName, True, True);
      LessonThemes.Wrap.MyBookmark.Save(LessonThemes.KeyFieldName, True, True);
      try

        LessonThemes.BeginUpdate;
        try
          LessonThemes.TotalHourParam.Operator := '>';
          LessonThemes.TotalHourParam.ParamValue := 0;
        finally
          LessonThemes.EndUpdate();
        end;

        Assert(LessonThemes.DS.RecordCount > 0);

        NumRows := 1;

        DisciplineSemestrs.DS.First;
        // Цикл по семестрам/сессиям
        while not DisciplineSemestrs.DS.Eof do
        begin
          // Добавляем новую строку в конец таблицы
          T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

          // Запоминаем, что ячейки в этой строке нужно будет объединить
          AMergeCells.Add(TMergeCells.Create(T, СтильСильноеВыделение));

          // Заполняем номер семестра/курса
          AWordTable.SetText(T.Rows.Count, 1,
            Format('%d %s', [DisciplineSemestrs.Field('SessionOrder').AsInteger,
            DisciplineSemestrs.Field('SessionName').AsString]));

          AClone := ThemeUnions.CreateCloneBySessionUnion
            (DisciplineSemestrs.PKValue);
          try
            AClone.First;
            // Цикл по всем ДЕ
            while not AClone.Eof do
            begin
              Inc(AThemeUnionRecNo); // Увеличиваем номер ДЕ

              // Получаем все темы этого ДЕ
              AClone2 := LessonThemes.CreateCloneByThemeUnion
                (AClone.FieldByName('ID_ThemeUnion').AsInteger);
              try
                // Если в ДЕ есть хотя-бы одна тема
                if AClone2.RecordCount > 0 then
                begin
                  // Добавляем новую строку в конец таблицы
                  T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

                  // Заполняем название раздела
                  AWordTable.SetText(T.Rows.Count, 1,
                    AClone.FieldByName('ThemeUnion').AsString.Trim);

                  // Запоминаем, что ячейки в этой строке нужно будет объединить
                  AMergeCells.Add(TMergeCells.Create(T, СтильСильноеВыделение));
                  // AMergeRows.Add(T.Rows.Count);

                  // AMergeCols.Clear;
                  MC := nil;
                  AClone2.First;
                  // Цикл по всем темам ДЕ
                  while not AClone2.Eof do
                  begin
                    Inc(AThemeRecNo); // Увеличиваем номер темы
                    // Добавляем новую строку в конец таблицы
                    T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
                    // Запоминаем, что ячеку в этой строке нужно будет объединить
                    if MC = nil then
                    begin
                      MC := TMergeCells.Create(T);
                      MC.EndColumn := 1;
                    end
                    else
                      MC.EndRow := T.Rows.Count;
                    // AMergeCols.Add(T.Rows.Count);

                    AWordTable.SetText(T.Rows.Count, 2,
                      Format('%d. %s', [AThemeRecNo,
                      AClone2.FieldByName('ThemeName').AsString.Trim]),
                      СтильТекстТаблицы, wdAlignParagraphLeft);

                    AWordTable.SetText(T.Rows.Count, 3,
                      AClone2.FieldByName('Всего').AsString, СтильТекстТаблицы,
                      wdAlignParagraphCenter, wdTextOrientationHorizontal,
                      wdCellAlignVerticalCenter);

                    for I := Low(FieldsNames) to High(FieldsNames) do
                    begin
                      if AClone2.FieldByName(FieldsNames[I]).AsInteger > 0 then
                        AWordTable.SetText(T.Rows.Count, 4 + I,
                          AClone2.FieldByName(FieldsNames[I]).AsString,
                          СтильТекстТаблицы, wdAlignParagraphCenter,
                          wdTextOrientationHorizontal,
                          wdCellAlignVerticalCenter);
                    end;
                    AClone2.Next;
                  end;
                  // Добавляем новую строку в конец таблицы
                  T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
                  // Заполняем строку Текущий контроль
                  AWordTable.SetText(T.Rows.Count, 1, 'Текущий контроль');
                  // запоминаем, что нужно будет объеденить ячейки. Объединять будем первый и второй столбец
                  AMergeCells.Add(TMergeCells.Create(T, СтильСильноеВыделение,
                    wdAlignParagraphLeft, 0, 0, 1, 2));

                  // Заполняем сам Текущий контроль
                  // Lookup поле в клоне не доступно
                  // S := VarToStrDef(ThemeUnions.DS.Lookup('ID_ThemeUnion', AClone.FieldByName('ID_ThemeUnion').Value, 'ControlName'), '');
                  AWordTable.SetText(T.Rows.Count, 3,
                    ThemeUnionControl.ToString
                    (AClone.FieldByName('ID_ThemeUnion').AsInteger));

                  // запоминаем, что нужно будет объеденить ячейки. Объединять будем с второго по последний столбец
                  AMergeCells.Add(TMergeCells.Create(T, СтильСильноеВыделение,
                    wdAlignParagraphLeft, 0, 0, 2, T.Columns.Count - 1));

                  // Объединяем ячейки первого столбца
                  Assert(MC <> nil);
                  if MC.StartRow < MC.EndRow then
                    MC.Merge;

                  S := Format('ДЕ %d', [AThemeUnionRecNo]);
                  if AClone.FieldByName('Max_Mark').AsInteger > 0 then
                    S := Format('%s (%d б.)',
                      [S, AClone.FieldByName('Max_Mark').AsInteger]);

                  // Вносим текст
                  AWordTable.SetText(MC.StartRow, MC.StartColumn, S,
                    СтильТекстТаблицы, wdAlignParagraphCenter,
                    wdTextOrientationUpward);

                  FreeAndNil(MC);
                end;
              finally
                FreeAndNil(AClone2);
              end;

              AClone.Next; // Переходим к следующей ДЕ
            end;
            // Достигли конца семестра/курса

            // Добавляем новую строку в конец таблицы
            T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
            // Вставляем текст
            AWordTable.SetText(T.Rows.Count, 1, 'Промежуточная аттестация');
            AWordTable.SetText(T.Rows.Count, 3,
              DisciplineSemestrs.Field('КонтрольнТочки').AsString);
            // запоминаем, что нужно будет объеденить ячейки. Объединять будем первый и второй столбец
            AMergeCells.Add(TMergeCells.Create(T, СтильСильноеВыделение,
              wdAlignParagraphLeft, 0, 0, 1, 2));
            // запоминаем, что нужно будет объеденить ячейки. Объединять будем с второго по последний столбец
            AMergeCells.Add(TMergeCells.Create(T, СтильСильноеВыделение,
              wdAlignParagraphLeft, 0, 0, 2, T.Columns.Count - 1));
            // Добавляем новую строку в конец таблицы
            T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
            // Заполняем итоговые часы за семестр
            AWordTable.SetText(T.Rows.Count, 1, Format('Итого за %s часов',
              [DisciplineSemestrs.Field('SessionName').AsString]));
            // запоминаем, что нужно будет объеденить ячейки в 1 и 2 столбце
            AMergeCells.Add(TMergeCells.Create(T, СтильСильноеВыделение,
              wdAlignParagraphLeft, 0, 0, 1, 2));

            ALessonHourSum.DS.Filter := Format('ID_SessionUnion = %d',
              [Integer(DisciplineSemestrs.PKValue)]);
            ALessonHourSum.DS.Filtered := True;

            AControlPointsHour.DS.Filter := Format('ID_SessionUnion = %d',
              [Integer(DisciplineSemestrs.PKValue)]);
            AControlPointsHour.DS.Filtered := True;

            X := ALessonHourSum.Field('ВсегоЗаСессию').AsInteger;
            S := '%d';
            // если есть часы за Контрольные точки
            if AControlPointsHour.DS.RecordCount > 0 then
            begin
              Inc(X, AControlPointsHour.Field('ВсегоЗаСессию').AsInteger);
              S := '%d*';
            end;

            AWordTable.SetText(T.Rows.Count, 3, Format(S, [X]), СтильСтрогий,
              wdAlignParagraphCenter);

            if ALessonHourSum.DS.RecordCount > 0 then
            begin
              for I := Low(FieldsNames) to High(FieldsNames) do
              begin
                if ALessonHourSum.Field(FieldsNames[I]).AsInteger > 0 then
                  AWordTable.SetText(T.Rows.Count, 4 + I,
                    ALessonHourSum.Field(FieldsNames[I]).AsString, СтильСтрогий,
                    wdAlignParagraphCenter);
              end;
            end;
          finally
            FreeAndNil(AClone);
          end;

          DisciplineSemestrs.DS.Next;
        end;
        // Заполняем итоговые часы за весь курс
        // Добавляем новую строку в конец таблицы
        T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
        // Меняем текст
        T.Cell(T.Rows.Count, 1).Range.Text := 'Итого за весь курс часов';
        // запоминаем, что нужно будет объеденить ячейки в 1 и 2 столбце
        AMergeCells.Add(TMergeCells.Create(T, СтильСильноеВыделение,
          wdAlignParagraphLeft, 0, 0, 1, 2));
        // AMergeRows3.Add(T.Rows.Count);

        // Снимаем фильтр с часов за контрольные точки
        AControlPointsHour.DS.Filtered := False;

        X := ATotalLessonHourSum.Field('Всего').AsInteger;
        S := '%d';
        // если есть часы за Контрольные точки
        if AControlPointsHour.DS.RecordCount > 0 then
        begin
          S := '%d*';
        end;

        AWordTable.SetText(T.Rows.Count, 3, Format(S, [X]), СтильСтрогий,
          wdAlignParagraphCenter);

        if ATotalLessonHourSum.DS.RecordCount > 0 then
        begin
          for I := Low(FieldsNames) to High(FieldsNames) do
          begin
            if ATotalLessonHourSum.Field('Всего' + FieldsNames[I]).AsInteger > 0
            then
              AWordTable.SetText(T.Rows.Count, 4 + I,
                ATotalLessonHourSum.Field('Всего' + FieldsNames[I]).AsString,
                СтильСтрогий, wdAlignParagraphCenter);
          end;
        end;

        // Добавляем новую строку в конец таблицы
        T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
        // Меняем текст
        T.Cell(T.Rows.Count, 1).Range.Text := 'Итого за весь курс з.е.';
        // Меняем текст
        T.Cell(T.Rows.Count, 3).Range.Text :=
          ATotalLessonHourSum.Field('ВсегоЗЕ').AsString;
        // запоминаем, что нужно будет объеденить ячейки в 1 и 2 столбце
        AMergeCells.Add(TMergeCells.Create(T, СтильСильноеВыделение,
          wdAlignParagraphLeft, 0, 0, 1, 2));
        // AMergeRows3.Add(T.Rows.Count);

        while AMergeCells.Count > 0 do
        begin
          // Объединяем ячейки
          AMergeCells[0].Merge;
          AMergeCells[0].Free;
          AMergeCells.Delete(0);
        end;

        ARange := ABookmarkData.Document.Range(T.Cell(1, 1).Range.Start,
          T.Cell(3, T.Columns.Count).Range.End_);
        ARange.Set_Style(Строгий);

        // Сбрасываем условие чтобы вернуться к нужной записи
        LessonThemes.TotalHourParam.SetUnassigned;
      finally
        DisciplineSemestrs.Wrap.MyBookmark.Restore;
        ThemeUnions.Wrap.MyBookmark.Restore;
        LessonThemes.Wrap.MyBookmark.Restore;
      end;
    finally
      FreeAndNil(AMergeCells);
      FreeAndNil(AWordTable);
    end;
  finally
    FreeAndNil(ALessonHourSum);
    FreeAndNil(AControlPointsHour);
    FreeAndNil(ATotalLessonHourSum);
  end;

end;

procedure TETP.UpdateHour;
var
  AClone: TClientDataSet;
  AOldValue: Integer;
  I: Integer;
begin
  if FChangedHour.Count = 0 then
    Exit;
  FBeforeUpdate.CallEventHandlers(Self);
  try
    for I := 0 to FChangedHour.Count - 1 do
    begin
      AClone := ThemeUnions.CreateCloneForOrder
        (FChangedHour.Items[I].IDThemeUnion);
      try
        AOldValue := AClone.FieldByName(FChangedHour.Items[I].FieldName)
          .AsInteger;
        AClone.Edit;
        AClone.FieldByName(FChangedHour.Items[I].FieldName).AsInteger :=
          FChangedHour.Items[I].Value;
        AClone.FieldByName('Всего').AsInteger := AClone.FieldByName('Всего')
          .AsInteger + FChangedHour.Items[I].Value - AOldValue;
        AClone.Post;
      finally
        FreeAndNil(AClone);
      end;
    end;
    FChangedHour.Clear;

  finally
    FAfterUpdate.CallEventHandlers(Self);
  end;
end;

procedure TETP.WndProc(var Msg: TMessage);
var
  M: TMessage;
begin
  with Msg do
    case Msg of
      WM_AfterHourChange:
        UpdateHour;
      WM_OnDataChange:
        OnDataChangeMessage(M);
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
    end;
end;

constructor TLessonThemes.Create(AOwner: TComponent);
begin
  SequenceName := 'CDB_DAT_STUDY_PROCESS.LESSONTHEMES_SEQ';
  inherited;

  FSynonymFileName := 'LessonThemeFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'IDLessonTheme';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('RowNum as RecNo');
    Fields.Add('t.*');

    Tables.Add('TABLE( CDB_DAT_UMK.UMKPACK.GetLessonThemes(:IDDiscipline) ) t');
  end;

  FTotalHourParam := T_KParam.Create(Params, '(t.Лек + t.Лаб + t.Сем + t.Сам)');
  FTotalHourParam.ParamName := 'Total';

  FLecParam := T_KParam.Create(Params, 't.Лек');
  FLecParam.ParamName := 'Lec';

  FLabParam := T_KParam.Create(Params, 't.Лаб');
  FLabParam.ParamName := 'Lab';

  FSemParam := T_KParam.Create(Params, 't.Сем');
  FLabParam.ParamName := 'Sem';

  FSamParam := T_KParam.Create(Params, 't.Сам');
  FLabParam.ParamName := 'Sam';

  FIDDisciplineParam := T_KFunctionParam.Create(Params, 'IDDiscipline');

  // Чтобы выполнить SQL запрос и создать поля по умолчанию
  FIDDisciplineParam.ParamValue := 0;
  SetSQLText;
  SetQueryParams;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию

  Field('Всего').FieldKind := fkCalculated;
  TNotifyEventWrap.Create(Wrap.OnCalcFields, OnCalcFields);

  // FieldByName().FieldKind := fkCalculated;
  // OnCalcFields := OnCalculateFields;

  Wrap.ImmediateCommit := False;
  Provider.BeforeUpdateRecord := BeforeLessonThemesUpdateRecord;

  // Подписываемся на событие AfterInsert
  TNotifyEventWrap.Create(Wrap.AfterInsert, DoAfterInsert);

  UpdatingTableName := 'LessonThemes';
end;

procedure TLessonThemes.AddSameRecordBeforePost;
begin
  // Очищаем все планируемые изменения порядка
  FRecOrderList.Clear;
end;

procedure TLessonThemes.AppendRows(AKey: Integer; AValues: TArray<String>);
var
  I: Integer;
begin
  Assert(AKey > 0);

  for I := Low(AValues) to High(AValues) do
  begin
    DS.Insert;
    ThemeName.AsString := AValues[I];
    DS.Post;
  end;
end;

procedure TLessonThemes.BeforeLessonThemesUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);

const
  FieldsNames: array [0 .. 2] of String = ('ThemeName', 'ThemeOrder',
    'IDThemeUnion');
begin
  if UpdateKind = ukDelete then
    DeleteLessonTheme('IDLessonTheme', DeltaDS)
  else
  begin
    // Обновляем тему для занятий
    InsertOrUpdateLessonTheme('IDLessonTheme', FieldsNames, DeltaDS,
      UpdateKind);

    // Обновляем часы по лекциям
    InsertOrUpdateLessonThemeHours(1, 'Лек', DeltaDS, UpdateKind);
    // Обновляем часы по лабораторным
    InsertOrUpdateLessonThemeHours(2, 'Лаб', DeltaDS, UpdateKind);
    // Обновляем часы по семинарам
    InsertOrUpdateLessonThemeHours(3, 'Сем', DeltaDS, UpdateKind);
    // Обновляем часы по самостоятельной работе
    InsertOrUpdateLessonThemeHours(22, 'Сам', DeltaDS, UpdateKind);
    // Обновляем часы по курсовым работам
    InsertOrUpdateLessonThemeHours(8, 'Курс', DeltaDS, UpdateKind);
    // Обновляем часы по экзаменам
    InsertOrUpdateLessonThemeHours(5, 'Экз', DeltaDS, UpdateKind);
  end;

  Applied := True;
end;

procedure TLessonThemes.CascadeDelete(AIDMaster: Integer);
var
  AClientDataSet: TClientDataSet;
begin
  // Каскадно удаляем все темы
  AClientDataSet := CreateCloneByThemeUnion(AIDMaster);
  try
    while not AClientDataSet.Eof do
    begin
      AClientDataSet.Delete;
    end;
  finally
    FreeAndNil(AClientDataSet);
  end;
end;

procedure TLessonThemes.CopyFrom(ASource: TLessonThemes;
  ASourceIDThemeUnion, ADestIDThemeUnion: Integer);
var
  ARecordHolder: TRecordHolder;
  ALessonThemes: TClientDataSet;
begin
  Assert(ASource <> nil);
  Assert(ASourceIDThemeUnion > 0);
  Assert(ADestIDThemeUnion > 0);

  ARecordHolder := TRecordHolder.Create();
  ALessonThemes := ASource.CreateClone;
  try
    // Фильтруем источник по коду ДЕ
    ALessonThemes.Filter := ASource.GetFilterExpression(ASourceIDThemeUnion);
    ALessonThemes.Filtered := True;
    ALessonThemes.First;
    while not ALessonThemes.Eof do
    begin
      // Добавляем такой-же текущий контроль
      if not HaveSameRecord(ALessonThemes.FieldByName(ThemeName.FieldName)) then
      begin
        // Запоминаем запись
        ARecordHolder.Attach(ALessonThemes);

        // Меняем код ДЕ
        ARecordHolder.Field[IDThemeUnion.FieldName] := ADestIDThemeUnion;

        AddSameRecord(ARecordHolder);
      end;

      ALessonThemes.Next;
    end;
  finally
    FreeAndNil(ALessonThemes);
    FreeAndNil(ARecordHolder);
  end;

end;

function TLessonThemes.CreateCloneByThemeUnion(AIDThemeUnion: Integer)
  : TClientDataSet;
begin
  Result := CreateClone;
  Result.Filter := GetFilterExpression(AIDThemeUnion);
  Result.Filtered := True;
end;

function TLessonThemes.CreateCloneForOrder(AID: Integer): TClientDataSet;
var
  OK: Boolean;
begin
  // Создаём клон
  Result := inherited;
  OK := Result.Locate(KeyFieldName, AID, []);
  Assert(OK);

  // Фильтруем клон
  Result.Filter := GetFilterExpression
    (Result.FieldByName(IDThemeUnion.FieldName).AsInteger);
  Result.Filtered := True;

  // Переходим на ту-же запись в клоне
  OK := Result.Locate(KeyFieldName, AID, []);
  Assert(OK);
end;

procedure TLessonThemes.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1', Format('%s;%s', [IDThemeUnion.FieldName,
    ThemeOrder.FieldName]), []); // 'IDThemeUnion;ThemeOrder', []);
  ClientDataSet.IndexName := 'idx1';
end;

procedure TLessonThemes.DeleteLessonTheme(const KeyFieldName: String;
  DeltaDS: TCustomClientDataSet);
var
  AKeyValue: Variant;
  ALessonThemes1: TLessonThemes1;
begin
  AKeyValue := DeltaDS.FieldByName(KeyFieldName).OldValue;
  ALessonThemes1 := TLessonThemes1.Create(Self);
  try
    ALessonThemes1.IDLessonThemeParam.ParamValue := AKeyValue;
    ALessonThemes1.Refresh;
    Assert(ALessonThemes1.DS.RecordCount <= 1);

    // Может так случится что тему уже удалили при каскадном удалении ДЕ
    if ALessonThemes1.DS.RecordCount = 1 then
      ALessonThemes1.DS.Delete;
  finally
    FreeAndNil(ALessonThemes1);
  end;
end;

procedure TLessonThemes.DoAfterInsert(Sender: TObject);
begin
  ThemeName.AsString := TLangConst.ИмяТемыПоУмолчанию;
  IDThemeUnion.AsInteger := LastIDThemeUnion;
end;

procedure TLessonThemes.DoOnUpdateOrder(ARecOrder: TRecOrder);
begin
  inherited;
  if ARecOrder is TRecOrderEx then
    IDThemeUnion.AsInteger := (ARecOrder as TRecOrderEx).IDParent;
end;

procedure TLessonThemes.DoPrepareUpdateOrderBeforeInsert;
begin
  // Если это первая добавляемая запись
  // или запись добавляется в ту-же ДЕ что была активна перед добавлением
  if (IsSynchronisedWithMaster) then
  begin
    inherited;
  end
  else
  begin
    // если ДЕ была пустая
    FNewRecOrder := 1;
  end;

end;

function TLessonThemes.GetFilterExpression(AIDThemeUnion: Integer): String;
begin
  Result := Format('%s = %d', [IDThemeUnion.FieldName, AIDThemeUnion]);
end;

function TLessonThemes.GetIDThemeUnion: TField;
begin
  Result := Field('IDThemeUnion');
end;

function TLessonThemes.GetIsSynchronisedWithMaster: Boolean;
begin
  Result := IDThemeUnion.AsInteger = LastIDThemeUnion;
end;

function TLessonThemes.GetOrderField: TField;
begin
  Result := ThemeOrder;
end;

function TLessonThemes.GetThemeName: TField;
begin
  Result := Field('ThemeName');
end;

function TLessonThemes.GetThemeOrder: TField;
begin
  Result := Field('ThemeOrder');
end;

function TLessonThemes.IsOK: Boolean;
var
  AClone: TClientDataSet;
  Всего: Integer;
begin
  // Если тематический план пустой
  if ClientDataSet.RecordCount = 0 then
  begin
    Result := True;
    Exit;
  end;

  // Проверяем текущую запись
  Всего := ClientDataSet.FieldByName('Лек').AsInteger +
    ClientDataSet.FieldByName('Лаб').AsInteger + ClientDataSet.FieldByName
    ('Сем').AsInteger + ClientDataSet.FieldByName('Сам').AsInteger;
  // +
  // ClientDataSet.FieldByName('Курс').AsInteger + ClientDataSet.FieldByName
  // ('Экз').AsInteger;

  Result := Всего > 0;

  if not Result then
  begin
    FErrorThemeName := ClientDataSet.FieldByName('ThemeName').AsString;
    Exit;
  end;

  // Создаём клона
  AClone := CreateClone;
  try
    AClone.First;
    while not AClone.Eof do
    begin
      // if AClone.FieldByName('IDLessonTheme').AsInteger = 80039 then
      // Beep;
      Всего := AClone.FieldByName('Лек').AsInteger + AClone.FieldByName('Лаб')
        .AsInteger + AClone.FieldByName('Сем').AsInteger +
        AClone.FieldByName('Сам').AsInteger;
      // +
      // AClone.FieldByName('Курс').AsInteger + ClientDataSet.FieldByName
      // ('Экз').AsInteger;

      Result := Всего > 0;

      if not Result then
      begin
        FErrorThemeName := AClone.FieldByName('ThemeName').AsString;
        System.Break;
      end;

      AClone.Next;
    end;
  finally
    FreeAndNil(AClone);
  end;
end;

procedure TLessonThemes.OnCalcFields(Sender: TObject);
begin
  Field('Всего').AsInteger := Field('Лек').AsInteger + Field('Лаб').AsInteger +
    Field('Сем').AsInteger + Field('Сам').AsInteger;
end;

procedure TLessonThemes.InsertOrUpdateLessonTheme(const KeyFieldName: string;
  const FieldNames: Array of String; DeltaDS: TCustomClientDataSet;
  const UpdateKind: TUpdateKind);
var
  AFieldName: string;
  AKeyValue: Variant;
  ALessonThemes1: TLessonThemes1;
  ANewValue: Variant;
  AOldValue: Variant;
  I: Integer;
begin
  AKeyValue := DeltaDS.FieldByName(KeyFieldName).OldValue;
  try
    for I := Low(FieldNames) to High(FieldNames) do
    begin
      AFieldName := FieldNames[I];
      ANewValue := DeltaDS.FieldByName(AFieldName).NewValue;
      AOldValue := DeltaDS.FieldByName(AFieldName).OldValue;

      if not VarIsEmpty(ANewValue) then
      begin
        if ((ANewValue <> AOldValue) and (UpdateKind = ukModify)) or
          (UpdateKind = ukInsert) then
        begin
          if ALessonThemes1 = nil then
          begin
            ALessonThemes1 := TLessonThemes1.Create(Self);
            ALessonThemes1.IDLessonThemeParam.ParamValue := AKeyValue;
            ALessonThemes1.Refresh;

            // Если такая запись в БД уже есть
            if ALessonThemes1.DS.RecordCount = 1 then
              ALessonThemes1.DS.Edit
            else
            begin
              ALessonThemes1.DS.Insert;
              ALessonThemes1.Field(ALessonThemes1.KeyFieldName).Value :=
                AKeyValue;
            end;
          end;

          ALessonThemes1.Field(AFieldName).Value := ANewValue;
        end;
      end;
    end;
  finally
    if ALessonThemes1 <> nil then
    begin
      // Сохраняем изменения в БД
      ALessonThemes1.DS.Post;
      FreeAndNil(ALessonThemes1);
    end;
  end;
end;

procedure TLessonThemes.InsertOrUpdateLessonThemeHours(const AIDType: Integer;
  const AFieldName: string; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind);
var
  // AID_LessonType: Integer;
  ALessonThemeHours2: TLessonThemeHours;
  ANewValue, AOldValue: Integer;
  // AThemeLessonType: TThemeLessonType;
begin
  if not VarIsEmpty(DeltaDS.FieldByName(AFieldName).NewValue) then
  begin
    ANewValue := StrToInt(VarToStrDef(DeltaDS.FieldByName(AFieldName)
      .NewValue, '0'));
    AOldValue := StrToInt(VarToStrDef(DeltaDS.FieldByName(AFieldName)
      .OldValue, '0'));
    if ((ANewValue <> AOldValue) and (UpdateKind = ukModify)) or
      ((UpdateKind = ukInsert) and (ANewValue <> 0)) then
    begin

      ALessonThemeHours2 := TLessonThemeHours.Create(Self);
      try
        ALessonThemeHours2.IDDisciplineParam.ParamValue :=
          IDDisciplineParam.ParamValue;

        ALessonThemeHours2.IDLessonThemeParam.ParamValue :=
          DeltaDS.FieldByName('IDLessonTheme').OldValue;

        ALessonThemeHours2.IDTypeParam.ParamValue := AIDType;
        ALessonThemeHours2.Refresh;

        // Если часы изменились
        if (UpdateKind = ukModify) and (AOldValue <> 0) then
        begin
          Assert(ALessonThemeHours2.DS.RecordCount = 1);

          if ANewValue <> 0 then
          begin
            Assert(ANewValue > 0);
            // Будем редактировать число часов
            ALessonThemeHours2.DS.Edit;
            ALessonThemeHours2.Field('Hours').AsInteger := ANewValue;
            ALessonThemeHours2.DS.Post;
          end
          else
          begin
            // Будем удалять
            ALessonThemeHours2.DS.Delete;
            Assert(ALessonThemeHours2.DS.RecordCount = 0);
          end;

        end
        else
        begin
          // Если часы появились
          Assert(ALessonThemeHours2.DS.RecordCount = 0);
          Assert(ANewValue > 0);

          // Будем добавлять часы
          ALessonThemeHours2.DS.Insert;
          ALessonThemeHours2.Field('IDLessonTheme').AsInteger :=
            ALessonThemeHours2.IDLessonThemeParam.ParamValue;

          ALessonThemeHours2.Field('IDType').AsInteger :=
            ALessonThemeHours2.IDTypeParam.ParamValue;

          ALessonThemeHours2.Field('IDDiscipline').AsInteger :=
            ALessonThemeHours2.IDDisciplineParam.ParamValue;

          ALessonThemeHours2.Field('Hours').AsInteger := ANewValue;
          ALessonThemeHours2.DS.Post;
        end;

      finally
        FreeAndNil(ALessonThemeHours2);
      end;
    end;
  end;
end;

procedure TLessonThemes.MoveDSRecord(AStartDrag: TStartDrag;
  ADropDrag: TDropDrag);
var
  AClone: TClientDataSet;
  ADropDragEx: TDropDragEx;
  ARecOrder: TRecOrderEx;
  AStartDragEx: TStartDragEx;
  I: Integer;
begin
  AStartDragEx := AStartDrag as TStartDragEx;
  ADropDragEx := ADropDrag as TDropDragEx;

  // Если был перенос в рамках одной ДЕ
  if AStartDragEx.IDParent = ADropDragEx.IDParent then
  begin
    inherited;
    Exit;
  end;

  // если был перенос темы в другую ДЕ
  // Готовимся обновить порядок тем как при удалении темы
  AClone := CreateCloneForOrder(AStartDrag.Keys[0]);
  try
    if not AClone.Locate(OrderField.FieldName, AStartDrag.MaxOrderValue, [])
    then
      raise Exception.CreateFmt('Внутренняя ошибка при перемещении записи %d',
        [AStartDrag.MaxOrderValue]);

    AClone.Next;
    if not AClone.Eof then
      // Будем поднимать вверх все темы, после последней перетаскиваемой
      PrepareUpdateOrder(AClone, -1 * Length(AStartDrag.Keys));
  finally
    FreeAndNil(AClone);
  end;

  // если в точке переноса была тема, которую надо подвинуть
  if ADropDrag.Key > 0 then
  begin
    // Готовимся обновить порядок тем как при добавлении темы
    AClone := CreateCloneForOrder(ADropDrag.Key);
    try
      // Будем опускать вниз все темы, начиная с текущей
      PrepareUpdateOrder(AClone, 1 * Length(AStartDrag.Keys));
    finally
      FreeAndNil(AClone);
    end;
  end;

  // Готовимся изменить порядок тех тем, которые переносили
  for I := Low(AStartDrag.Keys) to High(AStartDrag.Keys) do
  begin
    ARecOrder := TRecOrderEx.Create(AStartDrag.Keys[I],
      ADropDrag.OrderValue + I);
    // ARecOrder.Key := AStartDrag.Keys[I];
    // ARecOrder.Order := ADropDrag.OrderValue + I;
    (ARecOrder as TRecOrderEx).IDParent := ADropDragEx.IDParent;
    FRecOrderList.Add(ARecOrder);
  end;

  // Выполняем все изменения
  UpdateOrder;

  // Заново создаём индекс. Он почему-то исчезает
  CreateIndex;
end;

constructor TThemeUnions.Create(AOwner: TComponent);
const
  NotUpdatedFieldsNames: array [0 .. 4] of String = ('Всего', 'Лек', 'Лаб',
    'Сем', 'Сам');
begin
  SequenceName := 'CDB_DAT_STUDY_PROCESS.THEMEUNIONS_SEQ';
  inherited;
  FSynonymFileName := 'ThemeUnionFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'ID_ThemeUnion';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('*');

    Tables.Add('TABLE( CDB_DAT_UMK.UMKPACK.GetThemeUnions(:IDDiscipline) )');
  end;
  FIDDisciplineParam := T_KFunctionParam.Create(Params, 'IDDiscipline');
  (*
    // Чтобы выполнить SQL запрос и создать поля по умолчанию
    FIDDisciplineParam.ParamValue := 0;
    SetSQLText;
    SetQueryParams;
    Wrap.CreateDefaultFields; // Создаём поля по умолчанию

    // Создаём стандарты учебных планов
    FControlNames := TControlNames.Create(Self);
    FControlNames.Refresh;

    { Добавляем дополнительное, подстановочное поле }
    Field := TStringField.Create(DataSetWrap.DataSet);
    with Field do
    begin
    FieldName := 'ControlName';
    Size := 100;
    FieldKind := fkLookup;
    Name := DS.Name + FieldName;
    KeyFields := 'IDControlName';
    LookUpDataset := FControlNames.DS;
    LookUpKeyFields := 'ID_ControlName';
    LookUpResultField := 'ControlName';
    DataSet := DS;
    end;
  *)
  Wrap.ImmediateCommit := False;

  UpdatingTableName := 'THEMEUNIONS';
  UpdatingFieldNames.Add('IDSessionUnion');
  UpdatingFieldNames.Add('ThemeUnion');
  UpdatingFieldNames.Add('ThemeUnionOrder');
  UpdatingFieldNames.Add('Max_Mark');

  // Подписываемся на события
  TNotifyEventWrap.Create(Wrap.AfterInsert, DoAfterInsert);
end;

procedure TThemeUnions.AddSameRecordBeforePost;
begin
  // Очищаем все планируемые изменения порядка
  FRecOrderList.Clear;
end;

procedure TThemeUnions.AppendRows(AKey: Integer; AValues: TArray<String>);
var
  I: Integer;
begin
  Assert(AKey > 0);

  for I := Low(AValues) to High(AValues) do
  begin
    DS.Insert;
    ThemeUnion.AsString := AValues[I];
    DS.Post;
  end;
end;

function TThemeUnions.CreateCloneBySessionUnion(AIDSessionUnion: Integer)
  : TClientDataSet;
begin
  Result := CreateClone;
  Result.Filter := GetFilterExpression(AIDSessionUnion);
  Result.Filtered := True;
end;

function TThemeUnions.CreateCloneForOrder(AID: Integer): TClientDataSet;
var
  OK: Boolean;
begin

  // Создаём клон
  Result := inherited;
  OK := Result.Locate(KeyFieldName, AID, []);
  Assert(OK);

  // Фильтруем клон
  Result.Filter := GetFilterExpression
    (Result.FieldByName(IDSessionUnion.FieldName).AsInteger);
  Result.Filtered := True;

  // Переходим на ту-же запись в клоне
  OK := Result.Locate(KeyFieldName, AID, []);
  Assert(OK);
end;

procedure TThemeUnions.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1', Format('%s;%s', [IDSessionUnion.FieldName,
    ThemeUnionOrder.FieldName]), []);
  ClientDataSet.IndexName := 'idx1';
end;

function TThemeUnions.CreateNonEmptyClone: TClientDataSet;
begin
  Result := CreateClone;
  // Оставляем только непустые ДЕ
  Result.Filter := '[ВСЕГО] > 0';
  Result.Filtered := True;
end;

procedure TThemeUnions.DoAfterInsert(Sender: TObject);
begin
  ThemeUnion.AsString := TLangConst.ИмяРазделаПоУмолчанию;
  IDSessionUnion.AsInteger := FLastIDSessionUnion;
end;

procedure TThemeUnions.DoOnUpdateOrder(ARecOrder: TRecOrder);
begin
  inherited;
  if ARecOrder is TRecOrderEx then
    IDSessionUnion.AsInteger := (ARecOrder as TRecOrderEx).IDParent
end;

function TThemeUnions.GetFilterExpression(AIDSessionUnion: Integer): String;
begin
  Result := Format('%s = %d', [IDSessionUnion.FieldName, AIDSessionUnion]);
end;

function TThemeUnions.GetIDSessionUnion: TField;
begin
  Result := Field('IDSessionUnion');
end;

function TThemeUnions.GetOrderField: TField;
begin
  Result := ThemeUnionOrder;
end;

function TThemeUnions.GetThemeUnion: TField;
begin
  Result := Field('ThemeUnion');
end;

function TThemeUnions.GetThemeUnionOrder: TField;
begin
  Result := Field('ThemeUnionOrder');
end;

procedure TThemeUnions.MoveDSRecord(AStartDrag: TStartDrag;
  ADropDrag: TDropDrag);
var
  AClone: TClientDataSet;
  ADropDragEx: TDropDragEx;
  ARecOrder: TRecOrderEx;
  AStartDragEx: TStartDragEx;
  I: Integer;
begin
  AStartDragEx := AStartDrag as TStartDragEx;
  ADropDragEx := ADropDrag as TDropDragEx;

  // Если был перенос в рамках одной сессии
  if AStartDragEx.IDParent = ADropDragEx.IDParent then
  begin
    inherited;
    Exit;
  end;

  // если был перенос ДЕ в другую Сессию
  // Готовимся обновить порядок ДЕ как при удалении ДЕ
  AClone := CreateCloneForOrder(AStartDrag.Keys[0]);
  try
    if not AClone.Locate(OrderField.FieldName, AStartDrag.MaxOrderValue, [])
    then
      raise Exception.CreateFmt('Внутренняя ошибка при перемещении записи %d',
        [AStartDrag.MaxOrderValue]);

    AClone.Next;
    if not AClone.Eof then
      // Будем поднимать вверх все темы, после последней перетаскиваемой
      PrepareUpdateOrder(AClone, -1 * Length(AStartDrag.Keys));
  finally
    FreeAndNil(AClone);
  end;

  // если в точке переноса была ДЕ, которую надо подвинуть
  if ADropDrag.Key > 0 then
  begin
    // Готовимся обновить порядок ДЕ как при добавлении ДЕ
    AClone := CreateCloneForOrder(ADropDrag.Key);
    try
      // Будем опускать вниз все темы, начиная с текущей
      PrepareUpdateOrder(AClone, 1 * Length(AStartDrag.Keys));
    finally
      FreeAndNil(AClone);
    end;
  end;

  // Готовимся изменить порядок тех ДЕ, которые переносили
  for I := Low(AStartDrag.Keys) to High(AStartDrag.Keys) do
  begin
    ARecOrder := TRecOrderEx.Create(AStartDrag.Keys[I],
      ADropDrag.OrderValue + I);
    // ARecOrder.Key := AStartDrag.Keys[I];
    // ARecOrder.Order := ADropDrag.OrderValue + I;
    (ARecOrder as TRecOrderEx).IDParent := ADropDragEx.IDParent;
    FRecOrderList.Add(ARecOrder);
  end;

  // Выполняем все изменения
  UpdateOrder;

  // Заново создаём индекс. Он почему-то исчезает
  CreateIndex;
end;

constructor TLessonThemes1.Create(AOwner: TComponent);
begin
  inherited;
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'lth.ID_LessonTheme';

  with FSQLSelectOperator do
  begin
    Fields.Add('lth.*');

    Tables.Add('LESSONTHEMES lth');
  end;

  FIDLessonThemeParam := T_KParam.Create(Params, 'lth.ID_Lessontheme');
  FIDLessonThemeParam.ParamName := 'ID_Lessontheme';

  Wrap.ImmediateCommit := True;
  KeyFieldProviderFlags := [pfInKey, pfInUpdate];
end;

constructor TLessonThemeHours.Create(AOwner: TComponent);
begin
  inherited;
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'lthh.ID_LessonThemeHour';

  with FSQLSelectOperator do
  begin
    Fields.Add('lthh.*');

    Tables.Add('LessonThemeHours lthh');
  end;

  FIDTypeParam := T_KParam.Create(Params, 'LThh.IDType');
  FIDTypeParam.ParamName := 'IDType';

  FIDDisciplineParam := T_KParam.Create(Params, 'lthh.IDDiscipline');
  FIDDisciplineParam.ParamName := 'id_discipline';

  FIDLessonThemeParam := T_KParam.Create(Params, 'lthh.IDLessonTheme');
  FIDLessonThemeParam.ParamName := 'idlessontheme';

  KeyFieldProviderFlags := [pfInKey];
  // SequenceName := 'cdb_dat_study_process.LESSONTHEMEHOURS_SEQ';
  Wrap.ImmediateCommit := True;
end;

constructor TChangedHourData.Create(AIDThemeUnion, AValue: Integer;
  AFieldName: string);
begin
  IDThemeUnion := AIDThemeUnion;
  Value := AValue;
  FieldName := AFieldName;
end;

constructor TSPDisciplines.Create(AOwner: TComponent);
begin
  inherited;
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'd.ID_Discipline';

  with FSQLSelectOperator do
  begin
    Fields.Add('d.ID_Discipline');
    Fields.Add('nvl(dn.shortdisciplinename, dn.DisciplineName) DisciplineName');
    Fields.Add('dn.DisciplineName FullDisciplineName');
    Fields.Add('d.IDDisciplineName');
    Fields.Add('SE.IDSPECIALITY');
    Fields.Add('SE.YEAR');

    Tables.Add('disciplines d');

    Joins.Add('join Disciplinenames dn');
    Joins.WhereCondition.Add('D.IDDISCIPLINENAME = DN.ID_DISCIPLINENAME');

    Joins.Add('join studyplans sp');
    Joins.WhereCondition.Add('D.IDSTUDYPLAN = SP.ID_STUDYPLAN');

    Joins.Add('join cyclespecialityeducations cse');
    Joins.WhereCondition.Add
      ('SP.IDCYCLESPECIALITYEDUCATION = CSE.ID_CYCLESPECIALITYEDUCATION');

    Joins.Add('join specialityeducations se');
    Joins.WhereCondition.Add
      ('cse.idspecialityeducation = SE.ID_SPECIALITYEDUCATION');

  end;

  FIDStudyPlanParam := T_KParam.Create(Params, 'd.idstudyplan');
  FIDStudyPlanParam.ParamName := 'idstudyplan';
end;

function TSPDisciplines.GetIDDisciplineName: TField;
begin
  Result := Field('IDDisciplineName');
end;

function TSPDisciplines.GetIDSpeciality: TField;
begin
  Result := Field('IDSpeciality');
end;

function TSPDisciplines.GetYear: TField;
begin
  Result := Field('Year');
end;

procedure TETPCopyData.SetIDDiscipline(const Value: Integer);
begin
  if FIDDiscipline <> Value then
  begin
    FIDDiscipline := Value;
    Views.UpdateViews;
  end;
end;

constructor TControlPointsHour.Create(AOwner: TComponent);
begin
  inherited;
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('*');

    Tables.Add
      ('TABLE( CDB_DAT_UMK.UMKPACK.GetControlPointsHour(:IDDiscipline) )');
  end;

  FIDDisciplineParam := T_KFunctionParam.Create(Params, 'IDDiscipline');
end;

constructor TLessonHourSum.Create(AOwner: TComponent);
begin
  inherited;
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('t1.*');

    Tables.Add
      ('TABLE( CDB_DAT_UMK.UMKPACK.GetLessonHourSum(:IDDiscipline) ) t1');
  end;

  FIDDisciplineParam := T_KFunctionParam.Create(Params, 'IDDiscipline');
end;

constructor TTotalLessonHourSum.Create(AOwner: TComponent);
begin
  inherited;

  with FSQLSelectOperator do
  begin
    Fields.Clear;
    Fields.Add
      ('round( sum( t1.ВсегоЗаСессию + nvl(t2.ВсегоЗаСессию, 0) ) / 36, 0 ) ВсегоЗЕ');
    Fields.Add('sum( t1.ВсегоЗаСессию + nvl(t2.ВсегоЗаСессию, 0) ) Всего');
    Fields.Add('sum(t1.лек) ВсегоЛек');
    Fields.Add('sum(t1.Лаб) ВсегоЛаб');
    Fields.Add('sum(t1.Сем) ВсегоСем');
    Fields.Add('sum(t1.Сам) ВсегоСам');

    Joins.Add(
      'left join ( select unique id_sessionunion, всегозасессию from table(cdb_dat_umk.umkpack.GetControlPointsHour(:IDDiscipline))) t2'
      // 'left join table(cdb_dat_umk.umkpack.GetControlPointsHour(:IDDiscipline)) t2'
      );
    Joins.WhereCondition.Add('t1.ID_SessionUnion = t2.ID_SessionUnion');
  end;
end;

end.
