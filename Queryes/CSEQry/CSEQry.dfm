inherited QueryCSE: TQueryCSE
  Width = 238
  Height = 76
  ExplicitWidth = 238
  ExplicitHeight = 76
  inherited FDQuery: TFDQuery
    UpdateOptions.AssignedValues = [uvRefreshMode]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.KeyFields = 'ID_CYCLESPECIALITYEDUCATION'
    UpdateOptions.AutoIncFields = 'ID_CYCLESPECIALITYEDUCATION'
    UpdateObject = FDUpdateSQL
    SQL.Strings = (
      'SELECT '
      
        '  /*+ LEADING(cse) INDEX(cse)  USE_NL(cse, cy) INDEX(cy)  USE_NL' +
        '(cy, ct) INDEX(ct) */  '
      'cse.id_cyclespecialityeducation'
      ', cse.order_'
      ', cy.cycle'
      ', cy.short_cycle'
      ', ct.cycletype'
      ', ct.shortcycletype'
      ', ct.ord cycletype_ord'
      ', cse.idcycle'
      ', cse.IDSpecialityEducation'
      ', cse.idcyclespecialityeducation'
      ', cy.idcycle_type '
      ''
      'FROM CYCLESPECIALITYEDUCATIONS cse '
      'join cycles cy on cse.idcycle = cy.id_cycle'
      'join cycle_types ct on cy.idcycle_type = ct.id_cycle_type '
      ''
      'WHERE (0=0) --cse.idspecialityeducation = 5129 '
      ''
      'ORDER BY cse.IDSpecialityEducation'
      ', cse.IDCycleSpecialityEducation'
      ', cse.Order_')
    object FDQueryID_CYCLESPECIALITYEDUCATION: TBCDField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID_CYCLESPECIALITYEDUCATION'
      Origin = 'ID_CYCLESPECIALITYEDUCATION'
      ProviderFlags = [pfInKey]
      Precision = 9
      Size = 0
    end
    object FDQueryORDER_: TBCDField
      FieldName = 'ORDER_'
      Origin = 'ORDER_'
      ProviderFlags = []
      Required = True
      Precision = 9
      Size = 0
    end
    object FDQueryCYCLE: TStringField
      FieldName = 'CYCLE'
      Origin = '"CYCLE"'
      ProviderFlags = []
      Required = True
      Size = 500
    end
    object FDQuerySHORT_CYCLE: TStringField
      FieldName = 'SHORT_CYCLE'
      Origin = 'SHORT_CYCLE'
      ProviderFlags = []
      Size = 50
    end
    object FDQueryCYCLETYPE: TStringField
      FieldName = 'CYCLETYPE'
      Origin = 'CYCLETYPE'
      ProviderFlags = []
      Required = True
      Size = 100
    end
    object FDQuerySHORTCYCLETYPE: TStringField
      FieldName = 'SHORTCYCLETYPE'
      Origin = 'SHORTCYCLETYPE'
      ProviderFlags = []
    end
    object FDQueryCYCLETYPE_ORD: TFMTBCDField
      FieldName = 'CYCLETYPE_ORD'
      Origin = 'CYCLETYPE_ORD'
      ProviderFlags = []
      Precision = 38
      Size = 0
    end
    object FDQueryIDCYCLE: TBCDField
      FieldName = 'IDCYCLE'
      Origin = 'IDCYCLE'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 9
      Size = 0
    end
    object FDQueryIDSPECIALITYEDUCATION: TBCDField
      FieldName = 'IDSPECIALITYEDUCATION'
      Origin = 'IDSPECIALITYEDUCATION'
      Required = True
      Precision = 9
      Size = 0
    end
    object FDQueryIDCYCLESPECIALITYEDUCATION: TFMTBCDField
      FieldName = 'IDCYCLESPECIALITYEDUCATION'
      Origin = 'IDCYCLESPECIALITYEDUCATION'
      Precision = 38
      Size = 38
    end
    object FDQueryIDCYCLE_TYPE: TFMTBCDField
      FieldName = 'IDCYCLE_TYPE'
      Origin = 'IDCYCLE_TYPE'
      ProviderFlags = []
      Precision = 38
      Size = 0
    end
  end
  object FDUpdateSQL: TFDUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO CDB_WIN_STUDYPLAN.CYCLESPECIALITYEDUCATIONS'
      
        '(IDCYCLE, IDSPECIALITYEDUCATION, ORDER_, IDCYCLESPECIALITYEDUCAT' +
        'ION)'
      
        'VALUES (:NEW_IDCYCLE, :NEW_IDSPECIALITYEDUCATION, :NEW_ORDER_, :' +
        'NEW_IDCYCLESPECIALITYEDUCATION)'
      
        'RETURNING ID_CYCLESPECIALITYEDUCATION INTO :NEW_ID_CYCLESPECIALI' +
        'TYEDUCATION')
    ModifySQL.Strings = (
      'UPDATE CDB_WIN_STUDYPLAN.CYCLESPECIALITYEDUCATIONS'
      
        'SET IDCYCLE = :NEW_IDCYCLE, IDSPECIALITYEDUCATION = :NEW_IDSPECI' +
        'ALITYEDUCATION, '
      
        '  ORDER_ = :NEW_ORDER_, IDCYCLESPECIALITYEDUCATION = :NEW_IDCYCL' +
        'ESPECIALITYEDUCATION'
      
        'WHERE ID_CYCLESPECIALITYEDUCATION = :OLD_ID_CYCLESPECIALITYEDUCA' +
        'TION')
    DeleteSQL.Strings = (
      'DELETE FROM CDB_WIN_STUDYPLAN.CYCLESPECIALITYEDUCATIONS'
      
        'WHERE ID_CYCLESPECIALITYEDUCATION = :OLD_ID_CYCLESPECIALITYEDUCA' +
        'TION')
    FetchRowSQL.Strings = (
      'SELECT '
      
        '  /*+ LEADING(cse) INDEX(cse)  USE_NL(cse, cy) INDEX(cy)  USE_NL' +
        '(cy, ct) INDEX(ct) */  '
      '  cse.id_cyclespecialityeducation'
      ', cse.order_'
      ', cy.cycle'
      ', cy.short_cycle'
      ', ct.cycletype'
      ', ct.shortcycletype'
      ', ct.ord cycletype_ord'
      ', cse.idcycle'
      ', cse.IDSpecialityEducation'
      ', cse.idcyclespecialityeducation'
      ', cy.idcycle_type '
      ''
      'FROM CYCLESPECIALITYEDUCATIONS cse '
      'join cycles cy on cse.idcycle = cy.id_cycle'
      'join cycle_types ct on cy.idcycle_type = ct.id_cycle_type '
      'WHERE ID_CYCLESPECIALITYEDUCATION = :ID_CYCLESPECIALITYEDUCATION'
      'ORDER BY cse.IDSpecialityEducation'
      ', cse.IDCycleSpecialityEducation'
      ', cse.Order_')
    Left = 88
    Top = 16
  end
end
