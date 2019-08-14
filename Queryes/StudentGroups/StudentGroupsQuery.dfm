inherited QueryStudentGroups: TQueryStudentGroups
  Width = 285
  Height = 78
  ExplicitWidth = 285
  ExplicitHeight = 78
  inherited FDQuery: TFDQuery
    AfterApplyUpdates = FDQueryAfterApplyUpdates
    UpdateOptions.AssignedValues = [uvRefreshMode, uvCheckRequired]
    UpdateOptions.CheckRequired = False
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'ID'
    SQL.Strings = (
      'select '
      '    unique '
      '    sg.ID, '
      '    sg.START_YEAR,'
      '    sg.NAME,'
      '    t.student_count'
      'from Students_Groups sg'
      'join CDB_DAT_STUDENTS.t_students st on ST.GROUP_ID = SG.ID'
      'left join'
      '('
      '    select ST.GROUP_ID, count(*) student_count'
      '    from cdb_dat_students.t_students st'
      '    where ST.PEOPLE_ID > 0'
      '    group by ST.GROUP_ID'
      ') t on t.GROUP_ID = SG.ID'
      ''
      'where 0=0 and 1=1'
      'order by name'
      '')
  end
end
