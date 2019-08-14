unit QualificationQuery;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TQualificationsW = class;

  TQryQualifications = class(TQueryBase)
  private
    FW: TQualificationsW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TQualificationsW read FW;
    { Public declarations }
  end;

  TQualificationsW = class(TDSWrap)
  private
    FQualification: TFieldWrap;
    FID: TFieldWrap;
  public
    constructor Create(AOwner: TComponent); override;
    property Qualification: TFieldWrap read FQualification;
    property ID: TFieldWrap read FID;
  end;

implementation

constructor TQualificationsW.Create(AOwner: TComponent);
begin
  inherited;
  FID := TFieldWrap.Create(Self, 'ID', '', True);
  FQualification := TFieldWrap.Create(Self, 'Qualification', 'Квалификация');
end;

constructor TQryQualifications.Create(AOwner: TComponent);
begin
  inherited;
  FW := TQualificationsW.Create(FDQuery);
end;

{$R *.dfm}

end.
