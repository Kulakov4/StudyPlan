inherited viewDBTreeListSP: TviewDBTreeListSP
  inherited cxdbtlView: TcxDBTreeList
    Bands = <
      item
        Styles.Header = DM.cxstyl10
      end>
    DataController.ParentField = 'idcyclespecialityeducation'
    DataController.KeyField = 'id_cyclespecialityeducation'
    OptionsBehavior.ImmediateEditor = False
    OptionsBehavior.ExpandOnIncSearch = True
    OptionsBehavior.FooterHints = True
    OptionsBehavior.IncSearch = True
    OptionsBehavior.MultiSort = False
    OptionsData.SmartRefresh = True
    OptionsSelection.MultiSelect = True
    OptionsView.CellAutoHeight = True
    OptionsView.Bands = True
    OptionsView.Footer = True
    OptionsView.GridLines = tlglBoth
    OptionsView.GroupFooters = tlgfVisibleWhenExpanded
    Styles.Inactive = cxStyle1
    Styles.Selection = cxStyle1
    Styles.Indicator = cxStyle2
    OnCompare = cxdbtlViewCompare
    OnCustomDrawDataCell = cxdbtlViewCustomDrawDataCell
    OnEditing = cxdbtlViewEditing
    OnIsGroupNode = cxdbtlViewIsGroupNode
    object cxdbtlViewcxDBTreeListColumn1: TcxDBTreeListColumn
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <
        item
          AlignHorz = taLeftJustify
          Kind = skSum
        end>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 296
    Top = 144
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clGradientInactiveCaption
      TextColor = clBlack
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clHotLight
    end
  end
end
