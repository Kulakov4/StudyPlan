unit RetrainingSpecialitys;

interface

uses
  EssenceEx, System.Classes, Data.DB;

type
  TRetrainingSpeciality = class(TEssenceEx2)
  private
    function GetSHORT_SPECIALITY: TField;
    function GetSpeciality: TField;
    function GetSPECIALITY_ACCESS: TField;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Append(const ASpeciality, AShortSpeciality: string; const AIDChair:
        Integer);
    procedure FilterByChair(const AIDChair: Integer);
    procedure LocateOrAppend(const ASpeciality: string;
      const AIDChair: Integer);
    procedure TryUpdate(const AShortSpeciality: string);
    property SHORT_SPECIALITY: TField read GetSHORT_SPECIALITY;
    property Speciality: TField read GetSpeciality;
    property SPECIALITY_ACCESS: TField read GetSPECIALITY_ACCESS;
  end;

implementation

uses
  System.SysUtils, System.Variants;

constructor TRetrainingSpeciality.Create(AOwner: TComponent);
begin
  inherited;
  FSynonymFileName := 'SPECIALITYFields.txt';
  Wrap.ImmediateCommit := False;
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 's.ID_Speciality';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;
  SequenceName := 'cdb_com_directories.s_specialitys_id';

  with FSQLSelectOperator do
  begin
    Fields.Add('s.*');

    Tables.Add('SPECIALITYS s');

    WhereClause.Add('exists (select 1 from specialityeducations se ' +
      ' where SE.IDSPECIALITY = S.ID_SPECIALITY and SE.IDEDUCATION = 28)');

    OrderClause.Add('s.speciality');
  end;

  UpdatingTableName := 'SPECIALITYS';
  UpdatingFieldNames.Add('SPECIALITY');
  UpdatingFieldNames.Add('SPECIALITY_ACCESS');
  UpdatingFieldNames.Add('Short_Speciality');
end;

procedure TRetrainingSpeciality.Append(const ASpeciality, AShortSpeciality:
    string; const AIDChair: Integer);
begin
  DS.Append;
  Speciality.AsString := ASpeciality;
  SHORT_SPECIALITY.AsString := AShortSpeciality;
  SPECIALITY_ACCESS.AsInteger := AIDChair;
  DS.Post;
end;

procedure TRetrainingSpeciality.FilterByChair(const AIDChair: Integer);
begin
  Assert(AIDChair > 0);

  DS.Filter := Format('%s = %d', [SPECIALITY_ACCESS.FieldName, AIDChair]);
  DS.Filtered := True;
end;

function TRetrainingSpeciality.GetSHORT_SPECIALITY: TField;
begin
  Result := Field('Short_Speciality');
end;

procedure TRetrainingSpeciality.LocateOrAppend(const ASpeciality: string;
  const AIDChair: Integer);
var
  AFieldNames: string;
begin
  Assert(not ASpeciality.isEmpty);
  Assert(AIDChair > 0);

  AFieldNames := Format('%s;%s', [Speciality.FieldName,
    SPECIALITY_ACCESS.FieldName]);

  if DS.Locate(AFieldNames, VarArrayOf([ASpeciality, AIDChair]), []) then
    Exit;

  DS.Append;
  Speciality.AsString := ASpeciality;
  SPECIALITY_ACCESS.AsInteger := AIDChair;
  DS.Post;
end;

function TRetrainingSpeciality.GetSpeciality: TField;
begin
  Result := Field('Speciality');
end;

function TRetrainingSpeciality.GetSPECIALITY_ACCESS: TField;
begin
  Result := Field('SPECIALITY_ACCESS');
end;

procedure TRetrainingSpeciality.TryUpdate(const AShortSpeciality: string);
begin
  if SHORT_SPECIALITY.AsString = AShortSpeciality then
    Exit;

  DS.Edit;
  SHORT_SPECIALITY.AsString := AShortSpeciality;
  DS.Post;
end;

end.
