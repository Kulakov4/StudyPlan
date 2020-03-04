inherited PlanEditView: TPlanEditView
  Width = 860
  Height = 340
  ExplicitWidth = 860
  ExplicitHeight = 340
  object lbl1: TLabel
    Left = 14
    Top = 77
    Width = 35
    Height = 13
    Caption = #1052#1077#1089#1090#1086':'
  end
  object lbl2: TLabel
    Left = 14
    Top = 143
    Width = 65
    Height = 13
    Caption = #1044#1080#1089#1094#1080#1087#1083#1080#1085#1072':'
  end
  object lbl4: TLabel
    Left = 144
    Top = 295
    Width = 102
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1042#1089#1077#1075#1086' '#1095#1072#1089#1086#1074':'
    OnClick = lbl4Click
  end
  object lbl5: TLabel
    Left = 323
    Top = 295
    Width = 63
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1051#1077#1082#1094#1080#1081':'
  end
  object lbl6: TLabel
    Left = 463
    Top = 295
    Width = 106
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1099#1093':'
  end
  object lbl7: TLabel
    Left = 637
    Top = 295
    Width = 110
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1055#1088#1072#1082#1090#1080#1095#1077#1089#1082#1080#1093':'
  end
  object Label1: TLabel
    Left = 14
    Top = 216
    Width = 50
    Height = 13
    Caption = #1050#1072#1092#1077#1076#1088#1072':'
  end
  object Label2: TLabel
    Left = 14
    Top = 295
    Width = 20
    Height = 13
    Caption = #1047'.'#1045'.'
  end
  object lblPath: TLabel
    Left = 150
    Top = 3
    Width = 693
    Height = 64
    AutoSize = False
    Layout = tlBottom
    WordWrap = True
  end
  object Label3: TLabel
    Left = 14
    Top = 110
    Width = 100
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1099':'
  end
  object pnl1: TPanel
    Left = 154
    Top = 72
    Width = 696
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object pnl2: TPanel
    Left = 154
    Top = 145
    Width = 696
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object cxdbspndtTotal: TcxDBSpinEdit
    Left = 252
    Top = 291
    TabOrder = 6
    Width = 65
  end
  object cxdbspndtLectures: TcxDBSpinEdit
    Left = 392
    Top = 291
    TabOrder = 7
    Width = 65
  end
  object cxdbspndtLabworks: TcxDBSpinEdit
    Left = 569
    Top = 291
    TabOrder = 8
    Width = 65
  end
  object cxdbspndtSeminars: TcxDBSpinEdit
    Left = 747
    Top = 291
    TabOrder = 9
    Width = 65
  end
  object pnlChair: TPanel
    Left = 154
    Top = 212
    Width = 696
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object cxdbspndtTotal2: TcxDBSpinEdit
    Left = 58
    Top = 291
    Properties.ImmediatePost = True
    TabOrder = 5
    Width = 65
  end
  object cxdbchckbxIs_Option: TcxDBCheckBox
    Left = 14
    Top = 175
    Caption = #1055#1086' '#1074#1099#1073#1086#1088#1091
    Properties.Alignment = taRightJustify
    Properties.ImmediatePost = True
    Properties.ValueChecked = 1
    Properties.ValueUnchecked = 0
    TabOrder = 3
  end
  object cxdbspndtPosition: TcxDBSpinEdit
    Left = 154
    Top = 107
    TabOrder = 1
    Width = 71
  end
  object cxdbcbProfessionalModule: TcxDBCheckBox
    Left = 252
    Top = 107
    Caption = #1044#1080#1089#1094#1080#1087#1083#1080#1085#1072' '#1103#1074#1083#1103#1077#1090#1089#1103' '#1082#1086#1085#1090#1088#1086#1083#1100#1085#1086#1081' '#1090#1086#1095#1082#1086#1081' '#1087#1088#1086#1092#1077#1089#1089#1080#1086#1085#1072#1083#1100#1085#1086#1075#1086' '#1084#1086#1076#1091#1083#1103
    Properties.Alignment = taLeftJustify
    Properties.DisplayChecked = 'true'
    Properties.DisplayUnchecked = 'false'
    Properties.ImmediatePost = True
    Properties.NullStyle = nssUnchecked
    Properties.ValueChecked = 1
    Properties.ValueUnchecked = 0
    TabOrder = 10
  end
  object cxdbcbAutoSelfHours: TcxDBCheckBox
    Left = 14
    Top = 254
    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1095#1072#1089#1086#1074' '#1076#1083#1103' '#1089#1072#1084'. '#1088#1072#1073#1086#1090#1099
    DataBinding.DataField = 'AUTOSELFHOURS'
    Properties.Alignment = taLeftJustify
    Properties.ValueChecked = '1'
    Properties.ValueUnchecked = '0'
    TabOrder = 11
  end
end
