unit SPDBTreeListView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBTreeListView, cxGraphics, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, dxSkinsCore, dxSkinsDefaultPainters, cxControls,
  cxInplaceContainer, cxTLData, cxDBTL, DocumentView, cxMaskEdit, Menus,
  ExtCtrls, ActnList, cxEdit, cxLookAndFeels, cxLookAndFeelPainters,
  cxClasses, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TviewDBTreeListSP = class(TviewDBTreeList)
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxdbtlViewcxDBTreeListColumn1: TcxDBTreeListColumn;
    procedure cxdbtlViewCompare(Sender: TcxCustomTreeList;
      ANode1, ANode2: TcxTreeListNode; var ACompare: Integer);
    procedure cxdbtlViewCustomDrawDataCell(Sender: TcxCustomTreeList;
      ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo;
      var ADone: Boolean);
    procedure cxdbtlViewEditing(Sender: TcxCustomTreeList;
      AColumn: TcxTreeListColumn; var Allow: Boolean);
    procedure cxdbtlViewIsGroupNode(Sender: TcxCustomTreeList;
      ANode: TcxTreeListNode; var IsGroup: Boolean);
  private
    FCSE_ORDColumn: TcxDBTreeListColumn;
    FCodeColumn: TcxDBTreeListColumn;
    FLecSumCol: TcxDBTreeListColumn;
    FSemSumCol: TcxDBTreeListColumn;
    FLabSumCol: TcxDBTreeListColumn;
    FISOptionColumn: TcxDBTreeListColumn;
    FLecCol: TcxDBTreeListColumn;
    FPositionColumn: TcxDBTreeListColumn;
    FIDSPColumn: TcxDBTreeListColumn;
    FDisciplineNameColumn: TcxDBTreeListColumn;
    FSemCol: TcxDBTreeListColumn;
    FLabCol: TcxDBTreeListColumn;
    FTotalColumn: TcxDBTreeListColumn;
    FIDHourViewTypeColumn: TcxDBTreeListColumn;
    FSelfCol: TcxDBTreeListColumn;
    FSelfSumCol: TcxDBTreeListColumn;
    { Private declarations }
  protected
    procedure InitTreeListView; override;
  public
    property IDSPColumn: TcxDBTreeListColumn read FIDSPColumn;
    { Public declarations }
  end;

implementation

uses {QStrings,} DataSetWrap, SPViewDM, DB;

{$R *.dfm}

procedure TviewDBTreeListSP.cxdbtlViewCompare(Sender: TcxCustomTreeList;
  ANode1, ANode2: TcxTreeListNode; var ACompare: Integer);
var
  S1: string;
  S2: string;
  i: Integer;
//  i1: Integer;
//  i2: Integer;
begin
  // Exit;

  try
    Assert(FCSE_ORDColumn <> nil);
    Assert(FIDSPColumn <> nil);

//    i := FIDSPColumn.ItemIndex;
//    i1 := StrToInt(VarToStrDef(ANode1.Values[i], '0'));
//    i2 := StrToInt(VarToStrDef(ANode2.Values[i], '0'));
//    if (i1 < 0) or (i2 < 0) then
//      beep;

    i := FCSE_ORDColumn.ItemIndex;
    ACompare := StrToInt(VarToStrDef(ANode1.Values[i], '0')) -
      StrToInt(VarToStrDef(ANode2.Values[i], '0'));
    if ACompare = 0 then // Если дисциплины находятся в одном цикле
    begin
      // Сортируем согласно признаку "по выбору"
      Assert(FISOptionColumn <> nil);
      i := FISOptionColumn.ItemIndex;
      ACompare := StrToInt(VarToStrDef(ANode1.Values[i], '0')) -
        StrToInt(VarToStrDef(ANode2.Values[i], '0'));
      if ACompare = 0 then
      // Если дисциплины в одном цикле и имеют одинаковый признак "по выбору"
      begin
        // Сортируем согласно позиции дисциплины
        Assert(FPositionColumn <> nil);
        i := FPositionColumn.ItemIndex;
        ACompare := StrToInt(VarToStrDef(ANode1.Values[i], '0')) -
          StrToInt(VarToStrDef(ANode2.Values[i], '0'));
        if ACompare = 0 then
        // Если дисциплины в одном цикле и имеют одинаковую позицию
        begin
          Assert(FDisciplineNameColumn <> nil);
          i := FDisciplineNameColumn.ItemIndex;
          S1 := VarToStrDef(ANode1.Values[i], '');
          S2 := VarToStrDef(ANode2.Values[i], '');
          if S1 < S2 then
            ACompare := -1
          else if S1 > S2 then
            ACompare := 1
          else
            ACompare := 0;
        end;
      end
    end;
  except
    ;
  end;
end;

procedure TviewDBTreeListSP.cxdbtlViewCustomDrawDataCell
  (Sender: TcxCustomTreeList; ACanvas: TcxCanvas;
  AViewInfo: TcxTreeListEditCellViewInfo; var ADone: Boolean);
var
  // AIDHourViewTypeValue: Integer;
  ARect: TRect;
  AText: string;
  S: string;
  l: Integer;
  // IDSPValue: Variant;
  ANode: TcxDBTreeListNode;
  i: Integer;
  Position: Integer;
  AHour: Integer;
  ASum: Integer;
  MarkAsError: Boolean;
begin
  try
    MarkAsError := False;
    ANode := AViewInfo.Node as TcxDBTreeListNode;
    {
      if Q_PosText('Type', (AViewInfo.Column as TcxDBTreeListColumn).DataBinding.FieldName) = 1 then
      begin
      i := FIDSPColumn.ItemIndex;
      IDSPValue := ANode.Values[i];
      // Если текущая узел не является узлом дисциплины
      if StrToInt(VarToStrDef(ANode.Values[i], '0')) <= 0 then
      begin
      ARect := AViewInfo.BoundsRect;

      // Рисуем в ячейке
      ACanvas.FillRect(ARect);
      ADone := True;
      end;
      end
      else
    }
    if AViewInfo.Column = FCodeColumn then
    begin
      i := FPositionColumn.ItemIndex;
      // Получаем позицию текущей дисциплины
      Position := StrToInt(VarToStrDef(ANode.Values[i], '0'));
      if Position < 0 then
      begin
        Position := AViewInfo.Node.Index + 1;
      end;

      S := AViewInfo.DisplayValue;
      l := S.Length;
      if (l > 0) and (S[l] = '.') then
      begin
        AText := AViewInfo.DisplayValue + FormatFloat('00', Position);
        // Определяемся с границами ячейки
        ARect := AViewInfo.BoundsRect;
        ARect.Inflate(-3, -3, -3, -3);
        // Рисуем в ячейке
        ACanvas.FillRect(ARect);
        ACanvas.DrawText(AText, ARect, cxAlignCenter);
        ADone := True;
      end;

    end
    else if AViewInfo.Column = FLecCol then
    begin
      AHour := StrToInt(VarToStrDef(ANode.Values[FLecCol.ItemIndex], '0'));
      ASum := StrToInt(VarToStrDef(ANode.Values[FLecSumCol.ItemIndex], '0'));
      MarkAsError := AHour <> ASum;
    end
    else if AViewInfo.Column = FLabCol then
    begin
      AHour := StrToInt(VarToStrDef(ANode.Values[FLabCol.ItemIndex], '0'));
      ASum := StrToInt(VarToStrDef(ANode.Values[FLabSumCol.ItemIndex], '0'));
      MarkAsError := AHour <> ASum;
    end
    else if AViewInfo.Column = FSemCol then
    begin
      AHour := StrToInt(VarToStrDef(ANode.Values[FSemCol.ItemIndex], '0'));
      ASum := StrToInt(VarToStrDef(ANode.Values[FSemSumCol.ItemIndex], '0'));
      MarkAsError := AHour <> ASum;
    end
    else if AViewInfo.Column = FSelfCol then
    begin
      AHour := StrToInt(VarToStrDef(ANode.Values[FSelfCol.ItemIndex], '0'));
      ASum := StrToInt(VarToStrDef(ANode.Values[FSelfSumCol.ItemIndex], '0'));
      MarkAsError := (AHour <> ASum) and (ASum > 0);
    end
    (* Отображение в неделях осталось невостребованным
      else
      if AViewInfo.Column = FTotalColumn then
      begin
      AIDHourViewTypeValue := StrToInt(VarToStrDef(ANode.Values[FIDHourViewTypeColumn.ItemIndex], '0'));
      // Если отображать нужно в неделях
      if AIDHourViewTypeValue = 2 then
      begin
      AText := VarToStrDef(AViewInfo.DisplayValue, '0') + ' н.';
      // Определяемся с границами ячейки
      ARect := AViewInfo.BoundsRect;
      // Уменьшаем ячейку
      ARect.Inflate(-3, -3, -3, -3);
      // Рисуем в ячейке
      ACanvas.FillRect(ARect);
      ACanvas.DrawText(AText, ARect, cxAlignCenter);
      ADone := True;  // Всё! больше дорисовывать не нужно!
      end;
      end *);

    if MarkAsError then
    begin
      ACanvas.Font.Color := clWhite;
      ACanvas.Brush.Color := clRed;
      // Рисуем в ячейке
      ACanvas.FillRect(AViewInfo.BoundsRect);
      // ARect := AViewInfo.BoundsRect;
      // ARect.Left := ARect.Left + 3;
      ACanvas.DrawText(AViewInfo.DisplayValue, AViewInfo.BoundsRect,
        cxAlignCenter);
      ADone := True;
    end;
  except
    ;
  end;
end;

procedure TviewDBTreeListSP.cxdbtlViewEditing(Sender: TcxCustomTreeList;
  AColumn: TcxTreeListColumn; var Allow: Boolean);
begin
  inherited;
  try
    Allow := Document.DataSet.FieldByName(FIDSPColumn.DataBinding.FieldName)
      .Value > 0;
  except
    ;
  end;
end;

procedure TviewDBTreeListSP.cxdbtlViewIsGroupNode(Sender: TcxCustomTreeList;
  ANode: TcxTreeListNode; var IsGroup: Boolean);
begin
  try
    // Группой считается узел ID которого меньше нуля
    IsGroup := StrToInt(VarToStrDef(ANode.Values[FIDSPColumn.ItemIndex],
      '0')) <= 0;
  except
    ;
  end;
end;

procedure TviewDBTreeListSP.InitTreeListView;
begin
  inherited;

  if FDocument = nil then
    Exit;

  // Ищем среди колонок колонку с порядковым кодом цикла
  FCSE_ORDColumn := GetColumnByFieldName('CSE_ORD', True);
  FDisciplineNameColumn := GetColumnByFieldName('DisciplineName', True);
  FCodeColumn := GetColumnByFieldName('Code', True);
  FIDSPColumn := GetColumnByFieldName('ID_StudyPlan', True);
  FPositionColumn := GetColumnByFieldName('Position', True);
  FLecSumCol := GetColumnByFieldName('LecSum', True);
  FLecCol := GetColumnByFieldName('Lectures', True);
  FSemSumCol := GetColumnByFieldName('SemSum', True);
  FSemCol := GetColumnByFieldName('Seminars', True);
  FLabSumCol := GetColumnByFieldName('LabSum', True);
  FLabCol := GetColumnByFieldName('Labworks', True);
  FSelfSumCol := GetColumnByFieldName('SelfSum', True);
  FSelfCol := GetColumnByFieldName('Self', True);
  FISOptionColumn := GetColumnByFieldName('IS_Option', True);
  FTotalColumn := GetColumnByFieldName('Total', True);
  FIDHourViewTypeColumn := GetColumnByFieldName('IDHourViewType', True);
end;

end.
