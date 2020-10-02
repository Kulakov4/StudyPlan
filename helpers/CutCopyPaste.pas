unit CutCopyPaste;

interface

uses
  Classes, DB;

type
  TDataSetCutCopyPaste = class(TComponent)
  private
    FDataSet: TDataSet;
    FPKFieldName: string;
    function GetCopyOrCutID: Variant;
    function GetPKFieldName: string;
    procedure SetPKFieldName(const Value: string);
  protected
    FCopyID: Variant;
    FCutID: Variant;
    property CopyOrCutID: Variant read GetCopyOrCutID;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Copy;
    procedure Cut;
    function IsCopyEnabled: Boolean; virtual;
    function IsCutEnabled: Boolean; virtual;
    function IsPasteEnabled: Boolean; virtual;
    procedure Paste; virtual;
    property PKFieldName: string read GetPKFieldName write SetPKFieldName;
  end;

implementation

uses SysUtils, Variants;

constructor TDataSetCutCopyPaste.Create(AOwner: TComponent);
begin
  if not (AOwner is TDataSet) then
    raise Exception.Create('Владелец TDataSetCutCopyPaste должен быть класса TDataSet');

  inherited;
      
  FCutID := Unassigned;
  FCopyID := Unassigned;

  FDataSet := AOwner as TDataSet
end;

procedure TDataSetCutCopyPaste.Copy;
begin
  if IsCopyEnabled then
  begin
    FCopyID := FDataSet.FieldByName( PKFieldName ).Value;
    FCutID := Unassigned;
  end;
end;

procedure TDataSetCutCopyPaste.Cut;
begin
  if IsCopyEnabled then
  begin
    FCutID := FDataSet.FieldByName( PKFieldName ).Value;
    FCopyID := Unassigned;
  end;
end;

function TDataSetCutCopyPaste.GetCopyOrCutID: Variant;
begin
  Result := FCopyID;
  if VarType(Result) = varEmpty then
    Result := FCutID;
end;

function TDataSetCutCopyPaste.GetPKFieldName: string;
begin
  if FPKFieldName = '' then
    raise Exception.Create('Не задано ключевое поле для копирования');
  Result := FPKFieldName;
end;

function TDataSetCutCopyPaste.IsCopyEnabled: Boolean;
begin
  Result := FDataSet.RecordCount > 0;
end;

function TDataSetCutCopyPaste.IsCutEnabled: Boolean;
begin
  Result := IsCopyEnabled;
end;

function TDataSetCutCopyPaste.IsPasteEnabled: Boolean;
begin
  Result := ( (VarType(FCopyID) <> varEmpty) or (VarType(FCutID) <> varEmpty) );
end;

procedure TDataSetCutCopyPaste.Paste;
begin
  
end;

procedure TDataSetCutCopyPaste.SetPKFieldName(const Value: string);
begin
  FPKFieldName := Value;
end;

end.
