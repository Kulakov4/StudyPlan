inherited QueryCopyStudyPlan: TQueryCopyStudyPlan
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      
        'BEGIN CDB_DAT_STUDY_PROCESS.StudyPlanPack.CopyStudyPlan(:ID_Spec' +
        'ialityEducation, :year); END;')
    ParamData = <
      item
        Name = 'ID_SPECIALITYEDUCATION'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'YEAR'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
