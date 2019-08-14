inherited QrySpecEdBaseForm: TQrySpecEdBaseForm
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'select SE.ID_SPECIALITYEDUCATION, EF.IDEDUCATIONBASEFORM'
      'from cdb_dat_study_process.specialityeducations se'
      
        'join CDB_COM_DIRECTORIES.EDUCATIONS ed on SE.IDEDUCATION = ED.ID' +
        '_EDUCATION'
      
        'join CDB_COM_DIRECTORIES.EDUCATION_FORM ef on ED.IDEDUCATIONFORM' +
        ' = EF.ID_EDUCATION_FORM '
      'where 0=0')
  end
end
