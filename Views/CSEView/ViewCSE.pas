unit ViewCSE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData,
  cxStyles, cxTL, cxTLdxBarBuiltInMenu, cxInplaceContainer, cxTLData, cxDBTL,
  CSEQry, cxClasses, dxBar, System.Actions, Vcl.ActnList, cxMaskEdit,
  System.ImageList, Vcl.ImgList, cxImageList, TB2Item, TB2Dock, TB2Toolbar,
  CSEServiceInterface;

type
  TViewCSEFrame = class(TFrame)
    cxDBTreeList: TcxDBTreeList;
    ActionList: TActionList;
    actAddLevel: TAction;
    actAdd: TAction;
    actDelete: TAction;
    actMoveUp: TAction;
    actMoveDown: TAction;
    cxImageList: TcxImageList;
    TBDock1: TTBDock;
    TBToolbar1: TTBToolbar;
    TBItem1: TTBItem;
    TBItem2: TTBItem;
    TBItem3: TTBItem;
    TBItem4: TTBItem;
    TBItem5: TTBItem;
    actCycle: TAction;
    TBItem6: TTBItem;
    procedure actAddExecute(Sender: TObject);
    procedure actAddLevelExecute(Sender: TObject);
    procedure actCycleExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actMoveDownExecute(Sender: TObject);
    procedure actMoveUpExecute(Sender: TObject);
    procedure cxDBTreeListExpanded(Sender: TcxCustomTreeList; ANode:
        TcxTreeListNode);
  private
    FCSEServiceI: ICSEService;
    procedure Add(ASubLevel: Boolean);
    function GetPKValue: Integer;
    function GetW: TCSEWrap;
    procedure SetCSEServiceI(const Value: ICSEService);
    function ShowCycles: Boolean;
    { Private declarations }
  protected
    procedure UpdateView;
  public
    constructor Create(AOwner: TComponent); override;
    property CSEServiceI: ICSEService read FCSEServiceI write SetCSEServiceI;
    property W: TCSEWrap read GetW;
    { Public declarations }
  end;

implementation

uses
  GridViewForm, MyDir, ViewFormEx, CyclesView2, dxCore, CyclesView;

{$R *.dfm}

constructor TViewCSEFrame.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TViewCSEFrame.actAddExecute(Sender: TObject);
begin
  Add(False);
end;

procedure TViewCSEFrame.actAddLevelExecute(Sender: TObject);
begin
  Add(True);
end;

procedure TViewCSEFrame.actCycleExecute(Sender: TObject);
begin
  ShowCycles;
end;

procedure TViewCSEFrame.actDeleteExecute(Sender: TObject);
var
  AID: Integer;
begin
  AID := GetPKValue;
  if AID = 0 then
    Exit;

  W.LocateByPKAndDelete(AID);
  UpdateView;
end;

procedure TViewCSEFrame.actMoveDownExecute(Sender: TObject);
begin
  W.Move(GetPKValue, False);
  UpdateView;
end;

procedure TViewCSEFrame.actMoveUpExecute(Sender: TObject);
begin
  W.Move(GetPKValue, True);
  UpdateView;
end;

procedure TViewCSEFrame.Add(ASubLevel: Boolean);
var
  ACycleID: Integer;
begin
  if not ShowCycles then
    Exit;

  ACycleID := CSEServiceI.CycleService.CycleW.PK.AsInteger;

  // Если в справочнике циклов нет ни одного цикла
  if ACycleID = 0 then
    Exit;

  W.AddLevel(ACycleID, GetPKValue, ASubLevel);
  UpdateView;
end;

procedure TViewCSEFrame.cxDBTreeListExpanded(Sender: TcxCustomTreeList; ANode:
    TcxTreeListNode);
begin
  cxDBTreeList.ApplyBestFit;
end;

function TViewCSEFrame.GetPKValue: Integer;
var
  ACol: TcxDBTreeListColumn;
  V: Variant;
begin
  Result := 0;
  Assert(W <> nil);

  ACol := cxDBTreeList.GetColumnByFieldName(W.PKFieldName);
  Assert(ACol <> nil);

  V := cxDBTreeList.FocusedNode.Values[ACol.ItemIndex];
  if not VarIsNull(V) then
    Result := V;
end;

function TViewCSEFrame.GetW: TCSEWrap;
begin
  Result := FCSEServiceI.CSEWrap;
end;

procedure TViewCSEFrame.SetCSEServiceI(const Value: ICSEService);
var
  ACol: TcxDBTreeListColumn;
begin
  FCSEServiceI := Value;

  if FCSEServiceI = nil then
  begin
    cxDBTreeList.DataController.DataSource := nil;
    Exit;
  end;


  cxDBTreeList.DataController.KeyField :=
    W.ID_CycleSpecialityEducation.FieldName;
  cxDBTreeList.DataController.ParentField :=
    W.IDCycleSpecialityEducation.FieldName;
  cxDBTreeList.DataController.DataSource := W.DataSource;

  cxDBTreeList.DataController.CreateAllItems();
  cxDBTreeList.ApplyBestFit;

  ACol := cxDBTreeList.GetColumnByFieldName(W.IDSpecialityEducation.FieldName);
  ACol.SortOrder := soAscending;

  ACol := cxDBTreeList.GetColumnByFieldName
    (W.IDCycleSpecialityEducation.FieldName);
  ACol.SortOrder := soAscending;

  ACol := cxDBTreeList.GetColumnByFieldName(W.Order.FieldName);
  ACol.SortOrder := soAscending;
end;

function TViewCSEFrame.ShowCycles: Boolean;
var
  F: TfrmGridView;
begin

  F := TfrmGridView.Create(Self, 'Циклы, специализации, профессиональные модули ...',
    TMyDir.AppDataDirFile('NewCycleForm.ini'), [mbOk], 500);
  try
    F.GridViewClass := TViewCycles;
    (F.GridView as TViewCycles).CycleServiceI := CSEServiceI.CycleService;
    F.OKAction := (F.GridView as TViewCycles).actSave;

    Result := F.ShowModal = mrOK;
  finally
    FreeAndNil(F);
  end;

end;

procedure TViewCSEFrame.UpdateView;
var
  OK: Boolean;
begin
  OK := (CSEServiceI <> nil) and (CSEServiceI.CSEWrap.DataSet.Active);

  actAddLevel.Enabled := OK;
  actAdd.Enabled := OK;
  actDelete.Enabled := OK and (cxDBTreeList.FocusedNode <> nil);
end;

end.
