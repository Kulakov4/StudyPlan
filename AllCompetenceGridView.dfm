inherited dsgvAllCompetence: TdsgvAllCompetence
  inherited pnlGrid: TPanel
    inherited cxGrid: TcxGrid
      inherited cxGridDBBandedTableView: TcxGridDBBandedTableView
        OptionsBehavior.RecordScrollMode = rsmByPixel
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.CellAutoHeight = True
      end
    end
  end
end
