unit DiscNameGroup;

interface

uses
  System.Classes, DiscNameQry, ChairsQuery, DiscNameInt, InsertEditMode;

type
  TDiscNameGroup = class(TComponent)
  private
    FqChairs: TQueryChairs;
    FqDiscName: TQryDiscName;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Save(ADiscNameInt: IDiscName; AMode: TMode);
    property qChairs: TQueryChairs read FqChairs;
    property qDiscName: TQryDiscName read FqDiscName;
  end;

implementation

constructor TDiscNameGroup.Create(AOwner: TComponent);
begin
  inherited;
  FqChairs := TQueryChairs.Create(Self);
  FqChairs.W.RefreshQuery;

  FqDiscName := TQryDiscName.Create(Self);
  FqDiscName.SearchByType([1, 2]);
end;

procedure TDiscNameGroup.Save(ADiscNameInt: IDiscName; AMode: TMode);
begin
  Assert(ADiscNameInt <> nil);

  qDiscName.W.Save(ADiscNameInt, AMode);
end;

end.
