inherited QrySpecEdSimple2: TQrySpecEdSimple2
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'select *'
      'from specialityeducations se'
      
        'join education_level el on SE.IDEDUCATIONLEVEL = EL.ID_EDUCATION' +
        '_LEVEL'
      'where 0=0')
  end
end
