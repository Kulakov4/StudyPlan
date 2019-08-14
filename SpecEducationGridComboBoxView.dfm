inherited SpecEducationGridComboBox_View: TSpecEducationGridComboBox_View
  inherited cxExtLookupComboBox: TcxExtLookupComboBox
    Properties.DropDownListStyle = lsFixedList
    Properties.DropDownRows = 24
    Properties.DropDownSizeable = True
  end
  inherited cxgrdvwrpstry1: TcxGridViewRepository
    inherited RepositoryBandedTableView: TcxGridDBBandedTableView
      OptionsView.CellAutoHeight = True
      object RepositoryBandedTableViewColumn1: TcxGridDBBandedColumn
        DataBinding.FieldName = 'locked'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Width = 30
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
    end
  end
end
