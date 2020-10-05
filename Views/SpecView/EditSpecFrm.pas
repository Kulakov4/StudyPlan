unit EditSpecFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, Vcl.StdCtrls, Vcl.Menus, cxButtons, InsertEditMode,
  System.Generics.Collections, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, SpecQry, SpecInt, cxDBExtLookupComboBox,
  cxDBEdit, SpecEditInterface;

type
  TfrmEditSpec = class(TForm, ISpec)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cxteShortSpeciality: TcxTextEdit;
    btnClose: TcxButton;
    cxlcbChiper: TcxLookupComboBox;
    cxlcbSpeciality: TcxLookupComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxlcbChiperPropertiesChange(Sender: TObject);
  strict private
    function GetIDChair: Integer; stdcall;
    procedure SetIDChair(const Value: Integer); stdcall;
  private
    FEditModeCaption: TDictionary<Integer, String>;
    FIDChair: Integer;
    FInsertModeCaption: TDictionary<Integer, String>;
    FMode: TMode;
    FSpecEditI: ISpecEdit;
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
    property SpecEditI: ISpecEdit read FSpecEditI;
  public
    constructor Create(AOwner: TComponent; ASpecEditI: ISpecEdit; AMode: TMode);
        reintroduce;
    destructor Destroy; override;
    property ChiperSpeciality: string read GetChiperSpeciality
      write SetChiperSpeciality;
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

constructor TfrmEditSpec.Create(AOwner: TComponent; ASpecEditI: ISpecEdit;
    AMode: TMode);
begin
  inherited Create(AOwner);
  Assert(Assigned(ASpecEditI));
  FSpecEditI := ASpecEditI;

  // Выпадающий список уникальных кодов специальностей
  TLCB.Init(cxlcbChiper, FSpecEditI.SpecChiperW.Chiper_Speciality, lsEditList);

  // Выпадающий список уникальных наименований специальностей
  TLCB.Init(cxlcbSpeciality, FSpecEditI.SpecNameUniqueW.Speciality, lsEditList);

  FMode := EditMode;
  Mode := AMode;
end;

procedure TfrmEditSpec.cxlcbChiperPropertiesChange(Sender: TObject);
begin
  cxlcbChiper.PostEditValue;

  if cxlcbChiper.Text = '' then
    Exit;

    // Если есть специальность, соответствующая выбранному коду
  if FSpecEditI.SpecSearchByChiper(cxlcbChiper.Text) > 0 then
  begin
    cxlcbSpeciality.Text := FSpecEditI.SpecW.Speciality.F.AsString;
    cxteShortSpeciality.Text := FSpecEditI.SpecW.SHORT_SPECIALITY.F.AsString;
  end
  else
  begin
    cxlcbSpeciality.Text := '';
    cxteShortSpeciality.Text := '';
  end;
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
    FSpecEditI.SpecByChairW.Save(Self, Mode);
  except
    Action := caNone;
    raise;
  end;
end;

function TfrmEditSpec.GetChiperSpeciality: string;
begin
  Result := cxlcbChiper.Text;
end;

function TfrmEditSpec.GetIDChair: Integer;
begin
  Result := FIDChair;
end;

function TfrmEditSpec.GetSpeciality: string;
begin
  Result := cxlcbSpeciality.Text;
end;

function TfrmEditSpec.GetShortSpeciality: string;
begin
  Result := cxteShortSpeciality.Text;
end;

procedure TfrmEditSpec.SetChiperSpeciality(const Value: string);
begin
  cxlcbChiper.Text := Value;
end;

procedure TfrmEditSpec.SetIDChair(const Value: Integer);
begin
  FIDChair := Value;
end;

procedure TfrmEditSpec.SetSpeciality(const Value: string);
begin
  cxlcbSpeciality.Text := Value;
end;

procedure TfrmEditSpec.SetMode(const Value: TMode);
begin
  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FSpecEditI.SpecByChairW.RecordCount >= 0);

        with FSpecEditI do
        begin
          ChiperSpeciality := SpecByChairW.Chiper_Speciality.F.AsString;
          Speciality := SpecByChairW.Speciality.F.AsString;
          ShortSpeciality := SpecByChairW.SHORT_SPECIALITY.F.AsString;
        end;

        Caption := 'Изменение специальности (направления подготовки)';
      end;
    InsertMode:
      begin
        ChiperSpeciality := '';
        Speciality := '';
        ShortSpeciality := '';
        Caption := 'Новая специальность (направления подготовки)';
      end;
  end;
end;

procedure TfrmEditSpec.SetShortSpeciality(const Value: string);
begin
  cxteShortSpeciality.Text := Value;
end;

end.
