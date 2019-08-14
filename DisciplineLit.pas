unit DisciplineLit;

interface

uses
  EssenceEx, System.Classes, Data.DB, K_Params;

type
  TDisciplineLit = class(TEssenceEx2)
  private
    FIDDisciplineNameParam: T_KParam;
    FIDSpecialityParam: T_KParam;
    FYearParam: T_KParam;
  class var
    procedure DoBeforePost(Sender: TObject);
    function GetIDDisciplineName: TField;
    function GetIDLiterature: TField;
    function GetIDSpeciality: TField;
    function GetYear: TField;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddLit(const S: String);
    property IDDisciplineName: TField read GetIDDisciplineName;
    property IDDisciplineNameParam: T_KParam read FIDDisciplineNameParam;
    property IDLiterature: TField read GetIDLiterature;
    property IDSpeciality: TField read GetIDSpeciality;
    property IDSpecialityParam: T_KParam read FIDSpecialityParam;
    property Year: TField read GetYear;
    property YearParam: T_KParam read FYearParam;
  end;

function DiscLit: TDisciplineLit;

implementation

uses NotifyEvents, System.SyncObjs, System.Sysutils;

constructor TDisciplineLit.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'DisciplineLitFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'dl.ID_DisciplineLit';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  SequenceName := 'cdb_dat_study_process.DISCIPLINELIT_SEQ';

  Wrap.ImmediateCommit := True;
  RefreshRecordAfterPost := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('dl.*');
    Fields.Add('LIB.BOOKCARD.GETSHORTDESCRIPTION(dl.IDLiterature) Literature');

    Tables.Add('DisciplineLit dl');
  end;

  FIDDisciplineNameParam := T_KParam.Create(Params, 'dl.IDDISCIPLINENAME');
  FIDDisciplineNameParam.ParamName := 'IDDisciplineName';

  FYearParam := T_KParam.Create(Params, 'dl.Year');
  FYearParam.ParamName := 'Year';

  FIDSpecialityParam := T_KParam.Create(Params, 'dl.IDSpeciality');
  FIDSpecialityParam.ParamName := 'IDSpeciality';

  UpdatingTableName := 'DisciplineLit';
  UpdatingFieldNames.Add('Year');
  UpdatingFieldNames.Add('IDSpeciality');
  UpdatingFieldNames.Add('IDDisciplineName');
  UpdatingFieldNames.Add('IDLiterature');

  TNotifyEventWrap.Create(Wrap.BeforePost, DoBeforePost);
end;

procedure TDisciplineLit.AddLit(const S: String);
var
  AID: Integer;
  m: TArray<String>;
  SS: string;
begin
  m := S.Split([',']);

  for SS in m do
  begin
    AID := StrToUIntDef(SS, 0);
    if AID = 0 then
      Continue;

    DS.Append;
    IDLiterature.AsInteger := AID;
    try
      DS.Post;
    except
      DS.Cancel;
    end;
  end;
end;

procedure TDisciplineLit.DoBeforePost(Sender: TObject);
begin
  IDDisciplineName.Value := IDDisciplineNameParam.ParamValue;
  Year.Value := YearParam.ParamValue;
  IDSpeciality.Value := IDSpecialityParam.ParamValue;
end;

function TDisciplineLit.GetIDDisciplineName: TField;
begin
  Result := Field('IDDisciplineName');
end;

function TDisciplineLit.GetIDLiterature: TField;
begin
  Result := Field('IDLiterature');
end;

function TDisciplineLit.GetIDSpeciality: TField;
begin
  Result := Field('IDSpeciality');
end;

function TDisciplineLit.GetYear: TField;
begin
  Result := Field('Year');
end;

var
  Lock: TCriticalSection;
  _DisciplineLit: TDisciplineLit;

function DiscLit: TDisciplineLit;
begin
  Lock.Acquire;
  try
    if not(Assigned(_DisciplineLit)) then
      _DisciplineLit := TDisciplineLit.Create(nil);
    Result := _DisciplineLit;
  finally
    Lock.Release;
  end;
end;

initialization

Lock := TCriticalSection.Create;

finalization

Lock.Free;

end.
