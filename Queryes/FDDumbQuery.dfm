inherited QueryFDDumb: TQueryFDDumb
  inherited FDQuery: TFDQuery
    CachedUpdates = True
    SQL.Strings = (
      'select 0 ID from dual')
  end
  object DataSource: TDataSource
    DataSet = FDQuery
    Left = 120
    Top = 16
  end
end
