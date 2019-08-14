unit Dumb;

interface

uses
  EssenceEx, System.Classes, Data.DB;

type
  TDumb = class(TEssenceEx2)
  private
    function GetID: TField;
  public
    constructor Create(AOwner: TComponent); override;
    property ID: TField read GetID;
  end;

implementation

constructor TDumb.Create(AOwner: TComponent);
begin
  inherited;
  Wrap.ImmediateCommit := False;
  DataSetWrap.MultiSelectDSWrap.FullKeyFieldName := 'ID';
  DataSetWrap.MultiSelectDSWrap.UseInactiveStyle := False;

  with FSQLSelectOperator do
  begin
    Fields.Add('0 ID');

    Tables.Add('dual');
  end;
end;

function TDumb.GetID: TField;
begin
  Result := Field('ID');
end;

end.
