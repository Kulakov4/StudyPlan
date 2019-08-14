unit ThemeQuestions;

interface

uses
  EssenceEx, System.Classes, K_Params, Data.DB, OrderEssence, Datasnap.DBClient,
  DragHelper;

type
  TRecOrderEx = class(TRecOrder)
    IDParent: Integer;
  end;

  TDropDragEx = class(TDropDrag)
    IDParent: Integer;
  end;

  TStartDragEx = class(TStartDrag)
    IDParent: Integer;
  end;

  TIDQuestionType = (qtAud = 1, qtSelf = 2);

  TThemeQuestions = class(TOrderEssence)
  private
    FDefaultQuestionType: TIDQuestionType;
    procedure AfterInsert(Sender: TObject);
    function GetIDLessonTheme: TField;
    function GetIDThemeQuestionType: TField;
    function GetThemeQuestion: TField;
    function GetThemeQuestionTypeOrd: TField;
  protected
    FIDDisciplineParam: T_KParam;
    function CreateCloneForOrder(AID: Integer): TClientDataSet; override;
    procedure CreateIndex; override;
    procedure DoOnUpdateOrder(ARecOrder: TRecOrder); override;
    function GetFilterExpression(AID: Integer): String;
    function GetOrderField: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CreateCloneByTheme(AIDLessonTheme: Integer): TClientDataSet;
    procedure DoBeforePost(Sender: TObject);
    procedure MoveDSRecord(AStartDrag: TStartDrag;
      ADropDrag: TDropDrag); override;
    property DefaultQuestionType: TIDQuestionType read FDefaultQuestionType
      write FDefaultQuestionType;
    property IDDisciplineParam: T_KParam read FIDDisciplineParam;
    property IDLessonTheme: TField read GetIDLessonTheme;
    property IDThemeQuestionType: TField read GetIDThemeQuestionType;
    property ThemeQuestion: TField read GetThemeQuestion;
    property ThemeQuestionTypeOrd: TField read GetThemeQuestionTypeOrd;
  end;

implementation

uses NotifyEvents, System.SysUtils, StrHelper;

constructor TThemeQuestions.Create(AOwner: TComponent);
begin
  FSynonymFileName := 'ThemeQuestionFields.txt';

  inherited;

  FDefaultQuestionType := qtAud;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'thq.ID_ThemeQuestion';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.THEMEQUESTIONS_SEQ';

  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;

  with FSQLSelectOperator do
  begin
    Distinct := True;

    Fields.Add('thq.*');
    Fields.Add('thqt.ThemeQuestionType');
    Fields.Add('thqt.Ord ThemeQuestionTypeOrd');

    Tables.Add('disciplines d');

    Joins.Add('join LessonThemeHours lthh');
    Joins.WhereCondition.Add('lthh.IDDiscipline = d.id_discipline');

    Joins.Add('join ThemeQuestions thq');
    Joins.WhereCondition.Add('thq.IDLessonTheme = lthh.IDLessonTheme');

    Joins.Add('join ThemeQuestionTypes thqt');
    Joins.WhereCondition.Add
      ('thq.IDThemeQuestionType = thqt.ID_ThemeQuestionType');

    OrderClause.Add('thq.IDLessonTheme');
    OrderClause.Add('thqt.ord');
    OrderClause.Add('thq.ord');
  end;

  FIDDisciplineParam := T_KParam.Create(Params, 'd.ID_Discipline');
  FIDDisciplineParam.ParamName := 'ID_Discipline';

  UpdatingTableName := 'ThemeQuestions';
  UpdatingFieldNames.Add('ThemeQuestion');
  UpdatingFieldNames.Add('IDLessonTheme');
  UpdatingFieldNames.Add('IDThemeQuestionType');
  UpdatingFieldNames.Add('Ord');

  // Включаем режим добавления
  AppendMode := True;

  TNotifyEventWrap.Create(Wrap.AfterInsert, AfterInsert);
  TNotifyEventWrap.Create(Wrap.BeforePost, DoBeforePost);
end;

procedure TThemeQuestions.AfterInsert(Sender: TObject);
begin
  IDThemeQuestionType.AsInteger := Integer(FDefaultQuestionType);
  ThemeQuestionTypeOrd.AsInteger := Integer(FDefaultQuestionType);
end;

function TThemeQuestions.CreateCloneByTheme(AIDLessonTheme: Integer)
  : TClientDataSet;
begin
  Result := CreateClone;
  Result.Filter := GetFilterExpression(AIDLessonTheme);
  Result.Filtered := True;
end;

function TThemeQuestions.CreateCloneForOrder(AID: Integer): TClientDataSet;
begin

  // Создаём клон
  Result := inherited;
  if not Result.Locate(KeyFieldName, AID, []) then
    raise Exception.CreateFmt
      ('Ошибка при поиске записи с кодом %d при создании клона', [AID]);

  // Фильтруем клон по теме
  Result.Filter := GetFilterExpression
    (Result.FieldByName(IDLessonTheme.FieldName).AsInteger);
  Result.Filtered := True;

  // Переходим на ту-же запись в клоне
  if not Result.Locate(KeyFieldName, AID, []) then
    raise Exception.CreateFmt
      ('Ошибка 2 при поиске записи с кодом %d при создании клона', [AID]);
end;

procedure TThemeQuestions.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1', 'IDLessonTHEME;ThemeQuestionTypeOrd;ord', []);
  ClientDataSet.IndexName := 'idx1';
end;

procedure TThemeQuestions.DoBeforePost(Sender: TObject);
var
  S: string;
begin
  S := DeleteDoubleSpace(ThemeQuestion.AsString).Trim([' ', '.', ':', '-']);
  if not S.IsEmpty then
    S := S + '.';

  ThemeQuestion.AsString := S;
end;

procedure TThemeQuestions.DoOnUpdateOrder(ARecOrder: TRecOrder);
begin
  inherited;
  if ARecOrder is TRecOrderEx then
    IDLessonTheme.AsInteger := (ARecOrder as TRecOrderEx).IDParent;
end;

function TThemeQuestions.GetFilterExpression(AID: Integer): String;
begin
  Result := Format('%s = %d', [IDLessonTheme.FieldName, AID]);
end;

function TThemeQuestions.GetIDLessonTheme: TField;
begin
  Result := Field('IDLessonTheme');
end;

function TThemeQuestions.GetIDThemeQuestionType: TField;
begin
  Result := Field('IDThemeQuestionType');
end;

function TThemeQuestions.GetOrderField: TField;
begin
  Result := Field('ord');
end;

function TThemeQuestions.GetThemeQuestion: TField;
begin
  Result := Field('ThemeQuestion');
end;

function TThemeQuestions.GetThemeQuestionTypeOrd: TField;
begin
  Result := Field('ThemeQuestionTypeOrd')
end;

procedure TThemeQuestions.MoveDSRecord(AStartDrag: TStartDrag;
  ADropDrag: TDropDrag);
var
  AClone: TClientDataSet;
  ADropDragEx: TDropDragEx;
  ARecOrder: TRecOrderEx;
  AStartDragEx: TStartDragEx;
  I: Integer;
begin
  AStartDragEx := AStartDrag as TStartDragEx;
  ADropDragEx := ADropDrag as TDropDragEx;

  // Если был перенос в рамках одной темы
  if AStartDragEx.IDParent = ADropDragEx.IDParent then
  begin
    inherited;
    Exit;
  end;

  // если был перенос вопроса в другую тему
  // Готовимся обновить порядок вопросов как при удалении вопроса
  AClone := CreateCloneForOrder(AStartDrag.Keys[0]);
  try
    if not AClone.Locate(OrderField.FieldName, AStartDrag.MaxOrderValue, [])
    then
      raise Exception.CreateFmt('Внутренняя ошибка при перемещении записи %d',
        [AStartDrag.MaxOrderValue]);

    AClone.Next;
    if not AClone.Eof then
      // Будем поднимать вверх все темы, после последней перетаскиваемой
      PrepareUpdateOrder(AClone, -1 * Length(AStartDrag.Keys));
  finally
    FreeAndNil(AClone);
  end;

  // если в точке переноса была тема, которую надо подвинуть
  if ADropDrag.Key > 0 then
  begin
    // Готовимся обновить порядок тем как при добавлении темы
    AClone := CreateCloneForOrder(ADropDrag.Key);
    try
      // Будем опускать вниз все темы, начиная с текущей
      PrepareUpdateOrder(AClone, 1 * Length(AStartDrag.Keys));
    finally
      FreeAndNil(AClone);
    end;
  end;

  // Готовимся изменить порядок тех тем, которые переносили
  for I := Low(AStartDrag.Keys) to High(AStartDrag.Keys) do
  begin
    ARecOrder := TRecOrderEx.Create(AStartDrag.Keys[I],
      ADropDrag.OrderValue + I);
    // ARecOrder.Key := AStartDrag.Keys[I];
    // ARecOrder.Order := ADropDrag.OrderValue + I;
    (ARecOrder as TRecOrderEx).IDParent := ADropDragEx.IDParent;
    FRecOrderList.Add(ARecOrder);
  end;

  // Выполняем все изменения
  UpdateOrder;

  // Заново создаём индекс. Он почему-то исчезает
  CreateIndex;
end;

end.
