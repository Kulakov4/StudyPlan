unit EdLevelQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TEdLevelW = class;

  TQueryEdLevel = class(TQueryBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TEdLevelW = class(TDSWrap)
  private
    FID_Education_Level: TFieldWrap;
    FEducation_Level: TFieldWrap;
    FIDEducationType: TFieldWrap;
    FShort_Education_Level: TFieldWrap;
    FOrd: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property ID_Education_Level: TFieldWrap read FID_Education_Level;
    property Education_Level: TFieldWrap read FEducation_Level;
    property IDEducationType: TFieldWrap read FIDEducationType;
    property Short_Education_Level: TFieldWrap read FShort_Education_Level;
    property Ord: TFieldWrap read FOrd;
  end;

implementation

constructor TEdLevelW.Create(AOwner: TComponent);
begin
  inherited;
  FID_Education_Level := TFieldWrap.Create(Self, 'ID_Education_Level', '', True);
  FEducation_Level := TFieldWrap.Create(Self, 'Education_Level', 'Наименование');
  FShort_Education_Level := TFieldWrap.Create(Self, 'Short_Education_Level', 'Сокращение');
  FOrd := TFieldWrap.Create(Self, 'Ord');  
  FIDEducationType := TFieldWrap.Create(Self, 'IDEducationType');    
end;

{$R *.dfm}

end.
