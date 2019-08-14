inherited frmSPEdit: TfrmSPEdit
  Left = 355
  Top = 310
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1091#1095#1077#1073#1085#1086#1075#1086' '#1087#1083#1072#1085#1072
  ClientHeight = 376
  ClientWidth = 863
  OldCreateOrder = True
  ExplicitWidth = 869
  ExplicitHeight = 405
  PixelsPerInch = 96
  TextHeight = 16
  inherited pnlMain: TPanel
    Width = 863
    Height = 332
    Align = alTop
    ExplicitWidth = 863
    ExplicitHeight = 332
  end
  object cxButton1: TcxButton [1]
    Left = 210
    Top = 338
    Width = 203
    Height = 31
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1054#1050
    Default = True
    LookAndFeel.Kind = lfOffice11
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton [2]
    Left = 450
    Top = 338
    Width = 203
    Height = 31
    Anchors = [akLeft, akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    LookAndFeel.Kind = lfOffice11
    ModalResult = 2
    TabOrder = 2
  end
  inherited cxpsViewForm: TcxPropertiesStore
    Components = <
      item
        Component = frmView.Owner
        Properties.Strings = (
          'Height'
          'Width')
      end>
  end
end
