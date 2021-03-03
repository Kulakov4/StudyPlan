unit SPView2;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Forms,
  Dialogs, ViewEx, SPUnit, SPDBTreeListView, ExtCtrls, DocumentView,
  NotifyEvents, ActnList, ImgList, TB2Item, TB2Dock, TB2Toolbar, Menus, cxTL,
  System.Actions, UMKMasterView, System.Generics.Collections, System.ImageList,
  MyFR, SpecialitySessions, SpecialitySessionsView, System.Classes,
  Vcl.Controls;

const
  WM_AFTER_OPEN_WP = WM_USER + 112;

type
  TviewSP = class(TView_Ex)
    pnlMain: TPanel;
    ActionList: TActionList;
    actNew: TAction;
    actDelete: TAction;
    actEdit: TAction;
    actTotal: TAction;
    actSelf: TAction;
    actAuditor: TAction;
    actChair: TAction;
    actMark: TAction;
    actLectures: TAction;
    actPracticalLessons: TAction;
    actLaboratoryLessons: TAction;
    actExam: TAction;
    actZach: TAction;
    actCurs: TAction;
    actControl: TAction;
    actConsultation: TAction;
    actPract: TAction;
    actDiplom: TAction;
    actGA: TAction;
    actBase: TAction;
    actAddition: TAction;
    TBImageList1: TTBImageList;
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    TBItem2: TTBItem;
    TBItem5: TTBItem;
    TBItem1: TTBItem;
    TBSeparatorItem1: TTBSeparatorItem;
    TBSeparatorItem2: TTBSeparatorItem;
    TBItem7: TTBItem;
    TBItem6: TTBItem;
    pmDBTreeList: TPopupMenu;
    mniTotal: TMenuItem;
    N27: TMenuItem;
    N1: TMenuItem;
    mniSelf: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N14: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N17: TMenuItem;
    N16: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N25: TMenuItem;
    TBItem8: TTBItem;
    tbi1: TTBItem;
    actRefresh: TAction;
    TBSeparatorItem3: TTBSeparatorItem;
    TBItem10: TTBItem;
    actShowSummary: TAction;
    actTotal2: TAction;
    actRepeatExam: TAction;
    actSam: TAction;
    N3: TMenuItem;
    actUMK: TAction;
    actLessonThemes: TAction;
    actIDStudyPlan: TAction;
    ID1: TMenuItem;
    TBPopupMenu1: TTBPopupMenu;
    TBItem9: TTBItem;
    tbsmiLessonThemes: TTBSubmenuItem;
    TBItem11: TTBItem;
    TBItem12: TTBItem;
    actDisciplineCompetence: TAction;
    tbsmiCompetence: TTBSubmenuItem;
    TBSubmenuItem1: TTBSubmenuItem;
    TBItem13: TTBItem;
    TBItem14: TTBItem;
    tbsmiWP: TTBSubmenuItem;
    actOpenWP: TAction;
    tbsmiOpenWP: TTBSubmenuItem;
    actDisciplineLit: TAction;
    TBItem3: TTBItem;
    TBToolbar2: TTBToolbar;
    actStructure: TAction;
    TBItem4: TTBItem;
    TBSubmenuItem2: TTBSubmenuItem;
    actStudyPlanReport: TAction;
    TBItem15: TTBItem;
    actPlanGraphBySpecReport: TAction;
    TBItem16: TTBItem;
    actPlanGraphByAdmissionReport: TAction;
    TBItem17: TTBItem;
    actSpecialitySessions: TAction;
    TBItem18: TTBItem;
    actStructure2: TAction;
    procedure actAdditionExecute(Sender: TObject);
    procedure actAuditorExecute(Sender: TObject);
    procedure actBaseExecute(Sender: TObject);
    procedure actChairExecute(Sender: TObject);
    procedure actConsultationExecute(Sender: TObject);
    procedure actControlExecute(Sender: TObject);
    procedure actCursExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actDiplomExecute(Sender: TObject);
    procedure actDisciplineCompetenceExecute(Sender: TObject);
    procedure actDisciplineLitExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actEditUpdate(Sender: TObject);
    procedure actLessonThemesExecute(Sender: TObject);
    procedure actExamExecute(Sender: TObject);
    procedure actGAExecute(Sender: TObject);
    procedure actIDStudyPlanExecute(Sender: TObject);
    procedure actLaboratoryLessonsExecute(Sender: TObject);
    procedure actLecturesExecute(Sender: TObject);
    procedure actMarkExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actOpenWPExecute(Sender: TObject);
    procedure actPlanGraphByAdmissionReportExecute(Sender: TObject);
    procedure actPlanGraphBySpecReportExecute(Sender: TObject);
    procedure actPractExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actRepeatExamExecute(Sender: TObject);
    procedure actSamExecute(Sender: TObject);
    procedure actSelfExecute(Sender: TObject);
    procedure actPracticalLessonsExecute(Sender: TObject);
    procedure actShowSummaryExecute(Sender: TObject);
    procedure actSpecialitySessionsExecute(Sender: TObject);
    procedure actStructure2Execute(Sender: TObject);
    procedure actStructureExecute(Sender: TObject);
    procedure actStudyPlanReportExecute(Sender: TObject);
    procedure actTotal2Execute(Sender: TObject);
    procedure actTotalExecute(Sender: TObject);
    procedure actUMKExecute(Sender: TObject);
    procedure actZachExecute(Sender: TObject);
  private
    FAfterSPInsert: TNotifyEventWrap;
    FBeforeSPInsert: TNotifyEventWrap;
    FNotifyEventWrap: TNotifyEventWrap;
    FOnReportPlanGraphBySpecExec: TNotifyEventsEx;
    FReadOnly: Boolean;
    FShowCheked: Boolean;
    FviewDBTreeListSP: TviewDBTreeListSP;
    procedure AfterSPInsert(Sender: TObject);
    procedure BeforeSPInsert(Sender: TObject);
    procedure CheckSelectedAndFocused;
    procedure DoAfterOpenWP(var Message: TMessage); message WM_AFTER_OPEN_WP;
    function GetColumnVisible(AIDLessonType: Integer): Boolean;
    function GetDocument: TStudyPlan;
    function GetEditing: Boolean;
    function GetSelectedIDStudyPlan: TList<Integer>;
    procedure OnBandVisibleChange(AAction: TAction; ColumnName: string);
    procedure OnColumnVisibleChange(AAction: TAction;
      ColumnName: string); overload;
    procedure OnColumnVisibleChange(AAction: TAction;
      IDLessonType: Integer); overload;
    procedure OnLessonThemesToolbasItemClick(Sender: TObject);
    procedure OnUMKToolbasItemClick(Sender: TObject);
    procedure OnSummaryItemsGetText(Sender: TcxTreeListSummaryItem;
      const AValue: Variant; var AText: string);
    procedure OnSummaryItemsGetText2(Sender: TcxTreeListSummaryItem;
      const AValue: Variant; var AText: string);
    procedure OnDisciplineCompetenceToolbasItemClick(Sender: TObject);
    procedure OnOpenUMKToolbasItemClick(Sender: TObject);
    procedure SetColumnVisible(IDLessonType: Integer; const Value: Boolean);
    procedure SetEditing(const Value: Boolean);
    procedure ShowLessonThemes(AIDDiscipline: Integer; ADisciplineName: string);
    procedure ShowUMK(AIDDiscipline: Integer; ADisciplineName: string);
    procedure ShowSPEditForm;
    procedure ShowDisciplineCompetence(AIDDiscipline: Integer;
      ADisciplineName: string);
    procedure OpenUMK(AIDDiscipline: Integer; ADisciplineName: string);
    property ColumnVisible[IDLessonType: Integer]: Boolean read GetColumnVisible
      write SetColumnVisible;
    { Private declarations }
  protected
    procedure OnInitTreeListView(Sender: TObject);
    property Document: TStudyPlan read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    destructor Destroy; override;
    procedure Recreate;
    procedure SetDocument(const Value: TDocument); override;
    procedure UpdateView; override;
    property Editing: Boolean read GetEditing write SetEditing;
    property OnReportPlanGraphBySpecExec: TNotifyEventsEx
      read FOnReportPlanGraphBySpecExec;
    property ReadOnly: Boolean read FReadOnly write FReadOnly;
    property ShowCheked: Boolean read FShowCheked write FShowCheked;
    { Public declarations }
  end;

implementation

uses SPEditForm, DB, SPEditView, SPViewDM, cxDBTL, cxStyles, cxCustomData,
  DBTreeListView, DataSetWrap, dxCore, UMKMasterForm, UMKMaster, ViewFormEx,
  ETP, ETPView, EssenceGridView, MyDataAccess, CommissionOptions,
  DisciplineCompetence, DisciplineCompetenceView, ProgressBarForm,
  StudyPlanInfo, System.IOUtils, UMKDataModule, System.UITypes, DisciplineLit,
  DisciplineLitView, CSEView, OptionsHelper, SpecSessGroup, GridViewForm,
  SpecSessView, FR3, ReportFilesUpdater, MyDir, ViewCSE;

{$R *.dfm}

constructor TviewSP.Create(AOwner: TComponent; AParent: TWinControl;
  AAlign: TAlign = alClient);
begin
  inherited;
  FviewDBTreeListSP := TviewDBTreeListSP.Create(Self, pnlMain);

  FNotifyEventWrap := TNotifyEventWrap.Create
    (FviewDBTreeListSP.OnInitTreeListView, OnInitTreeListView);

  FOnReportPlanGraphBySpecExec := TNotifyEventsEx.Create(Self);

  UpdateView;
end;

destructor TviewSP.Destroy;
begin
  FreeAndNil(FOnReportPlanGraphBySpecExec);
  inherited;
end;

procedure TviewSP.actAdditionExecute(Sender: TObject);
begin
  FviewDBTreeListSP.cxdbtlView.BeginUpdate;
  try
    actBase.Checked := False;
    actAddition.Checked := True;

    if not actTotal.Checked then
      actTotal.Execute;
    if not actSelf.Checked then
      actSelf.Execute;
    if actAuditor.Checked then
      actAuditor.Execute;
    if actLectures.Checked then
      actLectures.Execute;
    if actPracticalLessons.Checked then
      actPracticalLessons.Execute;
    if actLaboratoryLessons.Checked then
      actLaboratoryLessons.Execute;
    if actExam.Checked then
      actExam.Execute;
    if actZach.Checked then
      actZach.Execute;
    if actCurs.Checked then
      actCurs.Execute;
    if actControl.Checked then
      actControl.Execute;
    if actConsultation.Checked then
      actConsultation.Execute;
    if not actPract.Checked then
      actPract.Execute;
    if not actDiplom.Checked then
      actDiplom.Execute;
    if not actGA.Checked then
      actGA.Execute;
  finally
    FviewDBTreeListSP.cxdbtlView.EndUpdate;
  end;
end;

procedure TviewSP.actAuditorExecute(Sender: TObject);
begin
  OnBandVisibleChange(actAuditor, 'all');
end;

procedure TviewSP.actBaseExecute(Sender: TObject);
begin
  FviewDBTreeListSP.cxdbtlView.BeginUpdate;
  try
    actBase.Checked := True;
    actAddition.Checked := False;

    if not actTotal.Checked then
      actTotal.Execute;
    if not actSelf.Checked then
      actSelf.Execute;
    if not actAuditor.Checked then
      actAuditor.Execute;
    if not actLectures.Checked then
      actLectures.Execute;
    if not actPracticalLessons.Checked then
      actPracticalLessons.Execute;
    if not actLaboratoryLessons.Checked then
      actLaboratoryLessons.Execute;
    if not actExam.Checked then
      actExam.Execute;
    if not actZach.Checked then
      actZach.Execute;
    if not actCurs.Checked then
      actCurs.Execute;
    if not actControl.Checked then
      actControl.Execute;
    if not actConsultation.Checked then
      actConsultation.Execute;
    if actPract.Checked then
      actPract.Execute;
    if actDiplom.Checked then
      actDiplom.Execute;
    if actGA.Checked then
      actGA.Execute;
  finally
    FviewDBTreeListSP.cxdbtlView.EndUpdate;
  end;
end;

procedure TviewSP.actChairExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actChair, 'department');
end;

procedure TviewSP.actConsultationExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actConsultation, actConsultation.Tag);
end;

procedure TviewSP.actControlExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actControl, actControl.Tag);
end;

procedure TviewSP.actCursExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actCurs, actCurs.Tag);
end;

procedure TviewSP.actDeleteExecute(Sender: TObject);
var
  AIDStudyPlanList: TList<Integer>;
  i: Integer;
  DeletePrompt: string;
begin
  CheckSelectedAndFocused;

  with FviewDBTreeListSP.cxdbtlView do
    if SelectionCount = 1 then
      Document.StudyPlanCDS.Wrap.Delete
        ('Вы действительно желаете удалить дисциплину ?')
    else
    begin
      DeletePrompt :=
        Format('Вы действительно желаете удалить все %d выделенные дисциплины ?',
        [SelectionCount]);

      AIDStudyPlanList := GetSelectedIDStudyPlan;
      try
        for i := 0 to AIDStudyPlanList.Count - 1 do
        begin
          if AIDStudyPlanList[i] > 0 then
          begin
            Document.StudyPlanCDS.Wrap.LocateAndCheck('id_studyplan',
              AIDStudyPlanList[i], []);
            Document.StudyPlanCDS.Wrap.Delete(DeletePrompt);
            DeletePrompt := ''; // В след. раз будем удалять без подтверждения
          end;
        end;
      finally
        FreeAndNil(AIDStudyPlanList);
      end;
    end;
end;

procedure TviewSP.actDeleteUpdate(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Enabled := (FDocument <> nil) and (not ReadOnly) and
    (Document.StudyPlanCDS.RecordCount > 0) and
    (not Document.StudyPlanCDS.CurrentRecordIsCategory);
end;

procedure TviewSP.actDiplomExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actDiplom, actDiplom.Tag);
end;

procedure TviewSP.actDisciplineCompetenceExecute(Sender: TObject);
var
  ASPDisciplines: TSPDisciplines;
  ATBItem: TTBItem;
  IDStudyPlan: Integer;
begin
  IDStudyPlan := Document.StudyPlanCDS.Wrap.PKValue;
  if IDStudyPlan <= 0 then
  begin
    Application.MessageBox('Выберите дисциплину учебного плана', 'Ошибка',
      MB_OK + MB_ICONSTOP);

    Exit;
  end;

  // ShowDisciplineCompetence( Document.StudyPlanCDS.FieldByName('iddisciplinename')

  // ASPDisciplines.Field('ID_Discipline').AsInteger,
  // ASPDisciplines.Field('FullDisciplineName').AsString);

  ASPDisciplines := TSPDisciplines.Create(Self);
  try
    ASPDisciplines.IDStudyPlanParam.ParamValue := IDStudyPlan;
    ASPDisciplines.Refresh;
    Assert(ASPDisciplines.DS.RecordCount >= 1);

    if ASPDisciplines.DS.RecordCount = 1 then
    begin
      ShowDisciplineCompetence(ASPDisciplines.Field('ID_Discipline').AsInteger,
        ASPDisciplines.Field('FullDisciplineName').AsString);
    end
    else
    begin
      tbsmiCompetence.Clear;
      ASPDisciplines.DS.First;
      while not ASPDisciplines.DS.Eof do
      begin
        ATBItem := TTBItem.Create(tbsmiCompetence);
        tbsmiCompetence.Add(ATBItem);
        ATBItem.Visible := True;
        ATBItem.Caption := ASPDisciplines.Field('DisciplineName').AsString;
        ATBItem.Tag := ASPDisciplines.Field('ID_Discipline').AsInteger;
        ATBItem.Hint := ASPDisciplines.Field('FullDisciplineName').AsString;
        ATBItem.OnClick := OnDisciplineCompetenceToolbasItemClick;
        ASPDisciplines.DS.Next;
      end;
    end;
  finally
    FreeAndNil(ASPDisciplines);
  end;
end;

procedure TviewSP.actDisciplineLitExecute(Sender: TObject);
var
  ADisciplineLit: TDisciplineLit;
  AIDStudyPlan: Integer;
  ASPDisciplines: TSPDisciplines;
  frmDisciplineLit: TfrmViewEx;
begin
  inherited;
  AIDStudyPlan := Document.StudyPlanCDS.Wrap.PKValue;
  if AIDStudyPlan <= 0 then
  begin
    Application.MessageBox('Выберите дисциплину учебного плана', 'Ошибка',
      MB_OK + MB_ICONSTOP);

    Exit;
  end;

  ASPDisciplines := TSPDisciplines.Create(Self);
  try
    ASPDisciplines.IDStudyPlanParam.ParamValue := AIDStudyPlan;
    ASPDisciplines.Refresh;
    Assert(ASPDisciplines.DS.RecordCount >= 1);

    // Создаём литературу по дисциплине
    ADisciplineLit := DisciplineLit.DiscLit;
    try
      ADisciplineLit.BeginUpdate;
      ADisciplineLit.YearParam.ParamValue := ASPDisciplines.Year.Value;
      ADisciplineLit.IDDisciplineNameParam.ParamValue :=
        ASPDisciplines.IDDisciplineName.Value;
      ADisciplineLit.IDSpecialityParam.ParamValue :=
        ASPDisciplines.IDSpeciality.Value;
      ADisciplineLit.EndUpdate();

      frmDisciplineLit := TfrmViewEx.Create(Self, 'Литература по дисциплине',
        'DisciplineLitForm', [mbOk]);
      try
        frmDisciplineLit.ViewClass := TviewDisciplineLit;
        frmDisciplineLit.View.SetDocument(ADisciplineLit);
        frmDisciplineLit.ShowModal;
      finally
        FreeAndNil(frmDisciplineLit);
      end;

    finally
      // FreeAndNil(ADisciplineLit);
    end;

  finally
    FreeAndNil(ASPDisciplines);
  end;

end;

procedure TviewSP.actEditExecute(Sender: TObject);
begin
  Document.StudyPlanCDS.Edit;
  ShowSPEditForm;
end;

procedure TviewSP.actEditUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (FDocument <> nil) and (not ReadOnly) and
    (not Document.StudyPlanCDS.CurrentRecordIsCategory);
end;

procedure TviewSP.actLessonThemesExecute(Sender: TObject);
var
  ASPDisciplines: TSPDisciplines;
  ATBItem: TTBItem;
  IDStudyPlan: Integer;
begin
  IDStudyPlan := Document.StudyPlanCDS.Wrap.PKValue;
  if IDStudyPlan <= 0 then
  begin
    Application.MessageBox('Выберите дисциплину учебного плана', 'Ошибка',
      MB_OK + MB_ICONSTOP);

    Exit;
  end;
  ASPDisciplines := TSPDisciplines.Create(Self);
  try
    ASPDisciplines.IDStudyPlanParam.ParamValue := IDStudyPlan;
    ASPDisciplines.Refresh;
    Assert(ASPDisciplines.DS.RecordCount >= 1);

    if ASPDisciplines.DS.RecordCount = 1 then
    begin
      ShowLessonThemes(ASPDisciplines.Field('ID_Discipline').AsInteger,
        ASPDisciplines.Field('FullDisciplineName').AsString);
    end
    else
    begin
      tbsmiLessonThemes.Clear;
      ASPDisciplines.DS.First;
      while not ASPDisciplines.DS.Eof do
      begin
        ATBItem := TTBItem.Create(tbsmiLessonThemes);
        tbsmiLessonThemes.Add(ATBItem);
        ATBItem.Visible := True;
        ATBItem.Caption := ASPDisciplines.Field('DisciplineName').AsString;
        ATBItem.Tag := ASPDisciplines.Field('ID_Discipline').AsInteger;
        ATBItem.Hint := ASPDisciplines.Field('FullDisciplineName').AsString;
        ATBItem.OnClick := OnLessonThemesToolbasItemClick;
        ASPDisciplines.DS.Next;
      end;
    end;
  finally
    FreeAndNil(ASPDisciplines);
  end;
end;

procedure TviewSP.actExamExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actExam, actExam.Tag);
end;

procedure TviewSP.actGAExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actGA, actGA.Tag);
end;

procedure TviewSP.actIDStudyPlanExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actIDStudyPlan, 'id_studyplan');
end;

procedure TviewSP.actLaboratoryLessonsExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actLaboratoryLessons, actLaboratoryLessons.Tag);
end;

procedure TviewSP.actLecturesExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actLectures, actLectures.Tag);
end;

procedure TviewSP.actMarkExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actMark, 'mark');
end;

procedure TviewSP.actNewExecute(Sender: TObject);
begin
  Document.StudyPlanCDS.Insert;
end;

procedure TviewSP.actOpenWPExecute(Sender: TObject);
var
  ASPDisciplines: TSPDisciplines;
  ATBItem: TTBItem;
  IDStudyPlan: Integer;
begin
  IDStudyPlan := Document.StudyPlanCDS.Wrap.PKValue;
  if IDStudyPlan <= 0 then
  begin
    Application.MessageBox('Выберите дисциплину учебного плана', 'Ошибка',
      MB_OK + MB_ICONSTOP);

    Exit;
  end;
  ASPDisciplines := TSPDisciplines.Create(Self);
  try
    ASPDisciplines.IDStudyPlanParam.ParamValue := IDStudyPlan;
    ASPDisciplines.Refresh;
    Assert(ASPDisciplines.DS.RecordCount >= 1);

    if ASPDisciplines.DS.RecordCount = 1 then
    begin
      OpenUMK(ASPDisciplines.Field('ID_Discipline').AsInteger,
        ASPDisciplines.Field('FullDisciplineName').AsString);
    end
    else
    begin
      tbsmiOpenWP.Clear;
      ASPDisciplines.DS.First;
      while not ASPDisciplines.DS.Eof do
      begin
        ATBItem := TTBItem.Create(tbsmiOpenWP);
        tbsmiOpenWP.Add(ATBItem);
        ATBItem.Visible := True;
        ATBItem.Caption := ASPDisciplines.Field('DisciplineName').AsString;
        ATBItem.Tag := ASPDisciplines.Field('ID_Discipline').AsInteger;
        ATBItem.Hint := ASPDisciplines.Field('FullDisciplineName').AsString;
        ATBItem.OnClick := OnOpenUMKToolbasItemClick;
        ASPDisciplines.DS.Next;
      end;
    end;
  finally
    FreeAndNil(ASPDisciplines);
  end;

end;

procedure TviewSP.actPlanGraphByAdmissionReportExecute(Sender: TObject);
begin
  // TMyFR.Create(Self).Show('study_plan\plan_graph_by_admission2.fr3',
  // ['idspecialityeducation'], [Document.IDSpecEducation]);
  TFR3.Create.Show(TReportFilesUpdater.TryUpdate
    ('study_plan\plan_graph_by_admission2.fr3'), ['idspecialityeducation'],
    [Document.IDSpecEducation]);
end;

procedure TviewSP.actPlanGraphBySpecReportExecute(Sender: TObject);
begin
  FOnReportPlanGraphBySpecExec.CallEventHandlers(Self);
end;

procedure TviewSP.actPractExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actPract, actPract.Tag);
end;

procedure TviewSP.actRefreshExecute(Sender: TObject);
begin
  Document.Refresh;
end;

procedure TviewSP.actRepeatExamExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actRepeatExam, actRepeatExam.Tag);
end;

procedure TviewSP.actSamExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actSam, actSam.Tag);
end;

procedure TviewSP.actSelfExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actSelf, 'Self');
end;

procedure TviewSP.actPracticalLessonsExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actPracticalLessons, actPracticalLessons.Tag);
end;

procedure TviewSP.actShowSummaryExecute(Sender: TObject);
begin
  inherited;
  (Sender as TAction).Checked := not(Sender as TAction).Checked;
end;

procedure TviewSP.actSpecialitySessionsExecute(Sender: TObject);
{
  var
  frmSpecialitySessions: TfrmViewEx;
  ASpecialitySessions: TSpecialitySessions;
}
var
  ASpecSessGroup: TSpecSessGroup;
  F: TfrmGridView;
begin

  ASpecSessGroup := TSpecSessGroup.Create(Self, Document.IDSpecEducation);
  F := TfrmGridView.Create(Self, 'Сессии / семестры',
    TMyDir.AppDataDirFile('NewSessionForm.ini'), [mbOk], 500);
  try
    F.GridViewClass := TViewSpecSess;
    (F.GridView as TViewSpecSess).SpecSessGroup := ASpecSessGroup;

    // Действие при нажатии кнопки OK
    F.OKAction := (F.GridView as TViewSpecSess).actSave;

    F.ShowModal;
  finally
    FreeAndNil(F);
    FreeAndNil(ASpecSessGroup);
  end;
  {
    ASpecialitySessions := TSpecialitySessions.Create(Self);
    frmSpecialitySessions := TfrmViewEx.Create(Self, 'Сессии / Семестры',
    'SpecialitySessionsForm', [mbOk]);
    try
    ASpecialitySessions.IDAdmissionParam.ParamValue := Document.IDSpecEducation;
    ASpecialitySessions.Refresh;
    frmSpecialitySessions.ViewClass := TgvSpecialitySessions;
    frmSpecialitySessions.View.SetDocument(ASpecialitySessions);
    frmSpecialitySessions.ShowModal;
    finally
    FreeAndNil(frmSpecialitySessions);
    end;
  }
end;

procedure TviewSP.actStructure2Execute(Sender: TObject);
var
  F: TfrmGridView;
begin
  F := TfrmGridView.Create(Self, 'Структура учебного плана',
    TMyDir.AppDataDirFile('NewCSEForm.ini'), [mbOk], 500);
  try
    F.GridViewClass := TViewCSEFrame;
    (F.GridView as TViewCSEFrame).W := Document.qCSE.W;

    F.ShowModal;
    Document.CSE.Refresh;
  finally
    FreeAndNil(F);
  end;
end;

procedure TviewSP.actStructureExecute(Sender: TObject);
var
  frmCSEView: TfrmViewEx;
begin
  Assert(Document <> nil);
  Assert(Document.CSE <> nil);

  frmCSEView := TfrmViewEx.Create(Self, 'Структура учебного плана',
    'CSEForm', [mbOk]);
  try
    frmCSEView.ViewClass := TviewCSE;
    frmCSEView.View.SetDocument(Document.CSE);
    frmCSEView.ShowModal;
  finally
    FreeAndNil(frmCSEView);
  end;

  // Если не перейти на первую запись, то FviewSP.FviewDBTreeListSP глючит
  Document.StudyPlanCDS.First;
end;

procedure TviewSP.actStudyPlanReportExecute(Sender: TObject);
begin
  // TMyFR.Create(Self).Show('study_plan\Study_plan2.fr3',
  // ['idspecialityeducation'],
  // [Document.SpecialitySessions.SpecialityEducationParam.ParamValue]);
  TFR3.Create.Show(TReportFilesUpdater.TryUpdate('study_plan\Study_plan2.fr3'),
    ['idspecialityeducation'],
    [Document.SpecialitySessions.SpecialityEducationParam.ParamValue]);
end;

procedure TviewSP.actTotal2Execute(Sender: TObject);
begin
  OnColumnVisibleChange(actTotal2, 'Total2');
end;

procedure TviewSP.actTotalExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actTotal, 'Total');
end;

procedure TviewSP.actUMKExecute(Sender: TObject);
var
  ASPDisciplines: TSPDisciplines;
  ATBItem: TTBItem;
  IDStudyPlan: Integer;
begin
  IDStudyPlan := Document.StudyPlanCDS.Wrap.PKValue;
  if IDStudyPlan <= 0 then
  begin
    Application.MessageBox('Выберите дисциплину учебного плана', 'Ошибка',
      MB_OK + MB_ICONSTOP);

    Exit;
  end;
  ASPDisciplines := TSPDisciplines.Create(Self);
  try
    ASPDisciplines.IDStudyPlanParam.ParamValue := IDStudyPlan;
    ASPDisciplines.Refresh;
    Assert(ASPDisciplines.DS.RecordCount >= 1);

    if ASPDisciplines.DS.RecordCount = 1 then
    begin
      ShowUMK(ASPDisciplines.Field('ID_Discipline').AsInteger,
        ASPDisciplines.Field('FullDisciplineName').AsString);
    end
    else
    begin
      tbsmiWP.Clear;
      ASPDisciplines.DS.First;
      while not ASPDisciplines.DS.Eof do
      begin
        ATBItem := TTBItem.Create(tbsmiWP);
        tbsmiWP.Add(ATBItem);
        ATBItem.Visible := True;
        ATBItem.Caption := ASPDisciplines.Field('DisciplineName').AsString;
        ATBItem.Tag := ASPDisciplines.Field('ID_Discipline').AsInteger;
        ATBItem.Hint := ASPDisciplines.Field('FullDisciplineName').AsString;
        ATBItem.OnClick := OnUMKToolbasItemClick;
        ASPDisciplines.DS.Next;
      end;
    end;
  finally
    FreeAndNil(ASPDisciplines);
  end;
end;

procedure TviewSP.actZachExecute(Sender: TObject);
begin
  OnColumnVisibleChange(actZach, actZach.Tag);
end;

procedure TviewSP.AfterSPInsert(Sender: TObject);
begin
  FreeAndNil(FBeforeSPInsert);
  FreeAndNil(FAfterSPInsert);
  try
    ShowSPEditForm;
  finally
    // Подписываемся на события
    FAfterSPInsert := TNotifyEventWrap.Create
      (Document.StudyPlanCDS.Wrap.AfterInsert, AfterSPInsert);
    FBeforeSPInsert := TNotifyEventWrap.Create
      (Document.StudyPlanCDS.Wrap.BeforeInsert, BeforeSPInsert);
  end;
end;

procedure TviewSP.BeforeSPInsert(Sender: TObject);
begin
  with Document do
    CSE.DataSetWrap.DataSet.Locate('ID_CYCLESPECIALITYEDUCATION',
      StudyPlanCDS.FieldByName('IDCYCLESPECIALITYEDUCATION').AsInteger, []);
end;

procedure TviewSP.CheckSelectedAndFocused;
var
  ANode: TcxTreeListNode;
  AIDStudyPlan: Integer;
begin
  if FviewDBTreeListSP.cxdbtlView.SelectionCount = 1 then
  begin
    ANode := FviewDBTreeListSP.cxdbtlView.Selections[0];
    AIDStudyPlan :=
      StrToInt(VarToStrDef(ANode.Values
      [FviewDBTreeListSP.IDSPColumn.ItemIndex], '0'));
    if Document.StudyPlanCDS.FieldByName('id_studyplan').AsInteger <> AIDStudyPlan
    then
    begin
      raise Exception.Create
        ('Выделенная дисциплина не совпадает с фокусированной');
    end;
  end;

end;

procedure TviewSP.DoAfterOpenWP(var Message: TMessage);
begin
  inherited;
  // tbsmiOpenWP.Enabled := False;
  if tbsmiOpenWP.Enabled then
  begin
    tbsmiOpenWP.Enabled := False;
    Application.ProcessMessages;
    FviewDBTreeListSP.SetFocus;
    Application.ProcessMessages;
    // tbsmiOpenWP.Enabled := True;
    // PostMessage(Handle, WM_AFTER_OPEN_WP, 0, 0);
  end
  else
    tbsmiOpenWP.Enabled := True;
end;

procedure TviewSP.OnSummaryItemsGetText(Sender: TcxTreeListSummaryItem;
  const AValue: Variant; var AText: string);
var
  X: Integer;
begin
  inherited;
  try
    if AValue = 0 then
    begin
      AText := '';
      // Sender.Visible := False;
    end
    else
    begin
      // Sender.Visible := True;
      X := AValue;
      AText := Format('%d', [Trunc(X / 2)]);
    end;
  except
    AText := '';
  end;
end;

function TviewSP.GetColumnVisible(AIDLessonType: Integer): Boolean;
var
  Action: TAction;
  i: Integer;
begin
  for i := 0 to ActionList.ActionCount - 1 do
  begin
    Action := ActionList.Actions[i] as TAction;
    if Action.Tag = AIDLessonType then
    begin
      Result := Action.Checked;
      Exit;
    end;
  end;
  Result := False;
end;

function TviewSP.GetDocument: TStudyPlan;
begin
  Result := FDocument as TStudyPlan;
end;

function TviewSP.GetEditing: Boolean;
begin
  Result := FviewDBTreeListSP.cxdbtlView.OptionsData.Editing;
end;

function TviewSP.GetSelectedIDStudyPlan: TList<Integer>;
var
  AIDStudyPlan: Integer;
  ANode: TcxTreeListNode;
  i: Integer;
begin
  Result := TList<Integer>.Create;
  // Заполняем список кодами выделенных записей
  for i := 0 to FviewDBTreeListSP.cxdbtlView.SelectionCount - 1 do
  begin
    ANode := FviewDBTreeListSP.cxdbtlView.Selections[i];
    AIDStudyPlan :=
      StrToInt(VarToStrDef(ANode.Values
      [FviewDBTreeListSP.IDSPColumn.ItemIndex], '0'));
    Result.Add(AIDStudyPlan);
  end;
end;

procedure TviewSP.OnInitTreeListView(Sender: TObject);
var
  Band, Band2, Band3, Band4: TcxTreeListBand;
  ALevel: Integer;
  ASession: Integer;
  ASemestr: Integer;
  ASSDataSet: TDataSet;
  ID_Session: Integer;
  ALTDataSet: TDataSet;
  c: TcxStyle;
begin

  // затираем старые столбики
  with FviewDBTreeListSP.cxdbtlView do
  begin
    Bands.Clear;
    DeleteAllColumns;
    if not(Sender as TviewDBTreeList).HaveDocument then
      Exit;

    c := nil;
    Band4 := nil;
    Band3 := nil;
    Band2 := nil;
    Styles.Footer := DM.cxstyl14;

    // добавляем главный банд
    Band := Bands.Add;
    Band.Caption.AlignHorz := taCenter;
    Band.FixedKind := tlbfLeft;
    Band.Styles.Header := DM.cxStyl10;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Идент.';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'id_studyplan';
      Caption.AlignHorz := taCenter;
      Width := 100;
      Options.Editing := False;
      RepositoryItem := DM.cxEditRepository1Label1;
      Styles.Header := DM.cxStyl10;
      Visible := actIDStudyPlan.Checked;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'X';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'Checked';
      Caption.AlignHorz := taCenter;
      Width := 90;
      Options.Editing := True;
      RepositoryItem := DM.cxEditRepository1CheckBoxItem2;
      Styles.Header := DM.cxStyl10;
      Visible := FShowCheked;
    end;

    // Порядковый номер цикла
    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'CSE_ORD';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'CSE_ORD';
      Caption.AlignHorz := taCenter;
      Width := 60;
      Options.Editing := False;
      SortOrder := soAscending;
      SortIndex := 0; // Сортируем по позиции цикла
      RepositoryItem := DM.cxEditRepository1Label1;
      Visible := False;
    end;

    // Является ли "по выбору"
    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'is_option';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'is_option';
      Caption.AlignHorz := taCenter;
      Width := 60;
      Options.Editing := False;
      SortOrder := soAscending;
      RepositoryItem := DM.cxEditRepository1Label1;
      Visible := False;
    end;

    // Вид представления
    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'IDHourViewType';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'IDHourViewType';
      Caption.AlignHorz := taCenter;
      Width := 60;
      Options.Editing := False;
      SortOrder := soAscending;
      RepositoryItem := DM.cxEditRepository1Label1;
      Visible := False;
    end;

    // Позиция дисциплины
    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Position';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'Position';
      Caption.AlignHorz := taCenter;
      Width := 60;
      Options.Editing := False;
      SortOrder := soAscending;
      RepositoryItem := DM.cxEditRepository1Label1;
      Visible := False;
    end;

    // N п.п
    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := '№ п/п';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'Code';
      Caption.AlignHorz := taCenter;
      Width := 150;
      Styles.Header := DM.cxStyl10;
      Options.Editing := False;
      RepositoryItem := DM.cxEditRepository1Label1;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Кафедра';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'department';
      Caption.AlignHorz := taCenter;
      Width := 160;
      Styles.Header := DM.cxStyl10;
      Options.Editing := True;

      Visible := actChair.Checked;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := '*';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'mark';
      Caption.AlignHorz := taCenter;
      Width := 24;
      Styles.Header := DM.cxStyl10;
      Options.Editing := True;
      RepositoryItem := DM.cxEditRepository1CheckComboBox1;
      Visible := actMark.Checked;
    end;

    // дисциплина
    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Наименование';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'disciplinename';
      OptionsView.CategorizedColumn := FviewDBTreeListSP.GetColumnByFieldName
        (DataBinding.FieldName);
      Width := 230;
      Caption.AlignHorz := taCenter;
      Styles.Header := DM.cxStyl10;
      {
        with Summary.GroupFooterSummaryItems.Add do
        begin
        Kind := skCount;
        AllNodes := False;
        Format := 'Количество: 0'
        end;
        with Summary.FooterSummaryItems.Add do
        begin
        Kind := skCount;
        AllNodes := False;
        Format := 'Количество: 0'
        end;
      }
      Options.Editing := False;
      SortIndex := 1;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'З.Е.';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'total2';
      Width := 45;
      Caption.AlignHorz := taCenter;
      Styles.Header := DM.cxStyl10;
      with Summary.GroupFooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;
      with Summary.FooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;

      RepositoryItem := DM.cxEditRepository1SpinItem1;
      Visible := actTotal2.Checked;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Всего';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'total';
      Width := 45;
      Caption.AlignHorz := taCenter;
      Styles.Header := DM.cxStyl10;
      with Summary.GroupFooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;
      with Summary.FooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;

      RepositoryItem := DM.cxEditRepository1SpinItem1;
      Visible := actTotal.Checked;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Сам.';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'self';
      Width := 35;
      Caption.AlignHorz := taCenter;
      Styles.Header := DM.cxStyl10;
      RepositoryItem := DM.cxEditRepository1Label1;
      Visible := actSelf.Checked;
      with Summary.GroupFooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;
      with Summary.FooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;

    end;

    // Невидимый столбец - реальная сумма сам. работ
    with CreateColumn as TcxDBTreeListColumn do
    begin
      RepositoryItem := DM.cxEditRepository1Label1;
      DataBinding.FieldName := Document.StudyPlanCDS.SelfSum.FieldName;
      Position.BandIndex := Band.Index;
      Visible := False;
    end;

    // добавляем банд
    Band := Bands.Add;
    Band.FixedKind := tlbfLeft;
    Band.Caption.Text := 'Объем аудиторных занятий';
    Band.Caption.AlignHorz := taCenter;
    Band.Styles.Header := DM.cxStyl10;
    Band.Visible := actAuditor.Checked;

    // всего аудиторных
    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Всего';
      Position.BandIndex := 0;
      DataBinding.FieldName := Document.StudyPlanCDS.AudSum.FieldName;
      Width := 50;
      Caption.AlignHorz := taCenter;
      Styles.Header := DM.cxStyl10;
      Position.BandIndex := Band.Index;
      Options.Editing := False;
      RepositoryItem := DM.cxEditRepository1Label1;
      with Summary.GroupFooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;
      with Summary.FooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;

    end;

    // лекций
    with CreateColumn as TcxDBTreeListColumn do
    begin // невидимый столбец - реальная сумма
      DataBinding.FieldName := Document.StudyPlanCDS.LecSum.FieldName;
      Position.BandIndex := Band.Index;
      Visible := False;
      Tag := 1;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Лек.';
      DataBinding.FieldName := Document.StudyPlanCDS.Lectures.FieldName;
      Width := 35;
      Caption.AlignHorz := taCenter;
      Styles.Header := DM.cxStyl10;
      Position.BandIndex := Band.Index;
      // Styles.OnGetContentStyle :=
      // cxGrid1DBBandedTableView1Column1StylesGetContentStyle;
      RepositoryItem := DM.cxEditRepository1SpinItem1;
      with Summary.GroupFooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;
      with Summary.FooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;
    end;

    // семинаров
    with CreateColumn as TcxDBTreeListColumn do
    begin // невидимый столбец - реальная сумма
      DataBinding.FieldName := Document.StudyPlanCDS.SemSum.FieldName;
      Position.BandIndex := Band.Index;
      Visible := False;
      Tag := 1;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Пр.';
      DataBinding.FieldName := Document.StudyPlanCDS.Seminars.FieldName;
      Width := 35;
      Caption.AlignHorz := taCenter;
      Styles.Header := DM.cxStyl10;
      Position.BandIndex := Band.Index;
      // Styles.OnGetContentStyle :=
      // cxGrid1DBBandedTableView1Column1StylesGetContentStyle;
      RepositoryItem := DM.cxEditRepository1SpinItem1;
      with Summary.GroupFooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;
      with Summary.FooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;
    end;

    // лабораторные
    with CreateColumn as TcxDBTreeListColumn do
    begin // невидимый столбец - реальная сумма
      DataBinding.FieldName := Document.StudyPlanCDS.LabSum.FieldName;
      Position.BandIndex := Band.Index;
      Visible := False;
      Tag := 1;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin // 10
      Caption.Text := 'Лаб.';
      DataBinding.FieldName := Document.StudyPlanCDS.LabWorks.FieldName;
      Width := 35;
      Caption.AlignHorz := taCenter;
      Styles.Header := DM.cxStyl10;
      Position.BandIndex := Band.Index;
      // Styles.OnGetContentStyle :=
      // cxGrid1DBBandedTableView1Column1StylesGetContentStyle;
      RepositoryItem := DM.cxEditRepository1SpinItem1;
      with Summary.GroupFooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;
      with Summary.FooterSummaryItems.Add do
      begin
        Kind := skSum;
        Format := '0'
      end;
    end;

    // банд число часов в семестре
    Band := Bands.Add;
    Band.Caption.Text := 'Число часов в семестре';
    Band.Caption.AlignHorz := taCenter;
    Band.Styles.Header := DM.cxStyl1;

    // Добавляем остальные поля
    ALevel := -1;
    ASession := -1;
    ASemestr := -1;

    ASSDataSet := Document.SpecialitySessions.DataSetWrap.DataSet;
    ASSDataSet.First;
    while not ASSDataSet.Eof do
    begin

      // рисуем банд курса
      if (ALevel <> ASSDataSet['level_']) then
      begin
        ALevel := ASSDataSet['level_'];
        Band2 := Bands.Add;
        Band2.Caption.Text := Format('%d курс', [ALevel]);
        Band2.Caption.AlignHorz := taCenter;
        Band2.Position.BandIndex := Band.Index;

        if ALevel mod 2 = 0 then
          c := DM.cxStyl2
        else
          c := DM.cxStyl3;
        Band2.Styles.Header := c;
      end;

      // рисуем банд семестра
      if (ASemestr <> ASSDataSet['Semestr']) then
      begin
        ASemestr := ASSDataSet['Semestr'];
        Band3 := Bands.Add;
        Band3.Caption.Text := Format('%d семестр',
          [(ALevel - 1) * 2 + ASemestr]);
        Band3.Caption.AlignHorz := taCenter;
        Band3.Position.BandIndex := Band2.Index;
        if ALevel mod 2 = 0 then
          c := DM.cxStyl2
        else
          c := DM.cxStyl3;
        Band3.Styles.Header := c;
      end;

      // рисуем банд сессии
      if (ID_Session <> ASSDataSet['ID_SPECIALITYSESSION']) then
      begin
        ID_Session := ASSDataSet['ID_SPECIALITYSESSION'];
        ASession := ASSDataSet['Session_in_level'];
        Band4 := Bands.Add;
        Band4.Caption.Text := Format('%s', [ASSDataSet['SessionName']]);
        Band4.Caption.AlignHorz := taCenter;
        Band4.Position.BandIndex := Band3.Index;
        Band4.Styles.Header := c;
      end;

      ALTDataSet := Document.LessonTypes.DataSetWrap.DataSet;
      ALTDataSet.First;
      while not ALTDataSet.Eof do
      begin
        // собственно само поле
        with CreateColumn as TcxDBTreeListColumn do
        begin
          Caption.Text := ALTDataSet['SHORT_DISCIPLINETYPE'];
          Position.BandIndex := Band4.Index;
          DataBinding.FieldName := Document.StudyPlanCDS.getFieldName
            (ALTDataSet['ID_DisciplineType'], ALevel, ASession);

          Styles.Header := c;
          Styles.Content := c;

          Width := 40;

          // Если необходим SpinEdit чтобы изменять кол-во часов
          if ALTDataSet.FieldByName('ID_DISCIPLINETYPE').AsInteger
            in [1, 2, 3, 12, 22] then
          begin

            RepositoryItem := DM.cxEditRepository1SpinItem1;
            with Summary.GroupFooterSummaryItems.Add do
            begin
              Kind := skSum;
              Format := '0';
              OnGetText := OnSummaryItemsGetText2;
            end;
            with Summary.FooterSummaryItems.Add do
            begin
              Kind := skSum;
              Format := '0';
              OnGetText := OnSummaryItemsGetText2;
            end;

          end
          else
          begin
            RepositoryItem := DM.cxEditRepository1CheckBoxItem1;
            with Summary.GroupFooterSummaryItems.Add do
            begin
              Kind := skSum;
              Format := '0';
              OnGetText := OnSummaryItemsGetText;
            end;
            with Summary.FooterSummaryItems.Add do
            begin
              Kind := skSum;
              Format := '0';
              OnGetText := OnSummaryItemsGetText;
            end;

          end;

          Caption.AlignHorz := taCenter;
          Visible := ColumnVisible[ALTDataSet['ID_DisciplineType']];
        end;
        ALTDataSet.Next;
      end;

      ASSDataSet.Next;
    end;
  end;
end;

procedure TviewSP.OnBandVisibleChange(AAction: TAction; ColumnName: string);
var
  AcxDBTreeListColumn: TcxDBTreeListColumn;
begin
  AAction.Checked := not AAction.Checked;
  AcxDBTreeListColumn := FviewDBTreeListSP.GetColumnByFieldName(ColumnName);
  if AcxDBTreeListColumn <> nil then
    AcxDBTreeListColumn.Position.Band.Visible := AAction.Checked;
end;

procedure TviewSP.OnColumnVisibleChange(AAction: TAction; ColumnName: string);
var
  AcxDBTreeListColumn: TcxDBTreeListColumn;
begin
  AAction.Checked := not AAction.Checked;
  AcxDBTreeListColumn := FviewDBTreeListSP.GetColumnByFieldName(ColumnName);
  if AcxDBTreeListColumn <> nil then
    AcxDBTreeListColumn.Visible := AAction.Checked;
end;

procedure TviewSP.OnColumnVisibleChange(AAction: TAction;
  IDLessonType: Integer);
begin
  AAction.Checked := not AAction.Checked;
  ColumnVisible[IDLessonType] := AAction.Checked;
end;

procedure TviewSP.OnLessonThemesToolbasItemClick(Sender: TObject);
var
  ATBItem: TTBItem;
begin
  ATBItem := Sender as TTBItem;
  ShowLessonThemes(ATBItem.Tag, ATBItem.Hint);
end;

procedure TviewSP.OnUMKToolbasItemClick(Sender: TObject);
var
  ATBItem: TTBItem;
begin
  ATBItem := Sender as TTBItem;
  ShowUMK(ATBItem.Tag, ATBItem.Hint);
end;

procedure TviewSP.OnSummaryItemsGetText2(Sender: TcxTreeListSummaryItem;
  const AValue: Variant; var AText: string);
begin
  inherited;
  if AValue = 0 then
    AText := '';

end;

procedure TviewSP.OnDisciplineCompetenceToolbasItemClick(Sender: TObject);
var
  ATBItem: TTBItem;
begin
  ATBItem := Sender as TTBItem;
  ShowDisciplineCompetence(ATBItem.Tag, ATBItem.Hint);
end;

procedure TviewSP.OnOpenUMKToolbasItemClick(Sender: TObject);
var
  ATBItem: TTBItem;
begin
  ATBItem := Sender as TTBItem;
  OpenUMK(ATBItem.Tag, ATBItem.Hint);
end;

procedure TviewSP.Recreate;
begin
  FreeAndNil(FNotifyEventWrap);
  FreeAndNil(FviewDBTreeListSP);

  FviewDBTreeListSP := TviewDBTreeListSP.Create(Self, pnlMain);
  FNotifyEventWrap := TNotifyEventWrap.Create
    (FviewDBTreeListSP.OnInitTreeListView, OnInitTreeListView, EventsList);

  FviewDBTreeListSP.SetDocument(Document.StudyPlanCDS.Wrap);
  FviewDBTreeListSP.cxdbtlView.PopupMenu := pmDBTreeList;
end;

procedure TviewSP.SetColumnVisible(IDLessonType: Integer; const Value: Boolean);
var
  i: Integer;
  AFieldName: string;
  ALessonType: Integer;
  ALevel: Integer;
  ASession: Integer;
begin
  FviewDBTreeListSP.cxdbtlView.BeginUpdate;
  try
    for i := 0 to FviewDBTreeListSP.cxdbtlView.ColumnCount - 1 do
    begin
      AFieldName := (FviewDBTreeListSP.cxdbtlView.Columns[i]
        as TcxDBTreeListColumn).DataBinding.FieldName;
      if Document.StudyPlanCDS.encodeFieldName(AFieldName, ALessonType, ALevel,
        ASession) and (ALessonType = IDLessonType) then
      begin
        FviewDBTreeListSP.cxdbtlView.Columns[i].Visible := Value;
      end;
    end;
  finally
    FviewDBTreeListSP.cxdbtlView.EndUpdate;
  end;
end;

procedure TviewSP.SetDocument(const Value: TDocument);
begin
  inherited;
  if (FDocument <> nil) then
  begin
    FviewDBTreeListSP.SetDocument(Document.StudyPlanCDS.Wrap);
    FviewDBTreeListSP.cxdbtlView.PopupMenu := pmDBTreeList;

    // Подписываемся на события
    FAfterSPInsert := TNotifyEventWrap.Create
      (Document.StudyPlanCDS.Wrap.AfterInsert, AfterSPInsert);
    FBeforeSPInsert := TNotifyEventWrap.Create
      (Document.StudyPlanCDS.Wrap.BeforeInsert, BeforeSPInsert);
  end
  else
  begin
    FreeAndNil(FAfterSPInsert);
    FreeAndNil(FBeforeSPInsert);

    FviewDBTreeListSP.cxdbtlView.PopupMenu := nil;
    FviewDBTreeListSP.SetDocument(nil);
  end;
end;

procedure TviewSP.SetEditing(const Value: Boolean);
begin
  FviewDBTreeListSP.cxdbtlView.OptionsData.Editing := Value;
end;

procedure TviewSP.ShowLessonThemes(AIDDiscipline: Integer;
  ADisciplineName: string);
var
  ETP: TETP;
  frmETP: TfrmViewEx;
begin
  Assert(AIDDiscipline > 0);
  frmETP := TfrmViewEx.Create(Self, 'Тематический план',
    'ThematicPlan', [mbOk]);
  try
    frmETP.Caption := Format('Тематический план по дисциплине «%s»',
      [ADisciplineName]);
    ETP := TETP.Create(Self, AIDDiscipline);
    try
      frmETP.ViewClass := TviewETP;
      frmETP.View.SetDocument(ETP);
      frmETP.ShowModal();
    finally
      FreeAndNil(ETP);
    end;
  finally
    FreeAndNil(frmETP);
  end;
end;

procedure TviewSP.ShowUMK(AIDDiscipline: Integer; ADisciplineName: string);
var
  frmUMKMaster: TfrmUMKMaster;
  UMKMaster: TUMKMaster;
begin
  Assert(AIDDiscipline > 0);

  frmUMKMaster := TfrmUMKMaster.Create(Self, 'UMKMasterForm');
  try
    frmUMKMaster.Caption := Format('Мастер создания РП по дисциплине «%s»',
      [ADisciplineName]);
    UMKMaster := TUMKMaster.Create(Self, AIDDiscipline);
    try
      frmUMKMaster.ViewClass := TviewUMKMaster;
      frmUMKMaster.View.SetDocument(UMKMaster);
      frmUMKMaster.ShowModal();
    finally
      FreeAndNil(UMKMaster);
    end;
  finally
    FreeAndNil(frmUMKMaster);
  end;
end;

procedure TviewSP.ShowSPEditForm;
var
  AfrmSPEdit: TfrmSPEdit;
  i: Integer;
  AIDStudyPlanList: TList<Integer>;
begin
  if not(Document.StudyPlanCDS.State in [dsEdit, dsInsert]) then
    Exit;

  if (FviewDBTreeListSP.cxdbtlView.SelectionCount <= 0) and
    (Document.StudyPlanCDS.State = dsEdit) then
    raise Exception.Create('Не выделено ни одной дисциплины');

  CheckSelectedAndFocused;
  Document.MultiSelect := (Document.StudyPlanCDS.State = dsEdit) and
    (FviewDBTreeListSP.cxdbtlView.SelectionCount > 1);
  // Вызываем форму для добавления новой записи
  AfrmSPEdit := TfrmSPEdit.Create(Self, 'SPEditForm');
  try
    AfrmSPEdit.ViewClass := TPlanEditView;
    AfrmSPEdit.View.SetDocument(Document);
    if AfrmSPEdit.ShowModal = mrOK then
    begin
      // Если произошло редактирование нескольких выделенных дисциплин
      if (Document.StudyPlanCDS.State = dsEdit) and
        (FviewDBTreeListSP.cxdbtlView.SelectionCount > 1) then
      begin
        // Создаём список выделенных кодов учебного плана
        AIDStudyPlanList := GetSelectedIDStudyPlan;
        try
          Document.StudyPlanCDS.DisableControls;
          try
            for i := 0 to AIDStudyPlanList.Count - 1 do
            begin
              if AIDStudyPlanList[i] > 0 then
              begin
                with Document.StudyPlanCDS do
                begin
                  Wrap.LocateAndCheck('id_studyplan', AIDStudyPlanList[i], []);
                  Edit;
                  try
                    // Меняем код цикла, к которому относится дисциплина
                    FieldByName('IDCYCLESPECIALITYEDUCATION').AsInteger :=
                      Document.CSE.Field('ID_CYCLESPECIALITYEDUCATION')
                      .AsInteger;
                    Post;
                  except
                    Cancel;
                    raise;
                  end;
                end;
              end;
            end;
          finally
            Document.StudyPlanCDS.EnableControls;
          end;
        finally
          FreeAndNil(AIDStudyPlanList);
        end;
      end
      else
      begin
        Assert(Document.StudyPlanCDS.State in [dsEdit, dsInsert]);
        with Document.StudyPlanCDS do
        begin
          FieldByName('IDCYCLESPECIALITYEDUCATION').AsInteger :=
            Document.CSE.Field('ID_CYCLESPECIALITYEDUCATION').AsInteger;
          FieldByName('IDDISCIPLINENAME').AsInteger :=
            Document.DisciplineNames.Field('ID_DISCIPLINENAME').AsInteger;
          FieldByName('IDCHAIR').AsInteger := Document.Chairs.Field('ID_Chair')
            .AsInteger;
          // Изменяем вид представления (в часах или неделях)
          // FieldByName('IDHourViewType').AsInteger := Document.HourViewTypes.PKValue;
          try
            DisableControls;
            try
              Post;
            finally
              EnableControls;
            end;
          except
            Cancel;
            raise;
          end;
        end;
      end;
    end
    else
      Document.StudyPlanCDS.Cancel;
  finally
    FreeAndNil(AfrmSPEdit);
  end;
end;

procedure TviewSP.ShowDisciplineCompetence(AIDDiscipline: Integer;
  ADisciplineName: string);
var
  frmDisciplineCompetence: TfrmViewEx;
  ADisciplineCompetence: TDisciplineCompetence;
begin
  Assert(AIDDiscipline > 0);

  frmDisciplineCompetence := TfrmViewEx.Create(Self,
    Format('Компетенции которые формирует дисциплина «%s»', [ADisciplineName]),
    'DisciplineCompetenceForm', [mbOk]);
  try

    ADisciplineCompetence := TDisciplineCompetence.Create(Self, AIDDiscipline);
    try
      frmDisciplineCompetence.ViewClass := TviewDisciplineCompetence;
      frmDisciplineCompetence.View.SetDocument(ADisciplineCompetence);

      // Хватит отображать временную форму
      // ProgressBarThread.Terminate;

      frmDisciplineCompetence.ShowModal();
    finally
      FreeAndNil(ADisciplineCompetence);
    end;
  finally
    FreeAndNil(frmDisciplineCompetence);
  end;
  // finally
  // FreeAndNil(AStudyPlanInfo);
  // end;

  // finally
  // ProgressBarThread.Terminate;
  // ProgressBarThread.WaitFor;
  // ProgressBarThread.Free;
  // end;

end;

procedure TviewSP.OpenUMK(AIDDiscipline: Integer; ADisciplineName: string);
var
  AFileName: string;
  // frmUMKMaster: TfrmUMKMaster;
  ProgressBarThread: TProgressBarThread;
  UMKMaster: TUMKMaster;
begin
  Assert(AIDDiscipline > 0);

  UMKMaster := TUMKMaster.Create(Self, AIDDiscipline);
  try
    AFileName := UMKMaster.FileName;

    if not TFile.Exists(AFileName) then
    begin
      MessageDlg('Файл с рабочей программой по этой дисциплине не найден.',
        mtError, [mbOk], 0)
    end
    else
    begin
      ProgressBarThread := TProgressBarThread.Create();
      try
        TUMKDM.Instance.Open(AFileName);
      finally
        ProgressBarThread.Terminate;
        ProgressBarThread.WaitFor;
        ProgressBarThread.Free;
      end;
      PostMessage(Handle, WM_LBUTTONDOWN, 0, 0);
    end;

  finally
    FreeAndNil(UMKMaster);
  end;
end;

procedure TviewSP.UpdateView;
var
  OK: Boolean;
begin
  OK := (FDocument <> nil) and (Document.StudyPlanCDS.RecordCount > 0) and
    (not ReadOnly);

  FviewDBTreeListSP.cxdbtlView.OptionsData.Inserting := OK;
  FviewDBTreeListSP.cxdbtlView.OptionsData.Editing := OK;
  FviewDBTreeListSP.cxdbtlView.OptionsData.Deleting := OK;

  actNew.Enabled := OK;
  actEdit.Enabled := OK;
  actDelete.Enabled := OK;

  actSpecialitySessions.Enabled := TOptions.AccessLevel = alAdmin;
  actStructure.Enabled := TOptions.AccessLevel = alAdmin;

  (*
    // Полный доступ на все кафедры или полный доступ к своей кафедре
    actNew.Enabled := StudyProcessOptions.AccessLevel < 20;
    actDelete.Enabled := actNew.Enabled;
    actEdit.Enabled := actNew.Enabled;
    actRefresh.Enabled := actNew.Enabled;

    // actLessonThemes.Visible := StudyProcessOptions.AccessLevel <= 1;
    // actUMK.Visible := StudyProcessOptions.AccessLevel <= 1;
    // actDisciplineCompetence.Visible := StudyProcessOptions.AccessLevel <= 1;
  *)
end;

initialization

if DM = nil then
  DM := TDM.Create(nil);

finalization

FreeAndNil(DM);

end.
