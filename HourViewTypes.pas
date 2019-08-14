unit HourViewTypes;

interface

uses
  EssenceEx, System.Classes;

type
  THourViewTypes = class(TEssenceEx2)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

constructor THourViewTypes.Create(AOwner: TComponent);
begin
  inherited;
  FSynonymFileName := 'HourViewTypeFields.txt';
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'htv.ID_HourViewType';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  with FSQLSelectOperator do
  begin
    Fields.Add('hvt.ID_HourViewType');
    Fields.Add('hvt.HourViewType');

    Tables.Add('HourViewTypes hvt');

    OrderClause.Add('hvt.ID_HourViewType');
  end;
end;

end.
