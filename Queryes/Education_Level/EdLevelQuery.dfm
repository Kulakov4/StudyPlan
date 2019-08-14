inherited QueryEdLevel: TQueryEdLevel
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      
        'select id_education_level, education_level, short_education_leve' +
        'l, ord, ideducationtype'
      'from Education_level'
      'order by ord')
  end
end
