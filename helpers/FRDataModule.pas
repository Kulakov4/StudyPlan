unit FRDataModule;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDesgn, frxExportPDF,
  frxExportXLSX, frxExportDOCX, frxExportXLS, frxExportBaseDialog;

type
  TFRDM = class(TDataModule)
    frxReport: TfrxReport;
    frxDesigner: TfrxDesigner;
    frxXLSExport1: TfrxXLSExport;
    frxDOCXExport1: TfrxDOCXExport;
    frxXLSXExport1: TfrxXLSXExport;
    frxPDFExport1: TfrxPDFExport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
