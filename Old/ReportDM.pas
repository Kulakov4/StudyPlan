unit ReportDM;

interface

uses
  SysUtils, Classes, frxServerClient, frxClass, frxExportXLS, frxExportPDF;

type
  TDMReport = class(TDataModule)
    frxReportClient1: TfrxReportClient;
    frxServerConnection1: TfrxServerConnection;
    frxPDFExport1: TfrxPDFExport;
    frxXLSExport1: TfrxXLSExport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMReport: TDMReport;

implementation

{$R *.dfm}

end.
