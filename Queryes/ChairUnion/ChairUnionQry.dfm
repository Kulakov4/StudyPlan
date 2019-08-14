inherited QryChairUnion: TQryChairUnion
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      'select *'
      'from cdb_com_directories.chair_union_detail'
      'where idchair_union in'
      '('
      '  select idchair_union'
      '  from cdb_com_directories.chair_union_detail'
      '  where 0=0 --idchair = 42'
      ')')
  end
end
