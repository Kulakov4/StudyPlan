inherited frmCopyStudyPlanFactors: TfrmCopyStudyPlanFactors
  Caption = 'frmCopyStudyPlanFactors'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 16
  inherited pnlMain: TPanel
    object tbdTop: TTBDock
      Left = 1
      Top = 1
      Width = 1048
      Height = 25
      object tbSPFCopy: TTBToolbar
        Left = 0
        Top = 0
        Caption = 'tbSPFCopy'
        TabOrder = 0
        object tbciOverride: TTBControlItem
          Control = cxcbOverride
        end
        object cxcbOverride: TcxCheckBox
          Left = 0
          Top = 0
          Caption = #1055#1077#1088#1077#1079#1072#1087#1080#1089#1072#1090#1100' '#1082#1088#1080#1090#1077#1088#1080#1080' '#1074' '#1089#1083#1091#1095#1072#1077' '#1089#1086#1074#1087#1072#1076#1077#1085#1080#1103
          TabOrder = 0
        end
      end
    end
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
