object DM: TDM
  OldCreateOrder = False
  Height = 265
  Width = 448
  object cxstylrpstry1: TcxStyleRepository
    Left = 23
    Top = 19
    PixelsPerInch = 96
    object cxstyl1: TcxStyle
      AssignedValues = [svColor]
      Color = 13475186
    end
    object cxstyl2: TcxStyle
      AssignedValues = [svColor]
      Color = 16046785
    end
    object cxstyl3: TcxStyle
      AssignedValues = [svColor]
      Color = 16769505
    end
    object cxstyl4: TcxStyle
      AssignedValues = [svColor]
      Color = 8565994
    end
    object cxstyl5: TcxStyle
      AssignedValues = [svColor]
      Color = clInfoBk
    end
    object cxstyl6: TcxStyle
      AssignedValues = [svColor]
      Color = 10930928
    end
    object cxstyl7: TcxStyle
      AssignedValues = [svColor]
      Color = 10209435
    end
    object cxstyl8: TcxStyle
      AssignedValues = [svColor]
      Color = 16776176
    end
    object cxstyl9: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxstyl10: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clTeal
      TextColor = clWhite
    end
    object cxstyl11: TcxStyle
      AssignedValues = [svColor]
      Color = clAqua
    end
    object cxstyl12: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clRed
      TextColor = clWhite
    end
    object cxstyl13: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clMenuBar
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object cxstyl14: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object cxEditRepository1: TcxEditRepository
    Left = 134
    Top = 19
    object cxEditRepository1SpinItem1: TcxEditRepositorySpinItem
      Properties.Alignment.Horz = taCenter
      Properties.Increment = 2.000000000000000000
      Properties.ValueType = vtFloat
    end
    object cxEditRepository1CheckBoxItem1: TcxEditRepositoryCheckBoxItem
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 2
      Properties.ValueUnchecked = '0'
    end
    object cxEditRepository1Label1: TcxEditRepositoryLabel
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
    end
    object cxEditRepository1ComboBoxItem1: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        ' '
        '*')
    end
    object cxEditRepository1CheckComboBox1: TcxEditRepositoryCheckComboBox
      Properties.ShowEmptyText = False
      Properties.Items = <
        item
          Description = '*'
        end>
    end
    object cxEditRepository1CheckBoxItem2: TcxEditRepositoryCheckBoxItem
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
    end
  end
end
