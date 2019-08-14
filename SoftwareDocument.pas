unit SoftwareDocument;

interface

uses
  DocumentView, SoftwareTypes, Software, System.Classes;

type
  TSoftwareDocument = class(TDocument)
  private
    FSoftware: TSoftware;
    FSoftwareTypes: TSoftwareTypes;
  public
    constructor Create(AOwner: TComponent); override;
    property Software: TSoftware read FSoftware;
    property SoftwareTypes: TSoftwareTypes read FSoftwareTypes;
  end;

implementation

constructor TSoftwareDocument.Create(AOwner: TComponent);
begin
  inherited;

  // Создаём типы ПО
  FSoftwareTypes := TSoftwareTypes.Create(Self);
  FSoftwareTypes.Refresh;

  // СОздаём список ПО
  FSoftware := TSoftware.Create(Self);
  FSoftware.Refresh;
end;

end.
