unit BaseFDQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TQryBase = class(TFrame)
    FDQuery: TFDQuery;
  private
    FDataSource: TDataSource;
    FSQL: string;
    function GetDataSource: TDataSource;
    { Private declarations }
  protected
    procedure FDQueryUpdateRecordOnClient(ASender: TDataSet;
      ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
      AOptions: TFDUpdateRowOptions);
    property SQL: string read FSQL write FSQL;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AfterConstruction; override;
    procedure CascadeDelete(const AIDMaster: Variant;
      const ADetailKeyFieldName: String;
      const AFromClientOnly: Boolean = False);
    procedure DeleteFromClient;
    procedure SetParamType(AParameterName: string;
      ADataType: TFieldType = ftInteger; AParamType: TParamType = ptInput);
    property DataSource: TDataSource read GetDataSource;
    { Public declarations }
  end;

implementation

uses
  FireDACDataModule;

{$R *.dfm}

constructor TQryBase.Create(AOwner: TComponent);
begin
  inherited;
  // Задаём соединение с базой данных
  FDQuery.Connection := TFDCon.Create.DM.FDConnection
end;

procedure TQryBase.AfterConstruction;
begin
  inherited;
  // Сохраняем первоначальный SQL
  FSQL := FDQuery.SQL.Text
end;

procedure TQryBase.CascadeDelete(const AIDMaster: Variant;
  const ADetailKeyFieldName: String; const AFromClientOnly: Boolean = False);
var
  E: TFDUpdateRecordEvent;
begin
  Assert(AIDMaster > 0);

  E := FDQuery.OnUpdateRecord;
  try
    // Если каскадное удаление уже реализовано на стороне сервера
    // Просто удалим эти записи с клиента ничего не сохраняя на стороне сервера
    if AFromClientOnly then
      FDQuery.OnUpdateRecord := FDQueryUpdateRecordOnClient;

    // Пока есть записи подчинённые мастеру
    while FDQuery.LocateEx(ADetailKeyFieldName, AIDMaster, []) do
    begin
      FDQuery.Delete;
    end;

  finally
    if AFromClientOnly then
      FDQuery.OnUpdateRecord := E;
  end;
end;

procedure TQryBase.DeleteFromClient;
var
  E: TFDUpdateRecordEvent;
begin
  Assert(FDQuery.RecordCount > 0);
  E := FDQuery.OnUpdateRecord;
  try
    FDQuery.OnUpdateRecord := FDQueryUpdateRecordOnClient;
    FDQuery.Delete;
  finally
    FDQuery.OnUpdateRecord := E;
  end;
end;

procedure TQryBase.FDQueryUpdateRecordOnClient(ASender: TDataSet;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
  AOptions: TFDUpdateRowOptions);
begin
  inherited;
  AAction := eaApplied;
end;

function TQryBase.GetDataSource: TDataSource;
begin
  if FDataSource = nil then
  begin
    FDataSource := TDataSource.Create(Self);
    FDataSource.DataSet := FDQuery;
  end;
  Result := FDataSource;
end;

procedure TQryBase.SetParamType(AParameterName: string;
  ADataType: TFieldType = ftInteger; AParamType: TParamType = ptInput);
var
  P: TFDParam;
begin
  Assert(not AParameterName.IsEmpty);
  P := FDQuery.ParamByName(AParameterName);
  P.DataType := ADataType;
  P.ParamType := AParamType;
end;

end.
