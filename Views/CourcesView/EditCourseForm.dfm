object frmEditCourse: TfrmEditCourse
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1099#1081' '#1087#1083#1072#1085' '#1082#1091#1088#1089#1072' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086#1075#1086' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
  ClientHeight = 305
  ClientWidth = 950
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  DesignSize = (
    950
    305)
  PixelsPerInch = 96
  TextHeight = 16
  object btnClose: TcxButton
    Left = 832
    Top = 257
    Width = 110
    Height = 33
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'OK'
    Default = True
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    ModalResult = 1
    TabOrder = 0
  end
  object cxPageControl: TcxPageControl
    Left = 0
    Top = 0
    Width = 950
    Height = 241
    Align = alTop
    TabOrder = 1
    Properties.ActivePage = cxtshGroups
    Properties.CustomButtons.Buttons = <>
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    OnChange = cxPageControlChange
    OnPageChanging = cxPageControlPageChanging
    ClientRectBottom = 237
    ClientRectLeft = 4
    ClientRectRight = 946
    ClientRectTop = 27
    object cxtshPlan: TcxTabSheet
      Caption = #1055#1083#1072#1085
      ImageIndex = 0
      object Label10: TLabel
        Left = 24
        Top = 27
        Width = 65
        Height = 16
        Caption = ' '#1050#1072#1092#1077#1076#1088#1072': '
      end
      object Label11: TLabel
        Left = 24
        Top = 74
        Width = 95
        Height = 16
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077': '
      end
      object Label12: TLabel
        Left = 24
        Top = 121
        Width = 179
        Height = 16
        Caption = #1057#1086#1082#1088#1072#1097#1105#1085#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077': '
      end
      object Label1: TLabel
        Left = 24
        Top = 166
        Width = 111
        Height = 16
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1095#1072#1089#1086#1074':'
      end
      object cxdblcbChair: TcxDBLookupComboBox
        Left = 208
        Top = 23
        Properties.DropDownListStyle = lsFixedList
        Properties.ListColumns = <>
        Properties.OnChange = cxdblcbChairPropertiesChange
        TabOrder = 0
        Width = 697
      end
      object cxdblcbSpeciality: TcxDBLookupComboBox
        Left = 208
        Top = 70
        Enabled = False
        Properties.DropDownListStyle = lsEditList
        Properties.ListColumns = <>
        Properties.OnEditValueChanged = cxdblcbSpecialityPropertiesEditValueChanged
        Properties.OnNewLookupDisplayText = cxdblcbSpecialityPropertiesNewLookupDisplayText
        TabOrder = 1
        Width = 697
      end
      object cxteShort: TcxTextEdit
        Left = 208
        Top = 117
        Enabled = False
        TabOrder = 2
        Width = 697
      end
      object cxteData: TcxTextEdit
        Left = 210
        Top = 162
        TabOrder = 3
        Width = 66
      end
    end
    object cxtshDisciplines: TcxTabSheet
      Caption = #1044#1080#1089#1094#1080#1087#1083#1080#1085#1099
      ImageIndex = 1
    end
    object cxtshGroups: TcxTabSheet
      Caption = #1043#1088#1091#1087#1087#1099
      ImageIndex = 2
    end
  end
end
