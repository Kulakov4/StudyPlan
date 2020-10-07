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
  dxDateRanges, DiscNameQry, InsertEditMode, CourceStudyPlanViewInterface;

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
    FCourceStudyPlanViewI: ICourceStudyPlanView;
    procedure DoOnExamChange(Sender: TObject);
    procedure DoOnIDDisciplineNameChanged(Sender: TObject);
    function GetclExam: TcxGridDBBandedColumn;
    function GetclIDDisciplineName: TcxGridDBBandedColumn;
    function GetclLab: TcxGridDBBandedColumn;
    function GetclLec: TcxGridDBBandedColumn;
    function GetclSem: TcxGridDBBandedColumn;
    function GetclZach: TcxGridDBBandedColumn;
    procedure SetCourceStudyPlanViewI(const Value: ICourceStudyPlanView);
    procedure ShowDisciplineEditForm(AMode: TMode);
    { Private declarations }
  protected
    procedure InitColumns(AView: TcxGridDBBandedTableView); override;
  public
    procedure InitView(AView: TcxGridDBBandedTableView); override;
    procedure UpdateView; override;
    property clExam: TcxGridDBBandedColumn read GetclExam;
    property clIDDisciplineName: TcxGridDBBandedColumn
      read GetclIDDisciplineName;
    property clLab: TcxGridDBBandedColumn read GetclLab;
    property clLec: TcxGridDBBandedColumn read GetclLec;
    property clSem: TcxGridDBBandedColumn read GetclSem;
    property clZach: TcxGridDBBandedColumn read GetclZach;
    property CourceStudyPlanViewI: ICourceStudyPlanView read FCourceStudyPlanViewI
        write SetCourceStudyPlanViewI;
    { Public declarations }
  end;

implementation

uses
  cxDropDownEdit, cxCheckBox, FireDAC.Comp.Client, cxDBLookupComboBox,
  NotifyEvents, CourceDiscEditForm,
  DBLookupComboBoxHelper;

{$R *.dfm}

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
    (CourceStudyPlanViewI.CourseStudyPlanW.ExamData.FieldName);
end;

function TViewDisciplines.GetclIDDisciplineName: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (CourceStudyPlanViewI.CourseStudyPlanW.IDDisciplineName.FieldName);
end;

function TViewDisciplines.GetclLab: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (CourceStudyPlanViewI.CourseStudyPlanW.LabData.FieldName);
end;

function TViewDisciplines.GetclLec: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (CourceStudyPlanViewI.CourseStudyPlanW.LecData.FieldName);
end;

function TViewDisciplines.GetclSem: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (CourceStudyPlanViewI.CourseStudyPlanW.SemData.FieldName);
end;

function TViewDisciplines.GetclZach: TcxGridDBBandedColumn;
begin
  Result := MainView.GetColumnByFieldName
    (CourceStudyPlanViewI.CourseStudyPlanW.ZachData.FieldName);
end;

procedure TViewDisciplines.InitColumns(AView: TcxGridDBBandedTableView);
begin
  inherited;
  // ����������� �������������� ������� ������������ ����������
  TDBLCB.InitColumn(clIDDisciplineName,
    CourceStudyPlanViewI.DiscNameW.DisciplineName, lsEditList).OnEditValueChanged :=
    DoOnIDDisciplineNameChanged;

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

  MyApplyBestFitForView(MainView);
end;

procedure TViewDisciplines.InitView(AView: TcxGridDBBandedTableView);
begin
  inherited;
  AView.OptionsBehavior.CellHints := True;
  DeleteMessages.Add(cxGridLevel, '������� ��������� ����������?');
end;

procedure TViewDisciplines.SetCourceStudyPlanViewI(const Value:
    ICourceStudyPlanView);
begin
  FCourceStudyPlanViewI := Value;

  if FCourceStudyPlanViewI = nil then
  begin
    DSWrap := nil;
    Exit;
  end;

  DSWrap := FCourceStudyPlanViewI.CourseStudyPlanW;

  UpdateView;
end;

procedure TViewDisciplines.ShowDisciplineEditForm(AMode: TMode);
var
  frm: TfrmCourceDiscEdit;
begin
  inherited;

  frm := TfrmCourceDiscEdit.Create(Self,
    FCourceStudyPlanViewI.GetCourceDiscEditI, AMode);
  try
    frm.ShowModal;
  finally
    FreeAndNil(frm);
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
  OK := (FCourceStudyPlanViewI <> nil) and
    (FCourceStudyPlanViewI.CourseStudyPlanW.DataSet.Active) and
    (FCourceStudyPlanViewI.DiscNameW.DataSet.Active);

  AView := FocusedTableView;

  actAdd.Enabled := OK;

  actEdit.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount = 1);

  actDeleteEx.Enabled := OK and (AView <> nil) and
    (AView.Controller.SelectedRowCount > 0);
end;

end.
