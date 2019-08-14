unit ThemeUnionDetails;

interface

uses
  EssenceEx, Datasnap.DBClient, K_Params, Data.DB;

type
  TThemeUnionDetails = class(TEssenceEx2)
  private
    function GetIDThemeUnion: TField;
  protected
    FIDDisciplineParam: T_KParam;
    function GetValue: TField; virtual; abstract;
    function HaveSameRecord(AIDThemeUnion: Integer; AValue: Variant)
      : Boolean; overload;
  public
    procedure CascadeDelete(AIDMaster: Integer); override;
    procedure CopyFrom(ASource: TThemeUnionDetails;
      ASourceIDThemeUnion, ADestIDThemeUnion: Integer);
    function CreateCloneByThemeUnion(AIDThemeUnion: Integer): TClientDataSet;
    function GetFilterExpression(AIDThemeUnion: Integer): String;
    property IDDisciplineParam: T_KParam read FIDDisciplineParam;
    property IDThemeUnion: TField read GetIDThemeUnion;
    property Value: TField read GetValue;
  end;

implementation

uses System.SysUtils, DBRecordHolder;

procedure TThemeUnionDetails.CascadeDelete(AIDMaster: Integer);
var
  AClientDataSet: TClientDataSet;
begin
  inherited;
  // Каскадно удаляем все темы
  AClientDataSet := CreateCloneByThemeUnion(AIDMaster);
  try
    while not AClientDataSet.Eof do
    begin
      AClientDataSet.Delete;
    end;
  finally
    FreeAndNil(AClientDataSet);
  end;
end;

procedure TThemeUnionDetails.CopyFrom(ASource: TThemeUnionDetails;
  ASourceIDThemeUnion, ADestIDThemeUnion: Integer);
var
  ARecordHolder: TRecordHolder;

  AThemeUnionTechnologies: TClientDataSet;
begin
  Assert(ASource <> nil);
  Assert(ASourceIDThemeUnion > 0);
  Assert(ADestIDThemeUnion > 0);

  ARecordHolder := TRecordHolder.Create();
  AThemeUnionTechnologies := ASource.CreateClone;
  try
    // Фильтруем источник по коду ДЕ
    AThemeUnionTechnologies.Filter := ASource.GetFilterExpression
      (ASourceIDThemeUnion);
    AThemeUnionTechnologies.Filtered := True;
    AThemeUnionTechnologies.First;
    while not AThemeUnionTechnologies.Eof do
    begin
      // Добавляем такой-же текущий контроль
      if not HaveSameRecord(ADestIDThemeUnion,
        AThemeUnionTechnologies.FieldByName(Value.FieldName).Value) then
      begin
        // Запоминаем запись
        ARecordHolder.Attach(AThemeUnionTechnologies);

        // Меняем код ДЕ
        ARecordHolder.Field['IDThemeUnion'] := ADestIDThemeUnion;

        AddSameRecord(ARecordHolder);
      end;
      AThemeUnionTechnologies.Next;
    end;
  finally
    FreeAndNil(AThemeUnionTechnologies);
    FreeAndNil(ARecordHolder);

  end;

end;

function TThemeUnionDetails.CreateCloneByThemeUnion(AIDThemeUnion: Integer)
  : TClientDataSet;
begin
  Result := CreateClone;
  Result.Filter := GetFilterExpression(AIDThemeUnion);
  Result.Filtered := True;
end;

function TThemeUnionDetails.GetFilterExpression(AIDThemeUnion: Integer): String;
begin
  Result := Format('IDThemeUnion = %d', [AIDThemeUnion]);
end;

function TThemeUnionDetails.GetIDThemeUnion: TField;
begin
  Result := Field('IDThemeUnion');
end;

function TThemeUnionDetails.HaveSameRecord(AIDThemeUnion: Integer;
  AValue: Variant): Boolean;
var
  ARecordHolder: TRecordHolder;
begin
  ARecordHolder := TRecordHolder.Create();
  try
    // Будем искать по двум полям
    TFieldHolder.Create(ARecordHolder, IDThemeUnion.FieldName, AIDThemeUnion);
    TFieldHolder.Create(ARecordHolder, Value.FieldName, AValue);

    Result := HaveSameRecord(ARecordHolder);
  finally
    FreeAndNil(ARecordHolder);
  end;
end;

end.
