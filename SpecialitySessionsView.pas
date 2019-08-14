unit SpecialitySessionsView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataSetView_2, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, ExtCtrls, TB2Dock,
  DataSetControlsView, DisciplineNames, DocumentView, SpecialitySessions,
  ActnList, ImgList, TB2Item, TB2Toolbar, cxTextEdit, cxLabel,
  cxLookAndFeels, cxLookAndFeelPainters, EssenceGridView, cxNavigator,
  System.Actions, cxDataControllerConditionalFormattingRulesManagerDialog,
  System.ImageList;

type
  TgvSpecialitySessions = class(TdsgvEssence)
    TBToolbar1: TTBToolbar;
    TBImageList1: TTBImageList;
    ActionList1: TActionList;
    actUpLevel: TAction;
    actDownLevel: TAction;
    tbiUpLevel: TTBItem;
    tbiDownLevel: TTBItem;
    tbdckLeft: TTBDock;
    actUpLevelYear: TAction;
    actDownLevelYear: TAction;
    tbdckRight: TTBDock;
    TBToolbar2: TTBToolbar;
    tbiLevelYearUp: TTBItem;
    tbiLevelYearDown: TTBItem;
    TBSeparatorItem1: TTBSeparatorItem;
    TBSeparatorItem2: TTBSeparatorItem;
    TBSeparatorItem3: TTBSeparatorItem;
    TBSeparatorItem4: TTBSeparatorItem;
    actAddLevel: TAction;
    tbiAddLevel: TTBItem;
    procedure actAddLevelExecute(Sender: TObject);
    procedure actAddLevelUpdate(Sender: TObject);
    procedure actDownLevelExecute(Sender: TObject);
    procedure actDownLevelYearExecute(Sender: TObject);
    procedure actUpLevelExecute(Sender: TObject);
    procedure actUpLevelUpdate(Sender: TObject);
    procedure actUpLevelYearExecute(Sender: TObject);
  private
    function GetDocument: TSpecialitySessions;
    { Private declarations }
  protected
    procedure InitColumn(AcxGridDBBandedColumn: TcxGridDBBandedColumn); override;
    property Document: TSpecialitySessions read GetDocument;
  public
    { Public declarations }
  end;

implementation

uses cxSpinEdit;

{$R *.dfm}

procedure TgvSpecialitySessions.actAddLevelExecute(Sender: TObject);
begin
  Document.AddLevel;
end;

procedure TgvSpecialitySessions.actAddLevelUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (Document.DS.State in [dsBrowse]);
end;

procedure TgvSpecialitySessions.actDownLevelExecute(Sender: TObject);
begin
  Document.DownLevel;
end;

procedure TgvSpecialitySessions.actDownLevelYearExecute(Sender: TObject);
begin
  Document.DownLevelYear;
end;

procedure TgvSpecialitySessions.actUpLevelExecute(Sender: TObject);
begin
  Document.UpLevel;
end;

procedure TgvSpecialitySessions.actUpLevelUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (Document.DS.State in [dsBrowse]) and
  (Document.DS.RecordCount > 1);
end;

procedure TgvSpecialitySessions.actUpLevelYearExecute(Sender: TObject);
begin
  Document.UpLevelYear;
end;

function TgvSpecialitySessions.GetDocument: TSpecialitySessions;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TSpecialitySessions;
end;

procedure TgvSpecialitySessions.InitColumn(AcxGridDBBandedColumn:
    TcxGridDBBandedColumn);
begin
    AcxGridDBBandedColumn.HeaderAlignmentHorz := taCenter;
    AcxGridDBBandedColumn.HeaderAlignmentVert := vaCenter;

  if AnsiSameText('Level_', AcxGridDBBandedColumn.DataBinding.FieldName) or
     AnsiSameText('Level_year', AcxGridDBBandedColumn.DataBinding.FieldName) then
  begin
    AcxGridDBBandedColumn.PropertiesClass := TcxLabelProperties;
    (AcxGridDBBandedColumn.Properties as TcxLabelProperties).Alignment.Vert := taVCenter;
    (AcxGridDBBandedColumn.Properties as TcxLabelProperties).Alignment.Horz := taCenter;
    AcxGridDBBandedColumn.Options.CellMerging := True;
  end;

  if AnsiSameText('Session_in_level', AcxGridDBBandedColumn.DataBinding.FieldName) then
  begin
    AcxGridDBBandedColumn.PropertiesClass := TcxSpinEditProperties;
  end;
end;

end.
 