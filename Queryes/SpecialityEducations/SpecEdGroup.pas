unit SpecEdGroup;

interface

uses
  System.Classes, SpecEdQuery, ChairsQuery, CourceNameQuery;

type
  TSpecEdGroup = class(TComponent)
  private
    FqChairs: TQueryChairs;
    FqCourceName: TQueryCourceName;
    FqSpecEd: TQuerySpecEd;
  public
    constructor Create(AOwner: TComponent); override;
    property qChairs: TQueryChairs read FqChairs;
    property qCourceName: TQueryCourceName read FqCourceName;
    property qSpecEd: TQuerySpecEd read FqSpecEd;
  end;

implementation

constructor TSpecEdGroup.Create(AOwner: TComponent);
begin
  inherited;
  // ������� ����� (������)
  FqSpecEd := TQuerySpecEd.Create(Self);
  FqSpecEd.W.RefreshQuery;

  // �������
  FqChairs := TQueryChairs.Create(Self);
  FqChairs.W.RefreshQuery;

  // �������� ��������������
  FqCourceName := TQueryCourceName.Create(Self);
  FqCourceName.Search();

end;

end.
