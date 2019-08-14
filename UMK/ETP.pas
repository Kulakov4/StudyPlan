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
  FieldNames: array [0 .. 3] of string = ('���', '���', '���', '���');

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
  Wrap.CreateDefaultFields; // ������ ���� �� ���������

  { ��������� ��������������, ����������� ���� }
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
    Field('SessionName').AsString, Field('��������������').AsString]);
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

  // �������� � ������� ���������� ����������
  FDisciplineSemestrs := TDisciplineSemestrs.Create(Self);
  FDisciplineSemestrs.IDDisciplineParam.ParamValue := AIDDiscipline;
  FDisciplineSemestrs.Refresh;

  // ������������� ������� �� ����������
  FThemeUnions := TThemeUnions.Create(Self);
  FThemeUnions.Provider.BeforeUpdateRecord := BeforeThemeUnionsUpdateRecord;
  FThemeUnions.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeUnions.ClientDataSet.Wrap.DataSource.OnDataChange := DoOnDataChange;
  FThemeUnions.Refresh;
  with TNotifyEventWrap.Create(FThemeUnions.Wrap.BeforeInsert,
    BeforeThemeUnionInsert) do
    Index := 0; // ����� ������� �������� �����������

  TNotifyEventWrap.Create(FThemeUnions.Wrap.BeforeDelete,
    BeforeThemeUnionsDelete);
  TNotifyEventWrap.Create(FThemeUnions.Wrap.AfterDelete,
    AfterThemeUnionsDelete);

  // ����������-������������ ����
  FLessonThemes := TLessonThemes.Create(Self);
  FLessonThemes.IDDisciplineParam.ParamValue := AIDDiscipline;
  TNotifyEventWrap.Create(FLessonThemes.Wrap.AfterOpen, AfterLessonThemeOpen);
  FLessonThemes.ClientDataSet.Wrap.DataSource.OnDataChange := DoOnDataChange;
  FLessonThemes.Refresh;
  with TNotifyEventWrap.Create(FLessonThemes.Wrap.BeforeInsert,
    BeforeLessonThemeInsert) do
    Index := 0; // ����� ������� �������� �����������

  // ������� �������� �� ��
  FThemeUnionControl := TThemeUnionControl.Create(Self);
  FThemeUnionControl.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeUnionControl.ClientDataSet.Wrap.DataSource.OnDataChange :=
    DoOnDataChange;
  FThemeUnionControl.Refresh;

  // ��� ������ �������� �� ��
  FThemeUnionIndependentWork := TThemeUnionIndependentWork.Create(Self);
  FThemeUnionIndependentWork.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeUnionIndependentWork.ClientDataSet.Wrap.DataSource.OnDataChange :=
    DoOnDataChange;
  FThemeUnionIndependentWork.Refresh;

  // ���� ������� ������ �� ��
  FThemeUnionEducationalWorks := TThemeUnionEducationalWorks.Create(Self);
  FThemeUnionEducationalWorks.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeUnionEducationalWorks.ClientDataSet.Wrap.DataSource.OnDataChange :=
    DoOnDataChange;
  FThemeUnionEducationalWorks.Refresh;

  // ����������� ���������� ������� �� ��
  FThemeUnionLessonTheatures := TThemeUnionLessonTheatures.Create(Self);
  FThemeUnionLessonTheatures.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeUnionLessonTheatures.ClientDataSet.Wrap.DataSource.OnDataChange :=
    DoOnDataChange;
  FThemeUnionLessonTheatures.Refresh;

  // ����������� ���������� ������� �� ��
  FTHEMEUNIONTECHNOLOGIES := TTHEMEUNIONTECHNOLOGIES.Create(Self);
  FTHEMEUNIONTECHNOLOGIES.IDDisciplineParam.ParamValue := AIDDiscipline;
  FTHEMEUNIONTECHNOLOGIES.ClientDataSet.Wrap.DataSource.OnDataChange :=
    DoOnDataChange;
  FTHEMEUNIONTECHNOLOGIES.Refresh;

  // ������� �� �����
  FThemeQuestions := TThemeQuestions.Create(Self);
  FThemeQuestions.IDDisciplineParam.ParamValue := AIDDiscipline;
  FThemeQuestions.ClientDataSet.Wrap.DataSource.OnDataChange := DoOnDataChange;
  FThemeQuestions.Refresh;

  // ���������� ����� ��������
  FThemeQuestionTypes := TThemeQuestionTypes.Create(Self);
  FThemeQuestionTypes.Refresh;

  FThemeUnions.Wrap.MultiSelectDSWrap.UseInactiveStyle := False;

  FStudyPlanInfo2 := TStudyPlanInfo2.Create(Self);
  FStudyPlanInfo2.IDDisciplineParam.ParamValue := AIDDiscipline;
  FStudyPlanInfo2.Refresh;
  Assert(FStudyPlanInfo2.DS.RecordCount = 1);

  // ���������� ����� ���. ���. ��������
  FIndependentWork := TIndependentWork.Create(Self);
  FIndependentWork.Refresh;

  // ���������� �������� ��������
  FControlNames := TControlNames.Create(Self);
  FControlNames.Refresh;

  // ���������� ����� ������� ������
  FEducationalWorks := TEducationalWorks.Create(Self);
  FEducationalWorks.Refresh;

  // ���������� ������������ ���������� �������
  FLessonFeatures := TLessonFeatures.Create(Self);
  FLessonFeatures.Refresh;

  // ���������� ��������������� ���������� �������
  FTechnologies := TTechnologies.Create(Self);
  FTechnologies.Refresh;

  // ������ ������������
  FCatalogs := TList<TETPCatalog>.Create;
  FCatalogs.Add(FControlNames);
  FCatalogs.Add(FIndependentWork);
  FCatalogs.Add(FEducationalWorks);
  FCatalogs.Add(FLessonFeatures);
  FCatalogs.Add(FTechnologies);

  // ������ �������� � ��
  FDetails := TList<TEssenceEx2>.Create;
  FDetails.Add(FLessonThemes);
  FDetails.Add(FThemeUnionControl);
  FDetails.Add(FThemeUnionIndependentWork);
  FDetails.Add(FThemeUnionEducationalWorks);
  FDetails.Add(FThemeUnionLessonTheatures);
  FDetails.Add(FTHEMEUNIONTECHNOLOGIES);
  // ������� ��������� � ���� � �� � ��
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

  // �������� ������� (���� �� ������� �������) ��� ���������� �� ���������
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
    raise Exception.CreateFmt('�������� ������������� ����� �� �����.'#13#10 +
      '����� ����� ����� �� ���� �%s� ����� 0', [LessonThemes.ErrorThemeName]);

  AChangedCatalogs := TList<TETPCatalog>.Create;
  ANeedRefreshList := TList<TEssenceEx2>.Create;
  try
    // ������� ��������� ��� ������ � ������������
    for ACatalog in FCatalogs do
    begin
      // ���� � ���� ���������� ��������� ���������
      if ACatalog.ClientDataSet.ChangeCount > 0 then
      begin
        ACatalog.ClientDataSet.ApplyUpdates(0);
        AChangedCatalogs.Add(ACatalog);
      end;
    end;

    // ������� ��������� ��. ��� �������� �������� ����, ���. �������� � ������
    if ThemeUnions.ChangeCount > 0 then
    begin
      ThemeUnions.ClientDataSet.ApplyUpdates(0);
      ANeedRefreshList.Add(ThemeUnions);
    end;

    // ��������� ��� �������� ��������
    for ADetail in FDetails do
    begin
      if ADetail.ClientDataSet.ChangeCount > 0 then
      begin
        if ADetail.ClientDataSet.ApplyUpdates(0) > 0 then
          ADetail.ClientDataSet.CancelUpdates;

        ANeedRefreshList.Add(ADetail);
      end;
    end;

    // ������ ������� ��� �������������� ������ � ������������ ������������
    for ACatalog in AChangedCatalogs do
    begin
      ACatalog.DropUnused;
      ACatalog.Refresh;
    end;

    // ����� ������ �� �� ����� ���������� "�����������" ����
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
  // �� ���� ��� ��������� ������������� �� � ������, ����� ��������� �� ����� ���� ����� ������
  LessonThemes.LastIDThemeUnion := ThemeUnions.PKValue;
end;

procedure TETP.BeforeThemeUnionInsert(Sender: TObject);
begin
  // �� ���� ��� ��������� ������������� ������ � ��, ����� ��������� �� ����� ������ ����� ������
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

      // �������� ������� ��, �� ��������� ��
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
    // �������� ��������� � �������� ���������
    for ADetail in FDetails do
    begin
      if ADetail.ClientDataSet.ChangeCount > 0 then
      begin
        ADetail.ClientDataSet.CancelUpdates;
        ANeedRefreshList.Add(ADetail);
      end;
    end;

    // �������� ��������� � ������������
    for ACatalog in FCatalogs do
    begin
      // ���� � ���� ���������� ��������� ���������
      if ACatalog.ClientDataSet.ChangeCount > 0 then
      begin
        ACatalog.ClientDataSet.CancelUpdates;
        ANeedRefreshList.Add(ACatalog);
      end;
    end;

    // �������� ��� ��������� ��������� � ��
    if ThemeUnions.ClientDataSet.ChangeCount > 0 then
    begin
      ThemeUnions.ClientDataSet.CancelUpdates;
      ANeedRefreshList.Add(ThemeUnions);
    end;

    // ����� ������ �� �� ����� ���������� "�����������" ����
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
    // ���� �� ���� ������� � ������� ����� ������� ��
    for I := 0 to ASplitData.Count - 1 do
    begin
      p := ASplitData[I].Part;
      // ���� �� ���� �� i-�� ������
      for j := 0 to p - 1 do
      begin
        Assert(not ASource.ThemeUnions.DS.Eof);

        // ���������� ������
        ARecordHolder.Attach(ASource.ThemeUnions.DS);

        // ������ ��� ������
        ARecordHolder.Field['IDSessionUnion'] := ASplitData[I].ID;

        // ��������� �����-�� ��
        if not ThemeUnions.HaveSameRecord(ASource.ThemeUnions.ThemeUnion, True)
        then
          ThemeUnions.AddSameRecord(ARecordHolder);

        // �������� ����
        LessonThemes.CopyFrom(ASource.LessonThemes, ASource.ThemeUnions.PKValue,
          ThemeUnions.PKValue);

        // �������� ������� ��������
        ThemeUnionControl.CopyFrom(ASource.ThemeUnionControl,
          ASource.ThemeUnions.PKValue, ThemeUnions.PKValue);

        // �������� ���. ���. ��������
        ThemeUnionIndependentWork.CopyFrom(ASource.ThemeUnionIndependentWork,
          ASource.ThemeUnions.PKValue, ThemeUnions.PKValue);

        // �������� ���� ������� ������
        ThemeUnionEducationalWorks.CopyFrom(ASource.ThemeUnionEducationalWorks,
          ASource.ThemeUnions.PKValue, ThemeUnions.PKValue);

        // �������� ��������������� ����������
        THEMEUNIONTECHNOLOGIES.CopyFrom(ASource.THEMEUNIONTECHNOLOGIES,
          ASource.ThemeUnions.PKValue, ThemeUnions.PKValue);

        // �������� ����������� ���������� �������
        ThemeUnionLessonTheatures.CopyFrom(ASource.ThemeUnionLessonTheatures,
          ASource.ThemeUnions.PKValue, ThemeUnions.PKValue);

        // ��������� � ��������� ��
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

    // ������� ������� ��, �.�. ���� ������� ��� ���� �� ������ ������������ �� ������ ��
    ThemeUnions.DS.Delete;

    // ������� ��� ���� ����������� � ���������� ��
    while not AClone.Eof do
      AClone.Delete;
  finally
    FreeAndNil(AClone);
  end;

end;

procedure TETP.DoOnDataChange(Sender: TObject; Field: TField);
begin
  // ���� ���������� ��������� ��� ����������
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

  // ���������, �������-�� �����-�� �� � ���
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

  if AnsiSameText(ABookmarkData.BookmarkName, '����������������') then
  begin
    ProcessThematicPlan(ABookmarkData);
  end;

  if AnsiSameText(ABookmarkData.BookmarkName, '�����') then
  begin
    TUMKDM.Instance.ReplaceBookmark(ABookmarkData.B, '1');
  end;

  if ABookmarkData.BookmarkName.StartsWith('�������������', True) then
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

  // ������ �������� ������������ ����
  Source := TETP.Create(Self, CopyData.FIDDiscipline);
  try
    Assert(Source.ThemeUnions.DS.RecordCount > 0);
    Assert(Source.LessonThemes.DS.RecordCount > 0);
    Assert(Source.DisciplineSemestrs.DS.RecordCount > 0);

    // ���������, �������-�� �����-�� �� � ���
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

    // ���� � ��� ��� ����� ��
    if not HaveSameThemeUnions then
    begin
      // ������� ��� ��
      while not ThemeUnions.DS.Eof do
        DeleteThemeUnion;
    end;

    DropOnChangeHourEvent;
    try
      LessonThemes.DS.DisableControls;
      ThemeUnions.DS.DisableControls;
      ASplitData := TObjectList<TSplitData>.Create();
      try

        // ���� ����� ������ ���������, �� ����������� �� �� ������� ���-�� �������
        if Source.DisciplineSemestrs.DS.RecordCount = DisciplineSemestrs.DS.RecordCount
        then
        begin
          Source.DisciplineSemestrs.DS.First;
          DisciplineSemestrs.DS.First;

          AClone := Source.ThemeUnions.CreateClone;
          try
            // ���� �� ���� ������� ���������
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
          // ���� ���-�� ������ � ��������� �� ��������� � ���������.
          // ����� ������������ �� �� ������� �����
          DisciplineSemestrs.DS.First;

          // ����� ��������� ������� �������������
          Proportion := 1 / DisciplineSemestrs.DS.RecordCount;
          // ���� �� ���� ������� � ������� ����� ��������� ��
          while not DisciplineSemestrs.DS.Eof do
          begin
            ASplitData.Add(TSplitData.Create(DisciplineSemestrs.PKValue,
              Proportion));
            DisciplineSemestrs.DS.Next;
          end;

          // ������ ����� ������������ ���-�� �� �� �������
          ARearrange := TRearrange.Create;
          try
            ARearrange.Split(Source.ThemeUnions.DS.RecordCount, ASplitData);
          finally
            ARearrange.Free;
          end;
        end;

        // �������� ������������� ������� � ������ ������������� �� �� �������
        CopyThemeUnionsFrom(Source, ASplitData);
      finally
        FreeAndNil(ASplitData);
        ThemeUnions.DS.EnableControls;
        LessonThemes.DS.EnableControls;
      end;
    finally
      AddOnChangeHourEvent;
      // � ����� ������� ��������� �������������
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
    TLangConst.��������������);

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
  FieldsNames: array [0 .. 3] of String = ('���', '���', '���', '���');
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
  �������: Style;
  AThemeRecNo: Integer;
  AThemeUnionRecNo: Integer;
  AWordTable: TWordTable;
  MC: TMergeCells;
  ���������������������: string;
  ������������: string;
  �����������������: String;
begin
  ������� := ABookmarkData.Document.Styles.Item('�������');
  Assert(������� <> nil);

  ������������ := TLangConst.����������������� + ',' + TLangConst.������������;
  ��������������������� := TLangConst.����������������� + ',' +
    TLangConst.���������������������;
  ����������������� := TLangConst.�����������������;

  AThemeUnionRecNo := 0; // ����� �� �� �������
  AThemeRecNo := 0; // ����� ���� �� �������

  if ABookmarkData.B.Range.Tables.Count = 0 then
    raise Exception.Create(TLangConst.������������������������������������);

  // �������� ������ ������� �� ��������
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
      // ���������� ������� ������ � ��������� ��
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
        // ���� �� ���������/�������
        while not DisciplineSemestrs.DS.Eof do
        begin
          // ��������� ����� ������ � ����� �������
          T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

          // ����������, ��� ������ � ���� ������ ����� ����� ����������
          AMergeCells.Add(TMergeCells.Create(T, ���������������������));

          // ��������� ����� ��������/�����
          AWordTable.SetText(T.Rows.Count, 1,
            Format('%d %s', [DisciplineSemestrs.Field('SessionOrder').AsInteger,
            DisciplineSemestrs.Field('SessionName').AsString]));

          AClone := ThemeUnions.CreateCloneBySessionUnion
            (DisciplineSemestrs.PKValue);
          try
            AClone.First;
            // ���� �� ���� ��
            while not AClone.Eof do
            begin
              Inc(AThemeUnionRecNo); // ����������� ����� ��

              // �������� ��� ���� ����� ��
              AClone2 := LessonThemes.CreateCloneByThemeUnion
                (AClone.FieldByName('ID_ThemeUnion').AsInteger);
              try
                // ���� � �� ���� ����-�� ���� ����
                if AClone2.RecordCount > 0 then
                begin
                  // ��������� ����� ������ � ����� �������
                  T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);

                  // ��������� �������� �������
                  AWordTable.SetText(T.Rows.Count, 1,
                    AClone.FieldByName('ThemeUnion').AsString.Trim);

                  // ����������, ��� ������ � ���� ������ ����� ����� ����������
                  AMergeCells.Add(TMergeCells.Create(T, ���������������������));
                  // AMergeRows.Add(T.Rows.Count);

                  // AMergeCols.Clear;
                  MC := nil;
                  AClone2.First;
                  // ���� �� ���� ����� ��
                  while not AClone2.Eof do
                  begin
                    Inc(AThemeRecNo); // ����������� ����� ����
                    // ��������� ����� ������ � ����� �������
                    T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
                    // ����������, ��� ����� � ���� ������ ����� ����� ����������
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
                      �����������������, wdAlignParagraphLeft);

                    AWordTable.SetText(T.Rows.Count, 3,
                      AClone2.FieldByName('�����').AsString, �����������������,
                      wdAlignParagraphCenter, wdTextOrientationHorizontal,
                      wdCellAlignVerticalCenter);

                    for I := Low(FieldsNames) to High(FieldsNames) do
                    begin
                      if AClone2.FieldByName(FieldsNames[I]).AsInteger > 0 then
                        AWordTable.SetText(T.Rows.Count, 4 + I,
                          AClone2.FieldByName(FieldsNames[I]).AsString,
                          �����������������, wdAlignParagraphCenter,
                          wdTextOrientationHorizontal,
                          wdCellAlignVerticalCenter);
                    end;
                    AClone2.Next;
                  end;
                  // ��������� ����� ������ � ����� �������
                  T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
                  // ��������� ������ ������� ��������
                  AWordTable.SetText(T.Rows.Count, 1, '������� ��������');
                  // ����������, ��� ����� ����� ���������� ������. ���������� ����� ������ � ������ �������
                  AMergeCells.Add(TMergeCells.Create(T, ���������������������,
                    wdAlignParagraphLeft, 0, 0, 1, 2));

                  // ��������� ��� ������� ��������
                  // Lookup ���� � ����� �� ��������
                  // S := VarToStrDef(ThemeUnions.DS.Lookup('ID_ThemeUnion', AClone.FieldByName('ID_ThemeUnion').Value, 'ControlName'), '');
                  AWordTable.SetText(T.Rows.Count, 3,
                    ThemeUnionControl.ToString
                    (AClone.FieldByName('ID_ThemeUnion').AsInteger));

                  // ����������, ��� ����� ����� ���������� ������. ���������� ����� � ������� �� ��������� �������
                  AMergeCells.Add(TMergeCells.Create(T, ���������������������,
                    wdAlignParagraphLeft, 0, 0, 2, T.Columns.Count - 1));

                  // ���������� ������ ������� �������
                  Assert(MC <> nil);
                  if MC.StartRow < MC.EndRow then
                    MC.Merge;

                  S := Format('�� %d', [AThemeUnionRecNo]);
                  if AClone.FieldByName('Max_Mark').AsInteger > 0 then
                    S := Format('%s (%d �.)',
                      [S, AClone.FieldByName('Max_Mark').AsInteger]);

                  // ������ �����
                  AWordTable.SetText(MC.StartRow, MC.StartColumn, S,
                    �����������������, wdAlignParagraphCenter,
                    wdTextOrientationUpward);

                  FreeAndNil(MC);
                end;
              finally
                FreeAndNil(AClone2);
              end;

              AClone.Next; // ��������� � ��������� ��
            end;
            // �������� ����� ��������/�����

            // ��������� ����� ������ � ����� �������
            T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
            // ��������� �����
            AWordTable.SetText(T.Rows.Count, 1, '������������� ����������');
            AWordTable.SetText(T.Rows.Count, 3,
              DisciplineSemestrs.Field('��������������').AsString);
            // ����������, ��� ����� ����� ���������� ������. ���������� ����� ������ � ������ �������
            AMergeCells.Add(TMergeCells.Create(T, ���������������������,
              wdAlignParagraphLeft, 0, 0, 1, 2));
            // ����������, ��� ����� ����� ���������� ������. ���������� ����� � ������� �� ��������� �������
            AMergeCells.Add(TMergeCells.Create(T, ���������������������,
              wdAlignParagraphLeft, 0, 0, 2, T.Columns.Count - 1));
            // ��������� ����� ������ � ����� �������
            T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
            // ��������� �������� ���� �� �������
            AWordTable.SetText(T.Rows.Count, 1, Format('����� �� %s �����',
              [DisciplineSemestrs.Field('SessionName').AsString]));
            // ����������, ��� ����� ����� ���������� ������ � 1 � 2 �������
            AMergeCells.Add(TMergeCells.Create(T, ���������������������,
              wdAlignParagraphLeft, 0, 0, 1, 2));

            ALessonHourSum.DS.Filter := Format('ID_SessionUnion = %d',
              [Integer(DisciplineSemestrs.PKValue)]);
            ALessonHourSum.DS.Filtered := True;

            AControlPointsHour.DS.Filter := Format('ID_SessionUnion = %d',
              [Integer(DisciplineSemestrs.PKValue)]);
            AControlPointsHour.DS.Filtered := True;

            X := ALessonHourSum.Field('�������������').AsInteger;
            S := '%d';
            // ���� ���� ���� �� ����������� �����
            if AControlPointsHour.DS.RecordCount > 0 then
            begin
              Inc(X, AControlPointsHour.Field('�������������').AsInteger);
              S := '%d*';
            end;

            AWordTable.SetText(T.Rows.Count, 3, Format(S, [X]), ������������,
              wdAlignParagraphCenter);

            if ALessonHourSum.DS.RecordCount > 0 then
            begin
              for I := Low(FieldsNames) to High(FieldsNames) do
              begin
                if ALessonHourSum.Field(FieldsNames[I]).AsInteger > 0 then
                  AWordTable.SetText(T.Rows.Count, 4 + I,
                    ALessonHourSum.Field(FieldsNames[I]).AsString, ������������,
                    wdAlignParagraphCenter);
              end;
            end;
          finally
            FreeAndNil(AClone);
          end;

          DisciplineSemestrs.DS.Next;
        end;
        // ��������� �������� ���� �� ���� ����
        // ��������� ����� ������ � ����� �������
        T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
        // ������ �����
        T.Cell(T.Rows.Count, 1).Range.Text := '����� �� ���� ���� �����';
        // ����������, ��� ����� ����� ���������� ������ � 1 � 2 �������
        AMergeCells.Add(TMergeCells.Create(T, ���������������������,
          wdAlignParagraphLeft, 0, 0, 1, 2));
        // AMergeRows3.Add(T.Rows.Count);

        // ������� ������ � ����� �� ����������� �����
        AControlPointsHour.DS.Filtered := False;

        X := ATotalLessonHourSum.Field('�����').AsInteger;
        S := '%d';
        // ���� ���� ���� �� ����������� �����
        if AControlPointsHour.DS.RecordCount > 0 then
        begin
          S := '%d*';
        end;

        AWordTable.SetText(T.Rows.Count, 3, Format(S, [X]), ������������,
          wdAlignParagraphCenter);

        if ATotalLessonHourSum.DS.RecordCount > 0 then
        begin
          for I := Low(FieldsNames) to High(FieldsNames) do
          begin
            if ATotalLessonHourSum.Field('�����' + FieldsNames[I]).AsInteger > 0
            then
              AWordTable.SetText(T.Rows.Count, 4 + I,
                ATotalLessonHourSum.Field('�����' + FieldsNames[I]).AsString,
                ������������, wdAlignParagraphCenter);
          end;
        end;

        // ��������� ����� ������ � ����� �������
        T.Cell(T.Rows.Count, 1).Range.Rows.Add(EmptyParam);
        // ������ �����
        T.Cell(T.Rows.Count, 1).Range.Text := '����� �� ���� ���� �.�.';
        // ������ �����
        T.Cell(T.Rows.Count, 3).Range.Text :=
          ATotalLessonHourSum.Field('�������').AsString;
        // ����������, ��� ����� ����� ���������� ������ � 1 � 2 �������
        AMergeCells.Add(TMergeCells.Create(T, ���������������������,
          wdAlignParagraphLeft, 0, 0, 1, 2));
        // AMergeRows3.Add(T.Rows.Count);

        while AMergeCells.Count > 0 do
        begin
          // ���������� ������
          AMergeCells[0].Merge;
          AMergeCells[0].Free;
          AMergeCells.Delete(0);
        end;

        ARange := ABookmarkData.Document.Range(T.Cell(1, 1).Range.Start,
          T.Cell(3, T.Columns.Count).Range.End_);
        ARange.Set_Style(�������);

        // ���������� ������� ����� ��������� � ������ ������
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
        AClone.FieldByName('�����').AsInteger := AClone.FieldByName('�����')
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

  FTotalHourParam := T_KParam.Create(Params, '(t.��� + t.��� + t.��� + t.���)');
  FTotalHourParam.ParamName := 'Total';

  FLecParam := T_KParam.Create(Params, 't.���');
  FLecParam.ParamName := 'Lec';

  FLabParam := T_KParam.Create(Params, 't.���');
  FLabParam.ParamName := 'Lab';

  FSemParam := T_KParam.Create(Params, 't.���');
  FLabParam.ParamName := 'Sem';

  FSamParam := T_KParam.Create(Params, 't.���');
  FLabParam.ParamName := 'Sam';

  FIDDisciplineParam := T_KFunctionParam.Create(Params, 'IDDiscipline');

  // ����� ��������� SQL ������ � ������� ���� �� ���������
  FIDDisciplineParam.ParamValue := 0;
  SetSQLText;
  SetQueryParams;
  Wrap.CreateDefaultFields; // ������ ���� �� ���������

  Field('�����').FieldKind := fkCalculated;
  TNotifyEventWrap.Create(Wrap.OnCalcFields, OnCalcFields);

  // FieldByName().FieldKind := fkCalculated;
  // OnCalcFields := OnCalculateFields;

  Wrap.ImmediateCommit := False;
  Provider.BeforeUpdateRecord := BeforeLessonThemesUpdateRecord;

  // ������������� �� ������� AfterInsert
  TNotifyEventWrap.Create(Wrap.AfterInsert, DoAfterInsert);

  UpdatingTableName := 'LessonThemes';
end;

procedure TLessonThemes.AddSameRecordBeforePost;
begin
  // ������� ��� ����������� ��������� �������
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
    // ��������� ���� ��� �������
    InsertOrUpdateLessonTheme('IDLessonTheme', FieldsNames, DeltaDS,
      UpdateKind);

    // ��������� ���� �� �������
    InsertOrUpdateLessonThemeHours(1, '���', DeltaDS, UpdateKind);
    // ��������� ���� �� ������������
    InsertOrUpdateLessonThemeHours(2, '���', DeltaDS, UpdateKind);
    // ��������� ���� �� ���������
    InsertOrUpdateLessonThemeHours(3, '���', DeltaDS, UpdateKind);
    // ��������� ���� �� ��������������� ������
    InsertOrUpdateLessonThemeHours(22, '���', DeltaDS, UpdateKind);
    // ��������� ���� �� �������� �������
    InsertOrUpdateLessonThemeHours(8, '����', DeltaDS, UpdateKind);
    // ��������� ���� �� ���������
    InsertOrUpdateLessonThemeHours(5, '���', DeltaDS, UpdateKind);
  end;

  Applied := True;
end;

procedure TLessonThemes.CascadeDelete(AIDMaster: Integer);
var
  AClientDataSet: TClientDataSet;
begin
  // �������� ������� ��� ����
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
    // ��������� �������� �� ���� ��
    ALessonThemes.Filter := ASource.GetFilterExpression(ASourceIDThemeUnion);
    ALessonThemes.Filtered := True;
    ALessonThemes.First;
    while not ALessonThemes.Eof do
    begin
      // ��������� �����-�� ������� ��������
      if not HaveSameRecord(ALessonThemes.FieldByName(ThemeName.FieldName)) then
      begin
        // ���������� ������
        ARecordHolder.Attach(ALessonThemes);

        // ������ ��� ��
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
  // ������ ����
  Result := inherited;
  OK := Result.Locate(KeyFieldName, AID, []);
  Assert(OK);

  // ��������� ����
  Result.Filter := GetFilterExpression
    (Result.FieldByName(IDThemeUnion.FieldName).AsInteger);
  Result.Filtered := True;

  // ��������� �� ��-�� ������ � �����
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

    // ����� ��� �������� ��� ���� ��� ������� ��� ��������� �������� ��
    if ALessonThemes1.DS.RecordCount = 1 then
      ALessonThemes1.DS.Delete;
  finally
    FreeAndNil(ALessonThemes1);
  end;
end;

procedure TLessonThemes.DoAfterInsert(Sender: TObject);
begin
  ThemeName.AsString := TLangConst.������������������;
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
  // ���� ��� ������ ����������� ������
  // ��� ������ ����������� � ��-�� �� ��� ���� ������� ����� �����������
  if (IsSynchronisedWithMaster) then
  begin
    inherited;
  end
  else
  begin
    // ���� �� ���� ������
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
  �����: Integer;
begin
  // ���� ������������ ���� ������
  if ClientDataSet.RecordCount = 0 then
  begin
    Result := True;
    Exit;
  end;

  // ��������� ������� ������
  ����� := ClientDataSet.FieldByName('���').AsInteger +
    ClientDataSet.FieldByName('���').AsInteger + ClientDataSet.FieldByName
    ('���').AsInteger + ClientDataSet.FieldByName('���').AsInteger;
  // +
  // ClientDataSet.FieldByName('����').AsInteger + ClientDataSet.FieldByName
  // ('���').AsInteger;

  Result := ����� > 0;

  if not Result then
  begin
    FErrorThemeName := ClientDataSet.FieldByName('ThemeName').AsString;
    Exit;
  end;

  // ������ �����
  AClone := CreateClone;
  try
    AClone.First;
    while not AClone.Eof do
    begin
      // if AClone.FieldByName('IDLessonTheme').AsInteger = 80039 then
      // Beep;
      ����� := AClone.FieldByName('���').AsInteger + AClone.FieldByName('���')
        .AsInteger + AClone.FieldByName('���').AsInteger +
        AClone.FieldByName('���').AsInteger;
      // +
      // AClone.FieldByName('����').AsInteger + ClientDataSet.FieldByName
      // ('���').AsInteger;

      Result := ����� > 0;

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
  Field('�����').AsInteger := Field('���').AsInteger + Field('���').AsInteger +
    Field('���').AsInteger + Field('���').AsInteger;
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

            // ���� ����� ������ � �� ��� ����
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
      // ��������� ��������� � ��
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

        // ���� ���� ����������
        if (UpdateKind = ukModify) and (AOldValue <> 0) then
        begin
          Assert(ALessonThemeHours2.DS.RecordCount = 1);

          if ANewValue <> 0 then
          begin
            Assert(ANewValue > 0);
            // ����� ������������� ����� �����
            ALessonThemeHours2.DS.Edit;
            ALessonThemeHours2.Field('Hours').AsInteger := ANewValue;
            ALessonThemeHours2.DS.Post;
          end
          else
          begin
            // ����� �������
            ALessonThemeHours2.DS.Delete;
            Assert(ALessonThemeHours2.DS.RecordCount = 0);
          end;

        end
        else
        begin
          // ���� ���� ���������
          Assert(ALessonThemeHours2.DS.RecordCount = 0);
          Assert(ANewValue > 0);

          // ����� ��������� ����
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

  // ���� ��� ������� � ������ ����� ��
  if AStartDragEx.IDParent = ADropDragEx.IDParent then
  begin
    inherited;
    Exit;
  end;

  // ���� ��� ������� ���� � ������ ��
  // ��������� �������� ������� ��� ��� ��� �������� ����
  AClone := CreateCloneForOrder(AStartDrag.Keys[0]);
  try
    if not AClone.Locate(OrderField.FieldName, AStartDrag.MaxOrderValue, [])
    then
      raise Exception.CreateFmt('���������� ������ ��� ����������� ������ %d',
        [AStartDrag.MaxOrderValue]);

    AClone.Next;
    if not AClone.Eof then
      // ����� ��������� ����� ��� ����, ����� ��������� ���������������
      PrepareUpdateOrder(AClone, -1 * Length(AStartDrag.Keys));
  finally
    FreeAndNil(AClone);
  end;

  // ���� � ����� �������� ���� ����, ������� ���� ���������
  if ADropDrag.Key > 0 then
  begin
    // ��������� �������� ������� ��� ��� ��� ���������� ����
    AClone := CreateCloneForOrder(ADropDrag.Key);
    try
      // ����� �������� ���� ��� ����, ������� � �������
      PrepareUpdateOrder(AClone, 1 * Length(AStartDrag.Keys));
    finally
      FreeAndNil(AClone);
    end;
  end;

  // ��������� �������� ������� ��� ���, ������� ����������
  for I := Low(AStartDrag.Keys) to High(AStartDrag.Keys) do
  begin
    ARecOrder := TRecOrderEx.Create(AStartDrag.Keys[I],
      ADropDrag.OrderValue + I);
    // ARecOrder.Key := AStartDrag.Keys[I];
    // ARecOrder.Order := ADropDrag.OrderValue + I;
    (ARecOrder as TRecOrderEx).IDParent := ADropDragEx.IDParent;
    FRecOrderList.Add(ARecOrder);
  end;

  // ��������� ��� ���������
  UpdateOrder;

  // ������ ������ ������. �� ������-�� ��������
  CreateIndex;
end;

constructor TThemeUnions.Create(AOwner: TComponent);
const
  NotUpdatedFieldsNames: array [0 .. 4] of String = ('�����', '���', '���',
    '���', '���');
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
    // ����� ��������� SQL ������ � ������� ���� �� ���������
    FIDDisciplineParam.ParamValue := 0;
    SetSQLText;
    SetQueryParams;
    Wrap.CreateDefaultFields; // ������ ���� �� ���������

    // ������ ��������� ������� ������
    FControlNames := TControlNames.Create(Self);
    FControlNames.Refresh;

    { ��������� ��������������, �������������� ���� }
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

  // ������������� �� �������
  TNotifyEventWrap.Create(Wrap.AfterInsert, DoAfterInsert);
end;

procedure TThemeUnions.AddSameRecordBeforePost;
begin
  // ������� ��� ����������� ��������� �������
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

  // ������ ����
  Result := inherited;
  OK := Result.Locate(KeyFieldName, AID, []);
  Assert(OK);

  // ��������� ����
  Result.Filter := GetFilterExpression
    (Result.FieldByName(IDSessionUnion.FieldName).AsInteger);
  Result.Filtered := True;

  // ��������� �� ��-�� ������ � �����
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
  // ��������� ������ �������� ��
  Result.Filter := '[�����] > 0';
  Result.Filtered := True;
end;

procedure TThemeUnions.DoAfterInsert(Sender: TObject);
begin
  ThemeUnion.AsString := TLangConst.���������������������;
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

  // ���� ��� ������� � ������ ����� ������
  if AStartDragEx.IDParent = ADropDragEx.IDParent then
  begin
    inherited;
    Exit;
  end;

  // ���� ��� ������� �� � ������ ������
  // ��������� �������� ������� �� ��� ��� �������� ��
  AClone := CreateCloneForOrder(AStartDrag.Keys[0]);
  try
    if not AClone.Locate(OrderField.FieldName, AStartDrag.MaxOrderValue, [])
    then
      raise Exception.CreateFmt('���������� ������ ��� ����������� ������ %d',
        [AStartDrag.MaxOrderValue]);

    AClone.Next;
    if not AClone.Eof then
      // ����� ��������� ����� ��� ����, ����� ��������� ���������������
      PrepareUpdateOrder(AClone, -1 * Length(AStartDrag.Keys));
  finally
    FreeAndNil(AClone);
  end;

  // ���� � ����� �������� ���� ��, ������� ���� ���������
  if ADropDrag.Key > 0 then
  begin
    // ��������� �������� ������� �� ��� ��� ���������� ��
    AClone := CreateCloneForOrder(ADropDrag.Key);
    try
      // ����� �������� ���� ��� ����, ������� � �������
      PrepareUpdateOrder(AClone, 1 * Length(AStartDrag.Keys));
    finally
      FreeAndNil(AClone);
    end;
  end;

  // ��������� �������� ������� ��� ��, ������� ����������
  for I := Low(AStartDrag.Keys) to High(AStartDrag.Keys) do
  begin
    ARecOrder := TRecOrderEx.Create(AStartDrag.Keys[I],
      ADropDrag.OrderValue + I);
    // ARecOrder.Key := AStartDrag.Keys[I];
    // ARecOrder.Order := ADropDrag.OrderValue + I;
    (ARecOrder as TRecOrderEx).IDParent := ADropDragEx.IDParent;
    FRecOrderList.Add(ARecOrder);
  end;

  // ��������� ��� ���������
  UpdateOrder;

  // ������ ������ ������. �� ������-�� ��������
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
      ('round( sum( t1.������������� + nvl(t2.�������������, 0) ) / 36, 0 ) �������');
    Fields.Add('sum( t1.������������� + nvl(t2.�������������, 0) ) �����');
    Fields.Add('sum(t1.���) ��������');
    Fields.Add('sum(t1.���) ��������');
    Fields.Add('sum(t1.���) ��������');
    Fields.Add('sum(t1.���) ��������');

    Joins.Add(
      'left join ( select unique id_sessionunion, ������������� from table(cdb_dat_umk.umkpack.GetControlPointsHour(:IDDiscipline))) t2'
      // 'left join table(cdb_dat_umk.umkpack.GetControlPointsHour(:IDDiscipline)) t2'
      );
    Joins.WhereCondition.Add('t1.ID_SessionUnion = t2.ID_SessionUnion');
  end;
end;

end.
