inherited QueryCreateVirtualStudent: TQueryCreateVirtualStudent
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      
        'begin CDB_DAT_STUDENTS.CREATEVIRTUALCOURSIST ( :ID_Group, :ID_Sp' +
        'ecialityEducation ); end;')
    ParamData = <
      item
        Name = 'ID_GROUP'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ID_SPECIALITYEDUCATION'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
