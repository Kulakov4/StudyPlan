unit CyclesQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TCycleW = class(TDSWrap)
  private
    FID_Cycle: TFieldWrap;
    FCycle: TFieldWrap;
    FShortCycle: TFieldWrap;
    FIDCycle_Type: TFieldWrap;
    procedure DoAfterInsert(Sender: TObject);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure FilterByCycleType(ACycleTypeID: Integer);
    property Cycle: TFieldWrap read FCycle;
    property IDCycle_Type: TFieldWrap read FIDCycle_Type;
    property ID_Cycle: TFieldWrap read FID_Cycle;
    property ShortCycle: TFieldWrap read FShortCycle;
  end;

  TQueryCycles = class(TQueryBase)
  private
    FW: TCycleW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TCycleW read FW;
    { Public declarations }
  end;

implementation

uses
  NotifyEvents;

constructor TCycleW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Cycle := TFieldWrap.Create(Self, 'ID_Cycle', '', True);
  FCycle := TFieldWrap.Create(Self, 'Cycle', 'Наименование');
  FShortCycle := TFieldWrap.Create(Self, 'Short_Cycle', 'Сокращение');
  FIDCycle_Type := TFieldWrap.Create(Self, 'IDCycle_Type');

  TNotifyEventWrap.Create(AfterInsert, DoAfterInsert, EventList);
end;

procedure TCycleW.DoAfterInsert(Sender: TObject);
begin
  if VarIsNull(IDCycle_Type.DefaultValue) then
    Exit;

  IDCycle_Type.F.Value := IDCycle_Type.DefaultValue;
end;

procedure TCycleW.FilterByCycleType(ACycleTypeID: Integer);
begin
  DataSet.Filter := Format('%s = %d', [IDCycle_Type.FieldName, ACycleTypeID]);
  DataSet.Filtered := True;
  IDCycle_Type.DefaultValue := ACycleTypeID;
end;

constructor TQueryCycles.Create(AOwner: TComponent);
begin
  inherited;
  FW := TCycleW.Create(FDQuery);
  FDQuery.UpdateOptions.CheckRequired := False;
  FDQuery.UpdateOptions.KeyFields := W.PKFieldName;
  FDQuery.UpdateOptions.AutoIncFields := W.PKFieldName;
end;

{$R *.dfm}

end.
