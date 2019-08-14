inherited frmAddFactor: TfrmAddFactor
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1082#1088#1080#1090#1077#1088#1080#1077#1074
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 16
  inherited cxbtnOk: TcxButton
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
  end
  object cxcbOverride: TcxCheckBox [3]
    Left = 8
    Top = 525
    Caption = #1055#1077#1088#1077#1079#1072#1087#1080#1089#1099#1074#1072#1090#1100' '#1082#1088#1080#1090#1077#1088#1080#1080' '#1087#1088#1080' '#1089#1086#1074#1087#1072#1076#1077#1085#1080#1080
    State = cbsChecked
    TabOrder = 3
  end
  inherited cxpsViewForm: TcxPropertiesStore
    Components = <
      item
        Component = frmViewEx.Owner
        Properties.Strings = (
          'Height'
          'Width')
      end>
  end
end
