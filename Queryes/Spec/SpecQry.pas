unit SpecQry;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BaseQuery, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DSWrap;

type
  TSpecW = class(TDSWrap)
  private
    FChiper_Speciality: TFieldWrap;
    FID_Speciality: TFieldWrap;
    FSHORT_SPECIALITY: TFieldWrap;
    FSpeciality: TFieldWrap;
  public
    constructor Create(AOwner: TComponent);
    property Chiper_Speciality: TFieldWrap read FChiper_Speciality;
    property ID_Speciality: TFieldWrap read FID_Speciality;
    property SHORT_SPECIALITY: TFieldWrap read FSHORT_SPECIALITY;
    property Speciality: TFieldWrap read FSpeciality;
  end;

  TQrySpec = class(TQueryBase)
  private
    FW: TSpecW;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property W: TSpecW read FW;
    { Public declarations }
  end;

implementation

constructor TSpecW.Create(AOwner: TComponent);
begin
  inherited;
   FID_Speciality := TFieldWrap.Create(Self, 'ID_Speciality', '', True);
   FSpeciality := TFieldWrap.Create(Self, 'Speciality', 'Наименование');
   FChiper_Speciality := TFieldWrap.Create(Self, 'Chiper_Speciality', 'Код');
   FSHORT_SPECIALITY := TFieldWrap.Create(Self, 'SHORT_SPECIALITY',
    'Сокращение');

end;

constructor TQrySpec.Create(AOwner: TComponent);
begin
  inherited;
  FW := TSpecW.Create(FDQuery);
end;

{$R *.dfm}

end.
