object frmEditStudyPlan: TfrmEditStudyPlan
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1091#1095#1077#1073#1085#1086#1075#1086' '#1087#1083#1072#1085#1072
  ClientHeight = 443
  ClientWidth = 856
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  DesignSize = (
    856
    443)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 32
    Top = 42
    Width = 98
    Height = 16
    Caption = #1060#1086#1088#1084#1072' '#1086#1073#1091#1095#1077#1085#1080#1103
  end
  object Label2: TLabel
    Left = 32
    Top = 90
    Width = 52
    Height = 16
    Caption = #1050#1072#1092#1077#1076#1088#1072
  end
  object lblSpeciality: TLabel
    Left = 32
    Top = 146
    Width = 148
    Height = 16
    Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1076#1075#1086#1090#1086#1074#1082#1080
  end
  object Label4: TLabel
    Left = 32
    Top = 257
    Width = 87
    Height = 16
    Caption = #1057#1088#1086#1082' '#1086#1073#1091#1095#1077#1085#1080#1103
  end
  object Label5: TLabel
    Left = 217
    Top = 254
    Width = 27
    Height = 16
    Caption = #1051#1077#1090':'
  end
  object Label6: TLabel
    Left = 335
    Top = 254
    Width = 56
    Height = 16
    Caption = #1052#1077#1089#1103#1094#1077#1074':'
  end
  object Label7: TLabel
    Left = 32
    Top = 307
    Width = 72
    Height = 16
    Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
  end
  object Label8: TLabel
    Left = 32
    Top = 205
    Width = 86
    Height = 16
    Caption = #1050#1074#1072#1083#1080#1092#1080#1082#1072#1094#1080#1103
  end
  object lblLocked: TLabel
    Left = 32
    Top = 359
    Width = 83
    Height = 16
    Caption = #1047#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085
  end
  object lblShowOnPortal: TLabel
    Left = 32
    Top = 399
    Width = 143
    Height = 16
    Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1085#1072' '#1087#1086#1088#1090#1072#1083#1077
  end
  object lblStandart: TLabel
    Left = 392
    Top = 42
    Width = 55
    Height = 16
    Caption = #1057#1090#1072#1085#1076#1072#1088#1090
  end
  object cxdblcbEducations: TcxDBLookupComboBox
    Left = 217
    Top = 39
    Properties.ListColumns = <>
    Properties.OnChange = cxdblcbEducationsPropertiesChange
    TabOrder = 0
    Width = 145
  end
  object btnClose: TcxButton
    Left = 720
    Top = 382
    Width = 110
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxdblcbChairs: TcxDBLookupComboBox
    Left = 217
    Top = 87
    Properties.ListColumns = <>
    Properties.OnChange = cxdblcbChairsPropertiesChange
    TabOrder = 2
    Width = 613
  end
  object cxdbextlcbSpecialitys: TcxDBExtLookupComboBox
    Left = 217
    Top = 143
    Properties.OnChange = cxdbextlcbSpecialitysPropertiesChange
    Properties.OnPopup = cxdbextlcbSpecialitysPropertiesPopup
    TabOrder = 3
    Width = 568
  end
  object cxteYears: TcxTextEdit
    Left = 257
    Top = 251
    Properties.OnValidate = cxteYearsPropertiesValidate
    TabOrder = 4
    Width = 48
  end
  object cxteMonths: TcxTextEdit
    Left = 405
    Top = 251
    Properties.OnValidate = cxteYearsPropertiesValidate
    TabOrder = 5
    Width = 48
  end
  object cxteAnnotation: TcxTextEdit
    Left = 217
    Top = 304
    TabOrder = 6
    Text = 'cxteAnnotation'
    Width = 613
  end
  object cxdblcbQualifications: TcxDBLookupComboBox
    Left = 217
    Top = 202
    Properties.ListColumns = <>
    TabOrder = 7
    Width = 613
  end
  object cxcbLocked: TcxCheckBox
    Left = 217
    Top = 355
    TabOrder = 8
  end
  object cxcbPortal: TcxCheckBox
    Left = 217
    Top = 394
    TabOrder = 9
  end
  object cxdblcbStandarts: TcxDBLookupComboBox
    Left = 461
    Top = 39
    Properties.ListColumns = <>
    Properties.OnChange = cxdblcbStandartsPropertiesChange
    Properties.OnNewLookupDisplayText = cxdblcbStandartsPropertiesNewLookupDisplayText
    TabOrder = 10
    Width = 145
  end
  object cxbtnAddSpeciality: TcxButton
    Left = 791
    Top = 143
    Width = 39
    Height = 24
    Hint = #1053#1086#1074#1086#1077' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1076#1075#1086#1090#1086#1074#1082#1080
    Caption = 'cxbtnAddSpeciality'
    OptionsImage.Glyph.SourceDPI = 96
    OptionsImage.Glyph.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      610000001B744558745469746C65004164643B506C75733B426172733B526962
      626F6E3B9506332F0000036349444154785E35927D6C535518C69F73EE6DEB64
      63A3AEFB60A3A36E33B8C56581E0D8707E21CC1A43A2A22304FE3001512A86C4
      E900132451FF503367420043B244364C483031465C248B4441C0980C45B4D065
      CDBA4ECAE82AAC5DBBDE8FF3E1BD27F1397973DE9C3CBFF7233964226FC2D543
      A53E0280443E3FD752525AB14323FA06685A3381E492F329C6ADF39954E2F8C9
      C3DBA6018858DE940A9C2C5870C1D51BB6FAF61DBB327860F81A1BFE25297FB8
      3127C7EFE4E5D5745E9EBB9991239766E481937FE4DE1818DB0DC0EB322EABBA
      B63FD5EB7D6CCBBE6F1B83FE9E67BA82E084C0E4123697CAE0D109BC94805B0C
      E7AFCC606A66EEECF75FBCBB753AFAEB2201A0BD3E7861B02914D8DBF34408A9
      AC0D2181D3672E23319D81AB950D016CEBED824E809A722FC62E4CE17A343130
      D4DF73507FB9FFAB551E9F6FCF93EB82B879BB088D52504A14FCC9CE4E95F79D
      B80CD396284A8179C7D3DD1144F29FEC5BE1D73E1BA6BEB2C09BEDCD955A7CCE
      44D1744C1687C9045C05EBFC686F0DAADCB08413D2098E89B4E1BC5779965687
      5ED585D03ACBFDA548E7197EFA711C776EDFC5FF12200A7075F4E85975D7D4FA
      F1F4A635A82C5F02A2956CD46D2EEB1D160B455BC19FEE5E0F4A885A45828071
      81137D1B61DB0C1E5D43E4C8CF5858E4D0A1810BBA5CB76DEEBDB768C1E604AE
      EA6B1F40D9121F0A265385BC0E5457530109404A8010E27805EEE60598CDA15B
      8699C8E7CD4784EEC3F2BA00767C340A4AA9327E79300CE1505BDEFF0E9AA681
      5082150DD5604CA26858282E1693D428E42F6666B3909068EF68C5E6171FC7E6
      17BA611A260C93A9029C713CF7FC3A3C1BEE404B5B2398E0989FCBA190FD774C
      CFA46243B11B4B77ADADF67BB236478E10500AA5D2121D5C48354D3A674108A1
      56114C201E4BB1D9F86FA70880FB1EDD3E34B0A229B4E7E1350FC2E22E2011BF
      16C3FCBD050557562DC3CA964608B8B4C4E49F4924A27F1F193F1DD9AF03B0FE
      1AFDE03D113EDC6431B1A96575089212B4AD6D555F581280D902398343308EC9
      EB49DC9A981A75E043000CA46D09005A49457059DB4BC78E77EDFCDAEAFDF892
      DC3B1295EF7C13977D4E444E45E52BCE5BE7AE338555E10FDF0650EE32B30E4B
      D24C0212A8F210EAAED3D01969BB3FD0BCDDE32BEB06D56AD5D09CCDDA66EE62
      EED6EF43A9AB2331008603ABCEFF019D3AAD15CCD8D2E00000000049454E44AE
      426082}
    PaintStyle = bpsGlyph
    TabOrder = 11
    OnClick = cxbtnAddSpecialityClick
  end
end
