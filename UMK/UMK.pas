unit UMK;

interface

uses
  EssenceEx, System.Classes, K_Params;

type
  TUMK = class(TEssenceEx2)
  private
    FIDParam: T_KParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDParam: T_KParam read FIDParam;
  end;

implementation

constructor TUMK.Create(AOwner: TComponent);
begin
  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'umk.id_umk';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('umk.id_umk');
    Fields.Add('umk.iduser');
    Fields.Add('umk.ИдентификаторФЛ');

    Tables.Add('UMK');

//    Joins.Add('join sessiontypes st');
//    Joins.WhereCondition.Add('ss.session_ = st.id_sessiontype');

//    OrderClause.Add('ss.level_');
//    OrderClause.Add('ss.session_in_level');
  end;
  FIDParam := T_KParam.Create(Params, 'umk.id_umk');
end;

end.
