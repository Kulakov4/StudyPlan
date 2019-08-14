object frmEditDisciplineName: TfrmEditDisciplineName
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1099
  ClientHeight = 262
  ClientWidth = 850
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  DesignSize = (
    850
    262)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 32
    Top = 42
    Width = 86
    Height = 16
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label2: TLabel
    Left = 32
    Top = 90
    Width = 74
    Height = 16
    Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077
  end
  object Label3: TLabel
    Left = 32
    Top = 146
    Width = 52
    Height = 16
    Caption = #1050#1072#1092#1077#1076#1088#1072
  end
  object cxdblcbChairs: TcxDBLookupComboBox
    Left = 200
    Top = 143
    Properties.ListColumns = <>
    TabOrder = 2
    Width = 609
  end
  object cxteDisciplineName: TcxTextEdit
    Left = 200
    Top = 39
    TabOrder = 0
    Width = 609
  end
  object cxteShortDisciplineName: TcxTextEdit
    Left = 200
    Top = 87
    TabOrder = 1
    Width = 609
  end
  object btnClose: TcxButton
    Left = 699
    Top = 205
    Width = 110
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    ModalResult = 1
    TabOrder = 3
  end
end
