inherited dsgvParameterValues: TdsgvParameterValues
  inherited pnlGrid: TPanel
    inherited cxGrid: TcxGrid
      inherited cxGridDBBandedTableView: TcxGridDBBandedTableView
        OnEditValueChanged = cx_dbbtvcxg1DBBandedTableView1EditValueChanged
        DataController.DataModeController.GridMode = True
        OptionsBehavior.ImmediateEditor = True
        OptionsBehavior.IncSearch = False
      end
    end
  end
end
