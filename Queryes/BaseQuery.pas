unit BaseQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TParamRec = record
    FieldName: String;
    Value: Variant;
    DataType: TFieldType;
    CaseInsensitive: Boolean;
    FullName: String;
    Operation: String;
  public
    constructor Create(const AFullName: String; const AValue: Variant;
      const ADataType: TFieldType = ftInteger;
      const ACaseInsensitive: Boolean = False; const AOperation: String = '=');
  end;

  TQueryBase = class(TFrame)
    FDQuery: TFDQuery;
  private
    FSQL: string;
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
    procedure Load(const AParamNames: TArray<String>;
      const AParamValues: TArray<Variant>); overload;
    function Search(const AParamNames: TArray<String>;
      const AParamValues: TArray<Variant>; TestResult: Integer = -1)
      : Integer; overload;
    function SearchEx(AParams: TArray<TParamRec>; TestResult: Integer = -1;
      ASQL: String = ''): Integer;
    procedure SetParameters(const AParamNames: TArray<String>;
      const AParamValues: TArray<Variant>);
    function SetParamType(const AParamName: String;
      AParamType: TParamType = ptInput; ADataType: TFieldType = ftInteger)
      : TFDParam;
    { Public declarations }
  end;

implementation

uses
  FireDACDataModule, System.Generics.Collections, System.StrUtils, StrHelper;

{$R *.dfm}

constructor TQueryBase.Create(AOwner: TComponent);
begin
  inherited;

  // ����� ���������� � ����� ������
  if FDQuery.Connection = nil then
    FDQuery.Connection := TFDCon.Create.DM.FDConnection
end;

procedure TQueryBase.AfterConstruction;
begin
  inherited;
  // ��������� �������������� SQL
  FSQL := FDQuery.SQL.Text
end;

procedure TQueryBase.CascadeDelete(const AIDMaster: Variant;
  const ADetailKeyFieldName: String; const AFromClientOnly: Boolean = False);
var
  E: TFDUpdateRecordEvent;
begin
  Assert(AIDMaster > 0);

  E := FDQuery.OnUpdateRecord;
  try
    // ���� ��������� �������� ��� ����������� �� ������� �������
    // ������ ������ ��� ������ � ������� ������ �� �������� �� ������� �������
    if AFromClientOnly then
      FDQuery.OnUpdateRecord := FDQueryUpdateRecordOnClient;

    // ���� ���� ������ ���������� �������
    while FDQuery.LocateEx(ADetailKeyFieldName, AIDMaster, []) do
    begin
      FDQuery.Delete;
    end;

  finally
    if AFromClientOnly then
      FDQuery.OnUpdateRecord := E;
  end;
end;

procedure TQueryBase.DeleteFromClient;
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

procedure TQueryBase.FDQueryUpdateRecordOnClient(ASender: TDataSet;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction;
  AOptions: TFDUpdateRowOptions);
begin
  inherited;
  AAction := eaApplied;
end;

procedure TQueryBase.Load(const AParamNames: TArray<String>;
  const AParamValues: TArray<Variant>);
begin
  FDQuery.DisableControls;
  try
    FDQuery.Close;
    SetParameters(AParamNames, AParamValues);
    FDQuery.Open;
  finally
    FDQuery.EnableControls;
  end;
end;

function TQueryBase.Search(const AParamNames: TArray<String>;
  const AParamValues: TArray<Variant>; TestResult: Integer = -1): Integer;
begin
  Load(AParamNames, AParamValues);

  Result := FDQuery.RecordCount;
  if TestResult >= 0 then
    Assert(Result = TestResult);
end;

function TQueryBase.SearchEx(AParams: TArray<TParamRec>;
  TestResult: Integer = -1; ASQL: String = ''): Integer;
var
  AParamNames: TList<String>;
  AFormatStr: string;
  ANewValue: string;
  ANewSQL: string;
  AValues: TList<Variant>;
  i: Integer;
begin
  Assert(Length(AParams) > 0);

  // ��������������� �������������� SQL ��� ���������� ��������
  ANewSQL := IfThen(ASQL.IsEmpty, SQL, ASQL);

  for i := Low(AParams) to High(AParams) do
  begin
    // ���� �������� ��������� = NULL
    if VarIsNull(AParams[i].Value) then
    begin
      ANewValue := Format('%s is null', [AParams[i].FullName]);
    end
    else
    begin
      // ���� ����� ���������������� � ��������
      if AParams[i].CaseInsensitive then
        AFormatStr := 'upper(%s) %s upper(:%s)'
      else
        AFormatStr := '%s %s :%s';

      ANewValue := Format(AFormatStr, [AParams[i].FullName,
        AParams[i].Operation, AParams[i].FieldName]);
    end;
    // ������ ������ � SQL �������
    ANewSQL := ReplaceInSQL(ANewSQL, ANewValue, i);
  end;

  // ������ SQL ������
  FDQuery.SQL.Text := ANewSQL;

  AParamNames := TList<String>.Create;
  AValues := TList<Variant>.Create;
  try
    // ������ ��������� SQL �������
    for i := Low(AParams) to High(AParams) do
    begin
      if VarIsNull(AParams[i].Value) then
        Continue;

      SetParamType(AParams[i].FieldName, ptInput, AParams[i].DataType);

      AParamNames.Add(AParams[i].FieldName);
      AValues.Add(AParams[i].Value);
    end;

    // ��������� �����
    Result := Search(AParamNames.ToArray, AValues.ToArray, TestResult);
  finally
    FreeAndNil(AParamNames);
    FreeAndNil(AValues);
  end;
end;

procedure TQueryBase.SetParameters(const AParamNames: TArray<String>;
  const AParamValues: TArray<Variant>);
var
  i: Integer;
begin
  Assert(Low(AParamNames) = Low(AParamValues));
  Assert(High(AParamNames) = High(AParamValues));

  for i := Low(AParamNames) to High(AParamNames) do
  begin
    FDQuery.ParamByName(AParamNames[i]).Value := AParamValues[i];
  end;
end;

function TQueryBase.SetParamType(const AParamName: String;
  AParamType: TParamType = ptInput; ADataType: TFieldType = ftInteger)
  : TFDParam;
begin
  Result := FDQuery.FindParam(AParamName);
  Assert(Result <> nil);
  Result.ParamType := AParamType;
  Result.DataType := ADataType;
end;

constructor TParamRec.Create(const AFullName: String; const AValue: Variant;
  const ADataType: TFieldType = ftInteger;
  const ACaseInsensitive: Boolean = False; const AOperation: String = '=');
var
  p: Integer;
begin
  inherited;
  Assert(not AFullName.IsEmpty);
// ������ �������� ������ ��������������!!
//  Assert(not VarIsNull(AValue));

  FullName := AFullName;
  p := FullName.IndexOf('.');
  FieldName := IfThen(p > 0, AFullName.Substring(p + 1), AFullName);
  Value := AValue;
  DataType := ADataType;
  CaseInsensitive := ACaseInsensitive;
  Operation := AOperation;

  if ACaseInsensitive then
    Assert(ADataType = ftWideString);
end;

end.
