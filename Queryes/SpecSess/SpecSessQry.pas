unit SpecSessQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap, DBRecordHolder,
  MaxSpecSessQry, SpecEdSimpleQuery;

type
  TAppendSpecSess = (assLevel, assSession);

  TSpecSessW = class(TDSWrap)
  private
    FAppendSpecSess: TAppendSpecSess;
    FIDSpecialityEducation: TFieldWrap;
    FID_SpecialitySession: TFieldWrap;
    FLevel_: TFieldWrap;
    FLevel_year: TFieldWrap;
    FQryMaxSpecSess: TQryMaxSpecSess;
    FQrySpecEdSimple: TQuerySpecEdSimple;
    FRecordHolder: TRecordHolder;
    FSession_: TFieldWrap;
    FSession_in_level: TFieldWrap;
    procedure DoAfterInsert(Sender: TObject);
    procedure DoAfterOpen(Sender: TObject);
    procedure DoBeforeInsert(Sender: TObject);
    function GetAdmissionYear: Integer;
    function GetMaxSessionInLevel(ALevel: Integer): Integer;
    function GetQryMaxSpecSess: TQryMaxSpecSess;
    function GetQrySpecEdSimple: TQuerySpecEdSimple;
  protected
    property QryMaxSpecSess: TQryMaxSpecSess read GetQryMaxSpecSess;
    property QrySpecEdSimple: TQuerySpecEdSimple read GetQrySpecEdSimple;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update(const AFieldName: string; AOldValue, ANewValue: Integer);
    property AppendSpecSess: TAppendSpecSess read FAppendSpecSess
      write FAppendSpecSess;
    property IDSpecialityEducation: TFieldWrap read FIDSpecialityEducation;
    property ID_SpecialitySession: TFieldWrap read FID_SpecialitySession;
    property Level_: TFieldWrap read FLevel_;
    property Level_year: TFieldWrap read FLevel_year;
    property Session_: TFieldWrap read FSession_;
    property Session_in_level: TFieldWrap read FSession_in_level;
  end;

  TQrySpecSess = class(TQueryBase)
    procedure FDQueryPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private
    FW: TSpecSessW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function SearchBySpecEd(AIDSpecEd: Integer): Integer;
    property W: TSpecSessW read FW;
    { Public declarations }
  end;

implementation

uses
  NotifyEvents, System.StrUtils, System.Math, FireDAC.Phys.OracleWrapper;

constructor TSpecSessW.Create(AOwner: TComponent);
begin
  inherited;
  FID_SpecialitySession := TFieldWrap.Create(Self, 'ID_SpecialitySession',
    '', True);
  FLevel_ := TFieldWrap.Create(Self, 'Level_', '№ курса');
  FLevel_year := TFieldWrap.Create(Self, 'Level_year', 'Год проведения');
  FSession_in_level := TFieldWrap.Create(Self, 'Session_in_level',
    'Сессия в курсе');
  FSession_ := TFieldWrap.Create(Self, 'Session_', 'Наименование сессии');
  FIDSpecialityEducation := TFieldWrap.Create(Self, 'IDSpecialityEducation');

  FRecordHolder := TRecordHolder.Create();

  TNotifyEventWrap.Create(AfterOpen, DoAfterOpen, EventList);
  TNotifyEventWrap.Create(BeforeInsert, DoBeforeInsert, EventList);
  TNotifyEventWrap.Create(AfterInsert, DoAfterInsert, EventList);
end;

destructor TSpecSessW.Destroy;
begin
  inherited;
  FreeAndNil(FRecordHolder);
end;

procedure TSpecSessW.DoAfterInsert(Sender: TObject);
var
  rc: Integer;
begin
  Assert(not VarIsNull(IDSpecialityEducation.DefaultValue));
  IDSpecialityEducation.F.Value := IDSpecialityEducation.DefaultValue;

  // Если нужно добавить новый курс
  case AppendSpecSess of
    assLevel:
      begin
        rc := QryMaxSpecSess.SearchBySpecEd(IDSpecialityEducation.DefaultValue);
        TryAppend;
        Level_.F.AsInteger := IfThen(rc = 0, 1,
          QryMaxSpecSess.W.Max_Level.F.AsInteger + 1);
        Level_year.F.AsInteger := IfThen(rc = 0, GetAdmissionYear,
          QryMaxSpecSess.W.Max_Level_Year.F.AsInteger + 1);
        Session_in_level.F.AsInteger := 1;
      end;
    assSession:
      // Если раньше не было ни одной записи
      if FRecordHolder.Count = 0 then
      begin
        Level_.F.AsInteger := 1;
        Session_in_level.F.AsInteger := 1;
        Level_year.F.AsInteger := GetAdmissionYear;
      end
      else
      begin
        Level_.F.AsInteger := FRecordHolder.Field[Level_.FieldName];
        Session_in_level.F.AsInteger :=
          GetMaxSessionInLevel(FRecordHolder.Field[Level_.FieldName]) + 1;
        Level_year.F.AsInteger := FRecordHolder.Field[Level_year.FieldName];
      end;
  end;
end;

procedure TSpecSessW.DoAfterOpen(Sender: TObject);
begin
  Level_.F.Alignment := taCenter;
  Level_year.F.Alignment := taCenter;
  // ID_SpecialitySession.F.Required := False;
end;

procedure TSpecSessW.DoBeforeInsert(Sender: TObject);
begin
  if DataSet.RecordCount > 0 then
    FRecordHolder.Attach(DataSet)
  else
    FRecordHolder.Clear;
end;

function TSpecSessW.GetAdmissionYear: Integer;
begin
  Assert(not VarIsNull(IDSpecialityEducation.DefaultValue));
  QrySpecEdSimple.SearchByPK(IDSpecialityEducation.DefaultValue, True);
  Result := QrySpecEdSimple.W.Year.F.AsInteger;
end;

function TSpecSessW.GetMaxSessionInLevel(ALevel: Integer): Integer;
begin
  Assert(not VarIsNull(IDSpecialityEducation.DefaultValue));
  QryMaxSpecSess.SearchBy(IDSpecialityEducation.DefaultValue, ALevel, True);
  Result := QryMaxSpecSess.W.Max_Session_in_Level.F.AsInteger;
end;

function TSpecSessW.GetQryMaxSpecSess: TQryMaxSpecSess;
begin
  if FQryMaxSpecSess = nil then
    FQryMaxSpecSess := TQryMaxSpecSess.Create(Self);

  Result := FQryMaxSpecSess;
end;

function TSpecSessW.GetQrySpecEdSimple: TQuerySpecEdSimple;
begin
  if FQrySpecEdSimple = nil then
    FQrySpecEdSimple := TQuerySpecEdSimple.Create(Self);

  Result := FQrySpecEdSimple;
end;

procedure TSpecSessW.Update(const AFieldName: string;
  AOldValue, ANewValue: Integer);
var
  AFilter: string;
begin
  Assert(ANewValue > 0);
  Assert(AOldValue > 0);
  Assert(not AFieldName.IsEmpty);
  Assert(not VarIsNull(AOldValue));
  Assert(DataSet.FindField(AFieldName) <> nil);

  // Формируем фильтр. Предполагаем что работаем с целыми числами
  AFilter := Format('%s = %d', [AFieldName, AOldValue]);

  SaveBookmark;
  DataSet.DisableControls;
  try
    DataSet.Filter := AFilter;
    DataSet.Filtered := True;
    try
      while not DataSet.Eof do
      begin
        TryEdit;
        Field(AFieldName).Value := ANewValue;
        TryPost;
      end;
    finally
      DataSet.Filtered := False;
      DataSet.Filter := '';

    end;
  finally
    RestoreBookmark;
    DataSet.EnableControls;
  end;

  {

    W := TSpecSessW.Create(AddClone(AFilter));
    try
    Assert(W.DataSet.RecordCount > 0);
    W.DataSet.First;
    while not W.DataSet.Eof do
    begin
    W.TryEdit;
    W.Field(AFieldName).Value := ANewValue;
    W.TryPost;
    end;
    finally
    DropClone(W.DataSet as TFDMemTable);
    end;
  }
end;

constructor TQrySpecSess.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSpecSessW.Create(FDQuery);

  FDQuery.UpdateOptions.KeyFields := W.PKFieldName;
  FDQuery.UpdateOptions.AutoIncFields := W.PKFieldName;
  FDQuery.UpdateOptions.RefreshMode := rmAll;
  FDQuery.UpdateOptions.CheckRequired := False;
end;

procedure TQrySpecSess.FDQueryPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
var
  A: TArray<TParamWrap>;
  AFW: TFieldWrap;
  AOCINativeException: EOCINativeException;
  AParamWrap: TParamWrap;
  S: string;
begin
  inherited;
  if not(E is EOCINativeException) then
    Exit;

  AOCINativeException := E as EOCINativeException;
  if AOCINativeException.ErrorCode = 01400 then // not null
  begin
    A := W.GetFieldsWrapAsArr;
    for AParamWrap in A do
    begin
      if not(AParamWrap is TFieldWrap) then
        Continue;

      AFW := AParamWrap as TFieldWrap;
      if E.Message.ToUpper.Contains(Format('."%s"', [AFW.FieldName.ToUpper]))
      then
      begin
        E.Message := Format('Поле "%s" не заполнено.', [AFW.DisplayLabel]);
        break;
      end;
    end;

  end;

end;

function TQrySpecSess.SearchBySpecEd(AIDSpecEd: Integer): Integer;
begin
  Assert(AIDSpecEd > 0);
  Result := SearchEx([TParamRec.Create(W.IDSpecialityEducation.FullName,
    AIDSpecEd)]);

  // Значение параметра будет являться значением по умолчанию
  W.IDSpecialityEducation.DefaultValue := AIDSpecEd;
end;

{$R *.dfm}

end.
