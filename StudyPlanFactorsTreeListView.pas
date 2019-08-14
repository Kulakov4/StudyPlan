unit StudyPlanFactorsTreeListView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBTreeListView, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, dxSkinsCore, dxSkinsDefaultPainters, cxInplaceContainer,
  cxTLData, cxDBTL, cxMaskEdit;

type
  TdbtlvStudyPlanFactors = class(TviewDBTreeList)
    cxdbtlViewcxDBTreeListColumn1: TcxDBTreeListColumn;
    procedure cxdbtlViewCustomDrawDataCell(Sender: TcxCustomTreeList;
      ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo;
      var ADone: Boolean);
    procedure cxdbtlViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure cxdbtlViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    FIDColumn: TcxDBTreeListColumn;
    FIDParentColumn: TcxDBTreeListColumn;
    FVerifyResultColumn: TcxDBTreeListColumn;
    { Private declarations }
  protected
    procedure DoOnInitTreeListView(Sender: TObject);
    procedure OnVerifyResultGetDisplayText(Sender: TcxTreeListColumn;
      ANode: TcxTreeListNode; var Value: string);
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl;
      AAlign: TAlign = alClient); override;
    property IDColumn: TcxDBTreeListColumn read FIDColumn;
    property IDParentColumn: TcxDBTreeListColumn read FIDParentColumn;
    { Public declarations }
  end;

implementation

uses
  NotifyEvents, DB, SPViewDM;

{$R *.dfm}

constructor TdbtlvStudyPlanFactors.Create(AOwner: TComponent;
  AParent: TWinControl; AAlign: TAlign = alClient);
begin
  inherited;
  TNotifyEventWrap.Create(OnInitTreeListView, DoOnInitTreeListView);
end;

procedure TdbtlvStudyPlanFactors.cxdbtlViewCustomDrawDataCell
  (Sender: TcxCustomTreeList; ACanvas: TcxCanvas;
  AViewInfo: TcxTreeListEditCellViewInfo; var ADone: Boolean);
var
  ANode: TcxDBTreeListNode;
  ARect: TRect;
  V: Variant;
begin
  inherited;
  try
    // Если сейчас рисуем колонку результата
    if (AViewInfo.Column = FVerifyResultColumn) then
    begin
      ANode := AViewInfo.Node as TcxDBTreeListNode;
      V := ANode.Values[FVerifyResultColumn.Position.ColIndex];
      // Если результат проверки критерия отрицательный
      if (V = 0) then
      begin
        ACanvas.Font.Color := clWhite;
        ACanvas.Brush.Color := clRed;
      end;

      ARect := AViewInfo.BoundsRect;
      ARect.Inflate(-2, -2);
      // Рисуем в ячейке
      ACanvas.FillRect(ARect);
      ACanvas.DrawText(ANode.Texts[FVerifyResultColumn.Position.ColIndex],
        ARect, cxAlignCenter);
      ADone := True;

    end;
  except
    ;
  end;
end;

procedure TdbtlvStudyPlanFactors.cxdbtlViewDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  DBTreeList: TcxDBTreeList;
  // NewParentValue: Variant;
  { AOrderField, } AParentField: TField;
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

procedure TdbtlvStudyPlanFactors.cxdbtlViewDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Sender = Source;
end;

procedure TdbtlvStudyPlanFactors.DoOnInitTreeListView(Sender: TObject);
var
  Band: TcxTreeListBand;
begin
  // затираем старые столбики
  with cxdbtlView do
  begin
    Bands.Clear;
    DeleteAllColumns;
    if not(Sender as TviewDBTreeList).HaveDocument then
      Exit;

    Styles.Footer := DM.cxstyl14;

    // добавляем главный банд
    Band := Bands.Add;
    Band.Caption.AlignHorz := taCenter;
    // Band.FixedKind := tlbfLeft;
    Band.Styles.Header := DM.cxStyl10;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'id_studyplanfactor';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'id_studyplanfactor';
      FIDColumn := GetColumnByFieldName(DataBinding.FieldName);
      Caption.AlignHorz := taCenter;
      Width := 60;
      Options.Editing := False;
      RepositoryItem := DM.cxEditRepository1Label1;
      Visible := False;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'idUpstudyplanfactor';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'idUpstudyplanfactor';
      FIDParentColumn := GetColumnByFieldName(DataBinding.FieldName);
      Caption.AlignHorz := taCenter;
      Width := 60;
      Options.Editing := False;
      RepositoryItem := DM.cxEditRepository1Label1;
      Visible := False;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Группа критериев';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'factorgroupname';
      Caption.AlignHorz := taCenter;
      Width := 160;
      Styles.Header := DM.cxStyl10;
      Options.Editing := False;

      Visible := False;
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

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Дата проверки';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'verifyDate';
      Caption.AlignHorz := taCenter;
      Width := 100;
      Styles.Header := DM.cxStyl10;
      Options.Editing := False;

      Visible := True;
    end;

    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Результат запроса';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'QueryResult';
      Caption.AlignHorz := taCenter;
      Width := 60;
      Styles.Header := DM.cxStyl10;
      Options.Editing := False;

      Visible := True;
    end;
    {
      with CreateColumn as TcxDBTreeListColumn do
      begin
      Caption.Text := 'Условие';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'RuleDescription';
      Caption.AlignHorz := taCenter;
      Width := 100;
      Styles.Header := DM.cxStyl10;
      Options.Editing := False;

      Visible := True;
      end;
    }
    with CreateColumn as TcxDBTreeListColumn do
    begin
      Caption.Text := 'Результат';
      Position.BandIndex := 0;
      DataBinding.FieldName := 'verifyResult';
      FVerifyResultColumn := GetColumnByFieldName(DataBinding.FieldName);
      Assert(FVerifyResultColumn <> nil);
      Caption.AlignHorz := taCenter;
      Width := 100;
      Styles.Header := DM.cxStyl10;
      Options.Editing := False;
      OnGetDisplayText := OnVerifyResultGetDisplayText;

      Visible := True;
    end;
  end;
end;

procedure TdbtlvStudyPlanFactors.OnVerifyResultGetDisplayText
  (Sender: TcxTreeListColumn; ANode: TcxTreeListNode; var Value: string);
var
  V: Variant;
begin
  V := ANode.Values[Sender.Position.ColIndex];
  if V = 1 then
    Value := 'Выполняется';
  if V = 0 then
    Value := 'Не выполняется';
end;

end.
