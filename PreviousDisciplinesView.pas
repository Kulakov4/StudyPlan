unit PreviousDisciplinesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EssenceGridView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, TB2Dock,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  Vcl.ExtCtrls, DocumentView, PreviousDisciplines, Vcl.ImgList, System.Actions,
  Vcl.ActnList, TB2Item, TB2Toolbar, System.ImageList,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TViewCustomDisciplines = class(TdsgvEssence)
    ImageList: TImageList;
    ActionList: TActionList;
    actAdd: TAction;
    actDelete: TAction;
    tbMain: TTBToolbar;
    tbiAdd: TTBItem;
    tbiDelete: TTBItem;
    procedure actAddExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
  private
    FDeleteConfirm: string;
    function GetDocument: TCustomDisciplines;
    { Private declarations }
  protected
    property Document: TCustomDisciplines read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    procedure UpdateView; override;
    property DeleteConfirm: string read FDeleteConfirm write FDeleteConfirm;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses SPUnit, SPView2, ViewFormEx, Main;

constructor TViewCustomDisciplines.Create(AOwner: TComponent;
  AParent: TWinControl; AAlign: TAlign = alClient);
begin
  inherited;
  DataSetControls_View.tbDataSet.Visible := False;
  FDeleteConfirm :=
    'Удалить дисциплину из списка необходимых предшествующих дисциплин?';
end;

{ TODO : Этот метод скорее всего больше не нужен }
procedure TViewCustomDisciplines.actAddExecute(Sender: TObject);
(*
var
  AIDDisciplineNameList: TStringList;
  AStudyPlan: TStudyPlan;
  AviewSP: TviewSP;
  frmSP: TfrmViewEx;
  S: string;
*)
begin
(*
  AStudyPlan := TStudyPlan.Create(Self);
  try
    AStudyPlan.DoOnMasterChange(frmMain.SpecEdVO.Wrap.PKValue,
      frmMain.SpecEdVO.IDEducationBaseForm.AsInteger,
      frmMain.SpecEdVO.IDEducationLevel.AsInteger);

    frmSP := TfrmViewEx.Create(Self, 'Учебный план', 'StudyPlanForm', [mbOk]);
    AviewSP := TviewSP.Create(Self, frmSP.pnlMain);
    AIDDisciplineNameList := TStringList.Create;
    try

      AviewSP.Editing := True;
      S := Document.Wrap.GetColumnValues
        (Document.IDCustomDisciplineName.FieldName, #13#10);
      AIDDisciplineNameList.Text := S;
      AStudyPlan.StudyPlanCDS.SetCheched(AIDDisciplineNameList);

      AviewSP.TBToolbar1.Visible := False;
      AviewSP.ShowCheked := True;
      AviewSP.SetDocument(AStudyPlan);
      if frmSP.ShowModal = mrOk then
      begin
        AStudyPlan.StudyPlanCDS.CheckedOnly := True;
        S := AStudyPlan.StudyPlanCDS.Wrap.GetColumnValues
          ('iddisciplinename', #13#10);
        AIDDisciplineNameList.Text := S;
        cxGrid.BeginUpdate();
        try
          Document.AddDiscipline(AIDDisciplineNameList);
        finally
          cxGrid.EndUpdate;
        end;
      end;
    finally
      FreeAndNil(AviewSP);
      FreeAndNil(frmSP);
      FreeAndNil(AIDDisciplineNameList);
    end;
  finally
    FreeAndNil(AStudyPlan);
  end;
*)
end;

procedure TViewCustomDisciplines.actDeleteExecute(Sender: TObject);
var
  AView: TcxGridDBBandedTableView;
  S: string;
begin
  AView := FocusedTableView;
  if AView = nil then
    Exit;

  S := '';
  if AView.Level = cxGridLevel then
    S := FDeleteConfirm;

  if (S <> '') and (Application.MessageBox(PWideChar(S), 'Удаление',
    MB_YESNO + MB_ICONQUESTION) = IDYES) and
    (AView.DataController.RecordCount > 0) then
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

  end;

  UpdateView;
end;

function TViewCustomDisciplines.GetDocument: TCustomDisciplines;
begin
  Assert(Esscence <> nil);
  Result := Esscence as TCustomDisciplines;
end;

procedure TViewCustomDisciplines.SetDocument(const Value: TDocument);
begin

  inherited;

  if FDocument <> nil then
  begin
  end
  else
  begin
  end;

  UpdateView;

end;

procedure TViewCustomDisciplines.UpdateView;
var
  AView: TcxGridDBBandedTableView;
begin
  AView := FocusedTableView;

  actAdd.Enabled := (FDocument <> nil) and (Document.DS.Active) and
    (AView <> nil) and (AView.Level = cxGridLevel);

  actDelete.Enabled := (FDocument <> nil) and (Document.DS.Active) and
    (AView <> nil) and (AView.DataController.RecordCount > 0);
end;

end.
