inherited QryDiscName: TQryDiscName
  inherited FDQuery: TFDQuery
    OnDeleteError = FDQueryDeleteError
    OnPostError = FDQueryPostError
    SQL.Strings = (
      'select *'
      'from DisciplineNames'
      'where --type_discipline in (1, 2)'
      '0=0'
      'order by DisciplineName')
  end
end
