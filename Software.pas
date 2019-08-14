unit Software;

interface

uses
  EssenceEx, System.Classes, Data.DB, System.Generics.Collections,
  OrderEssence, K_Params;

type
  TSStartDrag = class
  public
    Keys: array of Integer;
    IDParent: Integer;
  end;

  TSDropDrag = class
  public
    IDParent: Integer;
  end;

  TSRecOrder = class
    Key: Integer;
    IDParent: Integer;
  end;


  TSoftware = class(TEssenceEx2)
  private
    FIsDefaultParam: T_KParam;
    FRecOrderList: TList<TSRecOrder>;
    function GetIDSoftwareType: TField;
    function GetName: TField;
  protected
    procedure CreateIndex; override;
    procedure DoOnUpdateOrder(ARecOrder: TSRecOrder); virtual;
    procedure UpdateOrder;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AppendList(AList: TStringList; AIDSoftwareType: Integer);
    procedure MoveDSRecord(AStartDrag: TSStartDrag; ADropDrag: TSDropDrag);
    property IDSoftwareType: TField read GetIDSoftwareType;
    property IsDefaultParam: T_KParam read FIsDefaultParam;
    property Name: TField read GetName;
  end;

implementation

uses System.SysUtils;

constructor TSoftware.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'SoftwareFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'sw.ID_Software';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  SequenceName := 'cdb_dat_study_process.SOFTWARE_SEQ';

  Wrap.ImmediateCommit := True;
  RefreshRecordAfterPost := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('sw.*');

    Tables.Add('SOFTWARE sw');

  end;

  FIsDefaultParam := T_KParam.Create(Params, 'sw.IsDefault');
  FIsDefaultParam.ParamName := 'IsDefault';

  UpdatingTableName := 'SOFTWARE';
  UpdatingFieldNames.Add('Name');
  UpdatingFieldNames.Add('Description');
  UpdatingFieldNames.Add('IDSoftwareType');

  FRecOrderList := TList<TSRecOrder>.Create;
end;

destructor TSoftware.Destroy;
begin
  inherited;
  FreeAndNil(FRecOrderList);
end;

procedure TSoftware.AppendList(AList: TStringList; AIDSoftwareType: Integer);
var
  i: Integer;
begin
  DS.DisableControls;
  try
    for i := 0 to AList.Count - 1 do
    begin
      DS.Append;
      IDSoftwareType.AsInteger := AIDSoftwareType;
      Name.AsString := AList[i];
      try
        DS.Post;
      except
        DS.Cancel;
      end;
    end;
  finally
    DS.EnableControls;
  end;
end;

procedure TSoftware.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1', 'IDSoftwareType;Name', []);
  ClientDataSet.IndexName := 'idx1';
end;

procedure TSoftware.DoOnUpdateOrder(ARecOrder: TSRecOrder);
begin
  IDSoftwareType.AsInteger := ARecOrder.IDParent;
end;

function TSoftware.GetIDSoftwareType: TField;
begin
  Result := Field('IDSoftwareType');
end;

function TSoftware.GetName: TField;
begin
  Result := Field('Name');
end;

procedure TSoftware.MoveDSRecord(AStartDrag: TSStartDrag; ADropDrag:
    TSDropDrag);
var
  ARecOrder: TSRecOrder;
  I: Integer;
begin
  // Готовимся изменить порядок тех тем, которые переносили
  for I := Low(AStartDrag.Keys) to High(AStartDrag.Keys) do
  begin
    ARecOrder := TSRecOrder.Create;
    ARecOrder.Key := AStartDrag.Keys[I];
    ARecOrder.IDParent := ADropDrag.IDParent;
    FRecOrderList.Add(ARecOrder);
  end;

  // Выполняем все изменения
  UpdateOrder;
end;

procedure TSoftware.UpdateOrder;
var
  I: Integer;
begin
  if FRecOrderList.Count = 0 then
  begin
    Exit;
  end;

  DS.DisableControls;
  try
    Wrap.MyBookmark.Save(KeyFieldName);
    try
      // Теперь поменяем порядок
      for I := 0 to FRecOrderList.Count - 1 do
      begin
        Wrap.LocateAndCheck(KeyFieldName, FRecOrderList[I].Key, []);

        DS.Edit;
        DoOnUpdateOrder(FRecOrderList[I]);
        DS.Post;
      end;

      for I := 0 to FRecOrderList.Count - 1 do
        FRecOrderList[I].Free;
      FRecOrderList.Clear;
    finally
      Wrap.MyBookmark.Restore;
    end;
  finally
    DS.EnableControls;
  end;

end;

end.
