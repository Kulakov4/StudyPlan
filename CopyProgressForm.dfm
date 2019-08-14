object frmCopyProgress: TfrmCopyProgress
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1082#1088#1080#1090#1077#1088#1080#1077#1074
  ClientHeight = 105
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object cxpbCopy: TcxProgressBar
    Left = 18
    Top = 24
    TabOrder = 0
    Width = 527
  end
  object cxlblErrorCount: TcxLabel
    Left = 18
    Top = 64
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1096#1080#1073#1086#1082': 0'
  end
  object cxbtnClose: TcxButton
    Left = 202
    Top = 59
    Width = 155
    Height = 33
    Caption = #1054#1050
    LookAndFeel.Kind = lfOffice11
    ModalResult = 1
    TabOrder = 2
    Visible = False
    OnClick = cxbtnCloseClick
  end
end
