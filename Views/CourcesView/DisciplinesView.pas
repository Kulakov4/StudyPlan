unit DisciplinesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GridFrame,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.Menus,
  System.Actions, Vcl.ActnList, cxClasses, dxBar, Vcl.ComCtrls, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  System.ImageList, Vcl.ImgList, cxImageList, TB2Dock, TB2Toolbar, TB2Item,
  dxDateRanges, DiscNameQry, CourseDiscViewModel,
  InsertEditMode;

type
  TViewDisciplines = class(TfrmGrid)
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    actAdd: TAction;
    cxImageList: TcxImageList;
    actEdit: TAction;
    TBItem1: TTBItem;
    TBItem2: TTBItem;
    TBItem3: TTBItem;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
  private
    FModel: TCourseDiscViewModel;
    procedure DoOnExamChange(Sender: TObject);
    procedure DoOnIDDisciplineNameChanged(Sender: TObject);
    function GetclExam: TcxGridDBBandedColumn;
    function GetclIDDisciplineName: TcxGridDBBandedColumn;
    function GetclLab: TcxGridDBBandedColumn;
    function GetclLec: TcxGridDBBandedColumn;
    function GetclSem: TcxGridDBBandedColumn;
    function GetclZach: TcxGridDBBandedColumn;
    procedure SetModel(const Value: TCourseDiscViewModel);
    procedure ShowDisciplineEditForm(AMode: TMode);
    { Private declarations }
  public
    destructor Destroy; override;
    procedure UpdateView; override;
    property clExam: TcxGridDBBandedColumn read GetclExam;
    property clIDDisciplineName: TcxGridDBBandedColumn
      read GetclIDDisciplineName;
    property clLab: TcxGridDBBandedColumn read GetclLab;
    property clLec: TcxGridDBBandedColumn read GetclLec;
    property clSem: TcxGridDBBandedColumn read GetclSem;
    property clZach: TcxGridDBBandedColumn read GetclZach;
    property Model: TCourseDiscViewModel read FModel write SetModel;
    { Public declarations }
  end;

implementation

uses
  cxDropDownEdit, cxCheckBox, FireDAC.Comp.Client,
  cxDBLookupComboBox, NotifyEvents, CourceDiscEditForm,
  CourceDiscNameViewModel;

{$R *.dfm}

destructor TViewDisciplines.Destroy;
begin
  Model := nil;

  inherited;
end;

procedure TViewDisciplines.actAddExecute(Sender: TObject);
begin
  inherited;
  ShowDisciplineEditForm(InsertMode);
end;

procedure TViewDisciplines.actEditExecute(Sender: TObject);
begin
  inherited;
  ShowDisciplineEditForm(EditMode);
end;

procedure TViewDisciplines.DoOnExamChange(Sender: TObject);
begin
  (Sender as TcxCheckBox).PostEditValue;
  UpdateView;
end;

procedure TViewDisciplines.DoOnIDDisciplineNameChanged(Sender: TObject);
begin
  (Sender as TcxLookupComboBox).PostEditValue;
  clIDDisciplineName.ApplyBestFit();
  UpdateView;
end;

function TViewDisciplines.GetclExam: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (Model.CourseStudyPlanW.ExamData.FieldName);
end;

function TViewDisciplines.GetclIDDisciplineName: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (Model.CourseStudyPlanW.IDDisciplineName.FieldName);
end;

function TViewDisciplines.GetclLab: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (Model.CourseStudyPlanW.LabData.FieldName);
end;

function TViewDisciplines.GetclLec: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (Model.CourseStudyPlanW.LecData.FieldName);
end;

function TViewDisciplines.GetclSem: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (Model.CourseStudyPlanW.SemData.FieldName);
end;

function TViewDisciplines.GetclZach: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (Model.CourseStudyPlanW.ZachData.FieldName);
end;

procedure TViewDisciplines.SetModel(const Value: TCourseDiscViewModel);
begin
  if FModel = Value then
    Exit;

  FModel := Value;

  if FModel = nil then
  begin
    Exit;
  end;

  DataSource.DataSet := Model.CourseStudyPlanW.DataSet;
  MainView.DataController.CreateAllItems;

  InitView(MainView);
  MainView.OptionsBehavior.CellHints := True;

  // Настраиваем подстановочную колонку Наименование дисциплины
  InitializeLookupColumn(clIDDisciplineName, Model.DiscNameW.DataSource,
    lsEditList, Model.DiscNameW.DisciplineName.FieldName,
    Model.DiscNameW.PKFieldName);

  (clIDDisciplineName.Properties as TcxLookupComboBoxProperties)
    .OnEditValueChanged := DoOnIDDisciplineNameChanged;

  clIDDisciplineName.Options.SortByDisplayText := isbtOn;
  clLec.Options.AutoWidthSizable := False;
  clLec.Width := 100;
  clLab.Options.AutoWidthSizable := False;
  clLab.Width := 100;
  clSem.Options.AutoWidthSizable := False;
  clSem.Width := 100;
  clZach.Options.AutoWidthSizable := False;
  clZach.Width := 100;
  clExam.Options.AutoWidthSizable := False;
  clExam.Width := 100;

  clZach.PropertiesClass := TcxCheckBoxProperties;
  (clZach.Properties as TcxCheckBoxProperties).ValueChecked := 2;
  (clZach.Properties as TcxCheckBoxProperties).NullStyle := nssUnchecked;
  (clZach.Properties as TcxCheckBoxProperties).ValueUnchecked := 0;
  (clZach.Properties as TcxCheckBoxProperties).ImmediatePost := True;
  (clZach.Properties as TcxCheckBoxProperties).OnEditValueChanged :=
    DoOnExamChange;

  clExam.PropertiesClass := TcxCheckBoxProperties;
  (clExam.Properties as TcxCheckBoxProperties).ValueChecked := 2;
  (clExam.Properties as TcxCheckBoxProperties).NullStyle := nssUnchecked;
  (clExam.Properties as TcxCheckBoxProperties).ValueUnchecked := 0;
  (clExam.Properties as TcxCheckBoxProperties).ImmediatePost := True;
  (clExam.Properties as TcxCheckBoxProperties).OnEditValueChanged :=
    DoOnExamChange;

  {
    MainView.OptionsData.Deleting := False;
    MainView.OptionsData.Appending := False;
    MainView.OptionsData.Inserting := False;
    MainView.OptionsData.Editing := False;
  }

  DeleteMessages.Add(cxGridLevel, 'Удалить выбранные дисциплины?');

  MyApplyBestFitForView(MainView);

  UpdateView;
end;

procedure TViewDisciplines.ShowDisciplineEditForm(AMode: TMode);
var
  AModel: TCourceDiscNameVM;
  frm: TfrmCourceDiscEdit;
begin
  inherited;

  // Создаём модель для представления
  AModel := Model.CreateCourceDiscNameVM(Self);

  frm := TfrmCourceDiscEdit.Create(AModel);
  try
    frm.Mode := AMode;
    frm.ShowModal;
  finally
    FreeAndNil(AModel);
  end;

  MyApplyBestFitForView(MainView);
  UpdateView;
end;

procedure TViewDisciplines.UpdateView;
var
  AView: TcxGridDBBandedTableView;
  OK: Boolean;
begin
  inherited;
  OK := (Model <> nil) and (Model.CourseStudyPlanW.DataSet.Active) and
    (Model.DiscNameW.DataSet.Active);

  AView := FocusedTableView;

  actAdd.Enabled := OK;

  actEdit.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount = 1);

  actDeleteEx.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount > 0);
end;

end.
