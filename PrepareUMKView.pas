unit PrepareUMKView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewEx, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxLabel, Vcl.ExtCtrls, GridComboBox, DocumentView,
  UMKMaster, Vcl.Menus, System.Actions, Vcl.ActnList, Vcl.StdCtrls, cxButtons,
  cxTextEdit, cxDBEdit, cxMaskEdit, cxSpinEdit, cxCheckBox;

type
  TviewPrepareUMK = class(TView_Ex)
    GridPanel2: TGridPanel;
    Panel1: TPanel;
    cxButton1: TcxButton;
    ActionList1: TActionList;
    actPrepareUMK: TAction;
    GridPanel1: TGridPanel;
    cxLabel1: TcxLabel;
    pnlCreator: TPanel;
    cxdbteCreator: TcxDBTextEdit;
    GridPanel3: TGridPanel;
    cxLabel2: TcxLabel;
    pnlChairMaster: TPanel;
    cxdbteChairMaster: TcxDBTextEdit;
    pnlYear: TPanel;
    cxLabel3: TcxLabel;
    cxseYear: TcxSpinEdit;
    Panel2: TPanel;
    cxcbSave: TcxCheckBox;
    procedure actPrepareUMKExecute(Sender: TObject);
    procedure cxseYearPropertiesEditValueChanged(Sender: TObject);
    procedure cxseYearPropertiesChange(Sender: TObject);
  private
    FcxTeacherComboBoxView: TcxGridComboBoxView;
    FcxChairMasterComboBoxView: TcxGridComboBoxView;
    function GetDocument: TUMKMaster;
    { Private declarations }
  protected
    property Document: TUMKMaster read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

implementation

uses cxDropDownEdit, System.StrUtils;

{$R *.dfm}

constructor TviewPrepareUMK.Create(AOwner: TComponent; AParent: TWinControl;
    AAlign: TAlign = alClient);
begin
  inherited;

  FcxTeacherComboBoxView := TcxGridComboBoxView.Create(Self, pnlCreator);
  with FcxTeacherComboBoxView do
  begin
    Init(lsFixedList, 'FIO');
  end;

  FcxChairMasterComboBoxView := TcxGridComboBoxView.Create(Self, pnlChairMaster);
  with FcxChairMasterComboBoxView do
  begin
    Init(lsFixedList, 'FIO');
  end;
end;

procedure TviewPrepareUMK.cxseYearPropertiesChange(Sender: TObject);
begin
  inherited;
  if FDocument <> nil then
    Document.Year := cxseYear.Value;
end;

procedure TviewPrepareUMK.cxseYearPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  if FDocument <> nil then
    Document.Year := cxseYear.Value;
end;

procedure TviewPrepareUMK.actPrepareUMKExecute(Sender: TObject);
var
  AFileName: string;
begin
  if not Document.CheckSelectedETP then
  begin
    Application.MessageBox('Не заполнены тематические планы', 'Ошибка', MB_OK
      + MB_ICONSTOP);

    Exit;
  end;

  AFileName := IfThen(cxcbSave.Checked, Document.FileName, '');

  Document.PrepareUMK(AFileName);
end;

function TviewPrepareUMK.GetDocument: TUMKMaster;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TUMKMaster;
end;

procedure TviewPrepareUMK.SetDocument(const Value: TDocument);
begin
  inherited;

  if FDocument <> nil then
  begin
    FcxTeacherComboBoxView.SetDocument(Document.ChairTeachers.Wrap);
    FcxChairMasterComboBoxView.SetDocument(Document.ChairMaster.Wrap);

    cxdbteCreator.DataBinding.DataSource := Document.ChairTeachers.Wrap.DataSource;
    cxdbteCreator.DataBinding.DataField := 'Долж_Полн';

    cxdbteChairMaster.DataBinding.DataSource := Document.ChairMaster.Wrap.DataSource;
    cxdbteChairMaster.DataBinding.DataField := 'ЗавКаф_Полн';
    cxseYear.Value := Document.Year;
    cxcbSave.Caption := Format('Сохранить под именем %s', [Document.FileName]);
  end
  else
  begin
    FcxTeacherComboBoxView.SetDocument(nil);
    FcxChairMasterComboBoxView.SetDocument(nil);
    cxdbteCreator.DataBinding.DataSource := nil;
    cxdbteChairMaster.DataBinding.DataSource := nil;
    cxcbSave.Caption := '';
  end;
end;

end.
