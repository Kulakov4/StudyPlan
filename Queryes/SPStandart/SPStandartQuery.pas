unit SPStandartQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TSPStandartW = class(TDSWrap)
  private
    FID_StudyPlanStandart: TFieldWrap;
    FOrd: TFieldWrap;
    FStudyPlanStandart: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Append(const AStudyPlanStandart: String);
    property ID_StudyPlanStandart: TFieldWrap read FID_StudyPlanStandart;
    property Ord: TFieldWrap read FOrd;
    property StudyPlanStandart: TFieldWrap read FStudyPlanStandart;
  end;

  TQuerySPStandart = class(TQueryBase)
  private
    FW: TSPStandartW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TSPStandartW read FW;
    { Public declarations }
  end;

implementation

constructor TSPStandartW.Create(AOwner: TComponent);
begin
  inherited;
  FID_StudyPlanStandart := TFieldWrap.Create(Self, 'ID_StudyPlanStandart',
    '', True);
  FStudyPlanStandart := TFieldWrap.Create(Self, 'StudyPlanStandart',
    'Стандарт');
  FOrd := TFieldWrap.Create(Self, 'Ord');
end;

procedure TSPStandartW.Append(const AStudyPlanStandart: String);
begin
  Assert(not AStudyPlanStandart.IsEmpty);
  TryAppend;
  StudyPlanStandart.F.AsString := AStudyPlanStandart;
  TryPost;
end;

constructor TQuerySPStandart.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSPStandartW.Create(FDQuery);
  FDQuery.UpdateOptions.CheckRequired := False;
  FDQuery.UpdateOptions.AutoIncFields := W.PKFieldName;
  FDQuery.CachedUpdates := True;
end;

{$R *.dfm}

end.
