unit ThemeQuestionTypes;

interface

uses
  EssenceEx, System.Classes, Data.DB;

type
  TThemeQuestionTypes = class(TEssenceEx2)
  private
    function GetThemeQuestionType: TField;
  public
    constructor Create(AOwner: TComponent); override;
    property ThemeQuestionType: TField read GetThemeQuestionType;
  end;

implementation

constructor TThemeQuestionTypes.Create(AOwner: TComponent);
begin
//  FSynonymFileName := 'ThemeQuestionTypeFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName :=
    'thqt.ID_ThemeQuestionType';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

//  SequenceName := 'cdb_dat_study_process.CONTROLNAMES_SEQ';

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;

  with FSQLSelectOperator do
  begin
    Fields.Add('thqt.*');

    Tables.Add('ThemeQuestionTypes thqt');

    OrderClause.Add('thqt.ord');
  end;

  KeyFieldProviderFlags := [pfInKey, pfInUpdate];
end;

function TThemeQuestionTypes.GetThemeQuestionType: TField;
begin
  Result := Field('ThemeQuestionType');
end;

end.
