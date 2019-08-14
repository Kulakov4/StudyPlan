inherited dsgvAdmission: TdsgvAdmission
  inherited pnlGrid: TPanel
    inherited cxGrid: TcxGrid
      inherited cxGridDBBandedTableView: TcxGridDBBandedTableView
        DataController.DataModeController.GridMode = True
        OptionsSelection.MultiSelect = True
        OptionsSelection.CellMultiSelect = True
        object cxgdbbcID: TcxGridDBBandedColumn
          Caption = 'X'
          DataBinding.FieldName = 'ID_SpecialityEducation'
          OnGetCellHint = cxgdbbcIDGetCellHint
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxgdbbcYear: TcxGridDBBandedColumn
          Caption = #1043#1086#1076
          DataBinding.FieldName = 'Year'
          Visible = False
          GroupIndex = 0
          SortIndex = 0
          SortOrder = soDescending
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
    end
    inherited tbdEssenceTop: TTBDock
      Visible = False
    end
  end
end
