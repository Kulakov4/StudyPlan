unit EditDisciplineFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  Vcl.Menus, cxButtons, DiscNameGroup, FDDumbQuery, InsertEditMode, DiscNameInt;

type
  TfrmEditDisciplineName = class(TForm, IDiscName)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cxdblcbChairs: TcxDBLookupComboBox;
    cxteDisciplineName: TcxTextEdit;
    cxteShortDisciplineName: TcxTextEdit;
    btnClose: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  strict private
    function GetIDChair: Integer; stdcall;
    function GetShortDisciplineName: String; stdcall;
    function GetDisciplineName: string; stdcall;
  private
    FDiscNameGroup: TDiscNameGroup;
    FMode: TMode;
    FqChairDumb: TQueryFDDumb;
    procedure SetDisciplineName(const Value: string);
    procedure SetShortDisciplineName(const Value: String);
    procedure SetIDChair(const Value: Integer);
    property DisciplineName: string read GetDisciplineName
      write SetDisciplineName;
    property IDChair: Integer read GetIDChair write SetIDChair;
    property ShortDisciplineName: String read GetShortDisciplineName
      write SetShortDisciplineName;
    { Private declarations }
  protected
    procedure Check;
    procedure SetMode(const Value: TMode); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    property Mode: TMode read FMode write SetMode;
    { Public declarations }
  published
  end;

implementation

uses
  DBLookupComboBoxHelper, DialogUnit;

{$R *.dfm}

constructor TfrmEditDisciplineName.Create(AOwner: TComponent);
begin
  inherited;
  FDiscNameGroup := AOwner as TDiscNameGroup;

  FMode := InsertMode;

  // **********************************************
  // �������
  // **********************************************
  FqChairDumb := TQueryFDDumb.Create(Self);
  FqChairDumb.Name := 'qChair';

  TDBLCB.Init(cxdblcbChairs, FqChairDumb.DataSource, FqChairDumb.W.ID.FieldName,
    FDiscNameGroup.qChairs.DataSource, FDiscNameGroup.qChairs.W.������������,
    lsFixedList);
end;

procedure TfrmEditDisciplineName.Check;
begin
  if DisciplineName.IsEmpty then
    raise Exception.Create('�� ������ ������������ ����������');

  if IDChair = 0 then
    raise Exception.Create('�� ������� �������');
end;

procedure TfrmEditDisciplineName.FormClose(Sender: TObject;
  var Action: TCloseAction);
//var
//  S: string;
begin
  if ModalResult <> mrOK then
  begin
    // �� ��������� ��������� ��������� � ��
    // Cancel;
    Exit;
  end;

  try
    // ����� �������� ����� ���������� ������ � ��������� Dump ����� ��������� ��������
    btnClose.SetFocus;

    Check;

    // ������ ��������� ������
    FDiscNameGroup.Save(Self, FMode);
  except
    Action := caNone;
    raise;
  end;
end;

function TfrmEditDisciplineName.GetDisciplineName: string;
begin
  Result := cxteDisciplineName.Text;
end;

function TfrmEditDisciplineName.GetIDChair: Integer;
begin
  Result := FqChairDumb.W.ID.F.AsInteger;
end;

function TfrmEditDisciplineName.GetShortDisciplineName: String;
begin
  Result := cxteShortDisciplineName.Text;
end;

procedure TfrmEditDisciplineName.SetDisciplineName(const Value: string);
begin
  cxteDisciplineName.Text := Value;
end;

procedure TfrmEditDisciplineName.SetIDChair(const Value: Integer);
begin
  if IDChair = Value then
    Exit;

  FqChairDumb.W.UpdateID(Value);
end;

procedure TfrmEditDisciplineName.SetMode(const Value: TMode);
begin
  if FMode = Value then
    Exit;

  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FDiscNameGroup.qDiscName.FDQuery.RecordCount >= 0);

        with FDiscNameGroup.qDiscName do
        begin
          DisciplineName := W.DisciplineName.F.AsString;
          ShortDisciplineName := W.ShortDisciplineName.F.AsString;
          SetIDChair(W.IDChair.F.AsInteger);
        end;
        Caption := '��������� ������������ ����������';
      end;
    InsertMode:
      begin
        DisciplineName := '';
        ShortDisciplineName := '';
        SetIDChair(0);
        Caption := '����� ������������ ����������';
      end;
  end;
end;

procedure TfrmEditDisciplineName.SetShortDisciplineName(const Value: String);
begin
  cxteShortDisciplineName.Text := Value;
end;

end.
