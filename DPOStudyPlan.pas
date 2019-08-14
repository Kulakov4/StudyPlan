unit DPOStudyPlan;

interface

uses Chairs, EssenceEx, GFLTeachers, StudGroups, Contnrs, Windows,
  messages, DBClient, K_Params, Data.DBXCommon, Data.DB, System.Classes;

const
  WM_OnGroupChange = WM_USER + 1;

type
  TLessonTypeRec = record
    FieldName: string;
    IDType: Integer;
  end;

  TDPOStudyPlans = class(TEssenceEx2)
  private
    FAdmissionParam: T_KParam;
    FDBXTransaction: TDBXTransaction;
    FEventList: TObjectList;
    FGFLTeachers: TGFLTeachers;
    FInApplyAupdates: Boolean;
    FLessonTypesRecs: array [1 .. 5] of TLessonTypeRec;
    FStudGroups: TStudGroups;
    FWindowHandle: HWND;
    function GetIDDisciplineName: TField;
    procedure SetStudGroups(const Value: TStudGroups);
    procedure WndProc(var Msg: TMessage);
    procedure GetTableName(Sender: TObject; DataSet: TDataSet; var TableName:
      {$IFDEF VER230}WideString{$ELSE}String{$ENDIF});
  protected
    procedure AfterOpen(Sender: TObject);
    procedure AfterQueryOpen(Sender: TObject);
    procedure BeforePost(Sender: TObject);
    procedure AfterPost(Sender: TObject);
    procedure OnCalcFields(Sender: TObject);
    procedure MyBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
    procedure OnStudGroupChange(Sender: TObject);
    procedure UpdateGFLTeachers;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Commit(AIDSpecialitySession: Integer);
    procedure Drop;
    procedure EditLessons(ADataFieldName: string);
    function IsDataField(AFieldName: string): Boolean;
    procedure MoveUp;
    procedure MoveDown;
    procedure New(AIDDisciplineName, AIDCycleSpecialityEducation: Integer;
      ADisciplineName: string; AIDChair, AIDSpecialitySession: Integer);
    procedure UpdateDisciplineName(AIDDisciplineName: Integer);
    property AdmissionParam: T_KParam read FAdmissionParam;
    property IDDisciplineName: TField read GetIDDisciplineName;
    property StudGroups: TStudGroups read FStudGroups write SetStudGroups;
  end;

  TDPOStudyPlans2 = class(TDPOStudyPlans)
  private
    FYearParam: T_KParam;
  public
    constructor Create(AOwner: TComponent); override;
    property YearParam: T_KParam read FYearParam;
  end;

implementation

uses NotifyEvents, MyConnection, SQLTools, MyDataAccess, SysUtils, Essence,
  Dialogs, DataSetWrap, Provider, ViewFormEx, Lessons, DataSetView_2,
  LessonsView, StrUtils, K_StrUtils;

procedure TDPOStudyPlans.GetTableName(Sender: TObject; DataSet: TDataSet;
  var TableName: {$IFDEF VER230}WideString{$ELSE}String{$ENDIF});
begin
  TableName := 'STUDYPLANS'
end;

constructor TDPOStudyPlans.Create(AOwner: TComponent);
{ var
  Field: TIntegerField;
}
begin
  inherited;
  FDBXTransaction := nil;

  // Создаём дескриптор окна
  FWindowHandle := System.Classes.AllocateHWnd(WndProc);

  FEventList := TObjectList.Create(True);

  FLessonTypesRecs[1].FieldName := 'lec';
  FLessonTypesRecs[1].IDType := 1;

  FLessonTypesRecs[2].FieldName := 'lab';
  FLessonTypesRecs[2].IDType := 2;

  FLessonTypesRecs[3].FieldName := 'sem';
  FLessonTypesRecs[3].IDType := 3;

  FLessonTypesRecs[4].FieldName := 'zach';
  FLessonTypesRecs[4].IDType := 6;

  FLessonTypesRecs[5].FieldName := 'exam';
  FLessonTypesRecs[5].IDType := 5;

  FGFLTeachers := TGFLTeachers.Create(Self);

  Wrap.ImmediateCommit := True;
  SequenceName := 'cdb_dat_study_process.S_PLANS_ID';

  FSynonymFileName := 'StudyPlanFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'sp.ID_StudyPlan';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  with FSQLSelectOperator do
  begin
    Fields.Add('dn.disciplinename');
    Fields.Add('sp.*');
    // Лекции
    Fields.Add('lec.ID_LessonType LecID');
    Fields.Add('lec.data          LecData');
    // Лабораторные
    Fields.Add('Lab.ID_LessonType LabID');
    Fields.Add('Lab.data          LabData');
    // Семинары
    Fields.Add('Sem.ID_LessonType SemID');
    Fields.Add('Sem.data          SemData');
    // Зачёты
    Fields.Add('Zach.ID_LessonType  ZachID');
    Fields.Add('Zach.data           ZachData');
    // Экзамены
    Fields.Add('Exam.ID_LessonType  ExamID');
    Fields.Add('Exam.data           ExamData');

    Fields.Add('ss.ID_SpecialitySession');

    Tables.Add('cyclespecialityeducations cse');

    Joins.Add('join STUDYPLANS sp');
    Joins.WhereCondition.Add
      ('sp.idcyclespecialityeducation = cse.id_cyclespecialityeducation');

    Joins.Add('join specialityeducations se');
    Joins.WhereCondition.Add
      ('cse.idspecialityeducation = se.id_specialityeducation');

    Joins.Add('LEFT JOIN specialitysessions ss');
    Joins.WhereCondition.Add
      ('ss.idspecialityeducation = se.id_specialityeducation');

    Joins.Add('join disciplinenames dn');
    Joins.WhereCondition.Add('sp.iddisciplinename = dn.id_disciplinename');

    Joins.Add('left join lessontypes lec');
    Joins.WhereCondition.Add('lec.idtype = 1');
    Joins.WhereCondition.Add('lec.idstudyplan = sp.id_studyplan');

    Joins.Add('left join lessontypes lab');
    Joins.WhereCondition.Add('lab.idtype = 2');
    Joins.WhereCondition.Add('lab.idstudyplan = sp.id_studyplan');

    Joins.Add('left join lessontypes sem');
    Joins.WhereCondition.Add('sem.idtype = 3');
    Joins.WhereCondition.Add('sem.idstudyplan = sp.id_studyplan');

    Joins.Add('left join lessontypes zach');
    Joins.WhereCondition.Add('zach.idtype = 6');
    Joins.WhereCondition.Add('zach.idstudyplan = sp.id_studyplan');

    Joins.Add('left join lessontypes exam');
    Joins.WhereCondition.Add('exam.idtype = 5');
    Joins.WhereCondition.Add('exam.idstudyplan = sp.id_studyplan');

    WhereClause.Add('sp.ID_StudyPlan = 0');

    // OrderClause.Add('dn.DisciplineName');
    OrderClause.Add('sp.order_');
  end;

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию
  FSQLSelectOperator.WhereClause.Clear;
  (*
    { Добавляем дополнительное, вычисляемое поле }
    Field := TIntegerField.Create(DataSetWrap.DataSet);
    with Field do
    begin
    FieldName := 'TotalData';
    FieldKind := fkCalculated;
    Name := DataSetWrap.DataSet.Name + FieldName;
    DataSet := DataSetWrap.DataSet;
    end;
  *)
  // Создаём параметр "Код набора"
  FAdmissionParam := T_KParam.Create(Params, 'cse.idspecialityeducation');

  // Определяемся с именем изменяемой таблицы
  Provider.OnGetTableName := GetTableName;

  TNotifyEventWrap.Create(MySQLQuery.Wrap.AfterOpen, AfterQueryOpen);
  TNotifyEventWrap.Create(DataSetWrap.AfterOpen, AfterOpen);
  TNotifyEventWrap.Create(DataSetWrap.BeforePost, BeforePost);
  TNotifyEventWrap.Create(DataSetWrap.AfterPost, AfterPost);
  // TNotifyEventWrap.Create(DataSetWrap.OnCalcFields, OnCalcFields);
end;

destructor TDPOStudyPlans.Destroy;
begin
  // Уничтожаем дескриптор окна
  System.Classes.DeallocateHWnd(FWindowHandle);

  FreeAndNil(FEventList);
  inherited;
end;

procedure TDPOStudyPlans.AfterOpen(Sender: TObject);
begin
  DataSetWrap.SetFieldsRequired(False);
end;

procedure TDPOStudyPlans.AfterQueryOpen(Sender: TObject);
begin
  with MySQLQuery do
  begin
    Wrap.SetFieldsRequired(False);
    Wrap.SetProviderFlags([]);
    FieldByName(KeyFieldName).ProviderFlags := [pfInKey, pfInUpdate];
    FieldByName('IDCYCLESPECIALITYEDUCATION').ProviderFlags := [pfInUpdate];
    FieldByName('IDDISCIPLINENAME').ProviderFlags := [pfInUpdate];
    FieldByName('TOTAL').ProviderFlags := [pfInUpdate];
    FieldByName('LECTURES').ProviderFlags := [pfInUpdate];
    FieldByName('SEMINARS').ProviderFlags := [pfInUpdate];
    FieldByName('LABWORKS').ProviderFlags := [pfInUpdate];
    FieldByName('IDCHAIR').ProviderFlags := [pfInUpdate];
    FieldByName('ORDER_').ProviderFlags := [pfInUpdate];
  end;
end;

procedure TDPOStudyPlans.BeforePost(Sender: TObject);
var
  ASum: Integer;
begin
  if FInApplyAupdates then
    Exit;

  with DataSetWrap.DataSet do
  begin
    ASum := FieldByName('LecData').AsInteger + FieldByName('SemData').AsInteger
      + FieldByName('LabData').AsInteger + FieldByName('ZachData').AsInteger +
      FieldByName('ExamData').AsInteger;

    if ASum = 0 then
      raise Exception.Create
        ('В плане не указаны количество часов по лекциям, семинарам, лабораторным работам');

    // Если в StudyPlans не требуется вносить изменения
    if (FieldByName('LECTURES').AsInteger = FieldByName('LecData').AsInteger)
      and (FieldByName('SEMINARS').AsInteger = FieldByName('SemData').AsInteger)
      and (FieldByName('LABWORKS').AsInteger = FieldByName('LabData').AsInteger)
      and (FieldByName('Total').AsInteger = ASum) and
      (IDDisciplineName.OldValue = IDDisciplineName.NewValue) then
    begin
      Provider.BeforeUpdateRecord := MyBeforeUpdateRecord;
      // Подменяем сохранение
    end
    else
    begin
      Provider.BeforeUpdateRecord := nil; // Нормальное сохранение
    end;

    FieldByName('LECTURES').AsInteger := FieldByName('LecData').AsInteger;
    FieldByName('SEMINARS').AsInteger := FieldByName('SemData').AsInteger;
    FieldByName('LABWORKS').AsInteger := FieldByName('LabData').AsInteger;

    // Если общее кол-во часов по дисциплине меньше суммы, то корректируем его
    // if FieldByName('Total').AsInteger < ASum then
    FieldByName('Total').AsInteger := ASum;
  end;
  // начало транзакции
  FDBXTransaction := MySQLQuery.SQLConnection.BeginTransaction
    (TDBXIsolations.Create.RepeatableRead);
end;

procedure TDPOStudyPlans.AfterPost(Sender: TObject);
var
  ASQLInsertRecord: TSQLInsertRecord;
  ASQLQuery: TMySQLQuery;
  ASQLUpdateOperator: TSQLUpdateOperator;
  ASQLDeleteOperator: TSQLDeleteOperator;
var
  i: Integer;
begin
  if FInApplyAupdates then
    Exit;

  FInApplyAupdates := True;
  try
    if FDBXTransaction = nil then // начало транзакции
      FDBXTransaction := MySQLQuery.SQLConnection.BeginTransaction
        (TDBXIsolations.Create.RepeatableRead);

    try
      // Записываем в таблицу LessonTypes
      ASQLQuery := TMySQLQuery.Create(Self, 0);
      try

        for i := 1 to 5 do
        // Цикл по лекциям, лабам, семинарам, зачётам и экзаменам
        begin
          with DataSetWrap.DataSet do
          begin
            // Если добавить или обновить
            if FieldByName(Format('%sData', [FLessonTypesRecs[i].FieldName]))
              .AsInteger > 0 then
            begin
              // Если обновление
              if not FieldByName(Format('%sID', [FLessonTypesRecs[i].FieldName])
                ).IsNull then
              begin
                ASQLUpdateOperator := TSQLUpdateOperator.Create('LessonTypes');
                try
                  TFieldValue.Create(ASQLUpdateOperator.FieldValues, 'DATA',
                    FieldByName(Format('%sData', [FLessonTypesRecs[i].FieldName]
                    )).AsInteger);
                  ASQLUpdateOperator.WhereClause.Add
                    (Format('ID_LessonType = %d',
                    [FieldByName(Format('%sID', [FLessonTypesRecs[i].FieldName])
                    ).AsInteger]));

                  ASQLQuery.SQL.Text := ASQLUpdateOperator.SQL;
                  ASQLQuery.ExecSQL;
                finally
                  FreeAndNil(ASQLUpdateOperator);
                end;
              end
              else
              begin
                // Если добавление
                ASQLInsertRecord := TSQLInsertRecord.Create('LessonTypes');
                try
                  TFieldValue.Create(ASQLInsertRecord.FieldValues,
                    'IDSTUDYPLAN', FieldByName('ID_STUDYPLAN').AsInteger);
                  TFieldValue.Create(ASQLInsertRecord.FieldValues, 'IDTYPE',
                    FLessonTypesRecs[i].IDType);
                  TFieldValue.Create(ASQLInsertRecord.FieldValues, 'DATA',
                    FieldByName(Format('%sData', [FLessonTypesRecs[i].FieldName]
                    )).AsInteger);
                  TFieldValue.Create(ASQLInsertRecord.FieldValues,
                    'IDSpecialitySession', FieldByName('ID_SpecialitySession')
                    .AsInteger);

                  ASQLQuery.SQL.Text := ASQLInsertRecord.SQL;
                  ASQLQuery.ExecSQL;
                finally
                  FreeAndNil(ASQLInsertRecord);
                end;
              end;
            end
            else
            begin
              // Если удаление
              if not FieldByName(Format('%sID', [FLessonTypesRecs[i].FieldName])
                ).IsNull then
              begin
                ASQLDeleteOperator := TSQLDeleteOperator.Create('LessonTypes');
                try
                  ASQLDeleteOperator.WhereClause.Add
                    (Format('ID_LessonType = %d',
                    [FieldByName(Format('%sID', [FLessonTypesRecs[i].FieldName])
                    ).AsInteger]));

                  ASQLQuery.SQL.Text := ASQLDeleteOperator.SQL;
                  ASQLQuery.ExecSQL;
                finally
                  FreeAndNil(ASQLDeleteOperator);
                end
              end;
            end;
          end; // with
        end; // for
      finally
        FreeAndNil(ASQLQuery);
      end;
    except
      MySQLQuery.SQLConnection.RollbackIncompleteFreeAndNil(FDBXTransaction);
      raise;
    end;
    MySQLQuery.SQLConnection.CommitFreeAndNil(FDBXTransaction);

    // Обновляем текущую запись
    RefreshRecord;
  finally
    FInApplyAupdates := False;
  end;
end;

procedure TDPOStudyPlans.Commit(AIDSpecialitySession: Integer);
type
  TLessonTypeRec = record
    FieldName: string;
    IDType: Integer;
  end;

var
  ALessonTypes: array [1 .. 5] of TLessonTypeRec;
  ASQLInsertRecord: TSQLInsertRecord;
  ASQLQuery: TMySQLQuery;
  ASQLUpdateOperator: TSQLUpdateOperator;
  ASQLDeleteOperator: TSQLDeleteOperator;
var
  i: Integer;
begin
  Exit;
  Assert(AIDSpecialitySession > 0);

  ALessonTypes[1].FieldName := 'lec';
  ALessonTypes[1].IDType := 1;

  ALessonTypes[2].FieldName := 'lab';
  ALessonTypes[2].IDType := 2;

  ALessonTypes[3].FieldName := 'sem';
  ALessonTypes[3].IDType := 3;

  ALessonTypes[4].FieldName := 'zach';
  ALessonTypes[4].IDType := 6;

  ALessonTypes[5].FieldName := 'exam';
  ALessonTypes[5].IDType := 5;

  Assert(FDBXTransaction = nil);
  // начало транзакции
  FDBXTransaction := MySQLQuery.SQLConnection.BeginTransaction
    (TDBXIsolations.Create.RepeatableRead);
  try
    // Записываем в таблицу StudyPlans
    ClientDataSet.ApplyUpdates(-1);

    // Записываем в таблицу LessonTypes
    ASQLQuery := TMySQLQuery.Create(Self, 0);
    try

      for i := 1 to 5 do
      // Цикл по лекциям, лабам, семинарам, зачётам и экзаменам
      begin
        with DataSetWrap.DataSet do
        begin
          // Если добавить или обновить
          if FieldByName(Format('%sData', [ALessonTypes[i].FieldName]))
            .AsInteger > 0 then
          begin
            // Если обновление
            if not FieldByName(Format('%sID', [ALessonTypes[i].FieldName])).IsNull
            then
            begin
              ASQLUpdateOperator := TSQLUpdateOperator.Create('LessonTypes');
              try
                TFieldValue.Create(ASQLUpdateOperator.FieldValues, 'DATA',
                  FieldByName(Format('%sData', [ALessonTypes[i].FieldName]))
                  .AsInteger);
                ASQLUpdateOperator.WhereClause.Add(Format('ID_LessonType = %d',
                  [FieldByName(Format('%sID', [ALessonTypes[i].FieldName]))
                  .AsInteger]));

                ASQLQuery.SQL.Text := ASQLUpdateOperator.SQL;
                ASQLQuery.ExecSQL;
              finally
                FreeAndNil(ASQLUpdateOperator);
              end;
            end
            else
            begin
              // Если добавление
              ASQLInsertRecord := TSQLInsertRecord.Create('LessonTypes');
              try
                TFieldValue.Create(ASQLInsertRecord.FieldValues, 'IDSTUDYPLAN',
                  FieldByName('ID_STUDYPLAN').AsInteger);
                TFieldValue.Create(ASQLInsertRecord.FieldValues, 'IDTYPE',
                  ALessonTypes[i].IDType);
                TFieldValue.Create(ASQLInsertRecord.FieldValues, 'DATA',
                  FieldByName(Format('%sData', [ALessonTypes[i].FieldName]))
                  .AsInteger);
                TFieldValue.Create(ASQLInsertRecord.FieldValues,
                  'IDSPECIALITYSESSION', AIDSpecialitySession);

                ASQLQuery.SQL.Text := ASQLInsertRecord.SQL;
                ASQLQuery.ExecSQL;
              finally
                FreeAndNil(ASQLInsertRecord);
              end;
            end;
          end
          else
          begin
            // Если удаление
            if not FieldByName(Format('%sID', [ALessonTypes[i].FieldName])).IsNull
            then
            begin
              ASQLDeleteOperator := TSQLDeleteOperator.Create('LessonTypes');
              try
                ASQLDeleteOperator.WhereClause.Add(Format('ID_LessonType = %d',
                  [FieldByName(Format('%sID', [ALessonTypes[i].FieldName]))
                  .AsInteger]));

                ASQLQuery.SQL.Text := ASQLDeleteOperator.SQL;
                ASQLQuery.ExecSQL;
              finally
                FreeAndNil(ASQLDeleteOperator);
              end
            end;
          end;
        end; // with
      end; // for
    finally
      FreeAndNil(ASQLQuery);
    end;
  except
    MySQLQuery.SQLConnection.RollbackIncompleteFreeAndNil(FDBXTransaction);
    raise;
  end;
  MySQLQuery.SQLConnection.CommitFreeAndNil(FDBXTransaction);

  // Обновляем текущую запись
  RefreshRecord;
end;

procedure TDPOStudyPlans.Drop;
begin
  with DataSetWrap.DataSet do
    Delete;
  ClientDataSet.ApplyUpdates(-1);
end;

procedure TDPOStudyPlans.EditLessons(ADataFieldName: string);
var
  i: Integer;
  ALessonType: string;
  AIDLessonType: Integer;
  AIDDisciplineName: Integer;
  AfrmLessons: TfrmViewEx;
  ALessons: TLessons;
begin
  if not IsDataField(ADataFieldName) then
    Exit;

  if DataSetWrap.DataSet.FieldByName(ADataFieldName).AsInteger <= 0 then
    Exit;

  i := KPosText('Data', ADataFieldName);
  ALessonType := AnsiLeftStr(ADataFieldName, i - 1);

  AIDLessonType := Wrap.DataSet.FieldByName(ALessonType + 'ID').AsInteger;
  AIDDisciplineName := Wrap.DataSet.FieldByName('iddisciplinename').AsInteger;

  ALessons := TLessons.Create(Self);
  AfrmLessons := TfrmViewEx.Create(Self, 'Темы занятий', 'LessonsForm', [mbOk]);
  try
    AfrmLessons.ViewClass := TLessons_View;
    ALessons.BeginUpdate;
    try
      ALessons.IDDisciplineNameParam.ParamValue := AIDDisciplineName;
      ALessons.IDLessonTypeParam.ParamValue := AIDLessonType;
    finally
      ALessons.EndUpdate();
    end;
    AfrmLessons.View.SetDocument(ALessons);
    AfrmLessons.ShowModal;

  finally
    FreeAndNil(AfrmLessons);
    FreeAndNil(ALessons);
  end;
end;

function TDPOStudyPlans.GetIDDisciplineName: TField;
begin
  Result := Field('IDDisciplineName');
end;

function TDPOStudyPlans.IsDataField(AFieldName: string): Boolean;
begin
  Result := (KPosText('Data', AFieldName) > 3) and
    (KPosText('Total', AFieldName) = 0);
end;

procedure TDPOStudyPlans.MoveUp;
var
  ACurOrder: Integer;
  APriorOrder: Integer;
  APKValue: Variant;
begin
  // Перемещает дисциплину вверх в списке дисциплин

  Assert(FDBXTransaction = nil);
  // начало транзакции
  FDBXTransaction := MySQLQuery.SQLConnection.BeginTransaction
    (TDBXIsolations.Create.RepeatableRead);

  FInApplyAupdates := True; // Чтобы не обновлялось число часов
  try
    try
      with DataSetWrap.DataSet do
      begin
        ACurOrder := FieldByName('order_').AsInteger;
        APKValue := PKValue;
        Prior;
        if not Bof then
        begin
          APriorOrder := FieldByName('order_').AsInteger;
          Edit;
          FieldByName('order_').AsInteger := ACurOrder;
          Post;

          // Возвращаемся к первоначальной записи
          DataSetWrap.LocateByPK(APKValue);
          Edit;
          FieldByName('order_').AsInteger := APriorOrder;
          Post;
        end;
      end;
      MySQLQuery.SQLConnection.CommitFreeAndNil(FDBXTransaction);
    finally
      FInApplyAupdates := False;
    end;
  except
    MySQLQuery.SQLConnection.RollbackIncompleteFreeAndNil(FDBXTransaction);
    raise;
  end;
end;

procedure TDPOStudyPlans.MoveDown;
var
  ACurOrder: Integer;
  ANextOrder: Integer;
  APKValue: Variant;
begin
  // Перемещает дисциплину вверх в списке дисциплин

  Assert(FDBXTransaction = nil);
  // начало транзакции
  FDBXTransaction := MySQLQuery.SQLConnection.BeginTransaction
    (TDBXIsolations.Create.RepeatableRead);
  FInApplyAupdates := True; // Чтобы не обновлялось число часов
  try
    try
      with DataSetWrap.DataSet do
      begin
        ACurOrder := FieldByName('order_').AsInteger;
        APKValue := PKValue;
        Next;
        if not Eof then
        begin
          ANextOrder := FieldByName('order_').AsInteger;
          Edit;
          FieldByName('order_').AsInteger := ACurOrder;
          Post;

          // Возвращаемся к первоначальной записи
          DataSetWrap.LocateByPK(APKValue);
          Edit;
          FieldByName('order_').AsInteger := ANextOrder;
          Post;
        end;
      end;
      MySQLQuery.SQLConnection.CommitFreeAndNil(FDBXTransaction);
    finally
      FInApplyAupdates := False;
    end;
  except
    MySQLQuery.SQLConnection.RollbackIncompleteFreeAndNil(FDBXTransaction);
    raise;
  end;
end;

procedure TDPOStudyPlans.New(AIDDisciplineName, AIDCycleSpecialityEducation
  : Integer; ADisciplineName: string; AIDChair, AIDSpecialitySession: Integer);
begin
  Assert(AIDSpecialitySession > 0);
  with DataSetWrap.DataSet do
  begin
    if not(DataSetWrap.DataSet.State in [dsInsert, dsEdit]) then
      Insert;

    FieldByName('IDDisciplineName').AsInteger := AIDDisciplineName;
    FieldByName('IDCycleSpecialityEducation').AsInteger :=
      AIDCycleSpecialityEducation;
    FieldByName('DisciplineName').AsString := ADisciplineName;
    FieldByName('IDChair').AsInteger := AIDChair;
    FieldByName('ID_SpecialitySession').AsInteger := AIDSpecialitySession;
  end;
end;

procedure TDPOStudyPlans.OnCalcFields(Sender: TObject);
var
  Result: Integer;
  i: Integer;
begin
  // Необходимо посчитать общее число часов
  Result := 0;
  with DataSetWrap.DataSet do
  begin
    for i := 0 to DataSetWrap.DataSet.FieldCount - 1 do
    begin
      if (Fields[i] is TNumericField) and
        ( { Q_PosText } KPosText('Data', Fields[i].FieldName) > 0) then
        Result := Result + Fields[i].AsInteger;
    end;
    FieldByName('TotalData').AsInteger := Result;
  end;
end;

procedure TDPOStudyPlans.MyBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
begin
  // При обновлении записи не нужны никакие SQL запросы
  Applied := True;
end;

procedure TDPOStudyPlans.OnStudGroupChange(Sender: TObject);
begin
end;

procedure TDPOStudyPlans.SetStudGroups(const Value: TStudGroups);
begin
  if FStudGroups <> Value then
  begin
    FEventList.Clear;

    FStudGroups := Value;

    TNotifyEventWrap.Create(FStudGroups.OnEssenceChange, OnStudGroupChange);
  end;
end;

procedure TDPOStudyPlans.UpdateDisciplineName(AIDDisciplineName: Integer);
begin
  Assert(AIDDisciplineName > 0);
  DataSetWrap.DataSet.Edit;
  try
    DataSetWrap.DataSet.FieldByName('IDDisciplineName').AsInteger :=
      AIDDisciplineName;
    DataSetWrap.DataSet.Post;
  except
    DataSetWrap.DataSet.Cancel;
  end;
end;

procedure TDPOStudyPlans.UpdateGFLTeachers;
var
  AIDStudyPlan: Integer;
  AIDStudGroup: Integer;
  ABeforeUpdateRecordEvent: TBeforeUpdateRecordEvent;
begin
  if (DataSetWrap.DataSet.RecordCount <= 0) or
    (FStudGroups.DataSetWrap.DataSet.RecordCount <= 0) then
    Exit;

  AIDStudyPlan := PKValue;
  AIDStudGroup := FStudGroups.PKValue;

  FGFLTeachers.BeginUpdate;
  try
    FGFLTeachers.IDLessonTypeParam.ParamValue := 1;
    FGFLTeachers.IDStudyPlanParam.ParamValue := AIDStudyPlan;
    FGFLTeachers.IDStudGroupParam.ParamValue := AIDStudGroup;
  finally
    FGFLTeachers.EndUpdate();
  end;

  ABeforeUpdateRecordEvent := Provider.BeforeUpdateRecord;
  FInApplyAupdates := True;
  try
    Provider.BeforeUpdateRecord := OnRefreshApplyUpdates;

    DataSetWrap.DataSet.Edit;
    DataSetWrap.DataSet.FieldByName('LecTeachers').AsString :=
      FGFLTeachers.DataSetWrap.GetColumnValues('FIO');
    DataSetWrap.DataSet.Post;
  finally
    Provider.BeforeUpdateRecord := ABeforeUpdateRecordEvent;
    FInApplyAupdates := False;
  end;
end;

procedure TDPOStudyPlans.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_OnGroupChange then
      try
        UpdateGFLTeachers
      except
        on E: Exception do
          ShowMessage(E.Message);
      end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

constructor TDPOStudyPlans2.Create(AOwner: TComponent);
{ var
  Field: TIntegerField;
}
begin
  inherited;

  with FSQLSelectOperator do
  begin
    Tables.Clear;
    Tables.Add('SpecialityEducations se');

    Joins.Clear;
    Joins.Add('join CycleSpecialityEducations cse');
    Joins.WhereCondition.Add
      ('cse.idspecialityeducation = se.id_specialityeducation');

    Joins.Add('join STUDYPLANS sp');
    Joins.WhereCondition.Add
      ('sp.idcyclespecialityeducation = cse.id_cyclespecialityeducation');

    Joins.Add('LEFT JOIN specialitysessions ss');
    Joins.WhereCondition.Add
      ('ss.idspecialityeducation = se.id_specialityeducation');

    Joins.Add('join disciplinenames dn');
    Joins.WhereCondition.Add('sp.iddisciplinename = dn.id_disciplinename');

    Joins.Add('left join lessontypes lec');
    Joins.WhereCondition.Add('lec.idtype = 1');
    Joins.WhereCondition.Add('lec.idstudyplan = sp.id_studyplan');

    Joins.Add('left join lessontypes lab');
    Joins.WhereCondition.Add('lab.idtype = 2');
    Joins.WhereCondition.Add('lab.idstudyplan = sp.id_studyplan');

    Joins.Add('left join lessontypes sem');
    Joins.WhereCondition.Add('sem.idtype = 3');
    Joins.WhereCondition.Add('sem.idstudyplan = sp.id_studyplan');

    Joins.Add('left join lessontypes zach');
    Joins.WhereCondition.Add('zach.idtype = 6');
    Joins.WhereCondition.Add('zach.idstudyplan = sp.id_studyplan');

    Joins.Add('left join lessontypes exam');
    Joins.WhereCondition.Add('exam.idtype = 5');
    Joins.WhereCondition.Add('exam.idstudyplan = sp.id_studyplan');
  end;

  // Создаём параметр "Год"
  FYearParam := T_KParam.Create(Params, 'se.year');
end;

end.
