inherited QryMaxSpecSess: TQryMaxSpecSess
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'select '
      '    idspecialityeducation,'
      '    max(level_) Max_level,'
      '    max(level_year) max_level_year,'
      '    max(session_in_level) Max_session_in_level'
      'from'
      '    SPECIALITYSESSIONS ss'
      'where (0=0) and (1=1)'
      'group by idspecialityeducation')
  end
end
