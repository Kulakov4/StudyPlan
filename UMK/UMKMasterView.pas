unit UMKMasterView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewEx, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinsdxNavBarPainter, Vcl.ExtCtrls, dxNavBar, System.Actions, Vcl.ActnList,
  dxNavBarCollns, cxClasses, dxNavBarBase, SPForUMKView, UMKMaster,
  LessonThemesUMKView, PrepareUMKView, DocumentView, DisciplineCompetenceView,
  DisciplinePurposeView, SoftUMKView, PreviousDisciplinesView;

type
  TviewUMKMaster = class(TView_Ex)
    dxnbUMK: TdxNavBar;
    pnlCenter: TPanel;
    dxnbiUMKItem1: TdxNavBarItem;
    dxnbUMKGroup1: TdxNavBarGroup;
    actlstUMK: TActionList;
    actStudyPlansForUMK: TAction;
    dxnbUMKItem1: TdxNavBarItem;
    actLessonThemesForUMK: TAction;
    dxnbiUMKItem2: TdxNavBarItem;
    actPrepareReport: TAction;
    dxnbiUMKItem3: TdxNavBarItem;
    actCompetence: TAction;
    actPurpose: TAction;
    dxnbUMKItem2: TdxNavBarItem;
    actSoft: TAction;
    dxnbiUMKItem4: TdxNavBarItem;
    actPreviousDisciplines: TAction;
    dxnbUMKItem3: TdxNavBarItem;
    actSubsequenceDisciplines: TAction;
    dxnbUMKItem4: TdxNavBarItem;
    procedure actCompetenceExecute(Sender: TObject);
    procedure actLessonThemesForUMKExecute(Sender: TObject);
    procedure actPrepareReportExecute(Sender: TObject);
    procedure actPreviousDisciplinesExecute(Sender: TObject);
    procedure actPurposeExecute(Sender: TObject);
    procedure actSoftExecute(Sender: TObject);
    procedure actStudyPlansForUMKExecute(Sender: TObject);
    procedure actSubsequenceDisciplinesExecute(Sender: TObject);
  private
    FDisciplineCompetenceView: TviewDisciplineCompetence;
    FdsgvSPForUMK: TdsgvSPForUMK;
    FviewDisciplinePurpose: TviewDisciplinePurpose;
    FviewLessonThemesForUMK: TviewLessonThemesForUMK;
    FViewPrepareUMK: TviewPrepareUMK;
    FViewPreviousDisciplines: TViewCustomDisciplines;
    FViewSoftUMK: TViewSoftUMK;
    function GetDocument: TUMKMaster;
    procedure OnStudyPlanForUMKSelectionChange(Sender: TObject);
    property Document: TUMKMaster read GetDocument;
    { Private declarations }
  public
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;


implementation

uses NotifyEvents;

{$R *.dfm}

procedure TviewUMKMaster.actCompetenceExecute(Sender: TObject);
begin
  if FDisciplineCompetenceView = nil then
  begin
    FDisciplineCompetenceView := TviewDisciplineCompetence.Create(Self, pnlCenter);
    FDisciplineCompetenceView.SetDocument( Document.DisciplineCompetence );
  end;

  FDisciplineCompetenceView.BringToFront;
end;

procedure TviewUMKMaster.actLessonThemesForUMKExecute(Sender: TObject);
begin
  if FviewLessonThemesForUMK = nil then
  begin
    FviewLessonThemesForUMK := TviewLessonThemesForUMK.Create(Self, pnlCenter);
  end
  else
  begin
    FviewLessonThemesForUMK.SetDocument( nil );
  end;

  FviewLessonThemesForUMK.SetDocument( Document );
  FviewLessonThemesForUMK.BringToFront;
end;

procedure TviewUMKMaster.actPrepareReportExecute(Sender: TObject);
begin
  if FViewPrepareUMK = nil then
  begin
    FViewPrepareUMK := TviewPrepareUMK.Create(Self, pnlCenter);
    FViewPrepareUMK.SetDocument(Document);
  end;

  FViewPrepareUMK.BringToFront;
end;

procedure TviewUMKMaster.actPreviousDisciplinesExecute(Sender: TObject);
begin
  if FViewPreviousDisciplines = nil then
  begin
    FViewPreviousDisciplines := TViewCustomDisciplines.Create(Self, pnlCenter);
  end;

  FViewPreviousDisciplines.SetDocument(Document.PreviousDisciplines);
  FViewPreviousDisciplines.DeleteConfirm := 'Удалить дисциплину из списка необходимых предшествующих дисциплин?';

  FViewPreviousDisciplines.BringToFront;
end;

procedure TviewUMKMaster.actPurposeExecute(Sender: TObject);
begin
  if FviewDisciplinePurpose = nil then
  begin
    FviewDisciplinePurpose := TviewDisciplinePurpose.Create(Self, pnlCenter);
    FviewDisciplinePurpose.SetDocument(Document.StudyPlanInfo);
  end;

  FviewDisciplinePurpose.BringToFront;
end;

procedure TviewUMKMaster.actSoftExecute(Sender: TObject);
begin
  if FViewSoftUMK = nil then
  begin
    FViewSoftUMK := TViewSoftUMK.Create(Self, pnlCenter);
    FViewSoftUMK.SetDocument(Document.DisciplineSoft);
  end;

  FViewSoftUMK.BringToFront;
end;

procedure TviewUMKMaster.actStudyPlansForUMKExecute(Sender: TObject);
begin
  if FdsgvSPForUMK = nil then
  begin
    FdsgvSPForUMK := TdsgvSPForUMK.Create( Self, pnlCenter );
  end;

  FdsgvSPForUMK.SetDocument( Document.StudyPlanForUMK );
  FdsgvSPForUMK.BringToFront;

end;

procedure TviewUMKMaster.actSubsequenceDisciplinesExecute(Sender: TObject);
begin
  if FViewPreviousDisciplines = nil then
  begin
    FViewPreviousDisciplines := TViewCustomDisciplines.Create(Self, pnlCenter);
  end;
  FViewPreviousDisciplines.SetDocument(Document.SubsequentDisciplines);
  FViewPreviousDisciplines.DeleteConfirm := 'Удалить дисциплину из списка необходимых последующих дисциплин?';

  FViewPreviousDisciplines.BringToFront;
end;

function TviewUMKMaster.GetDocument: TUMKMaster;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TUMKMaster;
end;

procedure TviewUMKMaster.OnStudyPlanForUMKSelectionChange(Sender: TObject);
begin
  actLessonThemesForUMK.Enabled := Document.StudyPlanForUMK.Wrap.MultiSelectDSWrap.SelCount > 0;
  actPrepareReport.Enabled := Document.StudyPlanForUMK.Wrap.MultiSelectDSWrap.SelCount > 0;
  actCompetence.Enabled := Document.StudyPlanForUMK.Wrap.MultiSelectDSWrap.SelCount > 0;
end;

procedure TviewUMKMaster.SetDocument(const Value: TDocument);
begin
  inherited;

  if FDocument <> nil then
  begin
    TNotifyEventWrap.Create(
      Document.StudyPlanForUMK.Wrap.MultiSelectDSWrap.OnSelectionChange,
      OnStudyPlanForUMKSelectionChange, EventsList);

    actStudyPlansForUMKExecute(actStudyPlansForUMK);
  end;
end;

end.
