unit Qualifications;

interface

uses
  EssenceEx, System.Classes, Data.DB;

type
  TQualifications = class(TEssenceEx2)

  private
    function GetQualification: TField;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Append(const AQualification: String);
    property Qualification: TField read GetQualification;
  end;

implementation

constructor TQualifications.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'QualificationFields.txt';
  inherited;
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'q.ID';
  Wrap.ImmediateCommit := True;
  SequenceName := 'cdb_com_directories.QUALIFICATIONS_SEQ';
//  KeyFieldProviderFlags := [pfInUpdate, pfInKey];

  //Name := 'Qualifications';

  with FSQLSelectOperator do
  begin
    Fields.Add('q.ID');
    Fields.Add('q.Qualification');

    Tables.Add('QUALIFICATIONS q');

    WhereClause.Add('Q.Enabled = 1');
    WhereClause.Add('Q.ID <> 0');

    OrderClause.Add('q.Qualification');
  end;

  UpdatingTableName := 'QUALIFICATIONS';
  UpdatingFieldNames.Add('Qualification');
end;

procedure TQualifications.Append(const AQualification: String);
begin
  DS.Append;
  Qualification.AsString := AQualification;
  DS.Post;
end;

function TQualifications.GetQualification: TField;
begin
  Result := Field('Qualification');
end;

end.
