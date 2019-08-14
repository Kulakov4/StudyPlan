inherited dsgvSpecialitys: TdsgvSpecialitys
  inherited pnlGrid: TPanel
    inherited cxGrid: TcxGrid
      inherited cxGridDBBandedTableView: TcxGridDBBandedTableView
        object cxgdbbcQualification: TcxGridDBBandedColumn
          Caption = #1050#1074#1072#1083#1080#1092#1080#1082#1072#1094#1080#1103
          DataBinding.FieldName = 'QUALIFICATION'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = cx_dbbtvcxg1DBBandedTableView1Column1PropertiesButtonClick
          MinWidth = 100
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
    end
  end
end
