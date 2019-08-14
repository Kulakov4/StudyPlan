unit ThemeUnionControls;

interface

uses
  EssenceEx, System.Classes, K_Params, ControlNames, Data.DB,
  Datasnap.DBClient, DBRecordHolder, ThemeUnionDetails;

type
  TThemeUnionControl = class(TThemeUnionDetails)
  private
  protected
    procedure CreateIndex; override;
    function GetValue: TField; override;
  public
    constructor Create(AOwner: TComponent); override;
    function ToString(AIDThemeUnion: Integer): string; reintroduce;
  end;

implementation

uses System.SysUtils, KDBClient;

constructor TThemeUnionControl.Create(AOwner: TComponent);
//var
//  Field: TStringField;
begin
  FSynonymFileName := 'ThemeUnionControlFields.txt';

  inherited;

  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'thuc.ID_ThemeUnionControl';

  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  SequenceName := 'cdb_dat_study_process.THEMEUNIONCONTROLS_SEQ';

  with FSQLSelectOperator do
  begin
    Distinct := True;

    Fields.Add('thuc.*');
    Fields.Add('cn.ControlName');

    Tables.Add('disciplines d');

    Joins.Add('join LessonThemeHours lthh');
    Joins.WhereCondition.Add('lthh.IDDiscipline = d.id_discipline');

    Joins.Add('join lessonThemes lth');
    Joins.WhereCondition.Add('lthh.IDLessonTheme = lth.ID_LessonTheme');

    Joins.Add('join ThemeUnions thu');
    Joins.WhereCondition.Add('LTH.IDTHEMEUNION = THU.ID_THEMEUNION');

    Joins.Add('join ThemeUnionControls thuc');
    Joins.WhereCondition.Add('thuc.IDThemeUnion = THU.ID_THEMEUNION');

    Joins.Add('join ControlNames cn');
    Joins.WhereCondition.Add('THUC.IDCONTROLNAME = CN.ID_CONTROLNAME');

    OrderClause.Add('thuc.IDTHEMEUNION');
    OrderClause.Add('thuc.ID_THEMEUNIONCONTROL');
  end;

  FIDDisciplineParam := T_KParam.Create(Params, 'd.ID_Discipline');
  FIDDisciplineParam.ParamName := 'ID_Discipline';
(*
  FIDDisciplineParam.ParamValue := 0;

  SetSQLText;
  Wrap.CreateDefaultFields; // Создаём поля по умолчанию

  // Создаём справочник названий текущего контроля
  FControlNames := TControlNames.Create(Self);
  FControlNames.Refresh;

  { Добавляем дополнительное, подстановочное поле }
  Field := TStringField.Create(DataSetWrap.DataSet);
  with Field do
  begin
    FieldName := 'ControlName';
    Size := 100;
    FieldKind := fkLookup;
    Name := DS.Name + FieldName;
    KeyFields := 'IDControlName';
    LookUpDataset := FControlNames.DS;
    LookUpKeyFields := 'ID_ControlName';
    LookUpResultField := 'ControlName';
    DataSet := DS;
  end;
*)
  Wrap.ImmediateCommit := False;
  RefreshRecordAfterPost := False;
  UpdatingTableName := 'THEMEUNIONCONTROLS';
  UpdatingFieldNames.Add('IDThemeUnion');
  UpdatingFieldNames.Add('IDControlname');
end;

function TThemeUnionControl.ToString(AIDThemeUnion: Integer): string;
var
  AClone: TKClientDataSet;
begin
  AClone := TKClientDataSet.Create(Self);
  try
    AClone.CloneCursor(ClientDataSet, True);
    AClone.Filter := GetFilterExpression(AIDThemeUnion);
    AClone.Filtered := True;
    Result := AClone.Wrap.GetColumnValues('ControlName').ToLower;
  finally
    AClone.Free;
  end;
end;

procedure TThemeUnionControl.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1', 'IDTHEMEUNION;ID_THEMEUNIONCONTROL', []);
  ClientDataSet.IndexName := 'idx1';
end;

function TThemeUnionControl.GetValue: TField;
begin
  Result := Field('IDCONTROLNAME');
end;

end.
