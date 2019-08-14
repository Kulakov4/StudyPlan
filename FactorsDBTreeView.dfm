inherited dbtlvFactors: TdbtlvFactors
  inherited cxdbtlView: TcxDBTreeList
    DataController.ParentField = 'IDParentFactor'
    DataController.KeyField = 'ID_Factor'
    DragMode = dmAutomatic
    OptionsBehavior.CellHints = True
    OptionsBehavior.HintHidePause = 1
    OptionsBehavior.ImmediateEditor = False
    OptionsBehavior.ExpandOnIncSearch = True
    OptionsBehavior.HeaderHints = True
    OptionsBehavior.IncSearch = True
    OptionsView.ColumnAutoWidth = True
    OptionsView.DropNodeIndicator = True
    OptionsView.DynamicIndent = True
    OptionsView.ExtPaintStyle = True
    OptionsView.HeaderAutoHeight = True
    OptionsView.Indicator = True
    OnDragDrop = cxdbtlViewDragDrop
    OnDragOver = cxdbtlViewDragOver
  end
end
