inherited QueryChairs: TQueryChairs
  inherited FDQuery: TFDQuery
    SQL.Strings = (
      
        'select ch.*, '#1055'.'#1053#1040#1048#1052#1045#1053#1054#1042#1040#1053#1048#1045', nvl(short_name, '#1055'.'#1053#1040#1048#1052#1045#1053#1054#1042#1040#1053#1048#1045') Sho' +
        'rtening'
      'from chairs ch'
      
        'join '#1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103' '#1087' on ch.'#1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088#1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103' = '#1055'.'#1048#1044#1045#1053#1058#1048 +
        #1060#1048#1050#1040#1058#1054#1056
      'where 0=0 and ID_CHAIR > 0'
      'order by Shortening')
  end
end
