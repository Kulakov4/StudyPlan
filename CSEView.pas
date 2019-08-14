unit CSEView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ViewEx, ExtCtrls, CSE, DocumentView, DataSetControlsView,
  ImgList, TB2Item, ActnList, TB2Dock, TB2Toolbar, DBTreeListView,
  CSEDBTreeListView, cxGraphics, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, dxSkinsCore, dxSkinsDefaultPainters, cxControls,
  cxInplaceContainer, cxTLData, cxDBTL, cxMaskEdit, WSDLBind, NotifyEvents,
  System.Actions, System.ImageList;

type
  TviewCSE = class(TView_Ex)
    pnlMain: TPanel;
    tbdckTop: TTBDock;
    TBToolbar1: TTBToolbar;
    TBItem1: TTBItem;
    TBItem2: TTBItem;
    ActionList1: TActionList;
    actCSEUp: TAction;
    actCSEDown: TAction;
    actAddLevel: TAction;
    TBImageList1: TTBImageList;
    TBToolbar2: TTBToolbar;
    TBItem3: TTBItem;
    actEditLevel: TAction;
    TBItem4: TTBItem;
    procedure actAddLevelExecute(Sender: TObject);
    procedure actCSEDownExecute(Sender: TObject);
    procedure actCSEUpExecute(Sender: TObject);
    procedure actEditLevelExecute(Sender: TObject);
  private
    FAfterInsertWrap: TNotifyEventWrap;
    FCycles: TCycles;
    FCycleTypes: TCycleTypes;
    FDataSetControls_View: TDataSetControls_View;
    FviewDBTreeList: TvwdbtrlstCSE;
    procedure DoAfterInsert(Sender: TObject);
    function GetDocument: TCSE;
    function ShowCycles: Integer;
    { Private declarations }
  protected
    property Document: TCSE read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

implementation

uses ViewFormEx, CyclesView2;

{$R *.dfm}

constructor TviewCSE.Create(AOwner: TComponent; AParent: TWinControl;
  AAlign: TAlign = alClient);
begin
  inherited;
  FDataSetControls_View := TDataSetControls_View.Create(Self, tbdckTop);
  FviewDBTreeList := TvwdbtrlstCSE.Create(Self, pnlMain);

  // Создаём набор циклов и типов циклов
  FCycleTypes := TCycleTypes.Create(Self);
  FCycles := TCycles.Create(Self);
  FCycles.CycleType.Master := FCycleTypes;
  FCycleTypes.Refresh;
  FCycles.Refresh;
end;

procedure TviewCSE.actAddLevelExecute(Sender: TObject);
begin
  FreeAndNil(FAfterInsertWrap);
  if ShowCycles = mrOk then
  begin
    Document.AddLevel(FCycles.PKValue, True);
  end;
  FAfterInsertWrap := TNotifyEventWrap.Create(Document.Wrap.AfterInsert,
    DoAfterInsert, EventsList);
end;

procedure TviewCSE.actCSEDownExecute(Sender: TObject);
begin
  FDataSetControls_View.SetDocument(nil);
  try
    Document.Down;
  finally
    FDataSetControls_View.SetDocument(Document.Wrap);
    FviewDBTreeList.cxdbtlView.FullRefresh;
  end;
end;

procedure TviewCSE.actCSEUpExecute(Sender: TObject);
begin
  FDataSetControls_View.SetDocument(nil);
  try
    Document.Up;
  finally
    FDataSetControls_View.SetDocument(Document.Wrap);
    FviewDBTreeList.cxdbtlView.FullRefresh;
  end;
end;

procedure TviewCSE.actEditLevelExecute(Sender: TObject);
begin
  FreeAndNil(FAfterInsertWrap);
  if ShowCycles = mrOk then
  begin
    Document.EditLevel(FCycles.PKValue);
  end;
  FAfterInsertWrap := TNotifyEventWrap.Create(Document.Wrap.AfterInsert,
    DoAfterInsert, EventsList);
end;

procedure TviewCSE.DoAfterInsert(Sender: TObject);
begin
  FreeAndNil(FAfterInsertWrap);
  try

    if ShowCycles = mrOk then
    begin
      Document.AddLevel(FCycles.PKValue, False);
      Application.ProcessMessages;
    end
    else
      Document.DS.Cancel;

  finally
    FAfterInsertWrap := TNotifyEventWrap.Create(Document.Wrap.AfterInsert,
      DoAfterInsert, EventsList);
  end;
end;

function TviewCSE.GetDocument: TCSE;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TCSE;
end;

procedure TviewCSE.SetDocument(const Value: TDocument);
begin
  inherited;

  if (FDocument <> nil) then
  begin
    FDataSetControls_View.SetDocument(Document.Wrap);
    with FviewDBTreeList do
    begin
      SetDocument(Document.Wrap);
    end;
    FAfterInsertWrap := TNotifyEventWrap.Create(Document.Wrap.AfterInsert,
      DoAfterInsert, EventsList);
  end
  else
  begin
    FDataSetControls_View.SetDocument(nil);
    with FviewDBTreeList do
    begin
      SetDocument(nil);
    end;
  end;
end;

function TviewCSE.ShowCycles: Integer;
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
