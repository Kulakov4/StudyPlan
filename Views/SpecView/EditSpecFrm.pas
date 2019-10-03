unit EditSpecFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, Vcl.StdCtrls, Vcl.Menus, cxButtons, InsertEditMode,
  System.Generics.Collections, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, SpecQry, SpecInt, cxDBExtLookupComboBox;

type
  TfrmEditSpec = class(TForm, ISpec)
    cxteChiperSpeciality: TcxTextEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cxteSpeciality: TcxTextEdit;
    cxteShortSpeciality: TcxTextEdit;
    btnClose: TcxButton;
    cxlcbChiper: TcxLookupComboBox;
    cxlcbSpeciality: TcxLookupComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  strict private
  private
    FEditModeCaption: TDictionary<Integer, String>;
    FIDEdLvl: Integer;
    FInsertModeCaption: TDictionary<Integer, String>;
    FMode: TMode;
    FQrySpec: TQrySpec;
    function GetChiperSpeciality: string; stdcall;
    function GetSpeciality: string; stdcall;
    function GetShortSpeciality: string; stdcall;
    procedure SetChiperSpeciality(const Value: string);
    procedure SetSpeciality(const Value: string);
    procedure SetShortSpeciality(const Value: string);
    { Private declarations }
  protected
    procedure Check; virtual;
    procedure SetMode(const Value: TMode); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ChiperSpeciality: string read GetChiperSpeciality
      write SetChiperSpeciality;
    property IDEdLvl: Integer read FIDEdLvl write FIDEdLvl;
    property Speciality: string read GetSpeciality write SetSpeciality;
    property Mode: TMode read FMode write SetMode;
    property ShortSpeciality: string read GetShortSpeciality
      write SetShortSpeciality;
    { Public declarations }
  end;

implementation

uses
  System.StrUtils, DBLookupComboBoxHelper;

{$R *.dfm}

constructor TfrmEditSpec.Create(AOwner: TComponent);
begin
  inherited;
  Assert(AOwner is TQrySpec);
  FQrySpec := AOwner as TQrySpec;

  TLCB.Init(cxlcbChiper, FQrySpec.W.DataSource, FQrySpec.W.Chiper_Speciality,
    lsEditList);

  TLCB.Init(cxlcbSpeciality, FQrySpec.W.DataSource, FQrySpec.W.Speciality,
    lsEditList);

  FIDEdLvl := 2;

  FEditModeCaption := TDictionary<Integer, String>.Create;
  FEditModeCaption.Add(1, 'Изменение специальности');
  FEditModeCaption.Add(2, 'Изменение направления подготовки');
  FEditModeCaption.Add(3, 'Изменение специальности');
  FEditModeCaption.Add(5, 'Изменение направления переподготовки');

  FInsertModeCaption := TDictionary<Integer, String>.Create;
  FInsertModeCaption.Add(1, 'Новая специальность');
  FInsertModeCaption.Add(2, 'Новое направление подготовки');
  FInsertModeCaption.Add(3, 'Новая специальность');
  FInsertModeCaption.Add(5, 'Новое направление переподготовки');

  FMode := EditMode;
  Mode := InsertMode;

end;

destructor TfrmEditSpec.Destroy;
begin
  inherited;
  FreeAndNil(FEditModeCaption);
  FreeAndNil(FInsertModeCaption)
end;

procedure TfrmEditSpec.Check;
begin
  if Speciality.IsEmpty then
    raise Exception.Create('Не задано наименование направления подготовки');

  if ShortSpeciality.IsEmpty then
    raise Exception.Create('Не задано сокращение направления подготовки');
end;

procedure TfrmEditSpec.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOK then
  begin
    // НЕ сохраняем сделанные изменения в БД
    Exit;
  end;

  try
    // Чтобы потеряли фокус выпадающие списки и присвоили Dump новое выбранное значение
    btnClose.SetFocus;

    Check;

    // Просим сохранить данные
    FQrySpec.Save(Self, FMode);
  except
    Action := caNone;
    raise;
  end;
end;

function TfrmEditSpec.GetChiperSpeciality: string;
begin
  Result := cxteChiperSpeciality.Text;
end;

function TfrmEditSpec.GetSpeciality: string;
begin
  Result := cxteSpeciality.Text;
end;

function TfrmEditSpec.GetShortSpeciality: string;
begin
  Result := cxteShortSpeciality.Text;
end;

procedure TfrmEditSpec.SetChiperSpeciality(const Value: string);
begin
  cxteChiperSpeciality.Text := Value;
end;

procedure TfrmEditSpec.SetSpeciality(const Value: string);
begin
  cxteSpeciality.Text := Value;
end;

procedure TfrmEditSpec.SetMode(const Value: TMode);
begin
  if FMode = Value then
    Exit;

  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FQrySpec.FDQuery.RecordCount >= 0);

        with FQrySpec do
        begin
          ChiperSpeciality := W.Chiper_Speciality.F.AsString;
          Speciality := W.Speciality.F.AsString;
          ShortSpeciality := W.SHORT_SPECIALITY.F.AsString;
        end;

        Caption := FEditModeCaption[FIDEdLvl];
      end;
    InsertMode:
      begin
        ChiperSpeciality := '';
        Speciality := '';
        ShortSpeciality := '';
        Caption := FInsertModeCaption[FIDEdLvl]
      end;
  end;
end;

procedure TfrmEditSpec.SetShortSpeciality(const Value: string);
begin
  cxteShortSpeciality.Text := Value;
end;

end.
