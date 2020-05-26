object frmCourceDiscEdit: TfrmCourceDiscEdit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1099
  ClientHeight = 387
  ClientWidth = 980
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
    980
    387)
  PixelsPerInch = 96
  TextHeight = 16
  object Label11: TLabel
    Left = 24
    Top = 28
    Width = 95
    Height = 16
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077': '
  end
  object Label12: TLabel
    Left = 24
    Top = 70
    Width = 179
    Height = 16
    Hint = #1057#1086#1082#1088#1072#1097#1077#1085#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1099' ('#1085#1077#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086')'
    Caption = #1057#1086#1082#1088#1072#1097#1105#1085#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077': '
  end
  object Label1: TLabel
    Left = 24
    Top = 113
    Width = 48
    Height = 16
    Caption = #1051#1077#1082#1094#1080#1081':'
  end
  object Label2: TLabel
    Left = 24
    Top = 155
    Width = 91
    Height = 16
    Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1099#1093':'
  end
  object Label3: TLabel
    Left = 24
    Top = 198
    Width = 70
    Height = 16
    Caption = #1057#1077#1084#1080#1085#1072#1088#1086#1074':'
  end
  object Label4: TLabel
    Left = 24
    Top = 240
    Width = 39
    Height = 16
    Caption = #1047#1072#1095#1105#1090':'
  end
  object Label5: TLabel
    Left = 24
    Top = 283
    Width = 54
    Height = 16
    Caption = #1069#1082#1079#1072#1084#1077#1085':'
  end
  object cxdblcbDisciplineName: TcxDBLookupComboBox
    Left = 252
    Top = 24
    Hint = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1099
    Properties.DropDownListStyle = lsEditList
    Properties.ListColumns = <>
    Properties.OnEditValueChanged = cxdblcbDisciplineNamePropertiesEditValueChanged
    Properties.OnNewLookupDisplayText = cxdblcbDisciplineNamePropertiesNewLookupDisplayText
    TabOrder = 0
    Width = 697
  end
  object cxteShort: TcxTextEdit
    Left = 252
    Top = 66
    Hint = #1057#1086#1082#1088#1072#1097#1077#1085#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1099' ('#1085#1077#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086')'
    TabOrder = 1
    Width = 697
  end
  object cxseLec: TcxSpinEdit
    Left = 252
    Top = 109
    Hint = #1063#1072#1089#1086#1074' '#1083#1077#1082#1094#1080#1081
    Properties.Increment = 2.000000000000000000
    Properties.MaxValue = 1000.000000000000000000
    Properties.OnValidate = cxseLecPropertiesValidate
    TabOrder = 2
    Width = 81
  end
  object cxseLab: TcxSpinEdit
    Left = 252
    Top = 151
    Hint = #1063#1072#1089#1086#1074' '#1083#1072#1073#1086#1088#1072#1090#1086#1088#1085#1099#1093
    Properties.Increment = 2.000000000000000000
    Properties.MaxValue = 1000.000000000000000000
    Properties.OnValidate = cxseLecPropertiesValidate
    TabOrder = 3
    Width = 81
  end
  object cxseSem: TcxSpinEdit
    Left = 252
    Top = 194
    Hint = #1063#1072#1089#1086#1074' '#1089#1077#1084#1080#1085#1072#1088#1086#1074
    Properties.Increment = 2.000000000000000000
    Properties.MaxValue = 1000.000000000000000000
    Properties.OnValidate = cxseLecPropertiesValidate
    TabOrder = 4
    Width = 81
  end
  object cxcbZach: TcxCheckBox
    Left = 252
    Top = 238
    Hint = #1050#1086#1085#1090#1088#1086#1083#1100#1085#1072#1103' '#1090#1086#1095#1082#1072' - '#1079#1072#1095#1105#1090
    Properties.Alignment = taLeftJustify
    TabOrder = 5
  end
  object cxcbExam: TcxCheckBox
    Left = 252
    Top = 281
    Hint = #1050#1086#1085#1090#1088#1086#1083#1100#1085#1072#1103' '#1090#1086#1095#1082#1072' - '#1101#1082#1079#1072#1084#1077#1085
    Properties.Alignment = taLeftJustify
    TabOrder = 6
  end
  object btnClose: TcxButton
    Left = 295
    Top = 331
    Width = 391
    Height = 33
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 7
  end
end
