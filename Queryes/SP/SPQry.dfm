inherited QrySP: TQrySP
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      '  SELECT '
      '         sp.id_studyplan,'
      '         -sp.id_studyplan id_cyclespecialityeducation,'
      '         cse.idspecialityeducation,'
      '         cse.ORDER_ CSE_ORD,'
      
        '         CDB_DAT_STUDY_PROCESS.STUDYPLANPACK.GETSTUDYPLANCODE (s' +
        'p.id_studyplan) code,'
      '--         '#1087#1086#1076#1088'.'#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' department,'
      '--         dn.disciplinename,'
      '         sp.idcyclespecialityeducation,'
      '         sp.iddisciplinename,'
      '         CAST (sp.total2 AS NUMBER (9, 1)) total2,'
      '         CAST (sp.total AS NUMBER (9, 1)) total,'
      '         CAST (sp.lectures AS NUMBER (9, 1)) lectures,'
      '         CAST (sp.seminars AS NUMBER (9, 1)) seminars,'
      '         CAST (sp.labworks AS NUMBER (9, 1)) labworks,'
      '         sp.idchair,'
      '         sp.mark,'
      '         sp.is_option,'
      '         sp.position,'
      '         sp.professional_module,'
      '         sp.IDHOURVIEWTYPE,'
      '         sp.AutoSelfHours,'
      '         ch.hour CONTROLPOINTSHOUR,'
      '         lt.id_lessontype,'
      '         lt.idtype,'
      '         lt.DATA,'
      '         ss.level_,'
      '         ss.session_in_level session_'
      '    FROM CYCLESPECIALITYEDUCATIONS cse'
      
        '    JOIN studyplans sp ON sp.idcyclespecialityeducation = cse.id' +
        '_cyclespecialityeducation'
      
        '--    JOIN disciplinenames dn ON sp.iddisciplinename = dn.id_dis' +
        'ciplinename'
      '--    JOIN chairs ch ON sp.idchair = ch.id_chair'
      
        '--    LEFT JOIN '#1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103' '#1087#1086#1076#1088' ON ch.'#1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088#1055#1086#1076#1088#1072#1079#1076#1077#1083#1077 +
        #1085#1080#1103' =  '#1087#1086#1076#1088'.'#1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
      '    LEFT JOIN lessontypes lt ON lt.idstudyplan = sp.id_studyplan'
      
        '    LEFT JOIN cdb_dat_study_process.CONTROLPOINTSHOUR ch ON CH.I' +
        'DEDUCATIONBASEFORM = 2 AND CH.IDEDUCATIONLEVEL = 2 AND CH.IDLESS' +
        'ONTYPE = LT.IDTYPE'
      
        '    LEFT JOIN specialitysessions ss  ON lt.idspecialitysession =' +
        ' ss.id_specialitysession'
      '   WHERE 0=0'
      'ORDER BY sp.id_studyplan')
  end
end
