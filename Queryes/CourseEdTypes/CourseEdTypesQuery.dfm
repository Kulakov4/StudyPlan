inherited QueryCourseEdType: TQueryCourseEdType
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'select '
      '    et.id_educationtype'
      '    ,et.short_education_type'
      '    , ED.ID_EDUCATION'
      'from Education_type et'
      
        'join education_level el on EL.IDEDUCATIONTYPE = et.ID_EDUCATIONT' +
        'YPE and EL.ID_EDUCATION_LEVEL <> 5 '
      
        'join educations ed on ED.IDEDUCATIONLEVEL = EL.ID_EDUCATION_LEVE' +
        'L'
      'where et.ID_EDUCATIONTYPE in (3, 4) and 0=0'
      'order by et.ord')
  end
end
