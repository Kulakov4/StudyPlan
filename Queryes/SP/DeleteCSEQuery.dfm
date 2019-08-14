inherited QryDeleteCSE: TQryDeleteCSE
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'delete from cyclespecialityeducations cse '
      'where CSE.IDSPECIALITYEDUCATION = :IDSPECIALITYEDUCATION')
    ParamData = <
      item
        Name = 'IDSPECIALITYEDUCATION'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
