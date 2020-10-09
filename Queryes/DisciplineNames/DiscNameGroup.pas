unit DiscNameGroup;

interface

uses
  System.Classes, DiscNameQry, ChairsQuery, DiscNameInt, InsertEditMode,
  DiscNameViewInterface;

type
  TDiscNameGroup = class(TComponent, IDiscNameEdit, IDiscNameView)
  strict private
    function GetChairsW: TChairsW;
    function GetDiscNameEditI(AID_DisciplineName: Integer): IDiscNameEdit;
    function GetDiscNameW: TDiscNameW;
    function GetID_DisciplineName: Integer;
  private
    FID_DisciplineName: Integer;
    FqChairs: TQueryChairs;
    FqDiscName: TQryDiscName;
  public
    constructor Create(AOwner: TComponent); override;
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

function TDiscNameGroup.GetChairsW: TChairsW;
begin
  Result := FqChairs.W;
end;

function TDiscNameGroup.GetDiscNameEditI(AID_DisciplineName: Integer):
    IDiscNameEdit;
begin
  FID_DisciplineName := AID_DisciplineName;
  Result := Self;
end;

function TDiscNameGroup.GetDiscNameW: TDiscNameW;
begin
  Result := FqDiscName.W;
end;

function TDiscNameGroup.GetID_DisciplineName: Integer;
begin
  Result := FID_DisciplineName;
end;

end.
