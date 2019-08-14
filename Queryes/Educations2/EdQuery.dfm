inherited QueryEd: TQueryEd
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'select id_education, education, short_education, education_order'
      'from CDB_COM_DIRECTORIES.EDUCATIONS2'
      'order by education_order')
  end
end
