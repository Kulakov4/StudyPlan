inherited QueryCycles: TQueryCycles
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      '/*+ LEADING(cy) INDEX(cy) */'
      'select'
      '    cy.id_cycle,'
      '    cy.cycle,'
      '    cy.short_cycle,'
      '    cy.idcycle_type'
      'from'
      '    CYCLES cy'
      'where '
      '    CY.ENABLE_CYCLE = 1'
      'order by'
      '    cy.cycle')
  end
end
