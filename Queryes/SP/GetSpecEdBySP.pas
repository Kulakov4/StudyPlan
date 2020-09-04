unit GetSpecEdBySP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, SpecEdSimpleWrap;

type
  TGetSpecEdBySPW = class(TSpecEdSimpleW)
  private
    FID_STUDYPLAN: TParamWrap;
  protected
    property ID_STUDYPLAN: TParamWrap read FID_STUDYPLAN;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TQryGetSpecEdBySP = class(TQueryBase)
  private
    FW: TGetSpecEdBySPW;
    { Private declarations }
  protected
  public
    constructor Create(AOwner: TComponent); override;
    function SearchBy(AStudyPlanID: Integer): Integer;
    property W: TGetSpecEdBySPW read FW;
    { Public declarations }
  end;

implementation

{$R *.dfm}

constructor TQryGetSpecEdBySP.Create(AOwner: TComponent);
begin
  inherited;
  FW := TGetSpecEdBySPW.Create(FDQuery);
end;

function TQryGetSpecEdBySP.SearchBy(AStudyPlanID: Integer): Integer;
begin
  Assert(AStudyPlanID > 0);

  Result := SearchEx([TParamRec.Create(W.ID_STUDYPLAN.FullName, AStudyPlanID)]);
end;

constructor TGetSpecEdBySPW.Create(AOwner: TComponent);
begin
  inherited;

  FID_STUDYPLAN := TParamWrap.Create(Self, 'SP.ID_STUDYPLAN');
end;

end.
