inherited QueryCycleSpecialityEducations: TQueryCycleSpecialityEducations
  inherited FDQuery: TFDQuery
    UpdateOptions.AssignedValues = [uvRefreshMode, uvCheckRequired]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CheckRequired = False
    SQL.Strings = (
      'select *'
      'from cdb_dat_study_process.cyclespecialityeducations'
      'where 0=0')
  end
end
