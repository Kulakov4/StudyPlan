unit ETPView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataSetView_2, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls,
  DocumentView, ETP, KcxGridView, NotifyEvents, Vcl.StdCtrls, TB2Item,
  System.Actions, Vcl.ActnList, TB2Dock, TB2Toolbar, Vcl.ImgList,
  cxGridDBDataDefinitions, Vcl.Menus, cxButtons, Vcl.Grids, Vcl.DBGrids,
  cxGridDBTableView, Generics.Collections, cxSpinEdit, HRTimer,
  cxDBExtLookupComboBox, ControlNames, cxDBLookupComboBox, IndependentWork,
  DragHelper, cxTextEdit, ThemeQuestions, System.ImageList,
  cxGridCustomPopupMenu, cxGridPopupMenu,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu;

type
  TviewETP = class(TDataSetView2)
    glThemeUnions: TcxGridLevel;
    gdbbtvThemeUnions: TcxGridDBBandedTableView;
    glLessonThemes: TcxGridLevel;
    gdbbtvLessonThemes: TcxGridDBBandedTableView;
    tbdckTop: TTBDock;
    tbtlbrSave: TTBToolbar;
    actlstLessonThemes: TActionList;
    actSave: TAction;
    TBItem1: TTBItem;
    ilETP: TImageList;
    actUndo: TAction;
    TBItem2: TTBItem;
    actAddLessonTheme: TAction;
    tbiAdd: TTBItem;
    actDelete: TAction;
    TBItem5: TTBItem;
    actAddDE: TAction;
    TBItem6: TTBItem;
    TBItem7: TTBItem;
    Timer1: TTimer;
    alCatCopyPaste: TActionList;
    actCut: TAction;
    actCopy: TAction;
    actPaste: TAction;
    ilCutCopyPaste: TImageList;
    TBToolbar1: TTBToolbar;
    tbiCopy: TTBItem;
    tbiPaste: TTBItem;
    TBSeparatorItem1: TTBSeparatorItem;
    TBSeparatorItem2: TTBSeparatorItem;
    cxgdbbcMaxMark: TcxGridDBBandedColumn;
    actReport: TAction;
    TBToolbar2: TTBToolbar;
    TBItem4: TTBItem;
    glThemeUnionControls: TcxGridLevel;
    gdbbtvThemeUnionControls: TcxGridDBBandedTableView;
    acttest: TAction;
    TBToolbar3: TTBToolbar;
    tbsmiShow: TTBSubmenuItem;
    tbiShowLessonThemes: TTBItem;
    actShowLessonThemes: TAction;
    actShowThemeUnionControls: TAction;
    TBItem8: TTBItem;
    cxgdbbcControlName: TcxGridDBBandedColumn;
    actAddThemeUnionControl: TAction;
    glThemeUnionIndependentWork: TcxGridLevel;
    gdbbtvThemeUnionIndependentWork: TcxGridDBBandedTableView;
    clIndependentWork: TcxGridDBBandedColumn;
    actShowThemeUnionIndependentWork: TAction;
    actAddThemeUnionIndependentWork: TAction;
    TBItem3: TTBItem;
    glThemeUnionEducationalWorks: TcxGridLevel;
    gdbbtvThemeUnionEducationalWorks: TcxGridDBBandedTableView;
    clEducationalWork: TcxGridDBBandedColumn;
    actShowThemeUnionEducationalWorks: TAction;
    TBItem9: TTBItem;
    actAddThemeUnionEducationalWork: TAction;
    glThemeUnionLessonFeature: TcxGridLevel;
    gdbbtvThemeUnionLessonFeature: TcxGridDBBandedTableView;
    clLessonFeature: TcxGridDBBandedColumn;
    actAddThemeUnionLessonFeature: TAction;
    actShowThemeUnionLessonFeatures: TAction;
    TBItem10: TTBItem;
    glThemeUnionTechnologies: TcxGridLevel;
    gdbbtvThemeUnionTechnologies: TcxGridDBBandedTableView;
    clIDTechnology: TcxGridDBBandedColumn;
    actAddThemeUnionTechnology: TAction;
    actShowThemeUnionTechnologies: TAction;
    TBItem12: TTBItem;
    glThemeQuestions: TcxGridLevel;
    gdbbtvThemeQuestions: TcxGridDBBandedTableView;
    clThemeQuestionType: TcxGridDBBandedColumn;
    actAddAudQuestion: TAction;
    tbiAddQuestion: TTBItem;
    actAddSelfQuestion: TAction;
    tbiAddSelfQuestion: TTBItem;
    tbi1: TTBItem;
    cxGridPopupMenu: TcxGridPopupMenu;
    pmLessonThemes: TPopupMenu;
    actCopyPasteText: TActionList;
    actCopyText: TAction;
    actPasteLessonThemes: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    actPasteThemeUnions: TAction;
    pmThemeUnions: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure actAddDEExecute(Sender: TObject);
    procedure actAddLessonThemeExecute(Sender: TObject);
    procedure actAddAudQuestionExecute(Sender: TObject);
    procedure actAddSelfQuestionExecute(Sender: TObject);
    procedure actAddThemeUnionControlExecute(Sender: TObject);
    procedure actAddThemeUnionEducationalWorkExecute(Sender: TObject);
    procedure actAddThemeUnionIndependentWorkExecute(Sender: TObject);
    procedure actAddThemeUnionLessonFeatureExecute(Sender: TObject);
    procedure actAddThemeUnionTechnologyExecute(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actCopyTextExecute(Sender: TObject);
    procedure actCorrectOrderExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure actPasteLessonThemesExecute(Sender: TObject);
    procedure actPasteThemeUnionsExecute(Sender: TObject);
    procedure actReportExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actShowLessonThemesExecute(Sender: TObject);
    procedure actShowThemeUnionControlsExecute(Sender: TObject);
    procedure actShowThemeUnionEducationalWorksExecute(Sender: TObject);
    procedure actShowThemeUnionIndependentWorkExecute(Sender: TObject);
    procedure actShowThemeUnionLessonFeaturesExecute(Sender: TObject);
    procedure actShowThemeUnionTechnologiesExecute(Sender: TObject);
    procedure acttestExecute(Sender: TObject);
    procedure actUndoExecute(Sender: TObject);
    procedure cxgdbbcMaxMarkGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure gdbbtvThemeUnionsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure gdbbtvThemeUnionsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure gdbbtvThemeUnionsLeftPosChanged(Sender: TObject);
    procedure gdbbtvThemeUnionsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure gdbbtvLessonThemesCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure gdbbtvLessonThemesDragDrop(Sender, Source: TObject;
      X, Y: Integer);
    procedure gdbbtvLessonThemesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure gdbbtvLessonThemesStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure cx_dbbtvcxg1DBBandedTableView1CustomDrawCell
      (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgdbbcControlNamePropertiesChange(Sender: TObject);
    procedure cxgdbbcIndependentWorkPropertiesEditValueChanged(Sender: TObject);
    procedure cxgdbbcIndependentWorkPropertiesChange(Sender: TObject);
    procedure cxgdbbcIndependentWorkPropertiesNewLookupDisplayText
      (Sender: TObject; const AText: TCaption);
    procedure clEducationalWorkPropertiesNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
    procedure clLessonFeaturePropertiesNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
    procedure gdbbtvThemeUnionEducationalWorksEditKeyDown
      (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure gdbbtvThemeUnionIndependentWorkEditKeyDown
      (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure gdbbtvThemeUnionLessonFeatureEditKeyDown
      (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure clIDTechnologyPropertiesNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
    procedure gdbbtvThemeUnionTechnologiesEditKeyDown
      (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure cxgdbbcControlNamePropertiesNewLookupDisplayText(Sender: TObject;
      const AText: TCaption);
    procedure cxGridDBBandedTableViewMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure gdbbtvThemeQuestionsDragDrop(Sender, Source: TObject;
      X, Y: Integer);
    procedure gdbbtvThemeQuestionsDragOver(Sender, Source: TObject;
      X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure gdbbtvThemeQuestionsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure gdbbtvThemeUnionControlsEditKeyDown
      (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure tbi1Click(Sender: TObject);
    procedure gdbbtvLessonThemesDataControllerDetailExpanding(ADataController
      : TcxCustomDataController; ARecordIndex: Integer; var AAllow: Boolean);
  private
    FAction: TAction;
    FDictionary: TDictionary<String, TcxGridDBBandedColumn>;
    FDropDrag: TDropDragEx;
    FGlobaRowIndex: TStringList;
    FHRTimer: THRTimer;
    FKgdbbtvLessonThemes: TKcxGridDBBandedTableView;
    FKgdbbtvThemeUnions: TKcxGridDBBandedTableView;
    FKgdbbtvThemeUnionControls: TKcxGridDBBandedTableView;
    FKgdbbtvThemeUnionIndependentWork: TKcxGridDBBandedTableView;
    FKgdbbtvThemeUnionEducationalWorks: TKcxGridDBBandedTableView;
    FKgdbbtvThemeUnionLessonFeature: TKcxGridDBBandedTableView;
    FKgdbbtvThemeUnionTechnologies: TKcxGridDBBandedTableView;
    FKgdbbtvThemeQuestion: TKcxGridDBBandedTableView;
    FLessonThemeCursColumn: TcxGridDBBandedColumn;
    FLessonThemeKeyColumn: TcxGridDBBandedColumn;
    FLessonThemeOrderColumn: TcxGridDBBandedColumn;
    FLessonThemeTotalColumn: TcxGridDBBandedColumn;
    FQuestionKeyColumn: TcxGridDBBandedColumn;
    FQuestionOrderColumn: TcxGridDBBandedColumn;
    FSessionUnionKeyColumn: TcxGridDBBandedColumn;
    FStartDrag: TStartDragEx;
    FStartDragLevel: TcxGridLevel;
    FThemeUnionKeyColumn: TcxGridDBBandedColumn;
    FThemeUnionOrderColumn: TcxGridDBBandedColumn;
    FThemeUnionTotalColumn: TcxGridDBBandedColumn;
    FView: TDocumentView;
    procedure AddQuestion(AIDQuestionType: TIDQuestionType);
    procedure AfterUpdate(Sender: TObject);
    procedure BeforeUpdate(Sender: TObject);
    function GetDocument: TETP;
    function GetRow(ALevel: Cardinal): TcxCustomGridRow;
    function GetTableView(ALevel: Cardinal): TcxGridDBBandedTableView;
    procedure OnCopyDataChange(Sender: TObject);
    procedure UpdateGridColumnWidth(AcxGridDBBandedColumn
      : TcxGridDBBandedColumn; ColumnWidth: Integer);
    { Private declarations }
  protected
    function GetFocusedTableView: TcxGridDBBandedTableView; override;
    function GetShowAction: TAction;
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn);
      override;
    procedure UpdateView; override;
    property Document: TETP read GetDocument;
    property KgdbbtvLessonThemes: TKcxGridDBBandedTableView
      read FKgdbbtvLessonThemes;
    property KgdbbtvThemeUnions: TKcxGridDBBandedTableView
      read FKgdbbtvThemeUnions;
    property KgdbbtvThemeUnionControls: TKcxGridDBBandedTableView
      read FKgdbbtvThemeUnionControls;
    property KgdbbtvThemeUnionIndependentWork: TKcxGridDBBandedTableView
      read FKgdbbtvThemeUnionIndependentWork;
    property KgdbbtvThemeUnionEducationalWorks: TKcxGridDBBandedTableView
      read FKgdbbtvThemeUnionEducationalWorks;
    property KgdbbtvThemeUnionLessonFeature: TKcxGridDBBandedTableView
      read FKgdbbtvThemeUnionLessonFeature;
    property KgdbbtvThemeUnionTechnologies: TKcxGridDBBandedTableView
      read FKgdbbtvThemeUnionTechnologies;
    property KgdbbtvThemeQuestion: TKcxGridDBBandedTableView
      read FKgdbbtvThemeQuestion;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    destructor Destroy; override;
    procedure SetDocument(const Value: TDocument); override;
    property GlobaRowIndex: TStringList read FGlobaRowIndex;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses SPViewDM, dxCore, System.Generics.Collections,
  OrderEssence, ProgressBarForm, LanguageConstants, GridExtension, System.Math,
  Vcl.Clipbrd, ClipboardUnit;

constructor TviewETP.Create(AOwner: TComponent; AParent: TWinControl;
  AAlign: TAlign = alClient);
var
  ACol: TcxGridDBBandedColumn;
  AColIndex: Integer;
  ATableViews: TList<TKcxGridDBBandedTableView>;
  AKcxGridDBBandedTableView: TKcxGridDBBandedTableView;
  AView: TcxGridDBBandedTableView;
  i: Integer;
begin
  inherited;
  FGlobaRowIndex := TStringList.Create;
  FStartDrag := TStartDragEx.Create;
  FDropDrag := TDropDragEx.Create;

  FDictionary := TDictionary<String, TcxGridDBBandedColumn>.Create;

  FLessonThemeKeyColumn := nil;
  FThemeUnionOrderColumn := nil;
  FThemeUnionKeyColumn := nil;

  // Создаём представление ДЕ
  FKgdbbtvThemeUnions := TKcxGridDBBandedTableView.Create(Self,
    gdbbtvThemeUnions);

  // Создаём представление тем для занятий
  FKgdbbtvLessonThemes := TKcxGridDBBandedTableView.Create(Self,
    gdbbtvLessonThemes);

  // Создаём представление текущего контроля ДЕ
  FKgdbbtvThemeUnionControls := TKcxGridDBBandedTableView.Create(Self,
    gdbbtvThemeUnionControls);

  // Создаём представление сам. работ по ДЕ
  FKgdbbtvThemeUnionIndependentWork := TKcxGridDBBandedTableView.Create(Self,
    gdbbtvThemeUnionIndependentWork);

  // Создаём представление виды учебной работы по ДЕ
  FKgdbbtvThemeUnionEducationalWorks := TKcxGridDBBandedTableView.Create(Self,
    gdbbtvThemeUnionEducationalWorks);

  // Создаём представление особенности проведения занятий по ДЕ
  FKgdbbtvThemeUnionLessonFeature := TKcxGridDBBandedTableView.Create(Self,
    gdbbtvThemeUnionLessonFeature);

  // Создаём представление, образовательные технологии по ДЕ
  FKgdbbtvThemeUnionTechnologies := TKcxGridDBBandedTableView.Create(Self,
    gdbbtvThemeUnionTechnologies);

  // Чтобы убрать значки своравчивания/разворачивания слева от грида
  // Создаём новое представление своего типа
  AView := cxGrid.CreateView(TcxGridDBBandedTableViewWithoutExpand)
    as TcxGridDBBandedTableView;

  // Копируем в новое представление все колонки
  AView.Assign(gdbbtvThemeQuestions);

  // После копирования создались новые колонки.
  // Но они почему-то не на своих местах
  for i := 0 to gdbbtvThemeQuestions.ColumnCount - 1 do
  begin
    ACol := gdbbtvThemeQuestions.Columns[i];
    AColIndex := IfThen(ACol.Position.ColIndex >= 0, ACol.Position.ColIndex,
      ACol.Index);
    AView.Columns[ACol.Index].Position.ColIndex := AColIndex;
  end;

  // Новое представление будет отображаться на уровне вопросов к теме
  glThemeQuestions.GridView := AView;

  // Создаём представление, связанное с вопросами по теме
  FKgdbbtvThemeQuestion := TKcxGridDBBandedTableView.Create(Self, AView
    // gdbbtvThemeQuestions
    );

  // Список табличных представлений
  ATableViews := TList<TKcxGridDBBandedTableView>.Create;
  try
    // ДЕ
    ATableViews.Add(FKgdbbtvThemeUnions);
    // Темы
    ATableViews.Add(FKgdbbtvLessonThemes);
    // Текущий контроль по ДЕ
    ATableViews.Add(FKgdbbtvThemeUnionControls);
    // Сам. раб. по ДЕ
    ATableViews.Add(FKgdbbtvThemeUnionIndependentWork);
    // Виды учебной работы по ДЕ
    ATableViews.Add(FKgdbbtvThemeUnionEducationalWorks);
    // Особенности проведения занятий по ДЕ
    ATableViews.Add(FKgdbbtvThemeUnionLessonFeature);
    // Образовательные технологии
    ATableViews.Add(FKgdbbtvThemeUnionTechnologies);
    // Вопросы по теме
    ATableViews.Add(FKgdbbtvThemeQuestion);

    // Подписываем все представления на события
    for AKcxGridDBBandedTableView in ATableViews do
    begin
      // Подписываемся на событие о создании столбца
      TNotifyEventWrap.Create(AKcxGridDBBandedTableView.AfterCreateColumn,
        OnCreateColumn);
      // Подписываемся на событие о инициализации столбца
      TNotifyEventWrap.Create(AKcxGridDBBandedTableView.InitColumn,
        OnCreateColumn);
    end;

  finally
    FreeAndNil(ATableViews);
  end;
  // Создаём представление для слежения за копированием из одного тематического плана в другой
  FView := TDocumentView.Create(Self);
  FAction := actShowLessonThemes;
end;

destructor TviewETP.Destroy;
begin
  inherited;
  FreeAndNil(FGlobaRowIndex);
  FreeAndNil(FStartDrag);
  FreeAndNil(FDropDrag);
  FreeAndNil(FDictionary);
end;

procedure TviewETP.actAddDEExecute(Sender: TObject);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  cxGrid.BeginUpdate();
  try

    // Раскрываем выделенную запись о семестре/сессии
    GetRow(0).Expand(False);
    // Получаем текущее представление второго уровня (разделы)
    AView := GetTableView(1);
    // Фокусируем его
    AView.Focused := True;
    // Просим контроллер вставить запись
    AView.DataController.Insert;
    // Просим контроллер сохранить запись
    AView.DataController.Post();
    // Получаем колонку ThemeUnion
  finally
    cxGrid.EndUpdate;
  end;

  AColumn := AView.GetColumnByFieldName('ThemeUnion');
  // Site обеспечивает доступ к элементам размещённым на cxGrid
  AView.Site.SetFocus;
  // Показываем редактор для колонки
  AView.Controller.EditingController.ShowEdit(AColumn);

  {
    cxGridBeginUpdate();
    try
    Document.ThemeUnions.DS.Insert;
    Document.ThemeUnions.DS.Post;
    finally
    cxGridEndUpdate;
    end;
  }
end;

procedure TviewETP.actAddLessonThemeExecute(Sender: TObject);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  cxGrid.BeginUpdate();
  try
    // Раскрываем выделенную запись о разделе
    GetRow(1).Expand(False);
    // Получаем текущее представление третьего уровня (темы)
    AView := GetTableView(2);
    // Фокусируем его
    AView.Focused := True;
    // Просим контроллер вставить запись
    AView.DataController.Append;
    // Просим контроллер сохранить запись
    AView.DataController.Post();
  finally
    // Очищаем кэш глобальных нидексов
    GlobaRowIndex.Clear;
    cxGrid.EndUpdate;
  end;
  // Получаем колонку ThemeUnion
  AColumn := AView.GetColumnByFieldName('ThemeName');
  // Site обеспечивает доступ к элементам размещённым на cxGrid
  AView.Site.SetFocus;
  // Показываем редактор для колонки
  AView.Controller.EditingController.ShowEdit(AColumn);

  {

    cxGrid.BeginUpdate();
    try
    // Переходим в режим добавления новой записи
    Document.LessonThemes.DS.Insert;
    // Сохраняем новую запись (пересортируется)
    Document.LessonThemes.DS.Post;
    // Очищаем список индексов
    GlobaRowIndex.Clear;
    finally
    cxGrid.EndUpdate;
    end;
  }
end;

procedure TviewETP.actAddAudQuestionExecute(Sender: TObject);
begin
  AddQuestion(qtAud);
end;

procedure TviewETP.actAddSelfQuestionExecute(Sender: TObject);
begin
  AddQuestion(qtSelf);
end;

procedure TviewETP.actAddThemeUnionControlExecute(Sender: TObject);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  Document.ThemeUnionControl.Wrap.Post();
  cxGrid.BeginUpdate();
  try
    // Раскрываем выделенную запись о разделе
    GetRow(1).Expand(False);
    // Получаем текущее представление третьего уровня (темы)
    AView := GetTableView(2);
    // Фокусируем его
    AView.Focused := True;
    // Просим контроллер вставить запись
    AView.DataController.Append;
  finally
    cxGrid.EndUpdate;
  end;
  // Получаем колонку IDControlName
  AColumn := AView.GetColumnByFieldName('IDControlName');

  // (cxgdbbcControlName.Properties as TcxLookupComboBoxProperties).ImmediateDropDownWhenActivated := True;

  // Site обеспечивает доступ к элементам размещённым на cxGrid
  AView.Site.SetFocus;
  // Показываем редактор для колонки
  AView.Controller.EditingController.ShowEdit(AColumn);

  // (cxgdbbcControlName.Properties as TcxLookupComboBoxProperties).
end;

procedure TviewETP.actAddThemeUnionEducationalWorkExecute(Sender: TObject);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  Document.ThemeUnionEducationalWorks.Wrap.Post();
  cxGrid.BeginUpdate();
  try
    // Раскрываем выделенную запись о разделе
    GetRow(1).Expand(False);
    // Получаем текущее представление третьего уровня (темы)
    AView := GetTableView(2);
    // Фокусируем его
    AView.Focused := True;
    // Просим контроллер вставить запись
    AView.DataController.Append;
  finally
    cxGrid.EndUpdate;
  end;
  // Получаем колонку IDIndependentWork
  AColumn := AView.GetColumnByFieldName('IDEducationalWork');

  // (cxgdbbcControlName.Properties as TcxLookupComboBoxProperties).ImmediateDropDownWhenActivated := True;

  // Site обеспечивает доступ к элементам размещённым на cxGrid
  AView.Site.SetFocus;
  // Показываем редактор для колонки
  AView.Controller.EditingController.ShowEdit(AColumn);
end;

procedure TviewETP.actAddThemeUnionIndependentWorkExecute(Sender: TObject);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  Document.ThemeUnionIndependentWork.Wrap.Post();
  cxGrid.BeginUpdate();
  try
    // Раскрываем выделенную запись о разделе
    GetRow(1).Expand(False);
    // Получаем текущее представление третьего уровня (темы)
    AView := GetTableView(2);
    // Фокусируем его
    AView.Focused := True;
    // Просим контроллер вставить запись
    AView.DataController.Append;
  finally
    cxGrid.EndUpdate;
  end;
  // Получаем колонку IDIndependentWork
  AColumn := AView.GetColumnByFieldName('IDIndependentWork');

  // (cxgdbbcControlName.Properties as TcxLookupComboBoxProperties).ImmediateDropDownWhenActivated := True;

  // Site обеспечивает доступ к элементам размещённым на cxGrid
  AView.Site.SetFocus;
  // Показываем редактор для колонки
  AView.Controller.EditingController.ShowEdit(AColumn);
end;

procedure TviewETP.actAddThemeUnionLessonFeatureExecute(Sender: TObject);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  Document.ThemeUnionLessonTheatures.Wrap.Post();
  cxGrid.BeginUpdate();
  try
    // Раскрываем выделенную запись о разделе
    GetRow(1).Expand(False);
    // Получаем текущее представление третьего уровня (темы)
    AView := GetTableView(2);
    // Фокусируем его
    AView.Focused := True;
    // Просим контроллер вставить запись
    AView.DataController.Append;
  finally
    cxGrid.EndUpdate;
  end;
  // Получаем колонку IDIndependentWork
  AColumn := AView.GetColumnByFieldName(clLessonFeature.DataBinding.FieldName);

  // Site обеспечивает доступ к элементам размещённым на cxGrid
  AView.Site.SetFocus;
  // Показываем редактор для колонки
  AView.Controller.EditingController.ShowEdit(AColumn);
end;

procedure TviewETP.actAddThemeUnionTechnologyExecute(Sender: TObject);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  Document.THEMEUNIONTECHNOLOGIES.Wrap.Post();
  cxGrid.BeginUpdate();
  try
    // Раскрываем выделенную запись о разделе
    GetRow(1).Expand(False);
    // Получаем текущее представление третьего уровня (темы)
    AView := GetTableView(2);
    // Фокусируем его
    AView.Focused := True;
    // Просим контроллер вставить запись
    AView.DataController.Append;
  finally
    cxGrid.EndUpdate;
  end;
  // Получаем колонку IDIndependentWork
  AColumn := AView.GetColumnByFieldName(clIDTechnology.DataBinding.FieldName);

  // Site обеспечивает доступ к элементам размещённым на cxGrid
  AView.Site.SetFocus;
  // Показываем редактор для колонки
  AView.Controller.EditingController.ShowEdit(AColumn);
end;

procedure TviewETP.actCopyExecute(Sender: TObject);
begin
  Document.Copy;
end;

procedure TviewETP.actCopyTextExecute(Sender: TObject);
var
  AView: TcxGridDBBandedTableView;
begin
  inherited;
  AView := GetFocusedTableView;
  if AView <> nil then
    AView.CopyToClipboard(False);
end;

procedure TviewETP.actCorrectOrderExecute(Sender: TObject);
begin
  // Document.LessonThemes.CorrectOrder;
end;

procedure TviewETP.actDeleteExecute(Sender: TObject);
var
  AMessageText: string;
  AMessageCaption: string;
  AView: TcxGridDBBandedTableView;
  S: string;
begin
  AMessageText := '';

  AView := FocusedTableView;
  if AView = nil then
    Exit;

  if AView.Level = cxGridLevel then
  begin
    // Нельзя удалить сессию/семестр
    Exit;
  end;

  if AView.Level = glThemeUnions then
  begin
    AMessageText := Format('Полностью удалить раздел «%s» вместе с его темами?',
      [Document.ThemeUnions.Field('ThemeUnion').AsString]);
    AMessageCaption := 'Удаление раздела';
  end;

  if AView.Level = glLessonThemes then
  begin
    AMessageText := Format('Удалить тему «%s»?',
      [Document.LessonThemes.Field('ThemeName').AsString]);
    AMessageCaption := 'Удаление темы';
  end;

  if AView.Level = glThemeUnionControls then
  begin
    // (cxgdbbcControlName.Properties as TcxLookupComboBoxProperties).
    // S := AView.Controller.FocusedRow.DisplayTexts[cxgdbbcControlName.Index];
    AMessageText := 'Удалить из текущего контроля?';

    AMessageCaption := 'Удаление текущего контроля';
  end;

  if AView.Level = glThemeUnionIndependentWork then
  begin
    AMessageText := 'Удалить выделенный вид самостоятельной работы студента?';
    AMessageCaption := 'Удаление вида самостоятельной работы студента';
  end;

  if AView.Level = glThemeUnionEducationalWorks then
  begin
    AMessageText := 'Удалить выделенный вид учебной работы?';
    AMessageCaption := 'Удаление вида учебной работы';
  end;

  if AView.Level = glThemeUnionLessonFeature then
  begin
    AMessageText := 'Удалить особенность проведения занятий?';
    AMessageCaption := 'Удаление особенности проведения занятий';
  end;

  if AView.Level = glThemeUnionTechnologies then
  begin
    AMessageText := 'Удалить образовательную технологию?';
    AMessageCaption := 'Удаление образовательных технологий';
  end;

  if AView.Level = glThemeQuestions then
  begin
    AMessageText := 'Удалить вопрос по теме?';
    AMessageCaption := 'Удаление вопроса по теме';
  end;

  Assert(AMessageText <> '');

  S := 'dd';
  // S := AView.Controller.FocusedRow.DisplayTexts[1].Trim;

  if (AView.DataController.RowCount > 0) and
    (S.IsEmpty or (Application.MessageBox(PWideChar(AMessageText),
    PWideChar(AMessageCaption), MB_YESNO + MB_ICONQUESTION) = IDYES)) then
  begin
    if AView.Controller.SelectedRowCount > 0 then
      AView.DataController.DeleteSelection
    else
      AView.DataController.DeleteFocused;

    if (AView.DataController.RecordCount = 0) and (AView.MasterGridRecord <> nil)
    then
    begin
      AView.MasterGridRecord.Collapse(False);
    end;

    // Очищаем кэш глобальных номеров тем
    GlobaRowIndex.Clear;
  end;
end;

procedure TviewETP.actPasteExecute(Sender: TObject);
begin
  cxGrid.BeginUpdate();
  try

    if (Document.ThemeUnions.DS.RecordCount = 0) or
      (Document.HaveSameCopyDataUnions) or
      (Application.MessageBox
      ('Перед вставкой существующий тематический план будет удалён.' + #13#10 +
      'Продолжить?', 'Вставка тематического план', MB_YESNO + MB_ICONQUESTION)
      = IDYES) then
    begin
      try
        Document.Paste;
      finally
        GlobaRowIndex.Clear;
      end;
    end;
  finally
    cxGrid.EndUpdate;
  end;
end;

procedure TviewETP.actPasteLessonThemesExecute(Sender: TObject);
var
  m: TArray<String>;
  V: Variant;
begin
  inherited;

  if not Clipboard.HasFormat(CF_TEXT) then
    Exit;

  m := TClb.GetRowsAsArray;

  if Length(m) = 0 then
    Exit;

  V := GetTableView(2).Controller.FocusedRow.Values
    [FLessonThemeKeyColumn.Index];
  if VarIsNull(V) then
    Exit;

  gdbbtvLessonThemes.BeginUpdate();
  try
    Document.LessonThemes.AppendRows(V, m);
  finally
    gdbbtvLessonThemes.EndUpdate;
  end;
end;

procedure TviewETP.actPasteThemeUnionsExecute(Sender: TObject);
var
  m: TArray<String>;
  V: Variant;
begin
  inherited;

  if not Clipboard.HasFormat(CF_TEXT) then
    Exit;

  m := TClb.GetRowsAsArray;

  if Length(m) = 0 then
    Exit;


  V := GetTableView(1).Controller.FocusedRow.Values
    [FThemeUnionKeyColumn.Index];
  if VarIsNull(V) then
    Exit;

  gdbbtvThemeUnions.BeginUpdate();
  try
    Document.ThemeUnions.AppendRows(V, m);
  finally
    gdbbtvThemeUnions.EndUpdate;
  end;

end;

procedure TviewETP.actReportExecute(Sender: TObject);
var
  ProgressBarThread: TProgressBarThread;
begin
  ProgressBarThread := TProgressBarThread.Create();
  try
    cxGrid.BeginUpdate();
    try
      Document.PrepareReport;
    finally
      cxGrid.EndUpdate;
    end;
  finally
    ProgressBarThread.Terminate;
    ProgressBarThread.WaitFor;
    ProgressBarThread.Free;
  end;
end;

procedure TviewETP.actSaveExecute(Sender: TObject);
// var
// AAction: TAction;
begin
  // cxGrid.BeginUpdate();
  try
    Document.ApplyUpdates;

    // glLessonThemes.Index := 0;
    // glThemeUnionControls.Index := 0;

    // FAction.Execute;
  finally
    // cxGrid.EndUpdate;
  end;
end;

procedure TviewETP.actShowLessonThemesExecute(Sender: TObject);
begin
  FAction := Sender as TAction;
  glLessonThemes.Index := 0;
  FAction.Checked := True;
  tbsmiShow.Caption := (Sender as TAction).Caption;
  tbiAdd.Action := actAddLessonTheme;
  UpdateView;
end;

procedure TviewETP.actShowThemeUnionControlsExecute(Sender: TObject);
begin
  FAction := Sender as TAction;
  glThemeUnionControls.Index := 0;
  FAction.Checked := True;
  tbsmiShow.Caption := (Sender as TAction).Caption;
  tbiAdd.Action := actAddThemeUnionControl;
  ExpandAll(True);
  UpdateView;
end;

procedure TviewETP.actShowThemeUnionEducationalWorksExecute(Sender: TObject);
begin
  FAction := Sender as TAction;
  glThemeUnionEducationalWorks.Index := 0;
  FAction.Checked := True;
  tbsmiShow.Caption := (Sender as TAction).Caption;
  tbiAdd.Action := actAddThemeUnionEducationalWork;
  ExpandAll(True);
  UpdateView;
end;

procedure TviewETP.actShowThemeUnionIndependentWorkExecute(Sender: TObject);
begin
  FAction := Sender as TAction;
  glThemeUnionIndependentWork.Index := 0;
  FAction.Checked := True;
  tbsmiShow.Caption := (Sender as TAction).Caption;
  tbiAdd.Action := actAddThemeUnionIndependentWork;
  ExpandAll(True);
  UpdateView;
end;

procedure TviewETP.actShowThemeUnionLessonFeaturesExecute(Sender: TObject);
begin
  FAction := Sender as TAction;
  glThemeUnionLessonFeature.Index := 0;
  FAction.Checked := True;
  tbsmiShow.Caption := (Sender as TAction).Caption;
  tbiAdd.Action := actAddThemeUnionLessonFeature;
  ExpandAll(True);
  UpdateView;
end;

procedure TviewETP.actShowThemeUnionTechnologiesExecute(Sender: TObject);
begin
  FAction := Sender as TAction;
  glThemeUnionTechnologies.Index := 0;
  FAction.Checked := True;
  tbsmiShow.Caption := (Sender as TAction).Caption;
  tbiAdd.Action := actAddThemeUnionTechnology;
  ExpandAll(True);
  UpdateView;
end;

procedure TviewETP.acttestExecute(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to cxGridDBBandedTableView.ViewData.RowCount - 1 do
  begin
    cxGridDBBandedTableView.ViewData.Rows[i].Expand(True);
  end;

  // cxGridDBBandedTableView.ViewData.Expand(True);
  // GetDBBandedTableView(1).ViewData.Expand(True);
  // gdbbtvThemeUnions.ViewData.Expand(True);
end;

procedure TviewETP.actUndoExecute(Sender: TObject);
// var
// AAction: TAction;
begin
  // cxGrid.BeginUpdate();
  try
    try
      Document.CancelUpdates;

      glLessonThemes.Index := 0;
      glThemeUnionControls.Index := 0;
      FAction.Execute;

      // AAction := GetShowAction;
      // Assert(AAction <> nil);
      // actShowLessonThemes.Execute;
      // AAction.Execute;
    finally
      GlobaRowIndex.Clear;
    end;
  finally
    // cxGrid.EndUpdate;
  end;
end;

procedure TviewETP.AddQuestion(AIDQuestionType: TIDQuestionType);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
  Cnt: Integer;
begin
  // cxGrid.BeginUpdate();
  // try
  // Раскрываем выделенную запись о теме
  GetRow(2).Expand(False);
  // Получаем текущее представление четвёртого уровня (вопросы)
  AView := GetTableView(3);
  // Фокусируем его
  AView.Focused := True;
  // Устанавливает тип вопроса
  Document.ThemeQuestions.DefaultQuestionType := AIDQuestionType;
  // Просим контроллер вставить запись
  AView.DataController.Append;
  // Просим контроллер сохранить запись
  AView.DataController.Post();
  // finally
  // cxGrid.EndUpdate;
  // end;

  Cnt := AView.ViewInfo.RecordsViewInfo.VisibleCount;
  AView.Controller.TopRecordIndex := AView.Controller.FocusedRecordIndex -
    Round((Cnt + 1) / 2);

  AColumn := AView.GetColumnByFieldName('ThemeQuestion');
  // Site обеспечивает доступ к элементам размещённым на cxGrid
  AView.Site.SetFocus;
  // Показываем редактор для колонки
  AView.Controller.EditingController.ShowEdit(AColumn);

  UpdateView;
end;

var
  fci: Integer;
  fri: Integer;

procedure TviewETP.BeforeUpdate(Sender: TObject);
begin
  fri := GetTableView(2).Controller.FocusedRowIndex;
  fci := GetTableView(2).Controller.FocusedColumnIndex;
end;

procedure TviewETP.clEducationalWorkPropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  inherited;
  Document.EducationalWorks.AddNewValue(AText);
end;

procedure TviewETP.clIDTechnologyPropertiesNewLookupDisplayText(Sender: TObject;
  const AText: TCaption);
begin
  inherited;
  Document.Technologies.AddNewValue(AText);
end;

procedure TviewETP.clLessonFeaturePropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  Document.LessonFeatures.AddNewValue(AText);
end;

procedure TviewETP.AfterUpdate(Sender: TObject);
begin
  GetTableView(2).Controller.FocusedRowIndex := fri;
  GetTableView(2).Controller.FocusedColumnIndex := fci;

  GetTableView(2).Controller.FocusedRow.Selected := True;
  GetTableView(2).Controller.FocusedColumn.Selected := True;
  GetTableView(2).Focused := True;
end;

procedure TviewETP.cxgdbbcControlNamePropertiesChange(Sender: TObject);
begin
  inherited;
  // Document.ThemeUnionControl.Wrap.Post()
end;

procedure TviewETP.cxgdbbcControlNamePropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  inherited;
  Document.ControlNames.AddNewValue(AText);
end;

procedure TviewETP.cxgdbbcIndependentWorkPropertiesChange(Sender: TObject);
var
  S: string;
begin
  inherited;
  S := Sender.ClassName;
end;

procedure TviewETP.cxgdbbcIndependentWorkPropertiesEditValueChanged
  (Sender: TObject);
begin
  inherited;;
end;

procedure TviewETP.cxgdbbcIndependentWorkPropertiesNewLookupDisplayText
  (Sender: TObject; const AText: TCaption);
begin
  inherited;
  Document.IndependentWork.AddNewValue(AText);
end;

procedure TviewETP.cxgdbbcMaxMarkGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
var
  X: Integer;
begin
  inherited;

  if not VarIsNull(ARecord.Values[Sender.Index]) then
    X := Integer(ARecord.Values[Sender.Index])
  else
    X := 0;

  AText := Format('%d б.', [X]);
end;

procedure TviewETP.cxGridDBBandedTableViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin;
  inherited;
end;

procedure TviewETP.gdbbtvThemeUnionsDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  AcxCustomGridHitTest: TcxCustomGridHitTest;
  AcxGridDBBandedTableView: TcxGridDBBandedTableView;
  AcxGridRecordCellHitTest: TcxGridRecordCellHitTest;
  AcxGridViewNoneHitTest: TcxGridViewNoneHitTest;
begin
  Assert(FThemeUnionKeyColumn <> nil);
  Assert(FThemeUnionOrderColumn <> nil);
  Assert(FSessionUnionKeyColumn <> nil);
  AcxGridDBBandedTableView := nil;

  gdbbtvThemeUnions.BeginUpdate();
  try
    // Определяем точку переноса
    AcxCustomGridHitTest := (Sender as TcxGridSite).ViewInfo.GetHitTest(X, Y);

    if AcxCustomGridHitTest is TcxGridRecordCellHitTest then
    begin
      AcxGridRecordCellHitTest :=
        AcxCustomGridHitTest as TcxGridRecordCellHitTest;
      AcxGridDBBandedTableView := AcxGridRecordCellHitTest.GridView as
        TcxGridDBBandedTableView;

      // определяем порядок в точке переноса
      FDropDrag.OrderValue := AcxGridRecordCellHitTest.GridRecord.Values
        [FThemeUnionOrderColumn.Index];

      // определяем код темы в точке переноса
      FDropDrag.Key := AcxGridRecordCellHitTest.GridRecord.Values
        [FThemeUnionKeyColumn.Index];
    end;

    if AcxCustomGridHitTest is TcxGridViewNoneHitTest then
    begin
      AcxGridViewNoneHitTest := AcxCustomGridHitTest as TcxGridViewNoneHitTest;
      AcxGridDBBandedTableView := AcxGridViewNoneHitTest.GridView as
        TcxGridDBBandedTableView;

      FDropDrag.Key := 0;
      FDropDrag.OrderValue := 0;
    end;

    if AcxGridDBBandedTableView <> nil then
    begin

      // Определяем код дидактической еденицы в точке переноса
      FDropDrag.IDParent := AcxGridDBBandedTableView.MasterGridRecord.Values
        [FSessionUnionKeyColumn.Index];

      Document.ThemeUnions.MoveDSRecord(FStartDrag, FDropDrag);

      // Очищаем кэш глобальных индексов записей
      GlobaRowIndex.Clear;
    end;
  finally
    gdbbtvThemeUnions.EndUpdate;
  end;

  GetTableView(1).Focused := True;

end;

procedure TviewETP.gdbbtvThemeUnionsDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  AcxGridRecordCellHitTest: TcxGridRecordCellHitTest;
  AcxGridSite: TcxGridSite;
  AcxGridViewNoneHitTest: TcxGridViewNoneHitTest;
  HT: TcxCustomGridHitTest;
begin
  Accept := False;

  AcxGridSite := Sender as TcxGridSite;
  HT := AcxGridSite.ViewInfo.GetHitTest(X, Y);

  // Если перетаскиваем на пустой GridView
  if HT is TcxGridViewNoneHitTest then
  begin
    AcxGridViewNoneHitTest := HT as TcxGridViewNoneHitTest;

    Accept := AcxGridViewNoneHitTest.GridView.Level = FStartDragLevel;
  end;

  // Если перетаскиваем на ячейку GridView
  if HT is TcxGridRecordCellHitTest then
  begin
    AcxGridRecordCellHitTest := HT as TcxGridRecordCellHitTest;

    Accept := (AcxGridRecordCellHitTest.GridView.Level = FStartDragLevel) and
      (AcxGridRecordCellHitTest.GridRecord.RecordIndex <>
      AcxGridSite.GridView.DataController.FocusedRecordIndex);
  end
end;

var
  FisCurrentlySyncing: Boolean = False;

procedure TviewETP.gdbbtvThemeUnionsLeftPosChanged(Sender: TObject);
var
  AcxGridDBBandedTableView: TcxGridDBBandedTableView;
  AView: TcxGridBandedTableView;
  ADetailView: TcxCustomGridView;
  i: Integer;
  isExpanded: Boolean;
  lp: Integer;
begin
  if FisCurrentlySyncing then
    Exit;

  try
    FisCurrentlySyncing := True;

    AcxGridDBBandedTableView := Sender as TcxGridDBBandedTableView;
    lp := AcxGridDBBandedTableView.Controller.LeftPos;
    AView := (cxGridLevel.GridView as TcxGridBandedTableView);
    for i := 0 to AView.ViewData.RowCount - 1 do
    begin
      ADetailView := (TcxGridMasterDataRow(AView.ViewData.Rows[i]))
        .ActiveDetailGridView;
      isExpanded := (TcxGridMasterDataRow(AView.ViewData.Rows[i])).Expanded;
      if isExpanded then
        TcxGridDBBandedTableView(ADetailView).Controller.LeftPos := lp;
    end;
  finally
    FisCurrentlySyncing := False;
  end;

end;

procedure TviewETP.gdbbtvThemeUnionsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
var
  i: Integer;
begin
  Assert(FThemeUnionKeyColumn <> nil);
  Assert(FSessionUnionKeyColumn <> nil);

  with (Sender as TcxGridSite).GridView as TcxGridDBBandedTableView do
  begin
    Assert(Controller.SelectedRowCount > 0);

    FStartDragLevel := Level as TcxGridLevel;

    // Запоминаем код сессии переносимых записей
    FStartDrag.IDParent := MasterGridRecord.Values
      [FSessionUnionKeyColumn.Index];

    // запоминаем минимальный порядок записи которую начали переносить
    FStartDrag.MinOrderValue := Controller.SelectedRows[0].Values
      [FThemeUnionOrderColumn.Index];
    // запоминаем максимальный порядок записи которую начали переносить
    FStartDrag.MaxOrderValue := Controller.SelectedRows
      [Controller.SelectedRecordCount - 1].Values[FThemeUnionOrderColumn.Index];

    SetLength(FStartDrag.Keys, Controller.SelectedRowCount);
    for i := 0 to Controller.SelectedRowCount - 1 do
    begin
      FStartDrag.Keys[i] := Controller.SelectedRecords[i].Values
        [FThemeUnionKeyColumn.Index];
    end;
  end;
end;

procedure TviewETP.gdbbtvLessonThemesCustomDrawCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  AcxGridDBBandedColumn: TcxGridDBBandedColumn;
  AcxGridDBBandedTableView0: TcxGridDBBandedTableView;
  AcxGridDBBandedTableView1: TcxGridDBBandedTableView;
  AcxGridMasterDataRow0: TcxGridMasterDataRow;
  AcxGridMasterDataRow1: TcxGridMasterDataRow;
  AIDLessonTheme: String;
  AParentRecord: TcxCustomGridRecord;
  i: Integer;
  j: Integer;
  l0i: Integer;
  l1i: Integer;
  l2i: Integer;
  r: Integer;
  S: string;
  Всего: Integer;
  Курс: Integer;
begin
  inherited;

  try

    AcxGridDBBandedColumn := (Sender as TcxGridDBBandedTableView)
      .Columns[AViewInfo.Item.Index];

    if AnsiSameText('RecNo', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AIDLessonTheme := AViewInfo.GridRecord.DisplayTexts
        [FLessonThemeKeyColumn.Index];
      S := GlobaRowIndex.Values[AIDLessonTheme];
      r := 0;
      if S <> '' then
        r := StrToInt(S);

      if S = '' then
      begin
        l2i := AViewInfo.GridRecord.RecordIndex;
        AParentRecord := AViewInfo.GridRecord.ParentRecord;
        l1i := AParentRecord.RecordIndex;
        AParentRecord := AParentRecord.ParentRecord;
        l0i := AParentRecord.RecordIndex;

        r := 0;

        // Цикл по все семестрам от 1-го до текущего - 1
        for i := 0 to l0i - 1 do
        begin
          // Берём i-й семестр
          AcxGridMasterDataRow0 := GetTableView(0).ViewData.Rows[i]
            as TcxGridMasterDataRow;
          // Спускаемся на уровень ДЕ i-го семестра
          AcxGridDBBandedTableView0 :=
            AcxGridMasterDataRow0.ActiveDetailGridView as
            TcxGridDBBandedTableView;
          // Цикл по всем ДЕ i - го семестра
          for j := 0 to AcxGridDBBandedTableView0.ViewData.RowCount - 1 do
          begin
            // Берём j-ую ДЕ
            AcxGridMasterDataRow1 := AcxGridDBBandedTableView0.ViewData.Rows[j]
              as TcxGridMasterDataRow;
            // Спускаемся на уровень тем j-ой ДЕ
            AcxGridDBBandedTableView1 :=
              AcxGridMasterDataRow1.ActiveDetailGridView as
              TcxGridDBBandedTableView;
            // Добавляем кол-во тем в j-ой ДЕ
            Inc(r, AcxGridDBBandedTableView1.ViewData.RowCount);
          end;

        end;

        // Цикл по всем ДЕ текущего семестра от 0 до текущей ДЕ - 1
        for j := 0 to l1i - 1 do
        begin
          // Берём j-ую ДЕ
          AcxGridMasterDataRow1 := GetTableView(1).ViewData.Rows[j]
            as TcxGridMasterDataRow;
          // Спускаемся на уровень тем j-ой ДЕ
          AcxGridDBBandedTableView1 :=
            AcxGridMasterDataRow1.ActiveDetailGridView as
            TcxGridDBBandedTableView;
          // Добавляем кол-во тем в j-ой ДЕ
          Inc(r, AcxGridDBBandedTableView1.ViewData.RowCount);
        end;

        Inc(r, l2i + 1);

        // Запоминаем найденный глобальный индекс записи
        GlobaRowIndex.Values[AIDLessonTheme] := IntToStr(r);
      end;
      // Рисуем в ячейке
      ACanvas.FillRect(AViewInfo.Bounds);
      // ARect := AViewInfo.BoundsRect;
      // ARect.Left := ARect.Left + 3;
      ACanvas.DrawText(Format('%d', [r]), AViewInfo.Bounds, cxAlignCenter);
      ADone := True;

    end;

    if AnsiSameText('Всего', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      Курс := StrToIntDef(AViewInfo.GridRecord.DisplayTexts
        [FLessonThemeCursColumn.Index], -1);

      if not VarIsNull(AViewInfo.DisplayValue) then
      begin
        Всего := AViewInfo.DisplayValue;

        // Общее число часов по теме не должно быть равно 0
        if (Всего = 0) and (Курс = 0) then
        begin
          ACanvas.Font.Color := clWhite;
          ACanvas.Brush.Color := clRed;

          // Рисуем в ячейке
          ACanvas.FillRect(AViewInfo.Bounds);
          // ARect := AViewInfo.BoundsRect;
          // ARect.Left := ARect.Left + 3;
          ACanvas.DrawText(AViewInfo.DisplayValue, AViewInfo.Bounds,
            cxAlignCenter);
          ADone := True;
        end;
      end;
    end;
  except
    ;
  end;
end;

procedure TviewETP.gdbbtvLessonThemesDataControllerDetailExpanding
  (ADataController: TcxCustomDataController; ARecordIndex: Integer;
  var AAllow: Boolean);
begin
  inherited;
  // AAllow := False;
end;

procedure TviewETP.gdbbtvLessonThemesDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  AcxCustomGridHitTest: TcxCustomGridHitTest;
  AcxGridDBBandedTableView: TcxGridDBBandedTableView;
  AcxGridRecordCellHitTest: TcxGridRecordCellHitTest;
  AcxGridViewNoneHitTest: TcxGridViewNoneHitTest;
  time: Double;
begin
  // Таймер должны были запустить
  Assert(FHRTimer <> nil);
  time := FHRTimer.ReadTimer;
  // Таймер больше не нужен
  FreeAndNil(FHRTimer);

  // Если это было случайное перемещение, то ничего не делаем
  if time < 500 then
    Exit;

  Assert(FThemeUnionKeyColumn <> nil);
  Assert(FThemeUnionOrderColumn <> nil);
  Assert(FLessonThemeKeyColumn <> nil);
  AcxGridDBBandedTableView := nil;

  gdbbtvLessonThemes.BeginUpdate();
  try
    // Определяем точку переноса
    AcxCustomGridHitTest := (Sender as TcxGridSite).ViewInfo.GetHitTest(X, Y);

    if AcxCustomGridHitTest is TcxGridRecordCellHitTest then
    begin
      AcxGridRecordCellHitTest :=
        AcxCustomGridHitTest as TcxGridRecordCellHitTest;
      AcxGridDBBandedTableView := AcxGridRecordCellHitTest.GridView as
        TcxGridDBBandedTableView;

      // определяем порядок в точке переноса
      FDropDrag.OrderValue := AcxGridRecordCellHitTest.GridRecord.Values
        [FLessonThemeOrderColumn.Index];

      // определяем код темы в точке переноса
      FDropDrag.Key := AcxGridRecordCellHitTest.GridRecord.Values
        [FLessonThemeKeyColumn.Index];
    end;

    if AcxCustomGridHitTest is TcxGridViewNoneHitTest then
    begin
      AcxGridViewNoneHitTest := AcxCustomGridHitTest as TcxGridViewNoneHitTest;
      AcxGridDBBandedTableView := AcxGridViewNoneHitTest.GridView as
        TcxGridDBBandedTableView;

      FDropDrag.Key := 0;
      FDropDrag.OrderValue := 0;
    end;

    if AcxGridDBBandedTableView <> nil then
    begin
      // Определяем код дидактической еденицы в точке переноса
      FDropDrag.IDParent := AcxGridDBBandedTableView.MasterGridRecord.Values
        [FThemeUnionKeyColumn.Index];
      // Определяем порядок дидактической еденицы в точке переноса
      // FDropDrag.ThemeUnionOrder := AcxGridDBBandedTableView.MasterGridRecord.
      // Values[FThemeUnionOrderColumn.Index];

      Document.LessonThemes.MoveDSRecord(FStartDrag, FDropDrag);

      // Очищаем кэш глобальных индексов записей
      GlobaRowIndex.Clear;
    end;
  finally
    gdbbtvLessonThemes.EndUpdate;
  end;

  GetTableView(2).Focused := True;
end;

procedure TviewETP.gdbbtvLessonThemesDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  AcxGridRecordCellHitTest: TcxGridRecordCellHitTest;
  AcxGridSite: TcxGridSite;
  AcxGridViewNoneHitTest: TcxGridViewNoneHitTest;
  HT: TcxCustomGridHitTest;
begin
  Accept := False;

  AcxGridSite := Sender as TcxGridSite;
  HT := AcxGridSite.ViewInfo.GetHitTest(X, Y);

  // Если перетаскиваем на пустой GridView
  if HT is TcxGridViewNoneHitTest then
  begin
    AcxGridViewNoneHitTest := HT as TcxGridViewNoneHitTest;

    Accept := AcxGridViewNoneHitTest.GridView.Level = FStartDragLevel;
  end;

  // Если перетаскиваем на ячейку GridView
  if HT is TcxGridRecordCellHitTest then
  begin
    AcxGridRecordCellHitTest := HT as TcxGridRecordCellHitTest;

    Accept := (AcxGridRecordCellHitTest.GridView.Level = FStartDragLevel) and
      (AcxGridRecordCellHitTest.GridRecord.RecordIndex <>
      AcxGridSite.GridView.DataController.FocusedRecordIndex);
  end
end;

procedure TviewETP.gdbbtvLessonThemesStartDrag(Sender: TObject;
  var DragObject: TDragObject);
var
  i: Integer;
begin
  Assert(FLessonThemeKeyColumn <> nil);
  Assert(FThemeUnionKeyColumn <> nil);
  with (Sender as TcxGridSite).GridView as TcxGridDBBandedTableView do
  begin
    FStartDragLevel := Level as TcxGridLevel;

    Assert(Controller.SelectedRowCount > 0);

    // Запоминаем код дидактической еденицы переносимых записей
    FStartDrag.IDParent := MasterGridRecord.Values[FThemeUnionKeyColumn.Index];
    // Запоминаем порядковый номер дидактической еденицы переносимых записей
    // FStartDrag.ThemeUnionOrder := MasterGridRecord.Values
    // [FThemeUnionOrderColumn.Index];
    // запоминаем минимальный порядок записи которую начали переносить
    FStartDrag.MinOrderValue := Controller.SelectedRows[0].Values
      [FLessonThemeOrderColumn.Index];
    // запоминаем максимальный порядок записи которую начали переносить
    FStartDrag.MaxOrderValue := Controller.SelectedRows
      [Controller.SelectedRecordCount - 1].Values
      [FLessonThemeOrderColumn.Index];

    SetLength(FStartDrag.Keys, Controller.SelectedRowCount);
    for i := 0 to Controller.SelectedRowCount - 1 do
    begin
      FStartDrag.Keys[i] := Controller.SelectedRecords[i].Values
        [FLessonThemeKeyColumn.Index];
    end;

    // Запускаем таймер чтобы рассчитать время переноса записей
    FHRTimer := THRTimer.Create(True);
  end;
end;

procedure TviewETP.cx_dbbtvcxg1DBBandedTableView1CustomDrawCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  AcxGridDBBandedColumn: TcxGridDBBandedColumn;
  AcxGridDBBandedTableView0: TcxGridDBBandedTableView;
  AcxGridMasterDataRow0: TcxGridMasterDataRow;
  AValue: Variant;
  coli: Integer;
  FooterSum: Integer;
  i: Integer;
  SemestrSum: Integer;
begin
  try
    AcxGridDBBandedColumn := (Sender as TcxGridDBBandedTableView)
      .Columns[AViewInfo.Item.Index];

    if FDictionary.ContainsKey(AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      i := AViewInfo.GridRecord.RecordIndex;
      AcxGridMasterDataRow0 := GetTableView(0).ViewData.Rows[i]
        as TcxGridMasterDataRow;

      // Спускаемся на уровень ДЕ i-го семестра
      AcxGridDBBandedTableView0 := AcxGridMasterDataRow0.ActiveDetailGridView as
        TcxGridDBBandedTableView;
      coli := FDictionary.Items
        [AcxGridDBBandedColumn.DataBinding.FieldName].Index;
      AValue := AcxGridDBBandedTableView0.DataController.Summary.
        FooterSummaryValues[coli - 3];

      if not VarIsNull(AValue) and not VarIsNull(AViewInfo.DisplayValue) then
      begin
        FooterSum := AValue;
        SemestrSum := AViewInfo.DisplayValue;
        if FooterSum <> SemestrSum then
        begin
          ACanvas.Font.Color := clWhite;
          ACanvas.Brush.Color := clRed;

          // Рисуем в ячейке
          ACanvas.FillRect(AViewInfo.Bounds);
          // ARect := AViewInfo.BoundsRect;
          // ARect.Left := ARect.Left + 3;
          ACanvas.DrawText(AViewInfo.DisplayValue, AViewInfo.Bounds,
            cxAlignCenter);
          ADone := True;
        end;
      end;
    end;
  except
    ;
  end;
end;

procedure TviewETP.gdbbtvThemeQuestionsDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  AcxCustomGridHitTest: TcxCustomGridHitTest;
  AcxGridDBBandedTableView: TcxGridDBBandedTableView;
  AcxGridRecordCellHitTest: TcxGridRecordCellHitTest;
  AcxGridViewNoneHitTest: TcxGridViewNoneHitTest;
  time: Double;
begin
  // Таймер должны были запустить
  Assert(FHRTimer <> nil);
  time := FHRTimer.ReadTimer;
  // Таймер больше не нужен
  FreeAndNil(FHRTimer);

  // Если это было случайное перемещение, то ничего не делаем
  if time < 500 then
    Exit;

  Assert(FQuestionOrderColumn <> nil);
  Assert(FQuestionKeyColumn <> nil);
  Assert(FLessonThemeKeyColumn <> nil);

  AcxGridDBBandedTableView := nil;

  glThemeQuestions.GridView.BeginUpdate();
  try
    // Определяем точку переноса
    AcxCustomGridHitTest := (Sender as TcxGridSite).ViewInfo.GetHitTest(X, Y);

    if AcxCustomGridHitTest is TcxGridRecordCellHitTest then
    begin
      AcxGridRecordCellHitTest :=
        AcxCustomGridHitTest as TcxGridRecordCellHitTest;
      AcxGridDBBandedTableView := AcxGridRecordCellHitTest.GridView as
        TcxGridDBBandedTableView;

      // определяем порядок в точке переноса
      FDropDrag.OrderValue := AcxGridRecordCellHitTest.GridRecord.Values
        [FQuestionOrderColumn.Index];

      // определяем код вопроса в точке переноса
      FDropDrag.Key := AcxGridRecordCellHitTest.GridRecord.Values
        [FQuestionKeyColumn.Index];
    end;

    if AcxCustomGridHitTest is TcxGridViewNoneHitTest then
    begin
      AcxGridViewNoneHitTest := AcxCustomGridHitTest as TcxGridViewNoneHitTest;
      AcxGridDBBandedTableView := AcxGridViewNoneHitTest.GridView as
        TcxGridDBBandedTableView;

      FDropDrag.Key := 0;
      FDropDrag.OrderValue := 0;
    end;

    if AcxGridDBBandedTableView <> nil then
    begin
      // Определяем код дидактической еденицы в точке переноса
      FDropDrag.IDParent := AcxGridDBBandedTableView.MasterGridRecord.Values
        [FLessonThemeKeyColumn.Index];

      Document.ThemeQuestions.MoveDSRecord(FStartDrag, FDropDrag);

    end;
  finally
    glThemeQuestions.GridView.EndUpdate;
  end;

  GetTableView(3).Focused := True;

end;

procedure TviewETP.gdbbtvThemeQuestionsDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  AcxGridRecordCellHitTest: TcxGridRecordCellHitTest;
  AcxGridSite: TcxGridSite;
  AcxGridViewNoneHitTest: TcxGridViewNoneHitTest;
  HT: TcxCustomGridHitTest;
begin
  Accept := False;

  AcxGridSite := Sender as TcxGridSite;
  HT := AcxGridSite.ViewInfo.GetHitTest(X, Y);

  // Если перетаскиваем на пустой GridView
  if HT is TcxGridViewNoneHitTest then
  begin
    AcxGridViewNoneHitTest := HT as TcxGridViewNoneHitTest;

    Accept := AcxGridViewNoneHitTest.GridView.Level = FStartDragLevel;
  end;

  // Если перетаскиваем на ячейку GridView
  if HT is TcxGridRecordCellHitTest then
  begin
    AcxGridRecordCellHitTest := HT as TcxGridRecordCellHitTest;

    Accept := (AcxGridRecordCellHitTest.GridView.Level = FStartDragLevel) and
      (AcxGridRecordCellHitTest.GridRecord.RecordIndex <>
      AcxGridSite.GridView.DataController.FocusedRecordIndex);
  end

end;

procedure TviewETP.gdbbtvThemeQuestionsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
var
  i: Integer;
begin
  Assert(FLessonThemeKeyColumn <> nil);
  Assert(FQuestionKeyColumn <> nil);
  Assert(FQuestionOrderColumn <> nil);
  with (Sender as TcxGridSite).GridView as TcxGridDBBandedTableView do
  begin
    FStartDragLevel := Level as TcxGridLevel;

    Assert(Controller.SelectedRowCount > 0);

    // Запоминаем код темы переносимых вопросов
    FStartDrag.IDParent := MasterGridRecord.Values[FLessonThemeKeyColumn.Index];

    // запоминаем минимальный порядок записи которую начали переносить
    FStartDrag.MinOrderValue := Controller.SelectedRows[0].Values
      [FQuestionOrderColumn.Index];
    // запоминаем максимальный порядок записи которую начали переносить
    FStartDrag.MaxOrderValue := Controller.SelectedRows
      [Controller.SelectedRecordCount - 1].Values[FQuestionOrderColumn.Index];

    SetLength(FStartDrag.Keys, Controller.SelectedRowCount);
    for i := 0 to Controller.SelectedRowCount - 1 do
    begin
      FStartDrag.Keys[i] := Controller.SelectedRecords[i].Values
        [FQuestionKeyColumn.Index];
    end;

    // Запускаем таймер чтобы рассчитать время переноса записей
    FHRTimer := THRTimer.Create(True);
  end;

end;

procedure TviewETP.gdbbtvThemeUnionControlsEditKeyDown
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  inherited;
  AView := (Sender as TcxGridDBBandedTableView);
  AColumn := AView.GetColumnByFieldName
    (cxgdbbcControlName.DataBinding.FieldName);
  Assert(AColumn <> nil);

  // Если нажали Enter
  if (Key = 13) and (AItem = AColumn) then
  begin
    Document.ThemeUnionControl.Wrap.Post();
  end;
end;

procedure TviewETP.gdbbtvThemeUnionEducationalWorksEditKeyDown
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  AView := (Sender as TcxGridDBBandedTableView);
  AColumn := AView.GetColumnByFieldName
    (clEducationalWork.DataBinding.FieldName);
  Assert(AColumn <> nil);

  // Если нажали Enter
  if (Key = 13) and (AItem = AColumn) then
  begin
    Document.ThemeUnionEducationalWorks.Wrap.Post();
  end;
end;

procedure TviewETP.gdbbtvThemeUnionIndependentWorkEditKeyDown
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  inherited;
  AView := (Sender as TcxGridDBBandedTableView);
  AColumn := AView.GetColumnByFieldName
    (clIndependentWork.DataBinding.FieldName);
  Assert(AColumn <> nil);

  // Если нажали Enter
  if (Key = 13) and (AItem = AColumn) then
  begin
    Document.ThemeUnionIndependentWork.Wrap.Post();
  end;
end;

procedure TviewETP.gdbbtvThemeUnionLessonFeatureEditKeyDown
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  inherited;
  AView := (Sender as TcxGridDBBandedTableView);
  AColumn := AView.GetColumnByFieldName(clLessonFeature.DataBinding.FieldName);
  Assert(AColumn <> nil);

  // Если нажали Enter
  if (Key = 13) and (AItem = AColumn) then
  begin
    Document.ThemeUnionLessonTheatures.Wrap.Post();
  end;
end;

procedure TviewETP.gdbbtvThemeUnionTechnologiesEditKeyDown
  (Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
var
  AColumn: TcxGridDBBandedColumn;
  AView: TcxGridDBBandedTableView;
begin
  inherited;
  AView := (Sender as TcxGridDBBandedTableView);
  AColumn := AView.GetColumnByFieldName(clIDTechnology.DataBinding.FieldName);
  Assert(AColumn <> nil);

  // Если нажали Enter
  if (Key = 13) and (AItem = AColumn) then
  begin
    Document.THEMEUNIONTECHNOLOGIES.Wrap.Post();
  end;
end;

function TviewETP.GetDocument: TETP;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TETP;
end;

function TviewETP.GetFocusedTableView: TcxGridDBBandedTableView;
begin
  Result := inherited;

  // Если не первый уровень в фокусе
  if Result = nil then
  begin
    Result := GetTableView(1);
    if (Result <> nil) and (not Result.Focused) then
      Result := nil;
  end;

  // Если не второй уровень в фокусе
  if Result = nil then
  begin
    Result := GetTableView(2);
    if (Result <> nil) and (not Result.Focused) then
      Result := nil;
  end;
  {
    // Если не третий уровень в фокусе
    if Result = nil then
    begin
    Result := GetTableView(3);
    if (Result <> nil) and (not Result.Focused) then
    Result := nil;
    end;
  }
end;

function TviewETP.GetRow(ALevel: Cardinal): TcxCustomGridRow;
var
  i: Integer;
begin
  Result := nil;
  i := GetTableView(ALevel).DataController.FocusedRowIndex;
  if i >= 0 then
    Result := GetTableView(ALevel).ViewData.Rows[i];
end;

function TviewETP.GetShowAction: TAction;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to actlstLessonThemes.ActionCount - 1 do
  begin
    if (actlstLessonThemes.Actions[i].GroupIndex = 1) and
      (actlstLessonThemes.Actions[i].Checked) then
    begin
      Result := actlstLessonThemes.Actions[i] as TAction;
      Break;
    end;
  end;

end;

function TviewETP.GetTableView(ALevel: Cardinal): TcxGridDBBandedTableView;
var
  AcxGridDBBandedTableView: TcxGridDBBandedTableView;
  AcxGridMasterDataRow: TcxGridMasterDataRow;
  i: Integer;
begin
  Result := nil;

  case ALevel of
    0:
      Result := cxGridDBBandedTableView;
    1, 2:
      begin
        AcxGridDBBandedTableView := GetTableView(ALevel - 1);
        if AcxGridDBBandedTableView = nil then
          Exit;

        i := AcxGridDBBandedTableView.DataController.FocusedRowIndex;
        if i < 0 then
          Exit;

        // Assert(i >= 0);

        AcxGridMasterDataRow := GetTableView(ALevel - 1).ViewData.Rows[i]
          as TcxGridMasterDataRow;
        // Спускаемся на дочерний уровень
        Result := AcxGridMasterDataRow.ActiveDetailGridView as
          TcxGridDBBandedTableView;
      end;
  else
    raise Exception.Create('Уровень должен быть от 0 до 3');
  end;

end;

procedure TviewETP.InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn);
const
  FieldsNames: array [0 .. 4] of String = ('Всего', 'Лек', 'Лаб', 'Сем', 'Сам');
var
  AcxDataSummaryItem: TcxGridDbTableSummaryItem;
  i: Integer;
  P: TcxLookupComboBoxProperties;
begin
  // Независимо от уровня
  for i := Low(FieldsNames) to High(FieldsNames) do
    if AnsiSameText(FieldsNames[i], AcxGridDBBandedColumn.DataBinding.FieldName)
    then
    begin
      // Ширина таких колонок будет одинаковой
      UpdateGridColumnWidth(AcxGridDBBandedColumn, 55);
      AcxGridDBBandedColumn.RepositoryItem := DM.cxEditRepository1SpinItem1;

      // Колонки первого уровня могут быть красными в случае ошибки
      if AcxGridDBBandedColumn.GridView = gdbbtvLessonThemes then
      begin
        FDictionary.Add(AcxGridDBBandedColumn.DataBinding.FieldName,
          AcxGridDBBandedColumn);
      end;

      // Подвал у таких колонок будет содержать их сумму
      AcxDataSummaryItem := AcxGridDBBandedColumn.GridView.DataController.
        Summary.FooterSummaryItems.Add as TcxGridDbTableSummaryItem;
      AcxDataSummaryItem.Column := AcxGridDBBandedColumn;

      AcxDataSummaryItem.Kind := skSum;
      AcxDataSummaryItem.Format := '0';
    end;

  // Колонку "Всего" редактировать не будем
  if AnsiSameText('Всего', AcxGridDBBandedColumn.DataBinding.FieldName) then
    AcxGridDBBandedColumn.Options.Editing := False;

  // Колонки уровня "Сессия"
  if AcxGridDBBandedColumn.GridView = cxGridDBBandedTableView then
  begin
    AcxGridDBBandedColumn.Styles.Header := DM.cxstyl3;
    AcxGridDBBandedColumn.Styles.Content := DM.cxstyl3;

    if AnsiSameText(Document.DisciplineSemestrs.KeyFieldName,
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      FSessionUnionKeyColumn := AcxGridDBBandedColumn;
      AcxGridDBBandedColumn.Visible := False;
    end;
  end
  else if AcxGridDBBandedColumn.GridView = gdbbtvThemeUnions then
  begin
    // Колонки уровня "ДЕ"
    AcxGridDBBandedColumn.Styles.Header := DM.cxstyl2;
    AcxGridDBBandedColumn.Styles.Content := DM.cxstyl2;

    if AnsiSameText(Document.ThemeUnions.KeyFieldName,
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      FThemeUnionKeyColumn := AcxGridDBBandedColumn;
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('ThemeUnionOrder',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      FThemeUnionOrderColumn := AcxGridDBBandedColumn;
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('Всего', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      cxgdbbcMaxMark.Position.ColIndex :=
        AcxGridDBBandedColumn.Position.ColIndex - 1;
      FThemeUnionTotalColumn := AcxGridDBBandedColumn;
    end;

    if AnsiSameText('Max_Mark', AcxGridDBBandedColumn.DataBinding.FieldName)
    then
    begin
      AcxDataSummaryItem := AcxGridDBBandedColumn.GridView.DataController.
        Summary.FooterSummaryItems.Add as TcxGridDbTableSummaryItem;
      AcxDataSummaryItem.Column := AcxGridDBBandedColumn;
      AcxDataSummaryItem.Kind := skSum;
      AcxDataSummaryItem.Format := '0';
    end;

  end
  else if AcxGridDBBandedColumn.GridView = gdbbtvLessonThemes then
  begin
    // Колонки уровня "Темы"
    AcxGridDBBandedColumn.Styles.Header := DM.cxstyl3;

    if AnsiSameText(Document.LessonThemes.KeyFieldName,
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      FLessonThemeKeyColumn := AcxGridDBBandedColumn;
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('ThemeName', AcxGridDBBandedColumn.DataBinding.FieldName)
    then
    begin
      AcxGridDBBandedColumn.PropertiesClass := TcxTextEditProperties;
    end;

    if AnsiSameText('Курс', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      FLessonThemeCursColumn := AcxGridDBBandedColumn;
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('Экз', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('Всего', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      FLessonThemeTotalColumn := AcxGridDBBandedColumn;
    end;

    if AnsiSameText('RecNo', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      UpdateGridColumnWidth(AcxGridDBBandedColumn, 50);
      // Запрещаем прямое редактирование номера темы
      AcxGridDBBandedColumn.Options.Editing := False;

      AcxDataSummaryItem := AcxGridDBBandedColumn.GridView.DataController.
        Summary.FooterSummaryItems.Add as TcxGridDbTableSummaryItem;
      AcxDataSummaryItem.Column := AcxGridDBBandedColumn;
      AcxDataSummaryItem.Kind := skCount;
    end;

    if AnsiSameText('ThemeOrder', AcxGridDBBandedColumn.DataBinding.FieldName)
    then
    begin
      FLessonThemeOrderColumn := AcxGridDBBandedColumn;
      AcxGridDBBandedColumn.Visible := False;
    end;

  end
  else if AcxGridDBBandedColumn.GridView = gdbbtvThemeUnionControls then
  begin
    // Колонки уровня "Текущий контроль"
    if AnsiSameText('IDControlName', AcxGridDBBandedColumn.DataBinding.FieldName)
    then
    begin
      P := AcxGridDBBandedColumn.Properties as TcxLookupComboBoxProperties;
      P.ListSource := Document.ControlNames.DataSetWrap.DataSource;
      P.ListFieldNames := 'ControlName';
      P.KeyFieldNames := 'ID_ControlName';
    end;
  end
  else if AcxGridDBBandedColumn.GridView = gdbbtvThemeUnionIndependentWork then
  begin
    // Колонки уровня "Сам. раб. студента"
    if AnsiSameText('IDIndependentWork',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      P := AcxGridDBBandedColumn.Properties as TcxLookupComboBoxProperties;
      P.ListSource := Document.IndependentWork.DataSetWrap.DataSource;
      P.ListFieldNames := 'IndependentWork';
      P.KeyFieldNames := 'ID_IndependentWork';
    end;
  end
  else if AcxGridDBBandedColumn.GridView = gdbbtvThemeUnionEducationalWorks then
  begin
    // Колонки уровня "Виды учебной работы"
    if AnsiSameText('IDEducationalWork',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      P := AcxGridDBBandedColumn.Properties as TcxLookupComboBoxProperties;
      P.ListSource := Document.EducationalWorks.DataSetWrap.DataSource;
      P.ListFieldNames := 'EducationalWork';
      P.KeyFieldNames := 'ID_EducationalWork';
    end;
  end
  else if AcxGridDBBandedColumn.GridView = gdbbtvThemeUnionLessonFeature then
  begin
    // Колонки уровня "Особенности проведения занятий"
    if AnsiSameText('IDLessonFeature',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      P := AcxGridDBBandedColumn.Properties as TcxLookupComboBoxProperties;
      P.ListSource := Document.LessonFeatures.DataSetWrap.DataSource;
      P.ListFieldNames := 'LessonFeature';
      P.KeyFieldNames := 'ID_LessonFeature';
    end;
  end
  else if AcxGridDBBandedColumn.GridView = gdbbtvThemeUnionTechnologies then
  begin
    // Колонки уровня "Образовательные технологии"
    if AnsiSameText('IDTechnology', AcxGridDBBandedColumn.DataBinding.FieldName)
    then
    begin
      P := AcxGridDBBandedColumn.Properties as TcxLookupComboBoxProperties;
      P.ListSource := Document.Technologies.DataSetWrap.DataSource;
      P.ListFieldNames := 'Technology';
      P.KeyFieldNames := 'ID_Technology';
    end;
  end
  else if AcxGridDBBandedColumn.GridView.Level = glThemeQuestions then
  begin
    // Колонки уровня "Вопросы по темам"
    if AnsiSameText(Document.ThemeQuestions.KeyFieldName,
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      FQuestionKeyColumn := AcxGridDBBandedColumn;
      AcxGridDBBandedColumn.Visible := False;
    end;

    if AnsiSameText('IDThemeQuestionType',
      AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      P := AcxGridDBBandedColumn.Properties as TcxLookupComboBoxProperties;
      P.ListSource := Document.ThemeQuestionTypes.DataSetWrap.DataSource;
      P.ListFieldNames := 'ThemeQuestionType';
      P.KeyFieldNames := 'ID_ThemeQuestionType';
    end;

    if AnsiSameText('ORD', AcxGridDBBandedColumn.DataBinding.FieldName) then
    begin
      FQuestionOrderColumn := AcxGridDBBandedColumn;
    end;
  end;

  AcxGridDBBandedColumn.Options.Sorting := False;
  // AcxGridDBBandedColumn.Options.HorzSizing := False;
  AcxGridDBBandedColumn.Options.Moving := False;
  AcxGridDBBandedColumn.Options.VertSizing := False;
  AcxGridDBBandedColumn.Options.Grouping := False;
  AcxGridDBBandedColumn.Options.Filtering := False;

end;

procedure TviewETP.OnCopyDataChange(Sender: TObject);
begin
  UpdateView;
end;

procedure TviewETP.SetDocument(const Value: TDocument);
begin
  inherited;

  UpdateView;

  if (FDocument <> nil) then
  begin
    KcxGridDBBandedTableView.SetDocument(Document.DisciplineSemestrs.Wrap);
    KgdbbtvThemeUnions.SetDocument(Document.ThemeUnions.Wrap);
    KgdbbtvLessonThemes.SetDocument(Document.LessonThemes.Wrap);
    KgdbbtvThemeUnionControls.SetDocument(Document.ThemeUnionControl.Wrap);
    KgdbbtvThemeUnionIndependentWork.SetDocument
      (Document.ThemeUnionIndependentWork.Wrap);
    KgdbbtvThemeUnionEducationalWorks.SetDocument
      (Document.ThemeUnionEducationalWorks.Wrap);
    KgdbbtvThemeUnionLessonFeature.SetDocument
      (Document.ThemeUnionLessonTheatures.Wrap);
    KgdbbtvThemeUnionTechnologies.SetDocument
      (Document.THEMEUNIONTECHNOLOGIES.Wrap);
    KgdbbtvThemeQuestion.SetDocument(Document.ThemeQuestions.Wrap);

    // DBGrid1.DataSource := Document.ThemeQuestions.Wrap.DataSource;


    // DBGrid1.DataSource := Document.ThemeUnionControl.Wrap.DataSource;

    TNotifyEventWrap.Create(Document.BeforeUpdate, BeforeUpdate);
    TNotifyEventWrap.Create(Document.AfterUpdate, AfterUpdate);

    FView.SetDocument(Document.CopyData);
    TNotifyEventWrap.Create(FView.OnUpdateView, OnCopyDataChange, EventsList);
  end
  else
  begin
    KcxGridDBBandedTableView.SetDocument(nil);
    KgdbbtvThemeUnions.SetDocument(nil);
    KgdbbtvLessonThemes.SetDocument(nil);
    KgdbbtvThemeUnionControls.SetDocument(nil);
    KgdbbtvThemeUnionIndependentWork.SetDocument(nil);
    KgdbbtvThemeUnionEducationalWorks.SetDocument(nil);
    KgdbbtvThemeUnionLessonFeature.SetDocument(nil);
    KgdbbtvThemeUnionTechnologies.SetDocument(nil);
    KgdbbtvThemeQuestion.SetDocument(nil);
  end;
end;

procedure TviewETP.tbi1Click(Sender: TObject);
begin
  inherited;
  // PutInTheCenterFocusedRecord(cxGridDBBandedTableView);
  // V := GetRow(3).Values[FQuestionKeyColumn.Index];
  // if not VarIsNull(V) then
  // begin
  // Document.ThemeQuestions.Wrap.LocateByPK(V);
  // end;
  // gdbbtvThemeQuestions.DataController.DataModeController.SyncMode := True;
  gdbbtvThemeQuestions.DataController.DataModeController.SyncMode :=
    not gdbbtvThemeQuestions.DataController.DataModeController.SyncMode;
end;

procedure TviewETP.UpdateGridColumnWidth(AcxGridDBBandedColumn
  : TcxGridDBBandedColumn; ColumnWidth: Integer);
begin
  AcxGridDBBandedColumn.MinWidth := ColumnWidth;
  AcxGridDBBandedColumn.Options.AutoWidthSizable := False;
  AcxGridDBBandedColumn.Width := AcxGridDBBandedColumn.MinWidth;
end;

procedure TviewETP.UpdateView;
var
  AFocusedView: TcxGridDBBandedTableView;
begin
  AFocusedView := FocusedTableView;

  actUndo.Enabled := (FDocument <> nil) and (Document.ChangeCount > 0);

  actSave.Enabled := actUndo.Enabled and (Document.ChangeCount > 0);

  // Удалить раздел или тему
  actDelete.Enabled := (FDocument <> nil) and (AFocusedView <> nil) and
  // на сфокусированном уровне есть записи
    (AFocusedView.ViewData.RowCount > 0) and (AFocusedView.Level <> cxGridLevel);

  if actDelete.Enabled then
  begin
    if AFocusedView.Level = glThemeUnions then
      actDelete.Hint := TLangConst.ПодсказкаПриУдаленииРаздела;
    if AFocusedView.Level = glLessonThemes then
      actDelete.Hint := TLangConst.ПодсказкаПриУдаленииТемы;
    if AFocusedView.Level = glThemeUnionControls then
      actDelete.Hint := TLangConst.ПодсказкаПриУдаленииТекущегоКонтроля;
    if AFocusedView.Level = glThemeUnionIndependentWork then
      actDelete.Hint := TLangConst.ПодсказкаПриУдаленииСРС;
    if AFocusedView.Level = glThemeUnionEducationalWorks then
      actDelete.Hint := TLangConst.ПодсказкаПриУдаленииВидаУР;
    if AFocusedView.Level = glThemeUnionLessonFeature then
      actDelete.Hint := TLangConst.ПодсказкаПриУдаленииОсобенностей;
    if AFocusedView.Level = glThemeUnionTechnologies then
      actDelete.Hint := TLangConst.ПодсказкаПриУдаленииТехнологий;
    if AFocusedView.Level = glThemeQuestions then
      actDelete.Hint := TLangConst.ПодсказкаПриУдаленииВопросов;
  end;

  // Добавить СРС
  actAddThemeUnionIndependentWork.Enabled := (FDocument <> nil) and
    (AFocusedView <> nil) and ((
    // Сфокусирован уровень 2
    (AFocusedView.Level = glThemeUnions) and
    // На уровне 2 есть записи
    (AFocusedView.DataController.RowCount > 0) and
    (GetTableView(2) <> nil) and
    // У второго уровня активно дочернее представление темы
    (GetTableView(2).Level = glThemeUnionIndependentWork)
    // Или сфокусирован уровень 3
    ) or (AFocusedView.Level = glThemeUnionIndependentWork));

  // Добавить текущий контроль
  actAddThemeUnionControl.Enabled := (FDocument <> nil) and
    (AFocusedView <> nil) and ((
    // Сфокусирован уровень 2
    (AFocusedView.Level = glThemeUnions) and
    // На уровне 2 есть записи
    (AFocusedView.DataController.RowCount > 0) and
    (GetTableView(2) <> nil) and
    // У второго уровня активно дочернее представление темы
    (GetTableView(2).Level = glThemeUnionControls)
    // Или сфокусирован уровень 3
    ) or (AFocusedView.Level = glThemeUnionControls));

  // Добавить вид учебной работы
  actAddThemeUnionEducationalWork.Enabled := (FDocument <> nil) and
    (AFocusedView <> nil) and ((
    // Сфокусирован уровень 2
    (AFocusedView.Level = glThemeUnions) and
    // На уровне 2 есть записи
    (AFocusedView.DataController.RowCount > 0) and
    (GetTableView(2) <> nil) and
    // У второго уровня активно дочернее представление темы
    (GetTableView(2).Level = glThemeUnionEducationalWorks)
    // Или сфокусирован уровень 3
    ) or (AFocusedView.Level = glThemeUnionEducationalWorks));

  // Добавить особенность проведения занятий
  actAddThemeUnionLessonFeature.Enabled := (FDocument <> nil) and
    (AFocusedView <> nil) and ((
    // Сфокусирован уровень 2
    (AFocusedView.Level = glThemeUnions) and
    // На уровне 2 есть записи
    (AFocusedView.DataController.RowCount > 0) and
    (GetTableView(2) <> nil) and
    // У второго уровня активно дочернее представление темы
    (GetTableView(2).Level = glThemeUnionLessonFeature)
    // Или сфокусирован уровень 3
    ) or (AFocusedView.Level = glThemeUnionLessonFeature));

  // Добавить образовательную технологию
  actAddThemeUnionTechnology.Enabled := (FDocument <> nil) and
    (AFocusedView <> nil) and ((
    // Сфокусирован уровень 2
    (AFocusedView.Level = glThemeUnions) and
    // На уровне 2 есть записи
    (AFocusedView.DataController.RowCount > 0) and
    (GetTableView(2) <> nil) and
    // У второго уровня активно дочернее представление темы
    (GetTableView(2).Level = glThemeUnionTechnologies)
    // Или сфокусирован уровень 3
    ) or (AFocusedView.Level = glThemeUnionTechnologies));

    // Добавить тему
    actAddLessonTheme.Enabled :=
    (FDocument <> nil) and
    (AFocusedView <> nil) and
    (
    (
    // Сфокусирован уровень 2
    (AFocusedView.Level = glThemeUnions) and
    // На уровне 2 есть записи
    (AFocusedView.DataController.RowCount > 0) and
    (GetTableView(2) <> nil) and
    // У второго уровня активно дочернее представление темы
    (GetTableView(2).Level = glLessonThemes)
    // Или сфокусирован уровень 3
    )
    or
    (AFocusedView.Level = glLessonThemes)
    );

  {
    // Добавить тему
    actAddLessonTheme.Enabled := (FDocument <> nil) and
    (AFocusedView <> nil) and ((
    // Сфокусирован уровень 2
    (AFocusedView.Level = glThemeUnions) and
    // На уровне 2 есть записи
    (AFocusedView.DataController.RowCount > 0) and
    // У второго уровня активно дочернее представление темы
    (GetTableView(2).Level = glLessonThemes)
    // Или сфокусирован уровень 3
    ) or (AFocusedView.Level = glLessonThemes));

    // Добавить вопрос
    actAddAudQuestion.Enabled := (FDocument <> nil) and
    (AFocusedView <> nil) and ((
    // Сфокусирован уровень тем
    (AFocusedView.Level = glLessonThemes) and
    // На уровне тем есть записи
    (AFocusedView.DataController.RowCount > 0) and
    // У уровня тем дочернее представление - вопросы
    (GetTableView(3).Level = glThemeQuestions)
    // Или сфокусирован уровень вопросов
    ) or (AFocusedView.Level = glThemeQuestions));
  }
  actAddSelfQuestion.Enabled := actAddAudQuestion.Enabled;

  // Добавить раздел
  actAddDE.Enabled := (FDocument <> nil) and (AFocusedView <> nil) and ((
    // Сфокусирован уровень 1
    (AFocusedView.Level = cxGridLevel) and
    // На уровне 1 есть записи
    (AFocusedView.DataController.RowCount > 0)
    // Или сфокусирован уровень 2
    ) or (AFocusedView.Level = glThemeUnions));

  actCopy.Enabled := (FDocument <> nil) and (Document.IsCopyEnabled);

  actPaste.Enabled := (FDocument <> nil) and (Document.IsPasteEnabled);

  actReport.Enabled := (FDocument <> nil) and (Document.ChangeCount = 0) and
    (Document.LessonThemes.DS.RecordCount > 0)
end;

end.
