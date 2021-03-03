inherited vwdbtrlstCSE: TvwdbtrlstCSE
  Width = 989
  ExplicitWidth = 989
  inherited cxdbtlView: TcxDBTreeList
    Width = 989
    Bands = <
      item
      end>
    DataController.ParentField = 'idcyclespecialityeducation'
    DataController.KeyField = 'id_cyclespecialityeducation'
    OptionsBehavior.CellHints = True
    OptionsBehavior.ImmediateEditor = False
    OptionsBehavior.IncSearch = True
    OptionsBehavior.IncSearchItem = cxdbtlViewcxDBTreeListColumn1
    OptionsData.Appending = True
    OptionsData.Inserting = True
    OptionsSelection.CellSelect = False
    OptionsSelection.HideFocusRect = False
    OptionsSelection.InvertSelect = False
    OnCompare = cxdbtlViewCompare
    OnDblClick = cxdbtlViewDblClick
    ExplicitWidth = 989
    object cxdbtlViewcxDBTreeListColumn1: TcxDBTreeListColumn
      PropertiesClassName = 'TcxButtonEditProperties'
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Caption.Text = #1053#1072#1079#1074#1072#1085#1080#1077
      DataBinding.FieldName = 'Cycle'
      Width = 600
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      SortOrder = soAscending
      SortIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxdbtlViewcxDBTreeListColumn2: TcxDBTreeListColumn
      Caption.Text = #1058#1080#1087
      DataBinding.FieldName = 'CycleType'
      Width = 215
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxdbtlViewcxDBTreeListColumn3: TcxDBTreeListColumn
      Visible = False
      DataBinding.FieldName = 'order_'
      Width = 100
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
end
