unit EditDisciplineFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Vcl.Menus, cxButtons, InsertEditMode,
  DiscNameInt, FDDumb, DiscNameViewInterface;

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
    function GetIDChair: Integer;
    function GetShortDisciplineName: String;
    function GetDisciplineName: string;
    function GetID_DisciplineName: Integer;
    function GetType_Discipline: Integer;
  private
    FDiscNameEditI: IDiscNameEdit;
    FMode: TMode;
    FqChairDumb: TFDDumb;
    FType_Discipline: Integer;
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
    property Mode: TMode read FMode write SetMode;
  public
    constructor Create(AOwner: TComponent; ADiscNameEditI: IDiscNameEdit;
      AMode: TMode); reintroduce;
    { Public declarations }
  published
  end;

implementation

uses
  DBLookupComboBoxHelper, DialogUnit;

{$R *.dfm}

constructor TfrmEditDisciplineName.Create(AOwner: TComponent;
  ADiscNameEditI: IDiscNameEdit; AMode: TMode);
begin
  inherited Create(AOwner);

  Assert(ADiscNameEditI <> nil);
  FDiscNameEditI := ADiscNameEditI;

  // **********************************************
  // Кафедра
  // **********************************************
  FqChairDumb := TFDDumb.Create(Self);

  TDBLCB.Init(cxdblcbChairs, FqChairDumb.W.ID,
    FDiscNameEditI.ChairsW.Наименование, lsFixedList);

  Mode := AMode;
end;

procedure TfrmEditDisciplineName.Check;
begin
  if DisciplineName.IsEmpty then
    raise Exception.Create('Не задано наименование дисциплины');

  if IDChair = 0 then
    raise Exception.Create('Не выбрана кафедра');
end;

procedure TfrmEditDisciplineName.FormClose(Sender: TObject;
  var Action: TCloseAction);
// var
// S: string;
begin
  if ModalResult <> mrOK then
  begin
    // НЕ сохраняем сделанные изменения в БД
    // Cancel;
    Exit;
  end;

  try
    // Чтобы потеряли фокус выпадающие списки и присвоили Dump новое выбранное значение
    btnClose.SetFocus;

    Check;

    // Просим сохранить данные
    FDiscNameEditI.DiscNameW.Save(Self, FMode);
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

function TfrmEditDisciplineName.GetID_DisciplineName: Integer;
begin
  Result := FDiscNameEditI.ID_DisciplineName;
end;

function TfrmEditDisciplineName.GetShortDisciplineName: String;
begin
  Result := cxteShortDisciplineName.Text;
end;

function TfrmEditDisciplineName.GetType_Discipline: Integer;
begin
  Result := FType_Discipline;
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
  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FDiscNameEditI.DiscNameW.RecordCount >= 0);

        with FDiscNameEditI do
        begin
          DisciplineName := DiscNameW.DisciplineName.F.AsString;
          ShortDisciplineName := DiscNameW.ShortDisciplineName.F.AsString;
          SetIDChair(DiscNameW.IDChair.F.AsInteger);
          FType_Discipline := DiscNameW.Type_Discipline.F.AsInteger;
        end;
        Caption := 'Изменение наименования дисциплины';
      end;
    InsertMode:
      begin
        DisciplineName := '';
        ShortDisciplineName := '';
        FType_Discipline := 1;
        SetIDChair(0);
        Caption := 'Новое наименование дисциплины';
      end;
  end;
end;

procedure TfrmEditDisciplineName.SetShortDisciplineName(const Value: String);
begin
  cxteShortDisciplineName.Text := Value;
end;

end.
