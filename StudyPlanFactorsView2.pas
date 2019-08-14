unit StudyPlanFactorsView2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewEx, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  cxSplitter, Vcl.ExtCtrls, TB2Item, TB2Dock, TB2Toolbar, Vcl.ImgList,
  Vcl.ActnList, DocumentView, StudyPlanFactors, StudyPlanFactorsTreeListView,
  DataSetControlsView, ParameterValuesView, System.Actions, System.ImageList;

type
  TviewStudyPlanFactors = class(TView_Ex)
    pnlLeft: TPanel;
    pnlRight: TPanel;
    cxs1: TcxSplitter;
    alFactors: TActionList;
    actVerify: TAction;
    actVerifyAll: TAction;
    actFactors: TAction;
    actCopyFactor: TAction;
    actShowParameters: TAction;
    alCatCopyPaste: TActionList;
    actCut: TAction;
    actCopy: TAction;
    actPaste: TAction;
    ilCutCopyPaste: TImageList;
    tbdTop: TTBDock;
    tbFactors: TTBToolbar;
    tbiVerify: TTBItem;
    tbiShowParameters: TTBItem;
    tbsprtrtm1: TTBSeparatorItem;
    tbiFactors: TTBItem;
    tbiParameters: TTBItem;
    tbsprtrtm2: TTBSeparatorItem;
    tbi1: TTBItem;
    tbCutCopyPaste: TTBToolbar;
    TBItem2: TTBItem;
    TBItem1: TTBItem;
    procedure actCopyExecute(Sender: TObject);
    procedure actCopyFactorExecute(Sender: TObject);
    procedure actCopyUpdate(Sender: TObject);
    procedure actCutExecute(Sender: TObject);
    procedure actCutUpdate(Sender: TObject);
    procedure actFactorsExecute(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure actPasteUpdate(Sender: TObject);
    procedure actShowParametersExecute(Sender: TObject);
    procedure actVerifyAllExecute(Sender: TObject);
    procedure actVerifyExecute(Sender: TObject);
  private
    FDataSetControls_View: TDataSetControls_View;
    FdbtlvStudyPlanFactors: TdbtlvStudyPlanFactors;
    FdsgvParameterValues: TdsgvParameterValues;
    function GetDocument: TStudyPlanFactors;
    { Private declarations }
  protected
    procedure AfterFactorInsert(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    property Document: TStudyPlanFactors read GetDocument;
    { Public declarations }
  end;

var
  viewStudyPlanFactors: TviewStudyPlanFactors;

implementation

uses
  CommissionOptions, CopyFactorsForm, SpecEducation, CopyProgressForm, cxTL,
  KValuesList, AdmissionView, ViewFormEx, FactorsView2, EssenceGridView,
  NotifyEvents, AddFactorForm;

{$R *.dfm}

constructor TviewStudyPlanFactors.Create(AOwner: TComponent;
  AParent: TWinControl; AAlign: TAlign = alClient);
begin
  inherited;
  FDataSetControls_View := TDataSetControls_View.Create(Self, tbdTop);
  FDataSetControls_View.AllowEdit := False;

  FdsgvParameterValues := TdsgvParameterValues.Create(Self, pnlRight);

  FdbtlvStudyPlanFactors := TdbtlvStudyPlanFactors.Create(Self, pnlLeft);
  actFactors.Enabled := StudyProcessOptions.AccessLevel < 10;
  actCopyFactor.Enabled := StudyProcessOptions.AccessLevel < 10;
end;

procedure TviewStudyPlanFactors.actCopyExecute(Sender: TObject);
begin
  Document.CutCopyPaste.Copy;
end;

procedure TviewStudyPlanFactors.actCopyFactorExecute(Sender: TObject);
var
  AIDSpecialityEducation: Integer;
  AID_StudyPlanFactor: Integer;
  frmCopyStudyPlanFactors: TfrmCopyStudyPlanFactors;
  ASpecEducation: TSpecEducation;
  frmCopyProgress: TfrmCopyProgress;
  i: Integer;
  Id: Integer;
  IDArray: array of Integer;
  j: Integer;
  Node: TcxTreeListNode;
  ParentID: Variant;
  x: Integer;
begin
  ASpecEducation := TSpecEducation.Create(nil);
  frmCopyStudyPlanFactors := TfrmCopyStudyPlanFactors.Create(Self,
    'Учебные планы', 'StudyPlansForm');
  try
    with ASpecEducation.FieldsSynonym.Insert(0) as TValueItem do
    begin
      Ident := ASpecEducation.KeyFieldName;
      Value := 'x';
    end;
    ASpecEducation.Cources := False;

    frmCopyStudyPlanFactors.ViewClass := TdsgvAdmission;

    frmCopyStudyPlanFactors.View.SetDocument(ASpecEducation);
    if frmCopyStudyPlanFactors.ShowModal = mrOk then
    begin
      // Цикл по всем выделенным критериям
      with FdbtlvStudyPlanFactors do
        for i := 0 to cxdbtlView.SelectionCount - 1 do
        begin
          Node := cxdbtlView.Selections[i];
          Id := Node.Values[IDColumn.Position.ColIndex];
          // Получаем код критерия учебного плана
          ParentID := Node.Values[IDParentColumn.Position.ColIndex];
          // Получаем код родительского критерия учебного плана
          if VarIsNull(ParentID) then
          begin
            SetLength(IDArray, Length(IDArray) + 1);
            IDArray[Length(IDArray) - 1] := Id;
          end;
        end;

      frmCopyProgress := TfrmCopyProgress.Create(Self);
      try
        frmCopyProgress.cxpbCopy.Properties.Max :=
          ASpecEducation.DataSetWrap.MultiSelectDSWrap.SelCount *
          Length(IDArray);
        frmCopyProgress.Show;

        for i := 0 to ASpecEducation.DataSetWrap.MultiSelectDSWrap.
          SelCount - 1 do
        begin
          // Цикл по всем кодам критерие
          for j := 0 to High(IDArray) do
          begin
            AIDSpecialityEducation :=
              StrToInt(ASpecEducation.DataSetWrap.MultiSelectDSWrap.
              SelectedList[i]);
            if AIDSpecialityEducation <> Document.Field('IDSpecialityEducation')
              .AsInteger then
            begin
              AID_StudyPlanFactor := IDArray[j];
              x := Document.CopyStudyPlanFactor(AID_StudyPlanFactor, NULL,
                AIDSpecialityEducation, False,
                frmCopyStudyPlanFactors.cxcbOverride.Checked);
              if x = 0 then
                frmCopyProgress.ErrorCount := frmCopyProgress.ErrorCount + 1;

              frmCopyProgress.cxpbCopy.Position :=
                frmCopyProgress.cxpbCopy.Position + 1;
              Application.ProcessMessages;
            end;
          end;
        end;
        frmCopyProgress.Caption := 'Копирование завершено';
        frmCopyProgress.cxbtnClose.Enabled := True;
        frmCopyProgress.cxbtnClose.Visible := True;
      finally
        // frmCopyProgress.Free;
      end;
    end;
  finally
    FreeAndNil(frmCopyStudyPlanFactors);
    FreeAndNil(ASpecEducation);
  end;
end;

procedure TviewStudyPlanFactors.actCopyUpdate(Sender: TObject);
begin
  actCopy.Enabled := Document.CutCopyPaste.IsCopyEnabled;
end;

procedure TviewStudyPlanFactors.actCutExecute(Sender: TObject);
begin
  Document.CutCopyPaste.Cut;
end;

procedure TviewStudyPlanFactors.actCutUpdate(Sender: TObject);
begin
  actCut.Enabled := Document.CutCopyPaste.IsCutEnabled;
end;

procedure TviewStudyPlanFactors.actFactorsExecute(Sender: TObject);
var
  AFactors: TFactors;
  frmFactors: TfrmViewEx;
begin
  AFactors := TFactors.Create(Self);
  frmFactors := TfrmViewEx.Create(Self, 'Справочник критериев', 'FactorsForm');
  try
    AFactors.Refresh;
    AFactors.DS.Locate(AFactors.KeyFieldName, Document.Field('IDFactor')
      .Value, []);

    frmFactors.ViewClass := TviewFactors;
    frmFactors.View.SetDocument(AFactors);
    frmFactors.ShowModal;
  finally
    AFactors.Free;
    frmFactors.Free;
  end;
end;

procedure TviewStudyPlanFactors.actPasteExecute(Sender: TObject);
begin
  Document.CutCopyPaste.Paste;
end;

procedure TviewStudyPlanFactors.actPasteUpdate(Sender: TObject);
begin
  actPaste.Enabled := Document.CutCopyPaste.IsPasteEnabled;
end;

procedure TviewStudyPlanFactors.actShowParametersExecute(Sender: TObject);
var
  AdmissionParameters: TAdmissionParameters;
  frmParameters: TfrmViewEx;
begin
  AdmissionParameters := TAdmissionParameters.Create(Self);
  frmParameters := TfrmViewEx.Create(Self, 'Все Параметры',
    'AdmissionParametersForm', [mbOk]);
  try
    AdmissionParameters.IDAdmissionParam.ParamValue :=
      Document.IDAdmissionParam.ParamValue;
    AdmissionParameters.Refresh;
    frmParameters.ViewClass := TdsgvParameterValues;
    frmParameters.View.SetDocument(AdmissionParameters);
    frmParameters.ShowModal;
  finally
    AdmissionParameters.Free;
    frmParameters.Free;
  end;
end;

procedure TviewStudyPlanFactors.actVerifyAllExecute(Sender: TObject);
begin
  Document.VerifyAll;
end;

procedure TviewStudyPlanFactors.actVerifyExecute(Sender: TObject);
begin
  Document.Verify; // Проверяем выбранный фактор
end;

procedure TviewStudyPlanFactors.AfterFactorInsert(Sender: TObject);
var
  AFactors: TFactors;
  frmFactors: TfrmAddFactor;
begin

  AFactors := TFactors.Create(Self);
  frmFactors := TfrmAddFactor.Create(Self);
  try
    frmFactors.ViewClass := TviewFactors;
    frmFactors.View.SetDocument(AFactors);
    // AFactors.FactorParameters.IDAdmissionParam.ParamValue := Document.IDAdmissionParam.ParamValue;
    AFactors.Refresh;
    if frmFactors.ShowModal = mrOk then
    begin
      Document.DS.Cancel;
      Document.AddCriterionTree(AFactors.PKValue,
        Document.IDAdmissionParam.ParamValue, frmFactors.cxcbOverride.Checked);
    end
    else
      Document.DS.Cancel;
  finally
    AFactors.Free;
    frmFactors.Free;
  end;
end;

function TviewStudyPlanFactors.GetDocument: TStudyPlanFactors;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TStudyPlanFactors;
end;

procedure TviewStudyPlanFactors.SetDocument(const Value: TDocument);
begin
  inherited;

  if FDocument <> nil then
  begin
    FDataSetControls_View.SetDocument(Document.DataSetWrap);
    FdbtlvStudyPlanFactors.SetDocument(Document.DataSetWrap);
    FdsgvParameterValues.SetDocument(Document.Parameters);

    TNotifyEventWrap.Create(Document.DataSetWrap.AfterInsert, AfterFactorInsert,
      EventsList);

  end
  else
  begin
    FDataSetControls_View.SetDocument(nil);
    FdbtlvStudyPlanFactors.SetDocument(nil);
    FdsgvParameterValues.SetDocument(nil);
  end;

end;

end.
