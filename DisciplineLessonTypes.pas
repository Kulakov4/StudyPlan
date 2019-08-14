unit DisciplineLessonTypes;

interface

uses
  EssenceEx, System.Classes, K_Params;

type
  TDisciplineLessonTypes = class(TEssenceEx2)
  private
    FIDDisciplineParam: T_KFunctionParam;
  public
    constructor Create(AOwner: TComponent); override;
    property IDDisciplineParam: T_KFunctionParam read FIDDisciplineParam;
  end;

implementation

constructor TDisciplineLessonTypes.Create(AOwner: TComponent);
begin
  inherited;
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := True;

  with FSQLSelectOperator do
  begin
    Fields.Add('*');

    Tables.Add
      ('TABLE( CDB_DAT_UMK.UMKPACK.GetDisciplineLessonTypes(:IDDiscipline) )');
  end;

  FIDDisciplineParam := T_KFunctionParam.Create(Params, 'IDDiscipline');
end;

end.
