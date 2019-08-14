inherited dbtlvStudyPlanFactors: TdbtlvStudyPlanFactors
  inherited cxdbtlView: TcxDBTreeList
    Bands = <
      item
      end>
    DataController.ParentField = 'IDUPSTUDYPLANFACTOR'
    DataController.KeyField = 'ID_STUDYPLANFACTOR'
    DragMode = dmAutomatic
    LookAndFeel.Kind = lfOffice11
    OptionsBehavior.CellHints = True
    OptionsBehavior.ImmediateEditor = False
    OptionsBehavior.ExpandOnIncSearch = True
    OptionsBehavior.FooterHints = True
    OptionsBehavior.IncSearch = True
    OptionsBehavior.MultiSort = False
    OptionsBehavior.Sorting = False
    OptionsData.SmartRefresh = True
    OptionsSelection.MultiSelect = True
    OptionsView.CellAutoHeight = True
    OptionsView.Bands = True
    OptionsView.ColumnAutoWidth = True
    OptionsView.GridLines = tlglBoth
    OnCustomDrawDataCell = cxdbtlViewCustomDrawDataCell
    OnDragDrop = cxdbtlViewDragDrop
    OnDragOver = cxdbtlViewDragOver
    object cxdbtlViewcxDBTreeListColumn1: TcxDBTreeListColumn
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
end
