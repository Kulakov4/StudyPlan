unit FactorsView2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewEx, StudyPlanFactors, DocumentView,
  DataSetControlsView, FactorEditView, ViewFormEx,
  FactorsDBTreeView, TB2Dock, Vcl.ImgList, TB2Item, Vcl.ActnList, TB2Toolbar,
  NotifyEvents, System.Actions;

const
  WM_AFTER_INSERT = WM_USER + 100;

type
  TviewFactors = class(TView_Ex)
    tbdFactorsTop: TTBDock;
    tbFactors: TTBToolbar;
    alFactors: TActionList;
    actEditFactor: TAction;
    tbilFactors: TTBImageList;
    tbiEditfactor: TTBItem;
    tbiAddLevel: TTBItem;
    actAddLevel: TAction;
    procedure actAddLevelExecute(Sender: TObject);
    procedure actEditFactorExecute(Sender: TObject);
  private
    FAfterInsertWrap: TNotifyEventWrap;
    FdbtlvFactors: TdbtlvFactors;
    FdscvFactors: TDataSetControls_View;
    function GetDocument: TFactors;
    { Private declarations }
  protected
    procedure DoAfterInsert(Sender: TObject);
    procedure DoAfterInsertMessage(var Message: TMessage); message WM_AFTER_INSERT;
    function ShowFactorEditForm: TfrmViewEx;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    property Document: TFactors read GetDocument;
    { Public declarations }
  end;

var
  viewFactors: TviewFactors;

implementation

{$R *.dfm}

constructor TviewFactors.Create(AOwner: TComponent; AParent: TWinControl;
  AAlign: TAlign = alClient);
begin
  inherited;
  FdscvFactors := TDataSetControls_View.Create(Self, tbdFactorsTop);

  FdbtlvFactors := TdbtlvFactors.Create(Self, Self);
end;

procedure TviewFactors.actAddLevelExecute(Sender: TObject);
var
  frmFactorEdit: TfrmViewEx;
begin
  FreeAndNil(FAfterInsertWrap);
  try
    Document.DS.Insert;

    frmFactorEdit := ShowFactorEditForm;
    try
      if frmFactorEdit.ModalResult = mrOk then
      begin
        // ≈сли нужно фактор св€зывать с запросом
        if (frmFactorEdit.View as TviewFactorEdit)
          .viewFactorEditQuery.cxcbQueryLink.Checked then
          Document.Field('IDQuery').Value :=
            (frmFactorEdit.View as TviewFactorEdit)
            .viewFactorEditQuery.Querys.PKValue
        else
          Document.Field('IDQuery').Value := NULL;

        Document.AddLevel(True);
      end
      else
        Document.Wrap.Cancel(True);
    finally
      FreeAndNil(frmFactorEdit);
    end;
  finally
    FAfterInsertWrap := TNotifyEventWrap.Create(Document.Wrap.AfterInsert,
      DoAfterInsert, EventsList);
  end;
end;

procedure TviewFactors.actEditFactorExecute(Sender: TObject);
var
  frmFactorEdit: TfrmViewEx;
begin
  Document.DS.Edit;

  frmFactorEdit := ShowFactorEditForm;
  try
    if frmFactorEdit.ModalResult = mrOk then
    begin
      // ≈сли нужно фактор св€зывать с запросом
      if (frmFactorEdit.View as TviewFactorEdit)
        .viewFactorEditQuery.cxcbQueryLink.Checked then
        Document.Field('IDQuery').Value :=
          (frmFactorEdit.View as TviewFactorEdit)
          .viewFactorEditQuery.Querys.PKValue
      else
        Document.Field('IDQuery').Value := NULL;

      try
        Document.Wrap.Post(True);
      except
        raise;
        Document.Wrap.Cancel(True);
      end;
    end
    else
      Document.Wrap.Cancel(True);
  finally
    FreeAndNil(frmFactorEdit);
  end;
end;

procedure TviewFactors.DoAfterInsert(Sender: TObject);
begin
  // ѕосылаем сообщение, чтобы успело сработать событие AfterScroll
  PostMessage(Handle, WM_AFTER_INSERT, 0, 0);
end;

procedure TviewFactors.DoAfterInsertMessage(var Message: TMessage);
var
  frmFactorEdit: TfrmViewEx;
begin
  FreeAndNil(FAfterInsertWrap);
  frmFactorEdit := ShowFactorEditForm;
  try
    if frmFactorEdit.ModalResult = mrOk then
    begin
      // ≈сли нужно фактор св€зывать с запросом
      if (frmFactorEdit.View as TviewFactorEdit)
        .viewFactorEditQuery.cxcbQueryLink.Checked then
        Document.Field('IDQuery').Value :=
          (frmFactorEdit.View as TviewFactorEdit)
          .viewFactorEditQuery.Querys.PKValue
      else
        Document.Field('IDQuery').Value := NULL;

      Document.AddLevel(False);
    end
    else
      Document.Wrap.Cancel(True);
  finally
    FreeAndNil(frmFactorEdit);
    FAfterInsertWrap := TNotifyEventWrap.Create(Document.Wrap.AfterInsert,
          DoAfterInsert, EventsList);
  end;
end;

function TviewFactors.GetDocument: TFactors;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TFactors;
end;

procedure TviewFactors.SetDocument(const Value: TDocument);
begin
  inherited;

  if FDocument <> nil then
  begin

    FdscvFactors.SetDocument(Document.DataSetWrap);
    FdbtlvFactors.SetDocument(Document.DataSetWrap);

    FAfterInsertWrap := TNotifyEventWrap.Create
      (Document.DataSetWrap.AfterInsert, DoAfterInsert, EventsList);
  end
  else
  begin
    FdscvFactors.SetDocument(nil);
    FdbtlvFactors.SetDocument(nil);
  end;

end;

function TviewFactors.ShowFactorEditForm: TfrmViewEx;
var
  frmFactorEdit: TfrmViewEx;
begin
  // «аранее создаЄм форму и представление дл€ редактировани€ критери€
  frmFactorEdit := TfrmViewEx.Create(Self, '–едактирование критери€',
    'FactorEditForm');
  frmFactorEdit.ViewClass := TviewFactorEdit;
  (frmFactorEdit.View as TviewFactorEdit).SetDocument(Document);
  frmFactorEdit.ModalResult := frmFactorEdit.ShowModal;
  Result := frmFactorEdit;
end;

end.
