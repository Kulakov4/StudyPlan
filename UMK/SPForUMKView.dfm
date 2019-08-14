inherited dsgvSPForUMK: TdsgvSPForUMK
  Width = 710
  ExplicitWidth = 710
  inherited pnlGrid: TPanel
    Top = 138
    Width = 710
    Height = 309
    ExplicitTop = 138
    ExplicitWidth = 710
    ExplicitHeight = 309
    inherited cxGrid: TcxGrid
      Width = 708
      Height = 298
      ExplicitWidth = 708
      ExplicitHeight = 298
    end
    inherited tbdEssenceTop: TTBDock
      Width = 708
      Visible = False
      ExplicitWidth = 708
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 710
    Height = 138
    Align = alTop
    TabOrder = 1
    DesignSize = (
      710
      138)
    object cxLabel1: TcxLabel
      Left = 16
      Top = 50
      Caption = #1057#1090#1072#1085#1076#1072#1088#1090':'
    end
    object cxdbteStudyPlanStandart: TcxDBTextEdit
      Left = 176
      Top = 48
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Width = 505
    end
    object cxLabel2: TcxLabel
      Left = 16
      Top = 77
      Caption = #1064#1080#1092#1088' '#1089#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1080':'
    end
    object cxLabel3: TcxLabel
      Left = 16
      Top = 104
      Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100
    end
    object cxdbteChiperSpeciality: TcxDBTextEdit
      Left = 176
      Top = 75
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
      Width = 505
    end
    object cxdbteSpeciality: TcxDBTextEdit
      Left = 176
      Top = 102
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      Width = 505
    end
    object cxLabel4: TcxLabel
      Left = 16
      Top = 23
      Caption = #1044#1080#1089#1094#1080#1087#1083#1080#1085#1072':'
    end
    object cxdbteDisciplineName: TcxDBTextEdit
      Left = 176
      Top = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 7
      Width = 505
    end
  end
end
