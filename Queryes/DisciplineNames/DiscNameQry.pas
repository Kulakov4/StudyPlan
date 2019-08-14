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
    FIDCHAR: TFieldWrap;
    FType_Discipline: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Save(ADiscNameInt: IDiscName; AMode: TMode);
    property ID_DisciplineName: TFieldWrap read FID_DisciplineName;
    property DisciplineName: TFieldWrap read FDisciplineName;
    property ShortDisciplineName: TFieldWrap read FShortDisciplineName;
    property IDCHAR: TFieldWrap read FIDCHAR;
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
    property W: TDiscNameW read FW;
    { Public declarations }
  end;

implementation

uses
  FireDAC.Phys.OracleWrapper;

constructor TDiscNameW.Create(AOwner: TComponent);
begin
  inherited;
  FID_DisciplineName := TFieldWrap.Create(Self, 'ID_DisciplineName', '', True);
  FDisciplineName := TFieldWrap.Create(Self, 'DisciplineName', 'Наименование');
  FShortDisciplineName := TFieldWrap.Create(Self, 'ShortDisciplineName',
    'Сокращение');
  FIDCHAR := TFieldWrap.Create(Self, 'IDCHAR', 'Кафедра');
  FType_Discipline := TFieldWrap.Create(Self, 'Type_Discipline');
  // FType_Discipline.DefaultValue := 1;
end;

procedure TDiscNameW.Save(ADiscNameInt: IDiscName; AMode: TMode);
begin
  Assert(ADiscNameInt <> nil);

  if AMode = EditMode then
    TryEdit
  else
    TryAppend;
  try
    DisciplineName.F.AsString := ADiscNameInt.DisciplineName;
    ShortDisciplineName.F.AsString := ADiscNameInt.ShortDisciplineName;
    IDCHAR.F.AsInteger := ADiscNameInt.IDChair;
    // Type_Discipline.F.Value := Type_Discipline.DefaultValue;
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

end.
