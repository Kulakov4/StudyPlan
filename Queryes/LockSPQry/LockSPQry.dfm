inherited QryLockSP: TQryLockSP
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'update specialityeducations'
      'set locked = :locked'
      'where IDEducationLevel = :IDEducationLevel')
    ParamData = <
      item
        Name = 'LOCKED'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'IDEDUCATIONLEVEL'
        ParamType = ptInput
      end>
  end
end
