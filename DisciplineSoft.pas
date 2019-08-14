unit DisciplineSoft;

interface

uses
  EssenceEx, System.Classes, K_Params, Data.DB;

type
  TDisciplineSoft = class(TEssenceEx2)
  private
    FIDDisciplineNameParam: T_KParam;
    FIDSpecialityParam: T_KParam;
    FYearParam: T_KParam;
    function GetIDDisciplineName: TField;
    function GetIDSoftware: TField;
    function GetIDSpeciality: TField;
    function GetSoftwareName: TField;
    function GetYear: TField;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddDefaultSoftware;
    procedure AddSoftware(AIDSoftList: TStringList);
    property IDDisciplineName: TField read GetIDDisciplineName;
    property IDDisciplineNameParam: T_KParam read FIDDisciplineNameParam;
    property IDSoftware: TField read GetIDSoftware;
    property IDSpeciality: TField read GetIDSpeciality;
    property IDSpecialityParam: T_KParam read FIDSpecialityParam;
    property SoftwareName: TField read GetSoftwareName;
    property Year: TField read GetYear;
    property YearParam: T_KParam read FYearParam;
  end;

implementation

uses System.Variants, System.SysUtils, Software;

constructor TDisciplineSoft.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'DisciplineSoftFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'ds.ID_DisciplineSoft';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  SequenceName := 'cdb_dat_study_process.DISCIPLINESOFT_SEQ';

  Wrap.ImmediateCommit := True;
  RefreshRecordAfterPost := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('ds.*');
    Fields.Add('SW.NAME');

    Tables.Add('DISCIPLINESOFT ds');

    Joins.Add('join Software sw');
    Joins.WhereCondition.Add('DS.IDSOFTWARE = SW.ID_SOFTWARE');

  end;

  FIDDisciplineNameParam := T_KParam.Create(Params, 'DS.IDDISCIPLINENAME');
  FIDDisciplineNameParam.ParamName := 'IDDisciplineName';

  FYearParam := T_KParam.Create(Params, 'DS.Year');
  FYearParam.ParamName := 'Year';

  FIDSpecialityParam := T_KParam.Create(Params, 'DS.IDSpeciality');
  FIDSpecialityParam.ParamName := 'IDSpeciality';


  UpdatingTableName := 'DISCIPLINESOFT';
  UpdatingFieldNames.Add('Year');
  UpdatingFieldNames.Add('IDSpeciality');
  UpdatingFieldNames.Add('IDDisciplineName');
  UpdatingFieldNames.Add('IDSoftware');
end;

procedure TDisciplineSoft.AddDefaultSoftware;
var
  ADefaultIDSofList: TStringList;
  ASoftware: TSoftware;
  S: string;
begin
  ASoftware := TSoftware.Create(Self);
  try
    ASoftware.IsDefaultParam.ParamValue := 1;
    ASoftware.Refresh;
    S := ASoftware.Wrap.GetColumnValues(ASoftware.KeyFieldName, #13#10);
    ADefaultIDSofList := TStringList.Create;
    try
      ADefaultIDSofList.Text := S;
      AddSoftware(ADefaultIDSofList);
    finally
      FreeAndNil(ADefaultIDSofList);
    end;
  finally
    FreeAndNil(ASoftware);
  end;
end;

procedure TDisciplineSoft.AddSoftware(AIDSoftList: TStringList);
var
  AIDSoft: Integer;
  I: Integer;
  V: Variant;
begin
  Assert(not VarIsNull(YearParam.ParamValue));
  Assert(not VarIsNull(IDSpecialityParam.ParamValue));
  Assert(not VarIsNull(IDDisciplineNameParam.ParamValue));

  for I := 0 to AIDSoftList.Count - 1 do
  begin
    AIDSoft := StrToIntDef(AIDSoftList[i], 0);
    if AIDSoft = 0 then
      Continue;

    // Ищем такой софт
    V := DS.Lookup(IDSoftware.FieldName, AIDSoft, KeyFieldName);
    // если такого софта ещё нет
    if VarIsNull(V) then
    begin
      DS.Append;
      Year.AsInteger := YearParam.ParamValue;
      IDSpeciality.AsInteger := IDSpecialityParam.ParamValue;
      IDDisciplineName.AsInteger := IDDisciplineNameParam.ParamValue;
      IDSoftware.AsInteger := AIDSoft;
      DS.Post;
    end;
  end;
end;

function TDisciplineSoft.GetIDDisciplineName: TField;
begin
  Result := Field('IDDisciplineName');
end;

function TDisciplineSoft.GetIDSoftware: TField;
begin
  Result := Field('IDSoftware');
end;

function TDisciplineSoft.GetIDSpeciality: TField;
begin
  Result := Field('IDSpeciality');
end;

function TDisciplineSoft.GetSoftwareName: TField;
begin
  Result := Field('Name');
end;

function TDisciplineSoft.GetYear: TField;
begin
  Result := Field('Year');
end;

end.


