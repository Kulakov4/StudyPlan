inherited QuerySpecEdSimple: TQuerySpecEdSimple
  inherited FDQuery: TFDQuery
    OnUpdateRecord = FDQueryUpdateRecord
    SQL.Strings = (
      'select *'
      'from SpecialityEducations'
      'where 0=0')
  end
end
