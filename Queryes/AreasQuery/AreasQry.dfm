inherited QryAreas: TQryAreas
  inherited FDQuery: TFDQuery
    UpdateOptions.AssignedValues = [uvCheckRequired]
    SQL.Strings = (
      'select ID_AREA, AREA'
      'from AREAS'
      'order by AREA')
  end
end
