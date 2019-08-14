unit DisciplinePurposeView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewEx, DocumentView,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, cxMemo, cxDBEdit,
  cxLabel, Vcl.ExtCtrls, TB2Dock, DataSetControlsView, StudyPlanInfo;

type
  TviewDisciplinePurpose = class(TView_Ex)
    gpMain: TGridPanel;
    cxlbl1: TcxLabel;
    cxdbmPurpose: TcxDBMemo;
    cxLabel1: TcxLabel;
    cxdbmTask: TcxDBMemo;
    tbdckTop: TTBDock;
  private
    FDataSetControls_View: TDataSetControls_View;
    function GetDocument: TStudyPlanInfo;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    procedure SetDocument(const Value: TDocument); override;
    property DataSetControls_View: TDataSetControls_View read FDataSetControls_View;
    property Document: TStudyPlanInfo read GetDocument;
    { Public declarations }
  end;


implementation

{$R *.dfm}

constructor TviewDisciplinePurpose.Create(AOwner: TComponent; AParent:
    TWinControl; AAlign: TAlign = alClient);
begin
  inherited;
  FDataSetControls_View := TDataSetControls_View.Create( Self, tbdckTop );
  FDataSetControls_View.AllowInsert := False;
  FDataSetControls_View.AllowDelete := False;
//  FDataSetControls_View.AllowEdit := True;
end;

function TviewDisciplinePurpose.GetDocument: TStudyPlanInfo;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TStudyPlanInfo;
end;

procedure TviewDisciplinePurpose.SetDocument(const Value: TDocument);
begin

  inherited;

  if FDocument <> nil then
  begin
    FDataSetControls_View.SetDocument( Document.DataSetWrap );

    cxdbmPurpose.DataBinding.DataSource := Document.DataSetWrap.DataSource;
    cxdbmPurpose.DataBinding.DataField := 'Purpose';

    cxdbmTask.DataBinding.DataSource := Document.DataSetWrap.DataSource;
    cxdbmTask.DataBinding.DataField := 'Task';
  end
  else
  begin
  end;

end;

end.
