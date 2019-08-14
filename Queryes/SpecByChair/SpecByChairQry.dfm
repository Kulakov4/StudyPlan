inherited QrySpecByChair: TQrySpecByChair
  inherited FDQuery: TFDQuery
    OnPostError = FDQueryPostError
    Connection = FireDACDM.FDConnection
    UpdateObject = FDUpdateSQL
    SQL.Strings = (
      'select '
      '    distinct  '
      
        '    nvl2(s.chiper_speciality, s.chiper_speciality || '#39' '#39', '#39#39' ) |' +
        '| S.SPECIALITY CalcSpeciality, '
      '    s.ID_speciality,'
      '    s.Chiper_speciality,'
      '    s.Speciality,'
      '    s.Short_speciality,'
      '    S.ENABLE_SPECIALITY,'
      '    S.SPECIALITY_ACCESS,'
      '    S.QUALIFICATION_ID'
      'from cdb_dat_study_process.specialityeducations se'
      
        'join CDB_COM_DIRECTORIES.SPECIALITYS s on SE.IDSPECIALITY = S.ID' +
        '_SPECIALITY'
      'where'
      '    SE.ENABLE_SPECIALITYEDUCATION = 1 and'
      '    SE.IDEDUCATIONLEVEL = :IDEDUCATIONLEVEL and'
      '    (    '
      '        (SE.IDCHAIR = :IDCHAIR) '
      '        or '
      '        ('
      '            SE.IDCHAIR in '
      '            ('
      '                select IDChair'
      '                from cdb_com_directories.chair_union_detail'
      '                where idchair_union in'
      '                ('
      '                  select idchair_union'
      '                  from cdb_com_directories.chair_union_detail'
      '                  where idchair = :IDCHAIR'
      '                ) '
      '            )'
      '        )'
      '    )'
      'order by speciality')
    ParamData = <
      item
        Name = 'IDEDUCATIONLEVEL'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'IDCHAIR'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDUpdateSQL: TFDUpdateSQL
    Connection = FireDACDM.FDConnection
    InsertSQL.Strings = (
      'INSERT INTO CDB_WIN_STUDYPLAN.SPECIALITYS'
      
        '(SPECIALITY, CHIPER_SPECIALITY, SHORT_SPECIALITY, SPECIALITY_ACC' +
        'ESS)'
      
        'VALUES (:NEW_SPECIALITY, :NEW_CHIPER_SPECIALITY, :NEW_SHORT_SPEC' +
        'IALITY, :NEW_SPECIALITY_ACCESS)'
      'RETURNING ID_SPECIALITY INTO :NEW_ID_SPECIALITY')
    ModifySQL.Strings = (
      'UPDATE CDB_WIN_STUDYPLAN.SPECIALITYS'
      
        'SET ID_SPECIALITY = :NEW_ID_SPECIALITY, SPECIALITY = :NEW_SPECIA' +
        'LITY, '
      
        '  CHIPER_SPECIALITY = :NEW_CHIPER_SPECIALITY, SHORT_SPECIALITY =' +
        ' :NEW_SHORT_SPECIALITY, '
      '  SPECIALITY_ACCESS = :NEW_SPECIALITY_ACCESS'
      'WHERE ID_SPECIALITY = :OLD_ID_SPECIALITY'
      'RETURNING ID_SPECIALITY INTO :NEW_ID_SPECIALITY')
    DeleteSQL.Strings = (
      'DELETE FROM CDB_WIN_STUDYPLAN.SPECIALITYS'
      'WHERE ID_SPECIALITY = :OLD_ID_SPECIALITY')
    FetchRowSQL.Strings = (
      'SELECT'
      
        '    nvl2(s.chiper_speciality, s.chiper_speciality || '#39' '#39', '#39#39' ) |' +
        '| S.SPECIALITY CalcSpeciality, '
      '    s.ID_speciality,'
      '    s.Chiper_speciality,'
      '    s.Speciality,'
      '    s.Short_speciality,'
      '    S.ENABLE_SPECIALITY,'
      '    S.SPECIALITY_ACCESS,'
      '    S.QUALIFICATION_ID'
      'FROM CDB_WIN_STUDYPLAN.SPECIALITYS S'
      'WHERE S.ID_SPECIALITY = :ID_SPECIALITY')
    Left = 104
    Top = 16
  end
end
