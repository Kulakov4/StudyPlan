object frmEditSpec: TfrmEditSpec
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1086#1077' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1076#1075#1086#1090#1086#1074#1082#1080
  ClientHeight = 234
  ClientWidth = 631
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
    631
    234)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 24
    Top = 21
    Width = 21
    Height = 16
    Caption = #1050#1086#1076
  end
  object Label2: TLabel
    Left = 24
    Top = 77
    Width = 86
    Height = 16
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label3: TLabel
    Left = 24
    Top = 131
    Width = 74
    Height = 16
    Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077
  end
  object cxteShortSpeciality: TcxTextEdit
    Left = 208
    Top = 128
    TabOrder = 2
    Width = 395
  end
  object btnClose: TcxButton
    Left = 493
    Top = 177
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
  object cxlcbChiper: TcxLookupComboBox
    Left = 208
    Top = 18
    Properties.ListColumns = <>
    Properties.OnChange = cxlcbChiperPropertiesChange
    TabOrder = 0
    Width = 395
  end
  object cxlcbSpeciality: TcxLookupComboBox
    Left = 208
    Top = 74
    Properties.ListColumns = <>
    TabOrder = 1
    Width = 395
  end
end
