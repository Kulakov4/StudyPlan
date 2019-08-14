inherited ViewSpecEdPopup: TViewSpecEdPopup
  inherited cxGrid: TcxGrid
    Top = 0
    Height = 472
    ExplicitTop = 0
    ExplicitHeight = 472
    inherited cxGridDBBandedTableView: TcxGridDBBandedTableView
      object clCalc: TcxGridDBBandedColumn
        OnGetDataText = clCalcGetDataText
        OnGetDisplayText = clCalcGetDisplayText
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
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
  end
  object dsChairs: TDataSource
    Left = 40
    Top = 136
  end
  object dsSpeciality: TDataSource
    Left = 40
    Top = 192
  end
end
