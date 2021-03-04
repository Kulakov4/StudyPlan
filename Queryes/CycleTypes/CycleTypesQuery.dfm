inherited QueryCycleTypes: TQueryCycleTypes
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      '/*+ LEADING(ct) INDEX(ct) */'
      'select '
      '    ct.*'
      'from'
      '    CYCLE_TYPES ct'
      'Order by'
      '    ct.ord')
  end
end
