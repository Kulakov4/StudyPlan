unit OptionsHelper;

interface

uses
  CommissionOptions;

type
  TAccessLevel = (alTeacher, alAllReadOnly, alManager, alMethodist, alAdmin);

  TOptions = class(TObject)
  private
  public
    class function AccessLevel: TAccessLevel; static;
    class function SP: TStudyPlanOptions; static;
  end;

implementation

class function TOptions.AccessLevel: TAccessLevel;
begin
  Assert(SP.AccessLevel > 0);

  // Полный доступ на все кафедры
  if SP.AccessLevel < 10 then
  begin
    Result := alAdmin;
    Exit;
  end;

  // Полный доступ к своей кафедре
  if SP.AccessLevel < 15 then
  begin
    Result := alMethodist;
    Exit;
  end;

  // Полный доступ к вкладкам «Переподготовка» и «ДПО» для своей кафедры
  if SP.AccessLevel < 20 then
  begin
    Result := alManager;
    Exit;
  end;

  // Только чтение на все кафедры
  if SP.AccessLevel = 20 then
  begin
    Result := alAllReadOnly;
    Exit;
  end;

  // Только чтение на все кафедры или только к своей кафедре
  Result := alTeacher;
end;

class function TOptions.SP: TStudyPlanOptions;
begin
  Assert(StudyProcessOptions <> nil);
  Result := StudyProcessOptions as TStudyPlanOptions;
end;

end.
