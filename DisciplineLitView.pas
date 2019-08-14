unit DisciplineLitView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EssenceGridView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, TB2Dock,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  Vcl.ExtCtrls, DisciplineLit, System.Actions, Vcl.ActnList, TB2Item, TB2Toolbar,
  cxDataControllerConditionalFormattingRulesManagerDialog{,
  Cromis.Comm.IPC};

type
  TviewDisciplineLit = class(TdsgvEssence)
    ActionList: TActionList;
    actAdd: TAction;
    TBToolbar1: TTBToolbar;
    TBItem1: TTBItem;
    procedure actAddExecute(Sender: TObject);
  private
    function GetDocument: TDisciplineLit;
    { Private declarations }
  protected
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn); override;
    property Document: TDisciplineLit read GetDocument;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses LibConnector, System.SyncObjs, cxTextEdit;

constructor TviewDisciplineLit.Create(AOwner: TComponent; AParent: TWinControl;
    AAlign: TAlign = alClient);
begin
  inherited;
  DataSetControls_View.actAdd.Visible := False;

//  FIPCServer := TIPCServer.Create;
//  FIPCServer.ServerName := 'StudyPlanIPCServer2';
{
  FIPCServer.OnServerError := OnServerError;
  FIPCServer.OnClientConnect := OnClientConnect;
}
//  FIPCServer.OnExecuteRequest := OnExecuteRequest;
{
  FIPCServer.OnClientDisconnect := OnClientDisconnect;
}
//  FIPCServer.Start;
end;

procedure TviewDisciplineLit.actAddExecute(Sender: TObject);
begin
  inherited;
  LibraryConnector.FindBooks;
end;

function TviewDisciplineLit.GetDocument: TDisciplineLit;
begin
  Assert(Esscence <> nil);
  Result := Esscence as TDisciplineLit;
end;

procedure TviewDisciplineLit.InitColumn(AcxGridDBBandedColumn:
    TcxGridDBBandedColumn);
begin
  if AnsiSameText(AcxGridDBBandedColumn.DataBinding.FieldName, 'Literature') then
  begin
    AcxGridDBBandedColumn.PropertiesClass := TcxTextEditProperties;
    (AcxGridDBBandedColumn.Properties as TcxTextEditProperties).ReadOnly := True;
    (AcxGridDBBandedColumn.Properties as TcxTextEditProperties).IncrementalSearch := True;
    AcxGridDBBandedColumn.Editing := False;
  end;
end;


end.
