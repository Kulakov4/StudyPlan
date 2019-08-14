inherited QueryLessonType: TQueryLessonType
  inherited FDQuery: TFDQuery
    UpdateOptions.AssignedValues = [uvRefreshMode, uvCheckRequired]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CheckRequired = False
    SQL.Strings = (
      
        'select ID_LessonType, IDStudyPlan, IDType, Data, IDSpecialitySes' +
        'sion'
      'from lessontypes'
      'where 0=0 and 1=1')
  end
end
