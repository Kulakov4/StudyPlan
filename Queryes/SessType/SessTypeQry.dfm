inherited QrySessType: TQrySessType
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'select '
      '    st.*'
      'from SessionTypes st'
      'order by'
      '    st.sessiontype')
  end
end
