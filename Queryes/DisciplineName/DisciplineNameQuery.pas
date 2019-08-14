unit DisciplineNameQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TDisciplineNameW = class;

  TQueryDisciplineName = class(TQueryBase)
  private
    FW: TDisciplineNameW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TDisciplineNameW read FW;
    { Public declarations }
  end;

  TDisciplineNameW = class(TDSWrap)
  private
    FID_DisciplineName: TFieldWrap;
    FDisciplineName: TFieldWrap;
    FShortDisciplineName: TFieldWrap;
    FIDChair: TFieldWrap;
    FTypeDiscipline: TFieldWrap;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Append(const ADisciplineName, AShortDisciplineName: String; AIDChair:
        Integer);
    procedure FilterByChair(const AIDChair: Integer);
    procedure UpdateShortCaption(const AShortDisciplineName: String);
    property ID_DisciplineName: TFieldWrap read FID_DisciplineName;
    property DisciplineName: TFieldWrap read FDisciplineName;
    property ShortDisciplineName: TFieldWrap read FShortDisciplineName;
    property IDChair: TFieldWrap read FIDChair;
    property TypeDiscipline: TFieldWrap read FTypeDiscipline;
  end;

implementation

uses
  NotifyEvents;

constructor TDisciplineNameW.Create(AOwner: TComponent);
begin
  inherited;
  FID_DisciplineName := TFieldWrap.Create(Self, 'ID_DisciplineName');
  PKFieldName := FID_DisciplineName.FieldName;
  FDisciplineName := TFieldWrap.Create(Self, 'DisciplineName', 'Наименование дисциплины');
  FShortDisciplineName := TFieldWrap.Create(Self, 'ShortDisciplineName', 'Сокращение');
  FIDChair := TFieldWrap.Create(Self, 'IDChar');
  FTypeDiscipline := TFieldWrap.Create(Self, 'Type_Discipline');
end;

procedure TDisciplineNameW.Append(const ADisciplineName, AShortDisciplineName:
    String; AIDChair: Integer);
begin
  Assert(not ADisciplineName.IsEmpty);

  TryAppend;
  DisciplineName.F.Value := ADisciplineName;
  ShortDisciplineName.F.Value := AShortDisciplineName;
  IDChair.F.Value := AIDChair;
  TypeDiscipline.F.Value := 3;
  TryPost;
end;

procedure TDisciplineNameW.FilterByChair(const AIDChair: Integer);
begin
  Assert(AIDChair > 0);

  DataSet.Filter := Format('%s = %d', [IDChair.FieldName, AIDChair]);
  DataSet.Filtered := True;
end;

procedure TDisciplineNameW.UpdateShortCaption(const AShortDisciplineName:
    String);
begin
  TryEdit;
  ShortDisciplineName.F.AsString := AShortDisciplineName;
  TryPost;
end;

constructor TQueryDisciplineName.Create(AOwner: TComponent);
begin
  inherited;
  FW := TDisciplineNameW.Create(FDQuery);
  FDQuery.CachedUpdates := True;
end;

{$R *.dfm}

end.
