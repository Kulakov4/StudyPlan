unit ETPCatalog;

interface

uses
  EssenceEx, Data.DB;

type
  TETPCatalog = class(TEssenceEx2)
  private
  protected
    procedure CreateIndex; override;
    function GetValue: TField; virtual; abstract;
  public
    procedure AddNewValue(ANewValue: string);
    procedure DropUnused; virtual; abstract;
    property Value: TField read GetValue;
  end;

implementation

procedure TETPCatalog.AddNewValue(ANewValue: string);
begin
  DS.Append;
  Value.AsString := ANewValue;
  DS.Post;
end;

procedure TETPCatalog.CreateIndex;
begin
  ClientDataSet.AddIndex('idx1', Value.FieldName, []);
  ClientDataSet.IndexName := 'idx1';
end;

end.
