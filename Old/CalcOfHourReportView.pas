unit CalcOfHourReportView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ViewEx, StdCtrls, ExtCtrls, CalcOfHourReportDocument, GridComboBox,
  DocumentView;

type
  TviewCalcOfHourReport = class(TView_Ex)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnlYears: TPanel;
    pnlEducations: TPanel;
    pnlLevel: TPanel;
    pnlChair: TPanel;
  private
    FgcbChairs: TcxGridComboBoxView;
    FgcbEducations: TcxGridComboBoxView;
    FgcbLevel: TcxGridComboBoxView;
    FgcbYears: TcxGridComboBoxView;
    function GetDocument: TCalcOfHourReportDocument;
    { Private declarations }
  protected
    property Document: TCalcOfHourReportDocument read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    { Public declarations }
  end;

var
  viewCalcOfHourReport: TviewCalcOfHourReport;

implementation

{$R *.dfm}

constructor TviewCalcOfHourReport.Create(AOwner: TComponent; AParent:
    TWinControl; AAlign: TAlign = alClient);
begin
  inherited;
  FgcbYears := TcxGridComboBoxView.Create(Self, pnlYears);
  with FgcbYears do
  begin
    ListFieldName := 'year';
  end;

  FgcbEducations := TcxGridComboBoxView.Create(Self, pnlEducations);
  with FgcbEducations do
  begin
    ListFieldName := 'education';
  end;

  FgcbLevel := TcxGridComboBoxView.Create(Self, pnlLevel);
  with FgcbLevel do
  begin
    ListFieldName := 'level_';
  end;

  FgcbChairs := TcxGridComboBoxView.Create(Self, pnlChair);
  with FgcbChairs do
  begin
    ListFieldName := 'Department';
  end;
end;

function TviewCalcOfHourReport.GetDocument: TCalcOfHourReportDocument;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TCalcOfHourReportDocument;
end;

procedure TviewCalcOfHourReport.SetDocument(const Value: TDocument);
begin
  inherited;
  if FDocument <> nil then
  begin
    FgcbYears.SetDocument(Document.Year.DataSetWrap);
    FgcbEducations.SetDocument(Document.Education.DataSetWrap);
    FgcbLevel.SetDocument(Document.Level.DataSetWrap);
    FgcbChairs.SetDocument(Document.Chairs.DataSetWrap);
  end
  else
  begin
    FgcbYears.SetDocument(nil);
    FgcbEducations.SetDocument(nil);
    FgcbLevel.SetDocument(nil);
    FgcbChairs.SetDocument(nil);
  end;
end;

end.
