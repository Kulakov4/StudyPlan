inherited QueryDropVirtualStudent: TQueryDropVirtualStudent
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'begin CDB_DAT_STUDENTS.DROPVIRTUALCOURSIST( :ID_Group ); end;')
    ParamData = <
      item
        Name = 'ID_GROUP'
        ParamType = ptInput
      end>
  end
end
