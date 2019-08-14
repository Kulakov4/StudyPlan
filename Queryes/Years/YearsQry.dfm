inherited QryYears: TQryYears
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'select '
      '    year as ID_Year,'
      '    year'
      'from'
      '    years'
      'where'
      '    Enable_year = 1'
      'order by'
      '    year')
  end
end
