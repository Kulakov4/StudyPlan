inherited viewUMKMaster: TviewUMKMaster
  Width = 757
  Height = 500
  ExplicitWidth = 757
  ExplicitHeight = 500
  object dxnbUMK: TdxNavBar
    Left = 0
    Top = 0
    Width = 201
    Height = 500
    Align = alLeft
    ActiveGroupIndex = 0
    TabOrder = 0
    View = 17
    ViewStyle.ColorSchemeName = 'Blue'
    object dxnbUMKGroup1: TdxNavBarGroup
      Caption = #1056#1072#1073#1086#1095#1072#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1072
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      Links = <
        item
          Item = dxnbiUMKItem1
        end
        item
          Item = dxnbUMKItem1
        end
        item
          Item = dxnbUMKItem2
        end
        item
          Item = dxnbUMKItem3
        end
        item
          Item = dxnbUMKItem4
        end
        item
          Item = dxnbiUMKItem4
        end
        item
          Item = dxnbiUMKItem3
        end
        item
          Item = dxnbiUMKItem2
        end>
    end
    object dxnbiUMKItem1: TdxNavBarItem
      Action = actStudyPlansForUMK
    end
    object dxnbUMKItem1: TdxNavBarItem
      Action = actLessonThemesForUMK
      OnClick = actLessonThemesForUMKExecute
    end
    object dxnbiUMKItem2: TdxNavBarItem
      Action = actPrepareReport
      OnClick = actPrepareReportExecute
    end
    object dxnbiUMKItem3: TdxNavBarItem
      Action = actCompetence
    end
    object dxnbUMKItem2: TdxNavBarItem
      Action = actPurpose
    end
    object dxnbiUMKItem4: TdxNavBarItem
      Action = actSoft
    end
    object dxnbUMKItem3: TdxNavBarItem
      Action = actPreviousDisciplines
    end
    object dxnbUMKItem4: TdxNavBarItem
      Action = actSubsequenceDisciplines
    end
  end
  object pnlCenter: TPanel
    Left = 201
    Top = 0
    Width = 556
    Height = 500
    Align = alClient
    TabOrder = 1
  end
  object actlstUMK: TActionList
    Left = 305
    Top = 224
    object actStudyPlansForUMK: TAction
      Caption = #1059#1095#1077#1073#1085#1099#1077' '#1087#1083#1072#1085#1099
      OnExecute = actStudyPlansForUMKExecute
    end
    object actLessonThemesForUMK: TAction
      Caption = #1058#1077#1084#1072#1090#1080#1095#1077#1089#1082#1080#1077' '#1087#1083#1072#1085#1099
      Enabled = False
      OnExecute = actLessonThemesForUMKExecute
    end
    object actCompetence: TAction
      Caption = #1050#1086#1084#1087#1077#1090#1077#1085#1094#1080#1080
      Enabled = False
      OnExecute = actCompetenceExecute
    end
    object actPurpose: TAction
      Caption = #1062#1077#1083#1100' '#1080' '#1079#1072#1076#1072#1095#1080
      OnExecute = actPurposeExecute
    end
    object actSoft: TAction
      Caption = #1058#1088#1077#1073#1086#1074#1072#1085#1080#1103' '#1082' '#1055#1054
      OnExecute = actSoftExecute
    end
    object actPreviousDisciplines: TAction
      Caption = #1055#1088#1077#1076#1096#1077#1089#1090#1074#1091#1102#1097#1080#1077' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1099
      OnExecute = actPreviousDisciplinesExecute
    end
    object actSubsequenceDisciplines: TAction
      Caption = #1055#1086#1089#1083#1077#1076#1091#1102#1097#1080#1077' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1099
      OnExecute = actSubsequenceDisciplinesExecute
    end
    object actPrepareReport: TAction
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1056#1055
      Enabled = False
      OnExecute = actPrepareReportExecute
    end
  end
end
