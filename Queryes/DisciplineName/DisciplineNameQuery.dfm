inherited QueryDisciplineName: TQueryDisciplineName
  inherited FDQuery: TFDQuery
    UpdateOptions.AssignedValues = [uvRefreshMode, uvCheckRequired]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CheckRequired = False
    SQL.Strings = (
      'select '
      '  ID_DisciplineName'
      '  , DisciplineName'
      '  , ShortDisciplineName'
      '  , IDChar'
      '  , Type_Discipline '
      'from DisciplineNames'
      'where Type_Discipline = :Type_Discipline'
      'order by disciplineName')
    ParamData = <
      item
        Name = 'TYPE_DISCIPLINE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 3
      end>
  end
end
