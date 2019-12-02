unit EditSpecFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, Vcl.StdCtrls, Vcl.Menus, cxButtons, InsertEditMode,
  System.Generics.Collections, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, SpecQry, SpecInt, cxDBExtLookupComboBox,
  SPGroup, FDDumbQuery, cxDBEdit;

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
    function GetChiperSpeciality: string; stdcall;
    function GetSpeciality: string; stdcall;
    function GetShortSpeciality: string; stdcall;
    procedure SetChiperSpeciality(const Value: string);
    procedure SetSpeciality(const Value: string);
    procedure SetShortSpeciality(const Value: string);
    { Private declarations }
  protected
    FSPGroup: TSPGroup;
    procedure Check; virtual;
    procedure SetMode(const Value: TMode); virtual;
  public
    constructor Create(AOwner: TComponent); override;
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

constructor TfrmEditSpec.Create(AOwner: TComponent);
begin
  inherited;
  Assert(AOwner is TSPGroup);
  FSPGroup := AOwner as TSPGroup;

  // Выпадающий список уникальных кодов специальностей
  TLCB.Init(cxlcbChiper, FSPGroup.qSpecChiper.W.DataSource,
    FSPGroup.qSpecChiper.W.Chiper_Speciality, lsEditList);

  // Выпадающий список уникальных наименований специальностей
  TLCB.Init(cxlcbSpeciality, FSPGroup.qSpecName.W.DataSource,
    FSPGroup.qSpecName.W.Speciality, lsEditList);

  FMode := EditMode;
  Mode := InsertMode;
end;

procedure TfrmEditSpec.cxlcbChiperPropertiesChange(Sender: TObject);
begin
  cxlcbChiper.PostEditValue;

  if cxlcbChiper.Text = '' then
    Exit;

    // Если есть специальность, соответствующая выбранному коду
  if FSPGroup.qSpec.SearchByChiper(cxlcbChiper.Text) > 0 then
  begin
    cxlcbSpeciality.Text := FSPGroup.qSpec.W.Speciality.F.AsString;
    cxteShortSpeciality.Text := FSPGroup.qSpec.W.SHORT_SPECIALITY.F.AsString;
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
    FSPGroup.qSpecByChair.W.Save(Self, Mode);
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
  if FMode = Value then
    Exit;

  FMode := Value;

  case FMode of
    EditMode:
      begin
        Assert(FSPGroup.qSpecByChair.FDQuery.RecordCount >= 0);

        with FSPGroup.qSpecByChair do
        begin
          ChiperSpeciality := W.Chiper_Speciality.F.AsString;
          Speciality := W.Speciality.F.AsString;
          ShortSpeciality := W.SHORT_SPECIALITY.F.AsString;
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
