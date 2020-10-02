inherited ViewSpecEdPopup: TViewSpecEdPopup
  inherited cxGrid: TcxGrid
    Top = 0
    Height = 472
    ExplicitTop = 0
    ExplicitHeight = 472
    inherited cxGridDBBandedTableView: TcxGridDBBandedTableView
      OnCustomDrawCell = cxGridDBBandedTableViewCustomDrawCell
      OptionsView.FocusRect = False
      Styles.OnGetContentStyle = cxGridDBBandedTableViewStylesGetContentStyle
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
    inherited dxbrMain: TdxBar
      Visible = False
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
    object cxDisabledStyle: TcxStyle
      AssignedValues = [svColor]
      Color = clSkyBlue
    end
  end
end
