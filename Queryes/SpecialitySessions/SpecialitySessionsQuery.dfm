inherited QuerySpecialitySessions: TQuerySpecialitySessions
  inherited FDQuery: TFDQuery
    UpdateOptions.AssignedValues = [uvRefreshMode, uvCheckRequired]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CheckRequired = False
    SQL.Strings = (
      'select *'
      'from specialitysessions'
      'where 0=0')
  end
end
