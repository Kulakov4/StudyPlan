inherited QueryCourceName: TQueryCourceName
  inherited FDQuery: TFDQuery
    UpdateOptions.AssignedValues = [uvRefreshMode, uvCheckRequired]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CheckRequired = False
    SQL.Strings = (
      'select '
      '  id_speciality,'
      
        '  SPECIALITY || nvl2(chiper_speciality, '#39' ('#39' || chiper_specialit' +
        'y || '#39')'#39', '#39#39' ) CalcSpeciality,'
      '  speciality,'
      '  chiper_speciality,'
      '  short_speciality,'
      '  enable_speciality,'
      '  speciality_access,'
      '  qualification_id'
      'from specialitys'
      'where 0=0 and 1=1'
      'order by speciality')
  end
end
