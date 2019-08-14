inherited QueryStudyPlans: TQueryStudyPlans
  inherited FDQuery: TFDQuery
    UpdateOptions.AssignedValues = [uvRefreshMode, uvCheckRequired]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CheckRequired = False
    SQL.Strings = (
      'select '
      
        '  ID_StudyPlan, IDCycleSpecialityEducation, IDDisciplineName, To' +
        'tal, Lectures, Seminars, Labworks, IDChair, Order_'
      'from cdb_dat_study_process.StudyPlans'
      'where 0=0'
      '/*IDSPECIALITYEDUCATION '
      'and IDCYCLESPECIALITYEDUCATION in'
      '('
      '    select ID_CYCLESPECIALITYEDUCATION '
      '    from cyclespecialityeducations cse '
      '    where CSE.IDSPECIALITYEDUCATION = :IDSPECIALITYEDUCATION'
      ')'
      'IDSPECIALITYEDUCATION*/')
  end
end
