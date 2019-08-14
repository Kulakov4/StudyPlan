unit SoftwareTypes;

interface

uses
  EssenceEx, System.Classes;

type
  TSoftwareTypes = class(TEssenceEx2)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

constructor TSoftwareTypes.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'SoftwareTypeFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'st.ID_SoftwareType';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  SequenceName := 'cdb_dat_study_process.SOFTWARETYPES_SEQ';

  Wrap.ImmediateCommit := True;
  RefreshRecordAfterPost := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('st.*');

    Tables.Add('SOFTWARETYPES st');

    OrderClause.Add('st.SoftwareType');
  end;

  UpdatingTableName := 'SOFTWARETYPES';
  UpdatingFieldNames.Add('SOFTWARETYPE');
end;

end.
