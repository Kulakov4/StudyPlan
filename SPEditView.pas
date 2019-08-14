unit SPEditView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ViewEx, DocumentView, SPUnit, GridComboBox, ExtCtrls, StdCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit,
  cxDBEdit, Menus, cxLookAndFeelPainters, cxButtons, dxSkinsCore,
  dxSkinsDefaultPainters {, cxComboBoxGridView} , CSEDBTreeListView, CSE,
  cxCheckBox, cxGraphics, cxLookAndFeels, cxComboBoxGridView, NotifyEvents;

type
  TPlanEditView = class(TView_Ex)
    pnl1: TPanel;
    pnl2: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    cxdbspndtTotal: TcxDBSpinEdit;
    lbl5: TLabel;
    cxdbspndtLectures: TcxDBSpinEdit;
    lbl6: TLabel;
    cxdbspndtLabworks: TcxDBSpinEdit;
    lbl7: TLabel;
    cxdbspndtSeminars: TcxDBSpinEdit;
    Label1: TLabel;
    pnlChair: TPanel;
    Label2: TLabel;
    cxdbspndtTotal2: TcxDBSpinEdit;
    lblPath: TLabel;
    cxdbchckbxIs_Option: TcxDBCheckBox;
    Label3: TLabel;
    cxdbspndtPosition: TcxDBSpinEdit;
    cxdbcbProfessionalModule: TcxDBCheckBox;
    cxdbcbAutoSelfHours: TcxDBCheckBox;
    procedure cxdbcbProfessionalModuleClick(Sender: TObject);
    procedure cxdbspndtTotal2PropertiesEditValueChanged(Sender: TObject);
    procedure lbl4Click(Sender: TObject);
  private
    FgcbChairs: TcxGridComboBoxView;
    // FgcbHourViewType: TcxGridComboBoxView;
    FgcbCycles: TcxCmbBoxGridView;
    FgcbProfiles: TcxGridComboBoxView;
    FgcbDisciplines: TcxGridComboBoxView;
    FOnDNChange: TNotifyEventWrap;
    procedure AfterDisciplineNameScroll(Sender: TObject);
    // FgcbDisciplineTypes: TcxGridComboBoxView;
    procedure DoAfterCSEScroll(Sender: TObject);
    function GetDocument: TStudyPlan;
    procedure OnDisciplineNameChange(Sender: TObject);
    procedure UpdateStudyPlanPath;
    procedure UpdateTotalHours;
    { Private declarations }
  protected
    property Document: TStudyPlan read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

implementation

uses WordXP, K_Params, GridComboBoxViewEx, MydataAccess, DB,
  cxGridCustomTableView, CommissionOptions, SpecEducation, cxDropDownEdit;

{$R *.dfm}

constructor TPlanEditView.Create(AOwner: TComponent; AParent: TWinControl;
  AAlign: TAlign = alClient);
begin
  inherited;
  // Создаём представление для структуры в виде выпадающего списка
  FgcbCycles := TcxCmbBoxGridView.Create(Self, pnl1, TvwdbtrlstCSE, True);
  with FgcbCycles do
  begin
    cxbtnedt.Width := 500;
    DisplayFieldName := 'Cycle';
  end;

  FgcbDisciplines := TcxGridCBViewEx.Create(Self, pnl2);
  with FgcbDisciplines do
  begin
    Init(lsFixedList, '', 0, 'FgcbDisciplines');

    with RepositoryBandedTableView.OptionsBehavior do
    begin
      ImmediateEditor := False;
      // Чтобы список дисциплин случайно не отредактировать
      IncSearch := True;
    end;
    with RepositoryBandedTableView.OptionsData do
    begin
      Appending := StudyProcessOptions.AccessLevel < 10;
      Deleting := Appending;
      Inserting := Appending;
      Editing := False;
    end;
    ListFieldName := 'DisciplineName';
  end;

  { FgcbDisciplineTypes := TcxGridComboBoxView.Create(Self, pnl3);
    with FgcbDisciplineTypes do
    begin
    ListFieldName := 'cycletype';
    end;
  }
  FgcbChairs := TcxGridComboBoxView.Create(Self, pnlChair);
  with FgcbChairs do
  begin
    Init(lsFixedList, 'Department')
  end;
  (* Отображать в неделях и часах не потребовалось
    // Создаём представление для вида отображения часов
    FgcbHourViewType := TcxGridComboBoxView.Create(Self, pnlHourViewType);
    with FgcbHourViewType do
    begin
    cxexlcb1.Properties.DropDownListStyle := lsFixedList;
    ListFieldName := 'HourViewType';
    end;
  *)
end;

procedure TPlanEditView.AfterDisciplineNameScroll(Sender: TObject);
begin;
end;

procedure TPlanEditView.cxdbcbProfessionalModuleClick(Sender: TObject);
var
  ADisciplineName: string;
  AIDChair: Integer;
  OK: Boolean;
begin
  if cxdbcbProfessionalModule.Checked then
  begin
    if Document.CSE.Field('idcycle_type').AsInteger <> 5 then
    begin
      cxdbcbProfessionalModule.Checked := False; // Тут рекурсия!!!
      raise Exception.Create
        ('Выбранное место не является "Профессиональным модулем"');
    end;

    ADisciplineName := Document.CSE.Field('cycle').AsString;
    AIDChair := (Document.CSE.SpecialityEducationParam.Master as TSpecEducation)
      .Field('IDChair').AsInteger;

    // FgcbDisciplines.SetDocument(nil);

    // тут происходит множественный вызов событий AfterScroll!!!
    // ЗАПЛАТКА
    FreeAndNil(FOnDNChange);
    OK := Document.DisciplineNames.DS.Locate('DisciplineName',
      ADisciplineName, []);
    FOnDNChange := TNotifyEventWrap.Create
      (Document.DisciplineNames.OnEssenceChange, OnDisciplineNameChange,
      EventsList);

    if not OK then
    begin
      with Document.DisciplineNames.DS do
      begin
        Insert;
        FieldByName('DisciplineName').AsString := ADisciplineName;
        FieldByName('IDCHAR').AsInteger := AIDChair;
        Post;
      end;
    end;
    // FgcbDisciplines.SetDocument(Document.DisciplineNames.Wrap);
  end
end;

procedure TPlanEditView.cxdbspndtTotal2PropertiesEditValueChanged
  (Sender: TObject);
begin
  inherited;
  UpdateTotalHours;
end;

procedure TPlanEditView.DoAfterCSEScroll(Sender: TObject);
begin
  UpdateStudyPlanPath;
  cxdbcbProfessionalModule.Visible := Document.CSE.Field('idcycle_type')
    .AsInteger = 5;
end;

function TPlanEditView.GetDocument: TStudyPlan;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TStudyPlan;
end;

procedure TPlanEditView.lbl4Click(Sender: TObject);
begin
  inherited;
  UpdateTotalHours;
end;

procedure TPlanEditView.OnDisciplineNameChange(Sender: TObject);
begin
  Document.Chairs.DataSetWrap.LocateAndCheck('ID_Chair',
    Document.DisciplineNames.Field('IDChar').AsInteger, []);
end;

procedure TPlanEditView.SetDocument(const Value: TDocument);
begin
  inherited;
  if FDocument <> nil then
  begin
    // В списке циклов ищем текущий цикл
    Document.CSE.Wrap.DataSet.Locate('id_cyclespecialityeducation',
      Document.StudyPlanCDS.FieldByName('idcyclespecialityeducation')
      .AsInteger, []);

    // Привязываем цыклы к представлению
    FgcbCycles.SetDocument(Document.CSE.Wrap);

    // Ищем в списке видов представлений нужное представление
    // Document.HourViewTypes.Wrap.LocateAndCheck('ID_HourViewType',
    // Document.StudyPlanCDS.FieldByName('IDHourViewType').AsInteger, []);
    // Привязываем
    // FgcbHourViewType.SetDocument(Document.HourViewTypes.Wrap);

    // Реагируем на выбор места дисциплины в структуре учебного плана
    TNotifyEventWrap.Create(Document.CSE.Wrap.AfterScroll, DoAfterCSEScroll,
      EventsList);
    UpdateStudyPlanPath;

    cxdbspndtTotal2.Enabled := not Document.MultiSelect;
    cxdbspndtTotal.Enabled := not Document.MultiSelect;
    cxdbspndtLectures.Enabled := not Document.MultiSelect;
    cxdbspndtLabworks.Enabled := not Document.MultiSelect;
    cxdbspndtSeminars.Enabled := not Document.MultiSelect;
    cxdbchckbxIs_Option.Enabled := not Document.MultiSelect;
    cxdbspndtPosition.Enabled := not Document.MultiSelect;
    cxdbcbProfessionalModule.Enabled := not Document.MultiSelect;
    cxdbcbProfessionalModule.Visible := not Document.MultiSelect;

    // Если не происходит редактирование нескольких дисциплин
    if not Document.MultiSelect then
    begin

      // Выбираем в списке дисциплин дисциплину из учебного плана
      Document.DisciplineNames.Refresh;
      Document.DisciplineNames.Wrap.DataSet.Locate('id_disciplinename',
        Document.StudyPlanCDS.FieldByName('iddisciplinename').AsInteger, []);
      FgcbDisciplines.SetDocument(Document.DisciplineNames.Wrap);
      with TNotifyEventWrap.Create(Document.DisciplineNames.Wrap.AfterScrollEx,
        AfterDisciplineNameScroll, EventsList) do
        Index := 0;

      FOnDNChange := TNotifyEventWrap.Create
        (Document.DisciplineNames.OnEssenceChange, OnDisciplineNameChange,
        EventsList);

      cxdbcbProfessionalModule.DataBinding.DataSource :=
        Document.StudyPlanCDS.Wrap.DataSource;
      cxdbcbProfessionalModule.DataBinding.DataField := 'Professional_module';
      cxdbcbProfessionalModule.Visible := Document.CSE.Field('idcycle_type')
        .AsInteger = 5;
      cxdbcbProfessionalModule.OnClick := cxdbcbProfessionalModuleClick;

      // В списке кафедр ищем текущую кафедру учебного плана
      Document.Chairs.Wrap.DataSet.Locate('id_chair',
        Document.StudyPlanCDS.FieldByName('idchair').AsInteger, []);
      // FgcbChairs.cxexlcb1.Properties.GridMode := False;
      FgcbChairs.SetDocument(Document.Chairs.Wrap);

      cxdbspndtTotal2.DataBinding.DataSource :=
        Document.StudyPlanCDS.Wrap.DataSource;
      cxdbspndtTotal2.DataBinding.DataField := 'Total2';

      cxdbspndtTotal.DataBinding.DataSource :=
        Document.StudyPlanCDS.Wrap.DataSource;
      cxdbspndtTotal.DataBinding.DataField := 'Total';

      cxdbspndtLectures.DataBinding.DataSource :=
        Document.StudyPlanCDS.Wrap.DataSource;
      cxdbspndtLectures.DataBinding.DataField := 'Lectures';

      cxdbspndtLabworks.DataBinding.DataSource :=
        Document.StudyPlanCDS.Wrap.DataSource;
      cxdbspndtLabworks.DataBinding.DataField := 'Labworks';

      cxdbspndtSeminars.DataBinding.DataSource :=
        Document.StudyPlanCDS.Wrap.DataSource;
      cxdbspndtSeminars.DataBinding.DataField := 'Seminars';

      cxdbchckbxIs_Option.DataBinding.DataSource :=
        Document.StudyPlanCDS.Wrap.DataSource;
      cxdbchckbxIs_Option.DataBinding.DataField := 'IS_OPTION';

      cxdbspndtPosition.DataBinding.DataSource :=
        Document.StudyPlanCDS.Wrap.DataSource;
      cxdbspndtPosition.DataBinding.DataField := 'Position';

      cxdbcbAutoSelfHours.DataBinding.DataSource :=
        Document.StudyPlanCDS.Wrap.DataSource;

      cxdbspndtTotal2.Properties.OnEditValueChanged :=
        cxdbspndtTotal2PropertiesEditValueChanged;
    end;
  end
  else
  begin
    cxdbspndtTotal2.Properties.OnEditValueChanged := nil;
    FgcbCycles.SetDocument(nil);
    FgcbProfiles.SetDocument(nil);
    FgcbDisciplines.SetDocument(nil);
    // FgcbDisciplineTypes.SetDocument(nil);
    FgcbChairs.SetDocument(nil);
    // FgcbHourViewType.SetDocument(nil);

    cxdbspndtTotal.DataBinding.DataSource := nil;

    cxdbspndtLectures.DataBinding.DataSource := nil;

    cxdbspndtLabworks.DataBinding.DataSource := nil;

    cxdbspndtSeminars.DataBinding.DataSource := nil;
  end;
end;

procedure TPlanEditView.UpdateStudyPlanPath;
var
  MySQLQuery: TMySQLQuery;
begin
  MySQLQuery := TMySQLQuery.Create(Self, 0);
  try
    MySQLQuery.SQL.Text :=
      Format('select CDB_DAT_STUDY_PROCESS.StudyPlanPack.GetSPStructurePath(%d, '' \ '', '''') from dual',
      [Document.CSE.Field('id_cyclespecialityeducation').AsInteger]);
    MySQLQuery.Open;

    lblPath.Caption := MySQLQuery.Fields[0].AsString;
  finally
    FreeAndNil(MySQLQuery);
  end;
end;

procedure TPlanEditView.UpdateTotalHours;
var
  Total: Integer;
  Total2: Integer;
begin
  Total2 := Document.StudyPlanCDS.FieldByName('Total2').AsInteger;
  Total := Total2 * 36;
  Document.StudyPlanCDS.FieldByName('Total').AsInteger := Total;
end;

end.
