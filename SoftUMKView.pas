unit SoftUMKView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EssenceGridView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, TB2Dock,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  Vcl.ExtCtrls, DocumentView, Vcl.ImgList, System.Actions, Vcl.ActnList,
  DisciplineSoft, Vcl.ToolWin, Vcl.ComCtrls, TB2Item, TB2Toolbar,
  System.ImageList;

type
  TViewSoftUMK = class(TdsgvEssence)
    ImageList: TImageList;
    ActionList: TActionList;
    actAdd: TAction;
    tbMain: TTBToolbar;
    tbiAddSoft: TTBItem;
    actDelete: TAction;
    tbiDelete: TTBItem;
    procedure actAddExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
  private
    function GetDocument: TDisciplineSoft;
    { Private declarations }
  protected
    property Document: TDisciplineSoft read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    procedure UpdateView; override;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ViewFormEx, SoftwareDocument, SoftwareView;

constructor TViewSoftUMK.Create(AOwner: TComponent; AParent: TWinControl;
    AAlign: TAlign = alClient);
begin
  inherited;
  DataSetControls_View.tbDataSet.Visible := False;
end;

procedure TViewSoftUMK.actAddExecute(Sender: TObject);
var
  ASelectedList: TStringList;
  frmSoftware: TfrmViewEx;
  ASoftware: TSoftwareDocument;
  S: string;
begin
  ASoftware := TSoftwareDocument.Create(Self);
  frmSoftware := TfrmViewEx.Create(Self, 'Программное обеспечение',
    'SpecialitySessionsForm', [mbOk]);
  try
    // Получаем список используемого ПО
    S := Document.Wrap.GetColumnValues(Document.IDSoftware.FieldName, #13#10);
    // Выделяем наше по в общем списке
    ASoftware.Software.Wrap.MultiSelectDSWrap.SelectedList.Text := S;

    frmSoftware.ViewClass := TViewSoftware;
    frmSoftware.View.SetDocument(ASoftware);
    if frmSoftware.ShowModal = mrOk then
    begin
      // Получаем список выделенного по
      ASelectedList := ASoftware.Software.Wrap.MultiSelectDSWrap.SelectedList;
      Document.AddSoftware(ASelectedList);
    end;
  finally
    FreeAndNil(frmSoftware);
  end;
  UpdateView;
end;

procedure TViewSoftUMK.actDeleteExecute(Sender: TObject);
var
  AView: TcxGridDBBandedTableView;
  S: string;
begin
  AView := FocusedTableView;
  if AView = nil then
    Exit;

  S := '';
  if AView.Level = cxGridLevel then
    S := 'Удалить ПО из списка необходимых?';

  if (S <> '') and (Application.MessageBox(PWideChar(S), 'Удаление',
    MB_YESNO + MB_ICONQUESTION) = IDYES) and
    (AView.DataController.RecordCount > 0) then
  begin
    if AView.Controller.SelectedRowCount > 0 then
      AView.DataController.DeleteSelection
    else
      AView.DataController.DeleteFocused;

    if (AView.DataController.RecordCount = 0) and (AView.MasterGridRecord <> nil)
    then
    begin
      AView.MasterGridRecord.Collapse(False);
    end;

  end;

  UpdateView;
end;

function TViewSoftUMK.GetDocument: TDisciplineSoft;
begin
  Assert(Esscence <> nil);
  Result := Esscence as TDisciplineSoft;
end;

procedure TViewSoftUMK.SetDocument(const Value: TDocument);
begin

  inherited;

  if FDocument <> nil then
  begin
  end
  else
  begin
  end;

  UpdateView;

end;

procedure TViewSoftUMK.UpdateView;
var
  AView: TcxGridDBBandedTableView;
begin
  AView := FocusedTableView;

  actAdd.Enabled := (FDocument <> nil) and
    (Document.DS.Active) and (AView <> nil) and
    (AView.Level = cxGridLevel);


  actDelete.Enabled := (FDocument <> nil) and (Document.DS.Active)
    and (AView <> nil) and (AView.DataController.RecordCount > 0);
end;

end.
