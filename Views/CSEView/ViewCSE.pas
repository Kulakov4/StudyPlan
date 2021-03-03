unit ViewCSE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, cxInplaceContainer, cxTLData, cxDBTL, CSEQry, cxClasses,
  dxBar, System.Actions, Vcl.ActnList, CSE, cxMaskEdit, System.ImageList,
  Vcl.ImgList, cxImageList, TB2Item, TB2Dock, TB2Toolbar;

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
    procedure actAddExecute(Sender: TObject);
    procedure actAddLevelExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actMoveDownExecute(Sender: TObject);
    procedure actMoveUpExecute(Sender: TObject);
    procedure cxDBTreeListExpanded(Sender: TcxCustomTreeList; ANode:
        TcxTreeListNode);
  private
    FW: TCSEWrap;
    FCycles: TCycles;
    FCycleTypes: TCycleTypes;
    function GetPKValue: Integer;
    procedure SetW(const Value: TCSEWrap);
    function ShowCycles: Integer;
    { Private declarations }
  protected
  public
    constructor Create(AOwner: TComponent); override;
    property W: TCSEWrap read FW write SetW;
    { Public declarations }
  end;

implementation

uses
  GridViewForm, MyDir, ViewFormEx, CyclesView2, dxCore;

{$R *.dfm}

constructor TViewCSEFrame.Create(AOwner: TComponent);
begin
  inherited;
  // Создаём набор циклов и типов циклов
  FCycleTypes := TCycleTypes.Create(Self);
  FCycles := TCycles.Create(Self);
  FCycles.CycleType.Master := FCycleTypes;
  FCycleTypes.Refresh;
  FCycles.Refresh;
end;

procedure TViewCSEFrame.actAddExecute(Sender: TObject);
begin
  if ShowCycles <> mrOk then
    Exit;

  W.AddLevel(FCycles.PKValue, GetPKValue, False);
end;

procedure TViewCSEFrame.actAddLevelExecute(Sender: TObject);
begin
  if ShowCycles <> mrOk then
    Exit;

  W.AddLevel(FCycles.PKValue, GetPKValue, True);
end;

procedure TViewCSEFrame.actDeleteExecute(Sender: TObject);
var
  AID: Integer;
begin
  AID := GetPKValue;
  if AID = 0 then
    Exit;

  W.LocateByPKAndDelete(AID);
end;

procedure TViewCSEFrame.actMoveDownExecute(Sender: TObject);
begin
  W.Move(GetPKValue, False);
end;

procedure TViewCSEFrame.actMoveUpExecute(Sender: TObject);
begin
  W.Move(GetPKValue, True);
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

procedure TViewCSEFrame.SetW(const Value: TCSEWrap);
var
  ACol: TcxDBTreeListColumn;
begin
  FW := Value;

  if FW = nil then
  begin
    cxDBTreeList.DataController.DataSource := nil;
    Exit;
  end;

  cxDBTreeList.DataController.KeyField :=
    FW.ID_CycleSpecialityEducation.FieldName;
  cxDBTreeList.DataController.ParentField :=
    FW.IDCycleSpecialityEducation.FieldName;
  cxDBTreeList.DataController.DataSource := FW.DataSource;

  cxDBTreeList.DataController.CreateAllItems();
  cxDBTreeList.ApplyBestFit;

  ACol := cxDBTreeList.GetColumnByFieldName(FW.IDSpecialityEducation.FieldName);
  ACol.SortOrder := soAscending;

  ACol := cxDBTreeList.GetColumnByFieldName
    (FW.IDCycleSpecialityEducation.FieldName);
  ACol.SortOrder := soAscending;

  ACol := cxDBTreeList.GetColumnByFieldName(FW.Order.FieldName);
  ACol.SortOrder := soAscending;
end;

function TViewCSEFrame.ShowCycles: Integer;
var
  frmCycles: TfrmViewEx;
begin
  frmCycles := TfrmViewEx.Create(Self,
    'Циклы, специализации, профессиональные модули ...', 'CycleForm');
  try
    frmCycles.ViewClass := TdsgvCycles;
    frmCycles.View.SetDocument(FCycles);
    Result := frmCycles.ShowModal;
  finally
    frmCycles.Free;
  end;
end;

end.
