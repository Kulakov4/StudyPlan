unit LessonsView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataSetView_2, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, ExtCtrls,
  ActnList, Menus, cxGridCustomPopupMenu, cxGridPopupMenu, Lessons,
  DocumentView, TB2Dock, DataSetControlsView, ImgList, TB2Item, TB2Toolbar,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, EssenceGridView, cxNavigator, System.Actions;
type
  TLessons_View = class(TdsgvEssence)
    cxgrdpmn1: TcxGridPopupMenu;
    pm1: TPopupMenu;
    actlst1: TActionList;
    actEditLessonName: TAction;
    N1: TMenuItem;
    tbil1: TTBImageList;
    tb1: TTBToolbar;
    tbi1: TTBItem;
    procedure actEditLessonNameExecute(Sender: TObject);
  private
    function GetDocument: TLessons;
    { Private declarations }
  public
    property Document: TLessons read GetDocument;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TLessons_View.actEditLessonNameExecute(Sender: TObject);
var
  i: Integer;
  AIDLessons: string;
  ADelimiter: string;
  ALessonName: string;
begin
  ALessonName := '';
  ADelimiter := ',';
  AIDLessons := ADelimiter;
  with cxgridDBBandedTableView do
  begin
    if Controller.SelectedRowCount > 0 then
    begin
      BeginUpdate;
      try
        for i := 0 to Controller.SelectedRowCount - 1 do
        begin
          AIDLessons := AIDLessons + Controller.SelectedRows[i].DisplayTexts[0]
            + ADelimiter;
        end;
      finally
        EndUpdate;
      end;
      ALessonName := Controller.SelectedRows[0].DisplayTexts[2];
    end;
  end;
  if AIDLessons <> ADelimiter then
  begin
    if InputQuery( '¬вод темы', '¬ведите тему зан€ти€', ALessonName) then
      Document.SetLessonName(ALessonName, AIDLessons, ADelimiter);
  end;
end;

function TLessons_View.GetDocument: TLessons;
begin
  Assert(FDocument <> nil);
  Result := FDocument as TLessons;
end;

end.

