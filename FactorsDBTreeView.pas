unit FactorsDBTreeView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBTreeListView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, dxSkinsCore, dxSkinsDefaultPainters, cxInplaceContainer,
  cxTLData, cxDBTL;

type
  TdbtlvFactors = class(TviewDBTreeList)
    procedure cxdbtlViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure cxdbtlViewDragOver(Sender, Source: TObject; X, Y: Integer; State:
        TDragState; var Accept: Boolean);
  private
    { Private declarations }
  protected
    procedure DoOnInitTreeListView(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AAlign: TAlign =
        alClient); override;
    { Public declarations }
  end;

implementation

uses
  NotifyEvents, SPViewDM, DB;

{$R *.dfm}

constructor TdbtlvFactors.Create(AOwner: TComponent; AParent: TWinControl;
    AAlign: TAlign = alClient);
begin
  inherited;
  TNotifyEventWrap.Create(OnInitTreeListView, DoOnInitTreeListView);
end;

procedure TdbtlvFactors.cxdbtlViewDragDrop(Sender, Source: TObject; X, Y:
    Integer);
var
  DBTreeList: TcxDBTreeList;
  //NewParentValue: Variant;
  {AOrderField, }AParentField: TField;
begin
  if (Sender = Source) and (Sender = cxdbtlView) then
  begin
    if cxdbtlView.HitTest.HitState in [echc_Empty, 16] then
    begin

    DBTreeList := Sender as TcxDBTreeList;
    DBTreeList.BeginUpdate;
    try
      with DBTreeList.DataController do
      begin
        DataSet.DisableControls;
        AParentField := DataSet.FieldByName(ParentField);
        //AOrderField := DataSet.FieldByName('order');
        DataSet.Edit;
        AParentField.Value := NULL;
        DataSet.Post;
        DataSet.EnableControls;
      end;
    finally
      DBTreeList.EndUpdate;
    end;
    end;
  end;
end;

procedure TdbtlvFactors.cxdbtlViewDragOver(Sender, Source: TObject; X, Y:
    Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Sender = Source;
end;

procedure TdbtlvFactors.DoOnInitTreeListView(Sender: TObject);
var
  Band: TcxTreeListBand;
//  ALevel: Integer;
//  ASession: Integer;
//  ASemestr: Integer;
//  ID_Session: Integer;
//  c: TcxStyle;
begin
  // затираем старые столбики
  with cxdbtlView do
  begin
    Bands.Clear;
    DeleteAllColumns;
    if not(Sender as TviewDBTreeList).HaveDocument then
      Exit;

//    c := nil;
    Styles.Footer := DM.cxstyl14;

    // добавляем главный банд
    Band := Bands.Add;
    Band.Caption.AlignHorz := taCenter;
    //Band.FixedKind := tlbfLeft;
    Band.Styles.Header := DM.cxStyl10;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'id_factor';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'id_factor';
      Caption.AlignHorz := taCenter;
      Width := 60;
      Options.Editing := False;
      RepositoryItem := DM.cxEditRepository1Label1;
      Visible := false;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'IDParentFactor';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'IDParentFactor';
      Caption.AlignHorz := taCenter;
      Width := 60;
      Options.Editing := False;
      RepositoryItem := DM.cxEditRepository1Label1;
      Visible := false;
    end;


    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Критерий';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'factorname';
      Caption.AlignHorz := taCenter;
      Width := 400;
      Styles.Header := DM.cxStyl10;
      Options.Editing := False;

      Visible := True;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Описание';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'Description';
      Caption.AlignHorz := taCenter;
      Width := 160;
      Styles.Header := DM.cxStyl10;
      Options.Editing := False;

      Visible := True;
    end;
  end;
end;

end.
