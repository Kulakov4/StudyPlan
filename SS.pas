unit SS;

interface

uses EssenceEx, Classes, K_Params;

type
  TSpecialitySessions = class(TEssenceEx)
  private
    FSpecialityEducationParam: T_KParam;
  public
    constructor Create(AOwner: TComponent); override;
    property SpecialityEducationParam: T_KParam read FSpecialityEducationParam;
  end;

implementation

uses SQLTools;

constructor TSpecialitySessions.Create(AOwner: TComponent);
begin
  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'ss.id_specialitysession';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('ss.id_specialitysession');
    Fields.Add('ss.idspecialityeducation');
    Fields.Add('ss.level_');
    Fields.Add('ss.session_in_level');
    Fields.Add('ss.level_year');
    Fields.Add('st.sessiontype SessionName');
    Fields.Add('st.semestr');        

    Tables.Add('specialitysessions ss');

    Joins.Add('join sessiontypes st');
    Joins.WhereCondition.Add('ss.session_ = st.id_sessiontype');

    OrderClause.Add('ss.level_');
    OrderClause.Add('ss.session_in_level');
  end;
  FSpecialityEducationParam := T_KParam.Create(Params, 'ss.idspecialityeducation');
end;

end.
