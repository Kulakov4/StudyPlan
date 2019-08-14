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

  // ������ ������ �� ��� �������
  if SP.AccessLevel < 10 then
  begin
    Result := alAdmin;
    Exit;
  end;

  // ������ ������ � ����� �������
  if SP.AccessLevel < 15 then
  begin
    Result := alMethodist;
    Exit;
  end;

  // ������ ������ � �������� ��������������� � ���λ ��� ����� �������
  if SP.AccessLevel < 20 then
  begin
    Result := alManager;
    Exit;
  end;

  // ������ ������ �� ��� �������
  if SP.AccessLevel = 20 then
  begin
    Result := alAllReadOnly;
    Exit;
  end;

  // ������ ������ �� ��� ������� ��� ������ � ����� �������
  Result := alTeacher;
end;

class function TOptions.SP: TStudyPlanOptions;
begin
  Assert(StudyProcessOptions <> nil);
  Result := StudyProcessOptions as TStudyPlanOptions;
end;

end.
