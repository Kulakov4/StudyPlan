unit CourseNameQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap,
  CourseNameInterface, InsertEditMode;

type
  TCourseNameW = class;

  TQueryCourseName = class(TQueryBase)
  private
    FW: TCourseNameW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function ApplyUpdates: Integer;
    function Search(AEnabled: Boolean = True): Integer;
    function SearchCourceName(AEnabled: Boolean = True): Integer;
    property W: TCourseNameW read FW;
    { Public declarations }
  end;

  TCourseNameW = class(TDSWrap)
  private
    FChiper_Speciality: TFieldWrap;
    FID_Speciality: TFieldWrap;
    FSHORT_SPECIALITY: TFieldWrap;
    FEnable_Speciality: TFieldWrap;
    FSPECIALITY_ACCESS: TFieldWrap;
    FSpeciality: TFieldWrap;
    FCalcSpeciality: TFieldWrap;
    procedure DoAfterOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure FilterByChair(const AIDChair: Integer);
    procedure Save(ACourseNameI: ICourseName; AMode: TMode);
    property Chiper_Speciality: TFieldWrap read FChiper_Speciality;
    property ID_Speciality: TFieldWrap read FID_Speciality;
    property SHORT_SPECIALITY: TFieldWrap read FSHORT_SPECIALITY;
    property Enable_Speciality: TFieldWrap read FEnable_Speciality;
    property SPECIALITY_ACCESS: TFieldWrap read FSPECIALITY_ACCESS;
    property Speciality: TFieldWrap read FSpeciality;
    property CalcSpeciality: TFieldWrap read FCalcSpeciality;
  end;

implementation

uses
  System.Math, NotifyEvents;

constructor TQueryCourseName.Create(AOwner: TComponent);
begin
  inherited;
  FW := TCourseNameW.Create(FDQuery);
  FDQuery.CachedUpdates := True;
  FDQuery.UpdateOptions.AutoIncFields := W.PKFieldName;
  FDQuery.UpdateOptions.RefreshMode := rmOnDemand;
end;

function TQueryCourseName.ApplyUpdates: Integer;
begin
  Assert(FDQuery.CachedUpdates);

  // Наконец-то сохраняем сделанные изменения в БД
  FDQuery.ApplyUpdates(0);
  FDQuery.CommitUpdates;
  Assert(FDQuery.ChangeCount = 0);

  // Тут должен появиться положительный ID
  Assert(W.PK.AsInteger > 0);
  Result := W.PK.AsInteger;
end;

function TQueryCourseName.Search(AEnabled: Boolean = True): Integer;
begin

  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s is not null', [W.Chiper_Speciality.FieldName]));

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('1=1',
    Format('%s = :%s', [W.Enable_Speciality.FieldName,
    W.Enable_Speciality.FieldName]));

  SetParamType(W.Enable_Speciality.FieldName);

  Result := W.Load([W.Enable_Speciality.FieldName], [IfThen(AEnabled, 1, 0)]);
end;

function TQueryCourseName.SearchCourceName(AEnabled: Boolean = True): Integer;
begin
  FDQuery.SQL.Text := SQL; // Восстанавливаем первоначальный SQL
  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('0=0',
    Format('%s is null', [W.Chiper_Speciality.FieldName]));

  FDQuery.SQL.Text := FDQuery.SQL.Text.Replace('1=1',
    Format('%s = :%s', [W.Enable_Speciality.FieldName,
    W.Enable_Speciality.FieldName]));

  SetParamType(W.Enable_Speciality.FieldName);

  Result := W.Load([W.Enable_Speciality.FieldName], [IfThen(AEnabled, 1, 0)]);
end;

constructor TCourseNameW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Speciality := TFieldWrap.Create(Self, 'ID_Speciality');
  PKFieldName := FID_Speciality.FieldName;

  FSpeciality := TFieldWrap.Create(Self, 'Speciality', 'Наименование');
  FSHORT_SPECIALITY := TFieldWrap.Create(Self, 'SHORT_SPECIALITY',
    'Сокращение');
  FSPECIALITY_ACCESS := TFieldWrap.Create(Self, 'SPECIALITY_ACCESS');
  FChiper_Speciality := TFieldWrap.Create(Self, 'Chiper_Speciality', 'Код');
  FEnable_Speciality := TFieldWrap.Create(Self, 'Enable_Speciality');
  FCalcSpeciality := TFieldWrap.Create(Self, 'CalcSpeciality',
    'Наименование и код');

  TNotifyEventWrap.Create(AfterOpen, DoAfterOpen, EventList);
end;

procedure TCourseNameW.DoAfterOpen(Sender: TObject);
begin
  // Это вычисляемое в запросе поле
  CalcSpeciality.F.ProviderFlags := [];
end;

procedure TCourseNameW.FilterByChair(const AIDChair: Integer);
begin
  Assert(AIDChair > 0);

  DataSet.Filter := Format('%s = %d', [SPECIALITY_ACCESS.FieldName, AIDChair]);
  DataSet.Filtered := True;
end;

procedure TCourseNameW.Save(ACourseNameI: ICourseName; AMode: TMode);
begin
  Assert(ACourseNameI <> nil);

  if AMode = EditMode then
  begin
    Assert(ACourseNameI.ID_Speciality > 0);
    if ID_Speciality.F.AsInteger <> ACourseNameI.ID_Speciality then
      ID_Speciality.Locate(ACourseNameI.ID_Speciality, [], True);
    TryEdit;
  end
  else
    TryAppend;

  try
    Speciality.F.AsString := ACourseNameI.Speciality;
    SHORT_SPECIALITY.F.Value := ACourseNameI.ShortSpeciality;
    SPECIALITY_ACCESS.F.Value := ACourseNameI.IDChair;
  except
    TryCancel;
    raise;
  end;
end;

{$R *.dfm}

end.
