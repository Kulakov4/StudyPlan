unit DiscNameQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, DiscNameInt,
  InsertEditMode;

type
  TDiscNameW = class(TDSWrap)
  private
    FID_DisciplineName: TFieldWrap;
    FDisciplineName: TFieldWrap;
    FShortDisciplineName: TFieldWrap;
    FIDChair: TFieldWrap;
    FType_Discipline: TFieldWrap;
    procedure Append(const ADisciplineName, AShortDisciplineName: String; AIDChair,
        AIDType: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Save(ADiscNameI: IDiscName; AMode: TMode);
    property ID_DisciplineName: TFieldWrap read FID_DisciplineName;
    property DisciplineName: TFieldWrap read FDisciplineName;
    property ShortDisciplineName: TFieldWrap read FShortDisciplineName;
    property IDChair: TFieldWrap read FIDChair;
    property Type_Discipline: TFieldWrap read FType_Discipline;
  end;

  TQryDiscName = class(TQueryBase)
    procedure FDQueryDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure FDQueryPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private
    FW: TDiscNameW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    procedure SearchByType(AIDTypeArr: TArray<Integer>);
    property W: TDiscNameW read FW;
    { Public declarations }
  end;

implementation

uses
  FireDAC.Phys.OracleWrapper, StrHelper;

constructor TDiscNameW.Create(AOwner: TComponent);
begin
  inherited;
  FID_DisciplineName := TFieldWrap.Create(Self, 'ID_DisciplineName', '', True);
  FDisciplineName := TFieldWrap.Create(Self, 'DisciplineName', 'Наименование');
  FShortDisciplineName := TFieldWrap.Create(Self, 'ShortDisciplineName',
    'Сокращение');
  FIDChair := TFieldWrap.Create(Self, 'IDChar', 'Кафедра');
  FType_Discipline := TFieldWrap.Create(Self, 'Type_Discipline');
  // FType_Discipline.DefaultValue := 1;
end;

procedure TDiscNameW.Append(const ADisciplineName, AShortDisciplineName:
    String; AIDChair, AIDType: Integer);
begin
  Assert(not ADisciplineName.IsEmpty);

  TryAppend;
  DisciplineName.F.Value := ADisciplineName;
  ShortDisciplineName.F.Value := AShortDisciplineName;
  IDChair.F.Value := AIDChair;
  Type_Discipline.F.Value := AIDType;
  TryPost;
end;

procedure TDiscNameW.Save(ADiscNameI: IDiscName; AMode: TMode);
begin
  Assert(ADiscNameI <> nil);

  if AMode = EditMode then
  begin
    if ID_DisciplineName.F.AsInteger <> ADiscNameI.ID_DisciplineName then
      ID_DisciplineName.Locate(ADiscNameI.ID_DisciplineName, [], True);
    TryEdit;
  end
  else
    TryAppend;

  try
    DisciplineName.F.AsString := ADiscNameI.DisciplineName;
    ShortDisciplineName.F.AsString := ADiscNameI.ShortDisciplineName;
    IDChair.F.AsInteger := ADiscNameI.IDChair;
    Type_Discipline.F.Value := ADiscNameI.Type_Discipline;
    TryPost;
  except
    TryCancel;
    raise;
  end;
end;

constructor TQryDiscName.Create(AOwner: TComponent);
begin
  inherited;
  FW := TDiscNameW.Create(FDQuery);
  FDQuery.UpdateOptions.KeyFields := W.PKFieldName;
  FDQuery.UpdateOptions.AutoIncFields := W.PKFieldName;
  FDQuery.UpdateOptions.RefreshMode := rmAll;
  FDQuery.UpdateOptions.CheckRequired := False;
end;

procedure TQryDiscName.FDQueryDeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  inherited;
  E.Message :=
    'Дисциплина не может быть удалена, т.к. используется в учебном плане';
end;

{$R *.dfm}

procedure TQryDiscName.FDQueryPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  inherited;
  // Если нарушено ограничение уникальности ORA-0001
  if (E is EOCINativeException) and ((E as EOCINativeException).ErrorCode = 1)
  then
    E.Message := 'Дисциплина с таким наименованием уже есть в базе данных';
end;

procedure TQryDiscName.SearchByType(AIDTypeArr: TArray<Integer>);
var
  ASQL: string;
  S: string;
begin
  Assert(Length(AIDTypeArr) > 0);

  S := Format('%s in (%s)', [W.FType_Discipline.FieldName,
    IntArrToStr(AIDTypeArr, ', ')]);
  ASQL := ReplaceInSQL(SQL, S, 0);

  FDQuery.Open(ASQL);
end;

end.
