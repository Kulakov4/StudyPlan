inherited viewFactorEdit: TviewFactorEdit
  Width = 711
  Height = 358
  ExplicitWidth = 711
  ExplicitHeight = 358
  object pnlMain: TPanel
    Left = 176
    Top = 9
    Width = 535
    Height = 349
    Align = alClient
    TabOrder = 0
  end
  object dxNavBar1: TdxNavBar
    Left = 0
    Top = 9
    Width = 168
    Height = 349
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ActiveGroupIndex = 0
    TabOrder = 1
    View = 8
    OptionsStyle.DefaultStyles.Background.BackColor = clWindow
    OptionsStyle.DefaultStyles.Background.BackColor2 = clWindow
    OptionsStyle.DefaultStyles.Background.Font.Charset = DEFAULT_CHARSET
    OptionsStyle.DefaultStyles.Background.Font.Color = clWindowText
    OptionsStyle.DefaultStyles.Background.Font.Height = -13
    OptionsStyle.DefaultStyles.Background.Font.Name = 'Tahoma'
    OptionsStyle.DefaultStyles.Background.Font.Style = []
    OptionsStyle.DefaultStyles.Background.HAlignment = haLeft
    OptionsStyle.DefaultStyles.Button.BackColor = clBtnFace
    OptionsStyle.DefaultStyles.Button.BackColor2 = clBtnFace
    OptionsStyle.DefaultStyles.Button.Font.Charset = DEFAULT_CHARSET
    OptionsStyle.DefaultStyles.Button.Font.Color = clWindowText
    OptionsStyle.DefaultStyles.Button.Font.Height = -13
    OptionsStyle.DefaultStyles.Button.Font.Name = 'Tahoma'
    OptionsStyle.DefaultStyles.Button.Font.Style = []
    OptionsStyle.DefaultStyles.Button.HAlignment = haLeft
    OptionsStyle.DefaultStyles.ButtonHotTracked.BackColor = clBtnFace
    OptionsStyle.DefaultStyles.ButtonHotTracked.BackColor2 = clBtnFace
    OptionsStyle.DefaultStyles.ButtonHotTracked.Font.Charset = DEFAULT_CHARSET
    OptionsStyle.DefaultStyles.ButtonHotTracked.Font.Color = clWindowText
    OptionsStyle.DefaultStyles.ButtonHotTracked.Font.Height = -13
    OptionsStyle.DefaultStyles.ButtonHotTracked.Font.Name = 'Tahoma'
    OptionsStyle.DefaultStyles.ButtonHotTracked.Font.Style = []
    OptionsStyle.DefaultStyles.ButtonHotTracked.HAlignment = haLeft
    object dxnvbrgrpNavBar1Group1: TdxNavBarGroup
      Caption = #1050#1088#1080#1090#1077#1088#1080#1081
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      Links = <
        item
          Item = dxnvbrtmNavBar1Item1
        end
        item
          Item = dxnvbrtmNavBar1Item2
        end
        item
          Item = dxnvbrtmNavBar1Item3
        end>
    end
    object dxnvbrtmNavBar1Item1: TdxNavBarItem
      Caption = #1048#1084#1103' '#1080' '#1075#1088#1091#1087#1087#1072
      OnClick = dxnvbrtmNavBar1Item1Click
    end
    object dxnvbrtmNavBar1Item2: TdxNavBarItem
      Caption = #1047#1072#1087#1088#1086#1089
      OnClick = dxnvbrtmNavBar1Item2Click
    end
    object dxnvbrtmNavBar1Item3: TdxNavBarItem
      Caption = #1055#1088#1072#1074#1080#1083#1072' '#1087#1088#1086#1074#1077#1088#1082#1080
      OnClick = dxnvbrtmNavBar1Item3Click
    end
  end
  object cxs1: TcxSplitter
    Left = 168
    Top = 9
    Width = 8
    Height = 349
    HotZoneClassName = 'TcxMediaPlayer8Style'
    Control = dxNavBar1
  end
  object tbdTop: TTBDock
    Left = 0
    Top = 0
    Width = 711
    Height = 9
  end
end
