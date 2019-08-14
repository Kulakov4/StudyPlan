unit RearrangeUnit;

interface

uses System.Generics.Collections;

type
  TSplitData = class(TObject)
  private
  public
    ID: Integer;
    Part: Integer;
    Proportion: Double;
    constructor Create(AID: Integer; AProportion: Double; APart: Integer = 0);
  end;

  TRearrange = class(TObject)
  public
    procedure Split(AValue: Integer; ASplitData: TObjectList<TSplitData>);
  end;

implementation

procedure TRearrange.Split(AValue: Integer; ASplitData:
    TObjectList<TSplitData>);
var
  I: Integer;
  max: Integer;
  maxi: Integer;
  Part: Integer;
  SumPart: Integer;
begin
  Assert(AValue <> 0);

  SumPart := 0;
  for I := 0 to ASplitData.Count - 1 do
  begin
    Part := Round( AValue * ASplitData[i].Proportion );
    if SumPart + Part > AValue then
      Part := AValue - SumPart;

    ASplitData[i].Part := Part;

    Inc(SumPart, Part);
  end;

  // ���� �� �� ����� ������������
  if SumPart < AValue then
  begin
    maxi := 0;
    max := ASplitData[maxi].Part;
    // ���� ������ ������������ �����
    for I := 0 to ASplitData.Count - 1 do
    begin
      if ASplitData[i].Part > max then
      begin
        maxi := i;
        max := ASplitData[i].Part;
      end;
    end;

    //���������� �������� � ������������ �����
    Inc(ASplitData[maxi].Part, AValue - SumPart);
  end;
end;

constructor TSplitData.Create(AID: Integer; AProportion: Double; APart: Integer
    = 0);
begin
  ID := AID;
  Proportion := AProportion;
  Part := APart;
end;

end.
