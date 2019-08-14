inherited viewPrepareUMK: TviewPrepareUMK
  Width = 507
  Height = 417
  ExplicitWidth = 507
  ExplicitHeight = 417
  object GridPanel2: TGridPanel
    Left = 0
    Top = 362
    Width = 507
    Height = 41
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'GridPanel2'
    ColumnCollection = <
      item
        Value = 25.002422371665550000
      end
      item
        Value = 49.996625365480600000
      end
      item
        Value = 25.000952262853850000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = Panel1
        Row = 0
      end
      item
        Column = 1
        Control = cxButton1
        Row = 0
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 0
    DesignSize = (
      507
      41)
    object Panel1: TPanel
      Left = 2
      Top = 1
      Width = 124
      Height = 39
      Anchors = []
      BevelOuter = bvNone
      TabOrder = 0
    end
    object cxButton1: TcxButton
      Left = 127
      Top = 1
      Width = 252
      Height = 39
      Align = alClient
      Action = actPrepareUMK
      TabOrder = 1
    end
  end
  object GridPanel1: TGridPanel
    Left = 3
    Top = 16
    Width = 494
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    ColumnCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 150.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 200.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = cxLabel1
        Row = 0
      end
      item
        Column = 1
        Control = pnlCreator
        Row = 0
      end
      item
        Column = 2
        Control = cxdbteCreator
        Row = 0
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 1
    object cxLabel1: TcxLabel
      Left = 1
      Top = 1
      Align = alClient
      Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
    end
    object pnlCreator: TPanel
      Left = 151
      Top = 1
      Width = 200
      Height = 25
      Align = alClient
      TabOrder = 1
    end
    object cxdbteCreator: TcxDBTextEdit
      Left = 351
      Top = 1
      Align = alClient
      TabOrder = 2
      ExplicitHeight = 21
      Width = 142
    end
  end
  object GridPanel3: TGridPanel
    Left = 3
    Top = 56
    Width = 494
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    ColumnCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 150.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 200.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = cxLabel2
        Row = 0
      end
      item
        Column = 1
        Control = pnlChairMaster
        Row = 0
      end
      item
        Column = 2
        Control = cxdbteChairMaster
        Row = 0
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 2
    object cxLabel2: TcxLabel
      Left = 1
      Top = 1
      Align = alClient
      Caption = #1047#1072#1074'. '#1082#1072#1092#1077#1076#1088#1086#1081
    end
    object pnlChairMaster: TPanel
      Left = 151
      Top = 1
      Width = 200
      Height = 25
      Align = alClient
      TabOrder = 1
    end
    object cxdbteChairMaster: TcxDBTextEdit
      Left = 351
      Top = 1
      Align = alClient
      TabOrder = 2
      ExplicitHeight = 21
      Width = 142
    end
  end
  object pnlYear: TPanel
    Left = 3
    Top = 102
    Width = 493
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 3
    object cxLabel3: TcxLabel
      Left = 0
      Top = 0
      Align = alLeft
      Caption = #1043#1086#1076' '#1088#1072#1073#1086#1095#1077#1081' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    end
    object cxseYear: TcxSpinEdit
      Left = 167
      Top = 0
      Properties.OnChange = cxseYearPropertiesChange
      Properties.OnEditValueChanged = cxseYearPropertiesEditValueChanged
      TabOrder = 1
      Width = 121
    end
  end
  object Panel2: TPanel
    Left = 3
    Top = 133
    Width = 493
    Height = 44
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 4
    object cxcbSave: TcxCheckBox
      Left = 0
      Top = 0
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1086#1076' '#1080#1084#1077#1085#1077#1084
      State = cbsChecked
      TabOrder = 0
    end
  end
  object ActionList1: TActionList
    Left = 240
    Top = 144
    object actPrepareUMK: TAction
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1088#1072#1073#1086#1095#1091#1102' '#1087#1088#1086#1075#1088#1072#1084#1084#1091
      OnExecute = actPrepareUMKExecute
    end
  end
end
