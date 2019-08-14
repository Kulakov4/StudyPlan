inherited QuerySpecEd: TQuerySpecEd
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'SELECT SE.ID_SPECIALITYEDUCATION,'
      '       SE.IDSPECIALITY,'
      '       SE.YEAR,'
      '       SE.MOUNT_OF_YEAR,'
      '       SE.ENABLE_SPECIALITYEDUCATION,'
      '       SE.YEARS,'
      '       SE.MONTHS,'
      '       SE.IDCHAIR,'
      '       SE.DATA_,'
      '       SE.IDSTUDYPLANSTANDART,'
      '       SE.IDQUALIFICATION,'
      '       SE.IDAREA,'
      '       SE.IDEDUCATION2,'
      '       SE.IDEDUCATIONLEVEL,'
      '       '
      '       S.CHIPER_SPECIALITY,       '
      '       S.SPECIALITY,'
      '       ED.EDUCATION,'
      '       '
      
        '       case when se.YEARS > 0 then se.YEARS || '#39' '#39' || StudyPlanP' +
        'ack.CountNoun(se.YEARS, '#39#1075'.'#39', '#39#1075'.'#39', '#39#1083'.'#39') ||'
      '       case when se.months > 0 then '#39' '#1080' '#39' else '#39#39' end       '
      '       else '#39#39' end'
      '       ||'
      
        '       case when se.months > 0 then se.months || '#39' '#1084#1077#1089'.'#39' else '#39#39 +
        ' end Period,       '
      '       '
      '       ED.EDUCATION_ORDER,       '
      '       SE.ANNOTATION,'
      
        '       nvl2(S.CHIPER_SPECIALITY, S.CHIPER_SPECIALITY || '#39' '#39', '#39#39')' +
        ' ||       '
      '       S.SPECIALITY || '#39' ('#39' || ED.SHORT_EDUCATION ||'
      
        '       case when (se.YEARS * 12 + se.Months > 0) then '#39', '#39' else ' +
        #39#39' end '
      '       || '
      
        '       case when se.YEARS > 0 then se.YEARS || '#39' '#39' || StudyPlanP' +
        'ack.CountNoun(se.YEARS, '#39#1075'.'#39', '#39#1075'.'#39', '#39#1083'.'#39') ||'
      '       case when se.months > 0 then '#39' '#1080' '#39' else '#39#39' end       '
      '       else '#39#39' end'
      '       ||'
      
        '       case when se.months > 0 then se.months || '#39' '#1084#1077#1089'.'#39' else '#39#39 +
        ' end       '
      '        || '#39') '#39
      '        || SE.YEAR '
      '        || nvl2(se.annotation, '#39' ('#39' || se.annotation || '#39')'#39', '#39#39')'
      '        speciality_ex,'
      '       SE.LOCKED'
      '/*FROM SpecialityEducations se*/'
      'FROM CDB_DAT_STUDY_PROCESS.SpecialityEducations se'
      'join AUTHORIZEDCHAIRUNION2 auchu on SE.IDCHAIR = auchu.IDCHAIR'
      
        'join CDB_COM_DIRECTORIES.EDUCATION_LEVEL el on SE.IDEDUCATIONLEV' +
        'EL = EL.ID_EDUCATION_LEVEL'
      
        'join CDB_COM_DIRECTORIES.SPECIALITYS s on SE.IDSPECIALITY = S.ID' +
        '_SPECIALITY'
      
        'join CDB_COM_DIRECTORIES.EDUCATIONS2 ed on SE.IDEDUCATION2 = ED.' +
        'ID_EDUCATION'
      'where 0=0 and 1=1 and 2=2'
      
        'order by SE.YEAR desc, SE.IDEDUCATIONLEVEL, S.SPECIALITY, ED.EDU' +
        'CATION_ORDER ')
  end
end
