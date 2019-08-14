object frmMessage: TfrmMessage
  Left = 468
  Top = 314
  BorderStyle = bsDialog
  ClientHeight = 59
  ClientWidth = 519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 120
  TextHeight = 16
  object lblText: TLabel
    Left = 10
    Top = 20
    Width = 375
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnClose: TButton
    Left = 394
    Top = 10
    Width = 122
    Height = 40
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = btnCloseClick
  end
end
