inherited QryDeleteSP: TQryDeleteSP
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'delete from studyplans sp'
      'where SP.IDCYCLESPECIALITYEDUCATION in '
      '(  '
      '    select ID_CYCLESPECIALITYEDUCATION '
      '    from cyclespecialityeducations cse '
      '    where CSE.IDSPECIALITYEDUCATION = :IDSPECIALITYEDUCATION'
      ')')
    ParamData = <
      item
        Name = 'IDSPECIALITYEDUCATION'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
