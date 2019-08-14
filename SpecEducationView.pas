unit SpecEducationView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataSetView_2, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, ExtCtrls,
  DocumentView, SpecEducation, cxLabel, cxCheckBox, ActnList, TB2Dock,
  TB2Toolbar, TB2Item, StdCtrls, Spin, cxLookAndFeels,
  cxLookAndFeelPainters, ImgList, cxContainer, EssenceGridView, cxNavigator,
  System.Actions, System.ImageList,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TgvSpecEducation = class(TdsgvEssence)
    cx_dbbtvcxg1DBBandedTableView1Column1: TcxGridDBBandedColumn;
    cx_dbbtvcxg1DBBandedTableView1Column2: TcxGridDBBandedColumn;
    tbdckTop: TTBDock;
    tbtlbr1: TTBToolbar;
    actlst1: TActionList;
    actDropPlan: TAction;
    tbi1: TTBItem;
    actCopyStudyPlan: TAction;
    TBToolbar1: TTBToolbar;
    tbi2: TTBItem;
    seYears: TSpinEdit;
    TBControlItem1: TTBControlItem;
    TBControlItem2: TTBControlItem;
    Label1: TLabel;
    TBControlItem3: TTBControlItem;
    Label2: TLabel;
    tbCreatePlan: TTBToolbar;
    actCreateStudyPlan: TAction;
    TBItem1: TTBItem;
    TBToolbar2: TTBToolbar;
    TBItem2: TTBItem;
    actEditStudyPlan: TAction;
    il1: TImageList;
    cx_dbbtvcxg1DBBandedTableView1Column3: TcxGridDBBandedColumn;
    tbCources: TTBToolbar;
    tbciCources: TTBControlItem;
    cxcbCources: TcxCheckBox;
    procedure actCopyStudyPlanExecute(Sender: TObject);
    procedure actCreateStudyPlanExecute(Sender: TObject);
    procedure actDropPlanExecute(Sender: TObject);
    procedure actEditStudyPlanExecute(Sender: TObject);
    procedure cxcbCourcesClick(Sender: TObject);
  private
    function GetDocument: TSpecEducation;
    { Private declarations }
  protected
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn);
      override;
    property Document: TSpecEducation read GetDocument;
  public
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

implementation

uses MessageForm, CreateNewPlanForm, System.UITypes;

{$R *.dfm}

procedure TgvSpecEducation.actCopyStudyPlanExecute(Sender: TObject);
var
  frmMessage: TfrmMessage;
begin
  if MessageDlg(Format('Скопировать выбранный учебный план на %d год?'#13#10 +
    'Это займёт несколько минут.', [seYears.Value]), mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    if (not Document.ExistSameStudyPlan(seYears.Value)) or
      (MessageDlg(Format('Подобный план уже существует в %d году.'#13#10 +
      'Перед копированием он будет удалён. Продолжить?', [seYears.Value]),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin

      frmMessage := TfrmMessage.Create(Self);
      with frmMessage do
      begin
        FormStyle := fsStayOnTop;
        lblText.Caption := 'Идёт копирование';
        btnClose.Caption := 'Закрыть';
        btnClose.Enabled := False;
        Show;
      end;
      Application.ProcessMessages;
      try
        // Вызываем копирование
        Document.Copy(seYears.Value);

        // Обновляем окно сообщения
        with frmMessage do
        begin
          lblText.Caption := 'Копирование завершено';
          btnClose.Caption := 'ОК';
          btnClose.Enabled := True;
        end;
      except
        with frmMessage do
        begin
          lblText.Caption := 'При копировании возникла ошибка';
          btnClose.Enabled := True;
        end;
        raise;
      end;
    end;
  end;
end;

procedure TgvSpecEducation.actCreateStudyPlanExecute(Sender: TObject);
var
  frmCreateNewStudyPlan: TfrmCreateNewStudyPlan;
begin
  frmCreateNewStudyPlan := TfrmCreateNewStudyPlan.Create(Document);
  try
    with frmCreateNewStudyPlan do
    begin
      if ShowModal = mrOk then
        Document.CreateNew(IDSpeciality, IDEducation, Year, Years, Months,
          IDStudyPlanStandart, IDChair, Annotation, IDQualification);
    end;

  finally
    frmCreateNewStudyPlan.Free;
  end;
end;

procedure TgvSpecEducation.actDropPlanExecute(Sender: TObject);
var
  frmMessage: TfrmMessage;
begin
  if MessageDlg('Удалить выбранный учебный план?'#13#10 +
    'Это займёт несколько минут', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    frmMessage := TfrmMessage.Create(Self);
    with frmMessage do
    begin
      FormStyle := fsStayOnTop;
      lblText.Caption := 'Идёт удаление';
      btnClose.Caption := 'Закрыть';
      btnClose.Enabled := False;
      Show;
    end;
    Application.ProcessMessages;
    try
      // Вызываем Удаление
      Document.Drop;

      // Обновляем окно сообщения
      with frmMessage do
      begin
        lblText.Caption := 'Удаление завершено';
        btnClose.Caption := 'ОК';
        btnClose.Enabled := True;
      end;
    except
      with frmMessage do
      begin
        lblText.Caption := 'При удалении возникла ошибка';
        btnClose.Enabled := True;
      end;
      raise;
    end;
  end;
end;

procedure TgvSpecEducation.actEditStudyPlanExecute(Sender: TObject);
var
  frmCreateNewStudyPlan: TfrmCreateNewStudyPlan;
begin
  frmCreateNewStudyPlan := TfrmCreateNewStudyPlan.Create(Document);
  try
    with frmCreateNewStudyPlan do
    begin
      Caption := 'Изменение учебного плана';
      btnClose.Caption := 'ОК';
      cxmeYear.Properties.ReadOnly := True;

      if ShowModal = mrOk then
        Document.Edit(IDSpeciality, IDEducation, Years, Months,
          IDStudyPlanStandart, IDChair, Annotation, IDQualification);
    end;

  finally
    frmCreateNewStudyPlan.Free;
  end;
end;

procedure TgvSpecEducation.cxcbCourcesClick(Sender: TObject);
begin
  Document.Cources := (Sender as TcxCheckBox).Checked;
end;

function TgvSpecEducation.GetDocument: TSpecEducation;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TSpecEducation;
end;

procedure TgvSpecEducation.InitColumn(AcxGridDBBandedColumn
  : TcxGridDBBandedColumn);
begin
  if AnsiSameText(AcxGridDBBandedColumn.DataBinding.FieldName, 'speciality_ex')
  then
  begin
    AcxGridDBBandedColumn.Visible := False;
  end;

  if AnsiSameText(AcxGridDBBandedColumn.DataBinding.FieldName, 'speciality')
  then
  begin
    AcxGridDBBandedColumn.Options.CellMerging := True;
    AcxGridDBBandedColumn.PropertiesClass := TcxLabelProperties;
    with AcxGridDBBandedColumn.Properties as TcxLabelProperties do
    begin
      Alignment.Vert := taVCenter;
      WordWrap := True;
    end;
  end;

  if AnsiSameText(AcxGridDBBandedColumn.DataBinding.FieldName,
    'chiper_speciality') then
  begin
    AcxGridDBBandedColumn.Options.CellMerging := True;

    AcxGridDBBandedColumn.MinWidth := 100;
  end;

  if AnsiSameText(AcxGridDBBandedColumn.DataBinding.FieldName, 'locked') then
  begin
    AcxGridDBBandedColumn.PropertiesClass := TcxCheckBoxProperties;
    with AcxGridDBBandedColumn.Properties as TcxCheckBoxProperties do
    begin
      ImmediatePost := True;
      ValueChecked := 1;
      ValueUnchecked := 0;
    end;
  end;

  if AnsiSameText(AcxGridDBBandedColumn.DataBinding.FieldName,
    Document.QUALIFICATION.FieldName) then
  begin
    AcxGridDBBandedColumn.Options.CellMerging := True;
  end;

  if AnsiSameText(AcxGridDBBandedColumn.DataBinding.FieldName,
    Document.StudyPlanStandart.FieldName) then
  begin
    AcxGridDBBandedColumn.Options.CellMerging := True;
  end;

  if AnsiSameText(AcxGridDBBandedColumn.DataBinding.FieldName,
    Document.Education.FieldName) then
  begin
    AcxGridDBBandedColumn.MinWidth := 300;
  end;
end;

procedure TgvSpecEducation.SetDocument(const Value: TDocument);
begin
  seYears.Value := CurrentYear + 1;

  inherited;
  if FDocument <> nil then
  begin
    cxcbCources.Enabled := True;
    cxcbCources.Checked := Document.Cources;
  end
  else
  begin
    cxcbCources.Checked := False;
    cxcbCources.Enabled := False;
  end;
end;

end.
