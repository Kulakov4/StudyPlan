unit SPMainView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, TB2Item, cxLabel, cxDBLabel, cxCheckBox, cxDBEdit, cxTextEdit,
  Vcl.StdCtrls, TB2Dock, TB2Toolbar, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBExtLookupComboBox, SPGroup, SpecEdPopupView,
  cxGridDBBandedTableView, Data.DB, cxDBLookupComboBox, NotifyEvents, SPView2,
  System.Contnrs, System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList,
  cxImageList, OptionsHelper, Vcl.Menus;

type
  TViewSPMain = class(TFrame)
    tbd1: TTBDock;
    tbYear: TTBToolbar;
    tbci1: TTBControlItem;
    lbl1: TLabel;
    tbSpecEducation: TTBToolbar;
    tbci2: TTBControlItem;
    lbl2: TLabel;
    tbShortSpeciality: TTBToolbar;
    TBControlItem7: TTBControlItem;
    Label3: TLabel;
    tbChairs: TTBToolbar;
    TBControlItem9: TTBControlItem;
    Label4: TLabel;
    tbActions: TTBToolbar;
    TBSubmenuItem2: TTBSubmenuItem;
    TBItem6: TTBItem;
    cxdbelcbSpeciality: TcxDBExtLookupComboBox;
    TBControlItem15: TTBControlItem;
    cxdblcbShortSpeciality: TcxDBLookupComboBox;
    TBControlItem1: TTBControlItem;
    cxdblcbChair: TcxDBLookupComboBox;
    TBControlItem2: TTBControlItem;
    cxdblcbYears: TcxDBLookupComboBox;
    TBControlItem3: TTBControlItem;
    ActionList: TActionList;
    actEditStudyPlan: TAction;
    cxImageList: TcxImageList;
    TBItem1: TTBItem;
    actCopyStudyPlan: TAction;
    actDeleteStudyPlan: TAction;
    TBItem2: TTBItem;
    tbIDSpecEd: TTBToolbar;
    cxdblID: TcxDBLabel;
    TBControlItemID: TTBControlItem;
    tbLocked: TTBToolbar;
    TBControlItem4: TTBControlItem;
    cxdbcbLocked: TcxDBCheckBox;
    actCreateStudyPlan: TAction;
    TBItem3: TTBItem;
    PopupMenu: TPopupMenu;
    actShowAll: TAction;
    actActivePlans: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    actLockAllStudyPlans: TAction;
    TBItem4: TTBItem;
    procedure actCopyStudyPlanExecute(Sender: TObject);
    procedure actDeleteStudyPlanExecute(Sender: TObject);
    procedure actEditStudyPlanExecute(Sender: TObject);
    procedure actCreateStudyPlanExecute(Sender: TObject);
    procedure actActivePlansExecute(Sender: TObject);
    procedure actLockAllStudyPlansExecute(Sender: TObject);
    procedure actShowAllExecute(Sender: TObject);
    procedure cxdbelcbSpecialityMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxdbelcbSpecialityPropertiesPopup(Sender: TObject);
    procedure cxdbelcbSpecialityPropertiesChange(Sender: TObject);
    procedure cxdblcbYearsPropertiesChange(Sender: TObject);
  private
    FAccessLevel: TAccessLevel;
    FEventList: TObjectList;
    FSPGroup: TSPGroup;
    FViewSpecEdPopup: TViewSpecEdPopup;
    FViewSP: TviewSP;
    procedure DoOnReportPlanGraphBySpecExec(Sender: TObject);
    procedure SetAccessLevel(const Value: TAccessLevel);
    procedure SetSPGroup(const Value: TSPGroup);
    { Private declarations }
  protected
    procedure CreateStudyPlan; virtual;
    procedure EditStudyPlan; virtual;
    procedure Init; virtual;
    function IsActionsEnabled: Boolean; virtual;
    function IsReadOnly: Boolean; virtual;
    procedure UpdateView; virtual;
    property ViewSpecEdPopup: TViewSpecEdPopup read FViewSpecEdPopup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AccessLevel: TAccessLevel read FAccessLevel write SetAccessLevel;
    property SPGroup: TSPGroup read FSPGroup write SetSPGroup;
    { Public declarations }
  end;

implementation

uses
  DBLookupComboBoxHelper, CopyPlanForm, MessageForm, DialogUnit, System.Types;

{$R *.dfm}

constructor TViewSPMain.Create(AOwner: TComponent);
begin
  inherited;
  FViewSpecEdPopup := TViewSpecEdPopup.Create(Self);

  FViewSP := TviewSP.Create(Self, Self);
  FViewSP.ReadOnly := IsReadOnly;

  FEventList := TObjectList.Create;
  UpdateView;
end;

destructor TViewSPMain.Destroy;
begin
  FreeAndNil(FEventList);
  inherited;
end;

procedure TViewSPMain.actActivePlansExecute(Sender: TObject);
begin
  actActivePlans.Checked := True;
  SPGroup.ActivePlansOnly := True;
end;

procedure TViewSPMain.actCopyStudyPlanExecute(Sender: TObject);
var
  Afrm: TfrmCopyPlan;
  AYear: Integer;
  frmMessage: TfrmMessage;
begin
  Assert(FSPGroup.qSpecEd.FDQuery.RecordCount > 0);

  AYear := 0;
  Afrm := TfrmCopyPlan.Create(Self);
  try
    Afrm.Year := FSPGroup.qSpecEdSimple.W.Year.F.AsInteger + 1;
    if Afrm.ShowModal = mrOk then
    begin
      AYear := Afrm.Year;
    end;
  finally
    FreeAndNil(Afrm);
  end;

  if AYear = 0 then
    Exit;

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
    SPGroup.CopyStudyPlan(AYear);

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

procedure TViewSPMain.actDeleteStudyPlanExecute(Sender: TObject);
begin
  Assert(SPGroup.qSpecEd.FDQuery.RecordCount > 0);

  if not TDialog.Create.DeletePlanDialog
    (SPGroup.qSpecEd.W.SpecialityEx.F.AsString) then
    Exit;

  SPGroup.DeleteStudyPlan;
end;

procedure TViewSPMain.actEditStudyPlanExecute(Sender: TObject);
begin
  EditStudyPlan;
end;

procedure TViewSPMain.actCreateStudyPlanExecute(Sender: TObject);
begin
  CreateStudyPlan;
end;

procedure TViewSPMain.actLockAllStudyPlansExecute(Sender: TObject);
begin
  SPGroup.LockAllStudyPlans;
end;

procedure TViewSPMain.CreateStudyPlan;
begin
end;

procedure TViewSPMain.actShowAllExecute(Sender: TObject);
begin
  actShowAll.Checked := True;
  SPGroup.ActivePlansOnly := False;
end;

procedure TViewSPMain.cxdbelcbSpecialityMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin

  if Button = mbRight then
  begin
    P := cxdbelcbSpeciality.ClientToScreen(Point(X, Y));
    PopupMenu.Popup(P.X, P.Y);
  end;
end;

procedure TViewSPMain.cxdbelcbSpecialityPropertiesChange(Sender: TObject);
begin
  (Sender as TcxDBExtLookupComboBox).PostEditValue;
  FSPGroup.SpecEdDumb.W.TryPost;
  UpdateView;
end;

procedure TViewSPMain.cxdbelcbSpecialityPropertiesPopup(Sender: TObject);
var
  AView: TcxGridDBBandedTableView;
begin
  AView := cxdbelcbSpeciality.Properties.View as TcxGridDBBandedTableView;
  Assert(AView <> nil);
  FViewSpecEdPopup.MyApplyBestFitForView(AView);
end;

procedure TViewSPMain.cxdblcbYearsPropertiesChange(Sender: TObject);
begin
  (Sender as TcxDBLookupComboBox).PostEditValue;
  FSPGroup.YearDumb.W.TryPost;
  UpdateView;
end;

procedure TViewSPMain.DoOnReportPlanGraphBySpecExec(Sender: TObject);
begin
  FSPGroup.DoOnReportPlanGraphBySpecExec;

end;

procedure TViewSPMain.EditStudyPlan;
begin
end;

procedure TViewSPMain.Init;
begin
  // Года
  TDBLCB.Init(cxdblcbYears, FSPGroup.YearDumb.W.ID, FSPGroup.qYears.W.Year,
    lsFixedList);

  // Подключаем выпадающий список планов
  FViewSpecEdPopup.SPGroup := FSPGroup;
  with cxdbelcbSpeciality do
  begin
    DataBinding.DataSource := FSPGroup.SpecEdDumb.W.DataSource;
    DataBinding.DataField := FSPGroup.SpecEdDumb.W.ID.FieldName;
    Properties.DropDownListStyle := lsFixedList;
    Properties.DropDownRows := 24;
    Properties.DropDownSizeable := True;
    Properties.View := FViewSpecEdPopup.MainView;
    Properties.KeyFieldNames := FSPGroup.qSpecEd.W.PKFieldName;
    Properties.ListFieldItem := FViewSpecEdPopup.clSpecialityEx;
  end;

  // Сокращение специальности
  cxdblcbShortSpeciality.Enabled := False;
  TDBLCB.Init(cxdblcbShortSpeciality, FSPGroup.qSpecEdSimple.W.IDSpeciality,
    FSPGroup.qCourceName.W.SHORT_SPECIALITY, lsEditFixedList);

  // Кафедра
  cxdblcbChair.Enabled := False;
  TDBLCB.Init(cxdblcbChair, FSPGroup.qSpecEdSimple.W.IDChair,
    FSPGroup.qAllChairs.W.Наименование, lsEditFixedList);

  // Идентификатор уч. плана
  TDBL.Init(cxdblID, FSPGroup.qSpecEdSimple.DataSource,
    FSPGroup.qSpecEdSimple.W.ID_SPECIALITYEDUCATION);

  // Флажок "Заблокировано"
  TDBChB.Init(cxdbcbLocked, FSPGroup.qSpecEdSimple.DataSource,
    FSPGroup.qSpecEdSimple.W.Locked);

  // Содержимое учебного плана
  FViewSP.SetDocument(FSPGroup.SP);

  TNotifyEventWrap.Create(FViewSP.OnReportPlanGraphBySpecExec,
    DoOnReportPlanGraphBySpecExec, FEventList);
end;

function TViewSPMain.IsActionsEnabled: Boolean;
begin
  Result := False;
end;

function TViewSPMain.IsReadOnly: Boolean;
begin
  Result := True;
end;

procedure TViewSPMain.SetAccessLevel(const Value: TAccessLevel);
begin
  FAccessLevel := Value;
  UpdateView;
end;

procedure TViewSPMain.SetSPGroup(const Value: TSPGroup);
begin
  if FSPGroup = Value then
    Exit;

  FEventList.Clear;
  FSPGroup := Value;

  if FSPGroup = nil then
  begin
    UpdateView;
    Exit;
  end;

  Init;
  UpdateView;
end;

procedure TViewSPMain.UpdateView;
var
  OK: Boolean;
begin
  OK := (FSPGroup <> nil);

  actCreateStudyPlan.Enabled := OK and IsActionsEnabled;
  actEditStudyPlan.Enabled := OK and (FSPGroup.qSpecEd.FDQuery.RecordCount > 0)
    and IsActionsEnabled;
  actCopyStudyPlan.Enabled := OK and (FSPGroup.qSpecEd.FDQuery.RecordCount > 0)
    and IsActionsEnabled;
  actDeleteStudyPlan.Enabled := OK and
    (FSPGroup.qSpecEd.FDQuery.RecordCount > 0) and IsActionsEnabled;
  tbActions.Visible := IsActionsEnabled;

  tbIDSpecEd.Visible := OK and (TOptions.SP.UserName = 'prog1');

  // Галочка "Заблокирован" видна только админам
  tbLocked.Visible := OK and (TOptions.AccessLevel = alAdmin);

  FViewSP.ReadOnly := IsReadOnly;
  FViewSP.UpdateView;
end;

end.
