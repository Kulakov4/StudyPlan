inherited QueryDPOSP: TQueryDPOSP
  inherited FDQuery: TFDQuery
    OnUpdateRecord = FDQueryUpdateRecord
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    SQL.Strings = (
      'SELECT   '
      '         CSE.IDSPECIALITYEDUCATION,'
      '         SP.ID_STUDYPLAN,'
      '         SP.IDDISCIPLINENAME,'
      '         SP.IDCHAIR,'
      '         lec.ID_LessonType LecID,'
      '         lec.data LecData,'
      '         Lab.ID_LessonType LabID,'
      '         Lab.data LabData,'
      '         Sem.ID_LessonType SemID,'
      '         Sem.data SemData,'
      '         Zach.ID_LessonType ZachID,'
      '         Zach.data ZachData,'
      '         Exam.ID_LessonType ExamID,'
      '         Exam.data ExamData'
      '--         ,ss.ID_SpecialitySession'
      'from cdb_dat_study_process.SpecialityEducations se'
      
        'JOIN cdb_dat_study_process.cyclespecialityeducations cse ON cse.' +
        'idspecialityeducation = se.id_specialityeducation'
      
        'JOIN cdb_dat_study_process.STUDYPLANS sp ON sp.idcyclespeciality' +
        'education = cse.id_cyclespecialityeducation'
      
        '--LEFT JOIN specialitysessions ss  ON ss.idspecialityeducation =' +
        ' se.id_specialityeducation'
      '         LEFT JOIN lessontypes lec'
      
        '            ON lec.idtype = 1 AND lec.idstudyplan = sp.id_studyp' +
        'lan'
      '         LEFT JOIN lessontypes lab'
      
        '            ON lab.idtype = 2 AND lab.idstudyplan = sp.id_studyp' +
        'lan'
      '         LEFT JOIN lessontypes sem'
      
        '            ON sem.idtype = 3 AND sem.idstudyplan = sp.id_studyp' +
        'lan'
      '         LEFT JOIN lessontypes zach'
      
        '            ON zach.idtype = 6 AND zach.idstudyplan = sp.id_stud' +
        'yplan'
      '         LEFT JOIN lessontypes exam'
      
        '            ON exam.idtype = 5 AND exam.idstudyplan = sp.id_stud' +
        'yplan'
      'WHERE 0=0 and 1=1'
      'order by cse.IDSpecialityEducation')
  end
end
