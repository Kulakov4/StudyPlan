inherited QrySpecByChair: TQrySpecByChair
  inherited FDQuery: TFDQuery
    OnPostError = FDQueryPostError
    Connection = FireDACDM.FDConnection
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
      '--    SE.ENABLE_SPECIALITYEDUCATION = 1 and'
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
end
