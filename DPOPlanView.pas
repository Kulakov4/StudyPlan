unit DPOPlanView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EssenceGridView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, TB2Dock, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, Vcl.ExtCtrls,
  Vcl.ImgList, Vcl.ActnList, TB2Item, TB2Toolbar, DPOStudyPlan, DocumentView,
  Admissions, cxNavigator, System.Actions, System.ImageList,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TdsgvDPOStudyPlan = class(TdsgvEssence)
    tbd1: TTBDock;
    actlst1: TActionList;
    actMoveUp: TAction;
    actMoveDown: TAction;
    il1: TImageList;
    tb1: TTBToolbar;
    tbi1: TTBItem;
    tbi2: TTBItem;
    procedure actMoveDownExecute(Sender: TObject);
    procedure actMoveUpExecute(Sender: TObject);
    procedure cx_dbbtvcxg1DBBandedTableView1CellDblClick(Sender:
        TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
        AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  private
    function GetDocument: TDPOStudyPlans;
    function GetMasterAdmission: TAdmissions;
    { Private declarations }
  protected
    procedure AfterInsert(Sender: TObject);
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn); override;
    procedure OnDisciplineNameButtonClick(Sender: TObject; AButtonIndex: Integer);
    property Document: TDPOStudyPlans read GetDocument;
    property MasterAdmission: TAdmissions read GetMasterAdmission;
  public
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

implementation

uses
  NotifyEvents, DPODisciplineNames, cxButtonEdit, cxGridDBTableView,
  cxSpinEdit, cxCheckBox, ViewFormEx;


{$R *.dfm}

procedure TdsgvDPOStudyPlan.actMoveDownExecute(Sender: TObject);
begin
  Document.MoveDown;
end;

procedure TdsgvDPOStudyPlan.actMoveUpExecute(Sender: TObject);
begin
  Document.MoveUp;
end;

procedure TdsgvDPOStudyPlan.AfterInsert(Sender: TObject);
var
  ADisciplineNames: TDPODisciplineNames;
  AfrmDisciplineNames: TfrmViewEx;
begin
  if MasterAdmission.DataSetWrap.DataSet.RecordCount = 0 then
  begin
    ShowMessage('Прежде чем добавлять дисциплины, нужно добавить описание курсов');
    Document.DataSetWrap.DataSet.Cancel;
    Exit;
  end;

  ADisciplineNames := TDPODisciplineNames.Create(Self, MasterAdmission.CurrIDChair);
  AfrmDisciplineNames := TfrmViewEx.Create(Self, 'Дисциплины', 'DisciplineForm', [mbOk]);
  try
    AfrmDisciplineNames.cxbtnOk.Caption := 'ОК';
    ADisciplineNames.Refresh;
    AfrmDisciplineNames.ViewClass := TdsgvEssence;
    AfrmDisciplineNames.View.SetDocument(ADisciplineNames);
    if AfrmDisciplineNames.ShowModal = mrOk then
    begin
      Document.New(
        ADisciplineNames.DataSetWrap.DataSet.FieldByName('ID_DisciplineName').AsInteger,
        MasterAdmission.CurrIDCycle,
        ADisciplineNames.DataSetWrap.DataSet.FieldByName('DisciplineName').AsString,
        ADisciplineNames.DataSetWrap.DataSet.FieldByName('IDChar').AsInteger,
        MasterAdmission.CurrIDSpecialitySession);
    end
    else
      Document.DataSetWrap.DataSet.Cancel;
  finally
    FreeAndNil(AfrmDisciplineNames);
    FreeAndNil(ADisciplineNames);
  end;
end;

procedure TdsgvDPOStudyPlan.cx_dbbtvcxg1DBBandedTableView1CellDblClick(Sender:
    TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
    AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  AFieldName: string;
begin
  AFieldName := (ACellViewInfo.Item as
    TcxGridDBBandedColumn).DataBinding.FieldName;

  if Document.IsDataField(AFieldName) then
  begin
    Document.EditLessons(AFieldName);
  end;
end;

function TdsgvDPOStudyPlan.GetDocument: TDPOStudyPlans;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TDPOStudyPlans;
end;

function TdsgvDPOStudyPlan.GetMasterAdmission: TAdmissions;
begin
  if (Document.AdmissionParam.Master = nil) or
    (not (Document.AdmissionParam.Master is TAdmissions)) then
    raise Exception.Create('Нет возможности определить текущий набор');

  Result := Document.AdmissionParam.Master as TAdmissions;
end;

procedure TdsgvDPOStudyPlan.InitColumn(AcxGridDBBandedColumn:
    TcxGridDBBandedColumn);
begin
  AcxGridDBBandedColumn.Options.Filtering := False;

//  if KPosText('DisciplineName', AcxGridDBBandedColumn.DataBinding.FieldName) > 0
  if AnsiSameText('DisciplineName', AcxGridDBBandedColumn.DataBinding.FieldName) then
  begin
    //    AcxGridDBCardViewRow.Options.Editing := False;
    AcxGridDBBandedColumn.PropertiesClass := TcxButtonEditProperties;
    (AcxGridDBBandedColumn.Properties as TcxButtonEditProperties).OnButtonClick
      := OnDisciplineNameButtonClick;
  end;

  if AnsiSameText('Total', AcxGridDBBandedColumn.DataBinding.FieldName) then
  begin
    (cxgridDBBandedTableView.DataController.Summary.FooterSummaryItems.Items[0] as TcxGridDBTableSummaryItem).FieldName := 'Total';
    (cxgridDBBandedTableView.DataController.Summary.FooterSummaryItems.Items[0] as TcxGridDBTableSummaryItem).Column := AcxGridDBBandedColumn;
    //      cxgridDBBandedTableView.GetColumnByFieldName('Total');
    AcxGridDBBandedColumn.MinWidth := 100;
    AcxGridDBBandedColumn.PropertiesClass := TcxSpinEditProperties;
  end;

//  if (KPosText('ZachData', AcxGridDBBandedColumn.DataBinding.FieldName) > 0)
//    or (KPosText('ExamData', AcxGridDBBandedColumn.DataBinding.FieldName) > 0)
  if (AnsiSameText('ZachData', AcxGridDBBandedColumn.DataBinding.FieldName))
      or (AnsiSameText('ExamData', AcxGridDBBandedColumn.DataBinding.FieldName))
      then
  begin
    AcxGridDBBandedColumn.PropertiesClass := TcxCheckBoxProperties;
    (AcxGridDBBandedColumn.Properties as TcxCheckBoxProperties).NullStyle :=
      nssUnchecked;
    (AcxGridDBBandedColumn.Properties as TcxCheckBoxProperties).ValueChecked :=
      2;
    (AcxGridDBBandedColumn.Properties as TcxCheckBoxProperties).ValueUnchecked
      := 0;
    (AcxGridDBBandedColumn.Properties as TcxCheckBoxProperties).AllowGrayed :=
      False;
  end
  else if Document.IsDataField(AcxGridDBBandedColumn.DataBinding.FieldName) then
  begin
    AcxGridDBBandedColumn.PropertiesClass := TcxSpinEditProperties;
  end;
end;

procedure TdsgvDPOStudyPlan.OnDisciplineNameButtonClick(Sender: TObject;
    AButtonIndex: Integer);
var
  ADisciplineNames: TDPODisciplineNames;
  AfrmDisciplineNames: TfrmViewEx;
begin
  ADisciplineNames := TDPODisciplineNames.Create(Self,
    MasterAdmission.CurrIDChair);
  AfrmDisciplineNames := TfrmViewEx.Create(Self, 'Дисциплины', 'DisciplineForm', [mbOk]);
  try
    ADisciplineNames.Refresh;
    AfrmDisciplineNames.ViewClass := TdsgvEssence;
    AfrmDisciplineNames.View.SetDocument(ADisciplineNames);
    if AfrmDisciplineNames.ShowModal = mrOk then
    begin
      Document.UpdateDisciplineName(ADisciplineNames.DataSetWrap.DataSet.FieldByName('ID_DisciplineName').AsInteger);
    end
  finally
    FreeAndNil(AfrmDisciplineNames);
    FreeAndNil(ADisciplineNames);
  end;
end;

procedure TdsgvDPOStudyPlan.SetDocument(const Value: TDocument);
begin
  inherited;

  if FDocument <> nil then
  begin
    TNotifyEventWrap.Create(Document.Wrap.AfterInsert, AfterInsert, EventsList);
    KcxGridDBBandedTableView.SetDocument(Document.Wrap);
  end
  else
  begin
    KcxGridDBBandedTableView.SetDocument(nil);
  end;
end;

end.
