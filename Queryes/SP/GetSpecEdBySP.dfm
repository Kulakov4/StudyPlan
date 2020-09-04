inherited QryGetSpecEdBySP: TQryGetSpecEdBySP
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'select se.*'
      'from studyplans sp '
      
        'join cyclespecialityeducations cse on SP.IDCYCLESPECIALITYEDUCAT' +
        'ION = CSE.ID_CYCLESPECIALITYEDUCATION'
      
        'join specialityeducations se on CSE.IDSPECIALITYEDUCATION = SE.I' +
        'D_SPECIALITYEDUCATION'
      'where 0=0')
  end
end
