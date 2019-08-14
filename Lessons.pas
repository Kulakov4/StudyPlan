unit Lessons;

interface

uses EssenceEx, Classes, K_Params;

type
  TLessons = class(TEssenceEx2)
  private
    FIDDisciplineNameParam: T_KParam;
    FIDLessonTypeParam: T_KParam;
  protected
    procedure AfterQueryOpen(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetLessonName(ALessonName, AIDLessons: String; ADelimiter: String =
        ',');
    property IDDisciplineNameParam: T_KParam read FIDDisciplineNameParam;
    property IDLessonTypeParam: T_KParam read FIDLessonTypeParam;
  end;

implementation

uses NotifyEvents, Provider, DB, SysUtils, MyConnection;

constructor TLessons.Create(AOwner: TComponent);
begin
  inherited;

  Wrap.MultiSelectDSWrap.FullKeyFieldName := 'ls.id_lesson';
  FSynonymFileName := 'LessonsFields.txt';
  with FSQLSelectOperator do
  begin
    Fields.Add('ls.id_lesson');
    Fields.Add('ls.order_');
    Fields.Add('ls.lesson_name');

    Tables.Add('LESSONS ls');

    Joins.Add('join disciplines d');
    Joins.WhereCondition.Add('ls.IDDISCIPLINE = d.id_discipline');

    OrderClause.Add('ls.order_');
  end;
  FIDLessonTypeParam := T_KParam.Create(Params, 'ls.idlessontype');
  FIDDisciplineNameParam := T_KParam.Create(Params, 'd.iddisciplinename');
  FIDDisciplineNameParam.ParameterList := FSQLSelectOperator.Joins.on[0];

  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
  Wrap.ImmediateCommit := True;
  
  // «апрещаем добавление и удаление записей
  Provider.Options := Provider.Options + [poDisableInserts, poDisableDeletes]
end;

procedure TLessons.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([]);
    FieldByName(KeyFieldName).ProviderFlags := [pfInKey, pfInUpdate];
    FieldByName('Lesson_name').ProviderFlags := [pfInUpdate];
  end;
end;

procedure TLessons.SetLessonName(ALessonName, AIDLessons: String; ADelimiter:
    String = ',');
var
  ASQL: string;
begin
  // ”станавливаем название зан€тий дл€ Lessons с кодами из AIDLessons
  ASQL := Format(
    'update lessons ' +
    'set lesson_name = ''%s'' ' +
    'where instr(''%s'', ''%s'' || id_lesson || ''%s'' ) > 0',
    [ALessonName, AIDLessons, ADelimiter, ADelimiter, AIDLessons]);

  // ¬ыполн€ем обновление;
  MySQLQuery.SQLConnection.ExecuteDirect(ASQL);

  UseBookmark := True;
  Refresh;
end;

end.
