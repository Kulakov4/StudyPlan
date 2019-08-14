unit GFLTeachers;

interface

uses EssenceEx, classes, K_Params;

type
  TGFLTeachers = class(TEssenceEx)
  private
    FIDStudyPlanParam: T_KParam;
    FIDLessonTypeParam: T_KParam;
    FIDStudGroupParam: T_KParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDLessonTypeParam: T_KParam read FIDLessonTypeParam;
    property IDStudGroupParam: T_KParam read FIDStudGroupParam;
    property IDStudyPlanParam: T_KParam read FIDStudyPlanParam;
  end;

implementation

constructor TGFLTeachers.Create(AOwner: TComponent);
//var
//  AParamDefItemEx: TParamDefItemEx;
begin
  inherited;

  with FSQLSelectOperator do
  begin
    Pragma :=
      '/*+ LEADING(lt) INDEX(lt) ' +
      'USE_NL(lt, ls)  INDEX(ls) ' +
      'USE_NL(ls, pl)  INDEX(pl) ' +
      'USE_NL(pl, gfl) INDEX(gfl) ' +
      'USE_NL(pl, st) INDEX(st) ' +      
      'USE_NL(gfl, gflt) INDEX(gflt) ' +
      'USE_NL(gflt, e) INDEX(e) ' +
      'USE_NL(e, p) INDEX(p) ' +
      'USE_NL(p, ln) INDEX(ln) ' +
      'USE_NL(p, fn) INDEX(fn) ' +
      'USE_NL(p, pn) INDEX(pn) */';

    Fields.Add('DECODE(gfl.IDTeacher, NULL, NULL, LN.lastname || '' '' || SubStr(FN.FirstName, 1, 1) || ''. '' || SubStr(PN.Patronymic, 1, 1) || ''. '' ) FIO');

    Tables.Add('lessontypes lt');

    Joins.Add('join lessons ls');
    Joins.WhereCondition.Add('ls.IDLESSONTYPE = lt.ID_LESSONTYPE');

    Joins.Add('join t_plans partition (actual) pl');
    Joins.WhereCondition.Add('pl.idlesson = ls.id_lesson');
    Joins.WhereCondition.Add('ls.order_ = 1');    

    Joins.Add('join group_for_lesson gfl');
    Joins.WhereCondition.Add('pl.idgroup_for_lesson = gfl.ID_GROUP_FOR_LESSON');

    Joins.Add('join t_students st');
    Joins.WhereCondition.Add('pl.idstudent = st.ID');

    Joins.Add('join gfl_teachers gflt');
    Joins.WhereCondition.Add('gflt.idgroup_for_lesson = gfl.id_group_for_lesson');

    Joins.Add('JOIN t_employees e');
    Joins.WhereCondition.Add('gflt.idteacher = e.ID');

    Joins.Add('JOIN t_peoples p');
    Joins.WhereCondition.Add('e.people_id = p.ID');

    Joins.Add('JOIN lastnames LN');
    Joins.WhereCondition.Add('p.lastname_id = LN.ID');

    Joins.Add('JOIN firstnames fn');
    Joins.WhereCondition.Add('p.firstname_id = fn.ID');

    Joins.Add('JOIN patronymics pn');
    Joins.WhereCondition.Add('p.patronymic_id = pn.ID');

    OrderClause.Add('gflt.order_');
  end;

  // Создаём параметр "код учебного плана"
  //FIDStudyPlanParam := TParamDefItemEx.Create(FParamDefList, TKParam, 'lt.IDSTUDYPLAN').CustomParam as TKParam;
  FIDStudyPlanParam := T_KParam.Create(Params, 'lt.IDSTUDYPLAN');

  // Создаём параметр "код типа занятия"
  //FIDLessonTypeParam := TParamDefItemEx.Create(FParamDefList, TKParam, 'lt.IDType').CustomParam as TKParam;
  FIDLessonTypeParam := T_KParam.Create(Params, 'lt.IDType');

  // Создаём параметр "код группы студентов"
  //AParamDefItemEx := TParamDefItemEx.Create(FParamDefList, TKParam, 'st.group_id');
  //AParamDefItemEx.ParameterList := FSQLSelectOperator.Joins.on[3];
  //FIDStudGroupParam := AParamDefItemEx.CustomParam as TKParam;
  FIDStudGroupParam := T_KParam.Create(Params, 'st.group_id');
  FIDStudGroupParam.ParameterList := FSQLSelectOperator.Joins.on[3];
end;

end.

