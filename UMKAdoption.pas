unit UMKAdoption;

interface

uses
  EssenceEx, Data.DB, K_Params, System.Classes, Chairs;

type
  TUMKAdoption = class(TEssenceEx2)
  private
    FChairParam: T_KParam;
    FChairs: TChairs;
    FYearParam: T_KParam;
    function GetAdoptionDate: TField;
    function GetProtocol: TField;
  protected
    procedure DoBeforePost(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property AdoptionDate: TField read GetAdoptionDate;
    property ChairParam: T_KParam read FChairParam;
    property Protocol: TField read GetProtocol;
    property YearParam: T_KParam read FYearParam;
  end;

implementation

uses NotifyEvents;

constructor TUMKAdoption.Create(AOwner: TComponent);
var
  Field: TStringField;
begin
  FSynonymFileName := 'UMKAdoptionFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'umka.ID_UMKAdoption';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.UMKADOPTION_SEQ';

  Wrap.ImmediateCommit := True;
  RefreshRecordAfterPost := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('umka.*');

    Tables.Add('UMKADOPTION umka');
  end;

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию

  // Создаём кафедры
  FChairs := TChairs.Create(Self);
  FChairs.Refresh;

  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'Chair';
    Size := 100;
    FieldKind := fkLookup;
    Name := DS.Name + FieldName;
    KeyFields := 'IDChair';
    LookUpDataset := FChairs.DS;
    LookUpKeyFields := 'ID_Chair';
    LookUpResultField := 'Department';
    DataSet := DS;
  end;

  // Исправляем глюк Lookup поля
  DS.FieldByName('Chair').OnGetText := OnLookupGetText;

  DS.FieldByName('Chair').Index := 0;

  KeyFieldProviderFlags := [pfInKey, pfInUpdate];

  FYearParam := T_KParam.Create(Params, 'umka.year');

  FChairParam := T_KParam.Create(Params, 'umka.IDChair');
  FChairParam.ParamName := 'IDChair';

  TNotifyEventWrap.Create(DataSetWrap.BeforePost, DoBeforePost);
end;

procedure TUMKAdoption.DoBeforePost(Sender: TObject);
begin
  Field('Year').Value := FYearParam.ParamValue;
end;

function TUMKAdoption.GetAdoptionDate: TField;
begin
  Result := Field('AdoptionDate');
end;

function TUMKAdoption.GetProtocol: TField;
begin
  Result := Field('Protocol');
end;

end.
