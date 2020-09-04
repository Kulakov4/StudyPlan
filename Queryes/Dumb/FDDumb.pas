unit FDDumb;

interface

uses
  FireDAC.Comp.Client, System.Classes, DSWrap;

type
  TDumbW = class(TDSWrap)
  private
    FID: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateID(AID: Integer);
    property ID: TFieldWrap read FID;
  end;

  TStrDumbW = class(TDSWrap)
  private
    FID: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateID(AID: string);
    property ID: TFieldWrap read FID;
  end;

  TFDDumb = class(TFDMemTable)
  private
    FW: TDumbW;
  class var
    FCount: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    property W: TDumbW read FW;
  end;

  TFDStrDumb = class(TFDMemTable)
  private
    FW: TStrDumbW;
  class var
    FCount: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    property W: TStrDumbW read FW;
  end;

implementation

uses
  System.SysUtils, Data.DB;

constructor TFDDumb.Create(AOwner: TComponent);
begin
  inherited;
  Inc(FCount);
  Name := Format('%s_%d', ['FDDumb', FCount]);

  FW := TDumbW.Create(Self);
  FieldDefs.Add(W.ID.FieldName, ftInteger);
  CreateDataSet;
  W.TryAppend;
  W.ID.F.AsInteger := 0;
  W.TryPost;
end;

constructor TDumbW.Create(AOwner: TComponent);
begin
  inherited;
  FID := TFieldWrap.Create(Self, 'ID', '', True);
end;

procedure TDumbW.UpdateID(AID: Integer);
begin
  TryEdit;
  ID.F.AsInteger := AID;
  TryPost;
end;

constructor TFDStrDumb.Create(AOwner: TComponent);
begin
  inherited;
  Inc(FCount);
  Name := Format('%s_%d', ['FDStrDumb', FCount]);

  FW := TStrDumbW.Create(Self);
  FieldDefs.Add(W.ID.FieldName, ftWideString, 300);
  CreateDataSet;
  W.TryAppend;
  W.ID.F.AsString := '0';
  W.TryPost;
end;

constructor TStrDumbW.Create(AOwner: TComponent);
begin
  inherited;
  FID := TFieldWrap.Create(Self, 'ID', '', True);
end;

procedure TStrDumbW.UpdateID(AID: string);
begin
  TryEdit;
  ID.F.AsString := AID;
  TryPost;
end;

end.
