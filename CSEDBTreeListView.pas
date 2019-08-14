unit CSEDBTreeListView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBTreeListView, cxGraphics, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, dxSkinsCore, dxSkinsDefaultPainters, cxControls,
  cxInplaceContainer, cxTLData, cxDBTL, cxMaskEdit, cxButtonEdit, DocumentView,
  cxLookAndFeels, cxLookAndFeelPainters;

type
  TvwdbtrlstCSE = class(TviewDBTreeList)
    cxdbtlViewcxDBTreeListColumn1: TcxDBTreeListColumn;
    cxdbtlViewcxDBTreeListColumn2: TcxDBTreeListColumn;
    cxdbtlViewcxDBTreeListColumn3: TcxDBTreeListColumn;
    procedure cxdbtlViewCompare(Sender: TcxCustomTreeList; ANode1, ANode2:
      TcxTreeListNode; var ACompare: Integer);
    procedure cxdbtlViewDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  WM_EDIT_CYCLE = WM_USER + 10;

implementation

{$R *.dfm}

procedure TvwdbtrlstCSE.cxdbtlViewCompare(Sender: TcxCustomTreeList; ANode1,
  ANode2: TcxTreeListNode; var ACompare: Integer);
var
  V1, V2: Integer;
begin
  try
    V1 := StrToInt( VarToStrDef( ANode1.Values[2], '0') );
    V2 := StrToInt( VarToStrDef( ANode2.Values[2], '0') );
    ACompare := V1 - V2;
  except
    ;
  end;
end;

procedure TvwdbtrlstCSE.cxdbtlViewDblClick(Sender: TObject);
begin
  PostMessage(Application.Handle, WM_EDIT_CYCLE, 0, 0);
end;

end.

