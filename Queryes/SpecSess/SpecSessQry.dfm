inherited QrySpecSess: TQrySpecSess
  inherited FDQuery: TFDQuery
    OnPostError = FDQueryPostError
    SQL.Strings = (
      'select '
      '    ss.ID_specialitySession,'
      '    ss.level_,'
      '    ss.level_year,'
      '    ss.session_in_level,'
      '    ss.session_,'
      '    ss.IDSpecialityEducation'
      'from'
      '    SPECIALITYSESSIONS ss'
      'where (0=0)'
      'order by'
      '    ss.level_,'
      '    ss.session_in_level')
  end
end
