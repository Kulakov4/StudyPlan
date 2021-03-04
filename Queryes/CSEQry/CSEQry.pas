unit CSEQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, NotifyEvents;

type
  TCSEWrap = class(TDSWrap)
  private
    FOrder: TFieldWrap;
    FCycle: TFieldWrap;
    FCycleType: TFieldWrap;
    FIDCycle: TFieldWrap;
    FIDCycleSpecialityEducation: TFieldWrap;
    FIDSpecialityEducation: TFieldWrap;
    FID_CycleSpecialityEducation: TFieldWrap;
    procedure DoAfterInsert(Sender: TObject);
    procedure DoAfterOpen(Sender: TObject);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddLevel(ACycleID, AIDCSE: Integer; ASubLevel: Boolean);
    procedure Move(AID: Integer; AUp: Boolean);
    property Cycle: TFieldWrap read FCycle;
    property CycleType: TFieldWrap read FCycleType;
    property IDCycle: TFieldWrap read FIDCycle;
    property IDCycleSpecialityEducation: TFieldWrap
      read FIDCycleSpecialityEducation;
    property IDSpecialityEducation: TFieldWrap read FIDSpecialityEducation;
    property ID_CycleSpecialityEducation: TFieldWrap
      read FID_CycleSpecialityEducation;
    property Order: TFieldWrap read FOrder;
  end;

  TQueryCSE = class(TQueryBase)
    FDQueryID_CYCLESPECIALITYEDUCATION: TBCDField;
    FDQueryORDER_: TBCDField;
    FDQueryCYCLE: TStringField;
    FDQuerySHORT_CYCLE: TStringField;
    FDQueryCYCLETYPE: TStringField;
    FDQuerySHORTCYCLETYPE: TStringField;
    FDQueryCYCLETYPE_ORD: TFMTBCDField;
    FDQueryIDCYCLE: TBCDField;
    FDQueryIDSPECIALITYEDUCATION: TBCDField;
    FDQueryIDCYCLESPECIALITYEDUCATION: TFMTBCDField;
    FDQueryIDCYCLE_TYPE: TFMTBCDField;
    FDUpdateSQL: TFDUpdateSQL;
  private
    FW: TCSEWrap;
    { Private declarations }
  protected
  public
    constructor Create(AOwner: TComponent); override;
    function SearchByIDSpecEd(AIDSpecEd: Integer): Integer;
    property W: TCSEWrap read FW;
    { Public declarations }
  end;

implementation

constructor TCSEWrap.Create(AOwner: TComponent);
begin
  inherited;
  FID_CycleSpecialityEducation := TFieldWrap.Create(Self,
    'ID_CycleSpecialityEducation', '', True);

  FOrder := TFieldWrap.Create(Self, 'order_', '');
  FCycle := TFieldWrap.Create(Self, 'Cycle', 'Наименование');

  FIDCycleSpecialityEducation := TFieldWrap.Create(Self,
    'IDCycleSpecialityEducation', '');

  FIDSpecialityEducation := TFieldWrap.Create(Self, 'IDSpecialityEducation');

  FCycleType := TFieldWrap.Create(Self, 'ct.cycletype', 'Тип');

  FIDCycle := TFieldWrap.Create(Self, 'cse.idcycle');

  TNotifyEventWrap.Create(AfterOpen, DoAfterOpen);
  TNotifyEventWrap.Create(AfterInsert, DoAfterInsert);
end;

procedure TCSEWrap.AddLevel(ACycleID, AIDCSE: Integer; ASubLevel: Boolean);
var
  AIDParent: Variant;
begin
  Assert(ACycleID > 0);

  AIDParent := NULL;
  if AIDCSE > 0 then
  begin
    LocateByPK(AIDCSE, True);
    if ASubLevel then
      AIDParent := PK.Value
    else
      AIDParent := IDCycleSpecialityEducation.F.Value;
  end;

  TryAppend;
  try
    IDCycle.F.AsInteger := ACycleID;
    IDCycleSpecialityEducation.F.Value := AIDParent;
    TryPost;
  except
    TryCancel;
    raise;
  end;
end;

procedure TCSEWrap.DoAfterOpen(Sender: TObject);
begin
  SetFieldsRequired(False);
end;

constructor TQueryCSE.Create(AOwner: TComponent);
begin
  inherited;
  FW := TCSEWrap.Create(FDQuery);

  FDUpdateSQL.Connection := FDquery.Connection;

  with FDUpdateSQL.Commands[arInsert].ParamByName('NEW_' + W.PKFieldName) do
  begin
    ParamType := ptOutput;
    DataType := ftInteger;
  end;
end;

function TQueryCSE.SearchByIDSpecEd(AIDSpecEd: Integer): Integer;
begin
  // AIDSpecEd будет = 0 если за какой-то год нет учебных планов

  Result := SearchEx([TParamRec.Create(W.IDSpecialityEducation.FullName,
    AIDSpecEd)]);
  W.IDSpecialityEducation.DefaultValue := AIDSpecEd;
end;

{$R *.dfm}

procedure TCSEWrap.DoAfterInsert(Sender: TObject);
begin
  IDSpecialityEducation.F.Value := IDSpecialityEducation.DefaultValue;
end;

procedure TCSEWrap.Move(AID: Integer; AUp: Boolean);
var
  AFilter: string;
  AOrder: Integer;
  AOtherID: Integer;
  AOtherOrder: Integer;
  CW: TCSEWrap;
begin
  LocateByPK(AID, True);
  AFilter := IDCycleSpecialityEducation.FieldName;

  if (IDCycleSpecialityEducation.F.IsNull) then
    AFilter := AFilter + ' is null'
  else
    AFilter := Format('%s = %d',
      [AFilter, IDCycleSpecialityEducation.F.AsInteger]);

  // Создаём отфильтрованный курсор
  CW := TCSEWrap.Create(AddClone(AFilter));
  try
    (CW.DataSet as TFDMemTable).IndexFieldNames := Order.FieldName;

    // Переходим в клоне на нашу запись
      CW.LocateByPK(AID, True);

    if AUp then
    begin
      CW.DataSet.Prior;
      // Если предыдущей записи не существует
      if CW.DataSet.Bof then
        Exit;
    end
    else
    begin
      CW.DataSet.Next;
      // Если следующей записи не существует
      if CW.DataSet.Eof then
        Exit;
    end;

    AOtherID := CW.PK.AsInteger;
  finally
    DropClone(CW.DataSet as TFDMemTable);
  end;

  DataSet.DisableControls;
  try
    // Переходим на нашу запись
    LocateByPK(AID, True);
    // Запоминаем её порядок
    AOrder := Order.F.AsInteger;
    // Меняем её порядок на 0 чтобы не сработало ограничение уникальности
    TryEdit;
    Order.F.AsInteger := 0;
    TryPost;

    // Переходим в клоне на другую запись
    LocateByPK(AOtherID, True);
    // Запоминаем её порядок
    AOtherOrder := Order.F.AsInteger;
    // Меняем её порядок
    TryEdit;
    Order.F.AsInteger := AOrder;
    TryPost;

    // Переходим в клоне на нашу запись
    LocateByPK(AID, True);
    // Меняем её порядок
    TryEdit;
    Order.F.AsInteger := AOtherOrder;
    TryPost;
  finally
    DataSet.EnableControls;
  end;
end;

end.
