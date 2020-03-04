inherited QueryAdmissions: TQueryAdmissions
  inherited FDQuery: TFDQuery
    OnUpdateRecord = FDQueryUpdateRecord
    UpdateOptions.AssignedValues = [uvRefreshMode, uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.KeyFields = 'ID_SPECIALITYEDUCATION'
    UpdateOptions.AutoIncFields = 'id_specialityeducation'
    SQL.Strings = (
      'SELECT SE.id_specialityeducation,'
      '         SE.IDSPECIALITY,'
      '         SE.data_,'
      '         SE.IDSPECIALITY IDSHORTSPECIALITY,'
      '         SE.IDEDUCATIONLEVEL,'
      '         SE.Year,'
      '         SE.MOUNT_OF_YEAR,'
      '         SE.IDSTUDYPLANSTANDART,'
      '         SE.IDCHAIR,'
      '         SE.IDEDUCATION2,'
      '         t.GroupCount'
      'FROM SPECIALITYEDUCATIONS se'
      'join AUTHORIZEDCHAIRUNION2 auchu on SE.IDCHAIR = auchu.IDCHAIR'
      'left join'
      '('
      '    select ADMISSION_ID, count(*) GroupCount'
      '    from'
      '    ('
      '        select ST.ADMISSION_ID, ST.GROUP_ID'
      '        from CDB_DAT_STUDENTS.t_students st'
      '        group by ST.ADMISSION_ID, ST.GROUP_ID'
      '    )'
      '    group by ADMISSION_ID'
      ') t on ADMISSION_ID = SE.ID_SPECIALITYEDUCATION    '
      'WHERE 0=0 and 1=1')
  end
end
