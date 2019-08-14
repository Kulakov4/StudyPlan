inherited cxGridCBViewEx: TcxGridCBViewEx
  inherited cxExtLookupComboBox: TcxExtLookupComboBox
    Properties.DropDownSizeable = True
    Properties.FocusPopup = True
  end
  inherited cxgrdvwrpstry1: TcxGridViewRepository
    inherited RepositoryBandedTableView: TcxGridDBBandedTableView
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Edit.Visible = False
      Navigator.Buttons.Refresh.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = False
      Navigator.Visible = True
      OptionsData.Appending = True
    end
  end
end
