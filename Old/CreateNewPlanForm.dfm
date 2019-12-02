object frmCreateNewStudyPlan: TfrmCreateNewStudyPlan
  Left = 340
  Top = 330
  BorderStyle = bsDialog
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1085#1086#1074#1086#1075#1086' '#1091#1095#1077#1073#1085#1086#1075#1086' '#1087#1083#1072#1085#1072
  ClientHeight = 301
  ClientWidth = 960
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  DesignSize = (
    960
    301)
  PixelsPerInch = 96
  TextHeight = 16
  object tbdckTop: TTBDock
    Left = 0
    Top = 0
    Width = 960
    Height = 228
    object tbEducationLevel: TTBToolbar
      Left = 0
      Top = 0
      Caption = 'tbEducationLevel'
      TabOrder = 0
      object TBControlItem1: TTBControlItem
        Control = lbl3
      end
      object lbl3: TLabel
        Left = 0
        Top = 0
        Width = 118
        Height = 16
        Caption = #1042#1080#1076' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103':'
      end
    end
    object tbEducation: TTBToolbar
      Left = 0
      Top = 20
      Caption = 'tbEducation'
      DockPos = 0
      DockRow = 1
      TabOrder = 1
      object TBControlItem2: TTBControlItem
        Control = Label1
      end
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 113
        Height = 16
        Caption = #1060#1086#1088#1084#1072' '#1086#1073#1091#1095#1077#1085#1080#1103':'
      end
    end
    object tbYears: TTBToolbar
      Left = 123
      Top = 40
      Caption = 'tbYears'
      DockPos = 115
      DockRow = 2
      TabOrder = 3
      object TBControlItem3: TTBControlItem
        Control = Label2
      end
      object TBControlItem4: TTBControlItem
        Control = cxmeYears
      end
      object TBControlItem5: TTBControlItem
        Control = Label3
      end
      object TBControlItem6: TTBControlItem
        Control = cxmeMonths
      end
      object Label2: TLabel
        Left = 0
        Top = 4
        Width = 27
        Height = 16
        Caption = #1051#1077#1090':'
      end
      object Label3: TLabel
        Left = 65
        Top = 4
        Width = 66
        Height = 16
        Caption = '  '#1052#1077#1089#1103#1094#1077#1074':'
      end
      object cxmeYears: TcxMaskEdit
        Left = 27
        Top = 0
        Properties.EditMask = '!9;1;_'
        Properties.MaxLength = 0
        TabOrder = 0
        Text = ' '
        Width = 38
      end
      object cxmeMonths: TcxMaskEdit
        Left = 131
        Top = 0
        Properties.EditMask = '!99;1;_'
        Properties.MaxLength = 0
        TabOrder = 1
        Text = '  '
        Width = 38
      end
    end
    object tbYear: TTBToolbar
      Left = 0
      Top = 40
      Caption = 'tbEducation'
      DockPos = -2
      DockRow = 2
      TabOrder = 2
      object TBControlItem7: TTBControlItem
        Control = Label4
      end
      object TBControlItem8: TTBControlItem
        Control = cxmeYear
      end
      object Label4: TLabel
        Left = 0
        Top = 4
        Width = 29
        Height = 16
        Caption = #1043#1086#1076': '
      end
      object cxmeYear: TcxMaskEdit
        Left = 29
        Top = 0
        Properties.EditMask = '!9999;1;_'
        Properties.MaxLength = 0
        TabOrder = 0
        Text = '    '
        Width = 84
      end
    end
    object tbSpecialitys: TTBToolbar
      Left = 0
      Top = 124
      Caption = 'tbChair'
      DockPos = 0
      DockRow = 5
      TabOrder = 4
      object TBControlItem9: TTBControlItem
        Control = Label5
      end
      object TBControlItem15: TTBControlItem
        Control = cxdbbeSpecialitys
      end
      object Label5: TLabel
        Left = 0
        Top = 4
        Width = 107
        Height = 16
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100': '
      end
      object cxdbbeSpecialitys: TcxDBButtonEdit
        Left = 107
        Top = 0
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = cxdbbeSpecialitysPropertiesButtonClick
        TabOrder = 0
        Width = 803
      end
    end
    object tbStudyPlanStandart: TTBToolbar
      Left = 0
      Top = 152
      Caption = 'tbStudyPlanStandart'
      DockPos = -2
      DockRow = 6
      TabOrder = 5
      object TBControlItem10: TTBControlItem
        Control = Label6
      end
      object Label6: TLabel
        Left = 0
        Top = 0
        Width = 177
        Height = 16
        Caption = #1057#1090#1072#1085#1076#1072#1088#1090' '#1091#1095#1077#1073#1085#1086#1075#1086' '#1087#1083#1072#1085#1072': '
      end
    end
    object TBToolbar2: TTBToolbar
      Left = 0
      Top = 96
      Caption = 'TBToolbar1'
      DockPos = -16
      DockRow = 4
      TabOrder = 6
      object TBControlItem12: TTBControlItem
        Control = Label7
      end
      object TBControlItem13: TTBControlItem
        Control = cxdbteChiperCode
      end
      object Label7: TLabel
        Left = 0
        Top = 4
        Width = 144
        Height = 16
        Caption = #1064#1080#1092#1088' '#1089#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1080':'
      end
      object cxdbteChiperCode: TcxDBTextEdit
        Left = 144
        Top = 0
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 121
      end
    end
    object tbAnnotation: TTBToolbar
      Left = 0
      Top = 172
      Caption = 'tbAnnotation'
      DockPos = 0
      DockRow = 7
      TabOrder = 7
      object TBControlItem11: TTBControlItem
        Control = Label8
      end
      object TBControlItem14: TTBControlItem
        Control = cxteAnnotation
      end
      object Label8: TLabel
        Left = 0
        Top = 4
        Width = 86
        Height = 16
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077':'
      end
      object cxteAnnotation: TcxTextEdit
        Left = 86
        Top = 0
        TabOrder = 0
        Width = 121
      end
    end
    object TBToolbar1: TTBToolbar
      Left = 0
      Top = 200
      Caption = #1050#1074#1072#1083#1080#1092#1080#1082#1072#1094#1080#1103
      DockPos = 0
      DockRow = 8
      TabOrder = 8
      object TBControlItem16: TTBControlItem
        Control = Label9
      end
      object TBControlItem17: TTBControlItem
        Control = cxdbbeQualification
      end
      object TBControlItem18: TTBControlItem
        Control = cxcbQualification
      end
      object Label9: TLabel
        Left = 0
        Top = 4
        Width = 100
        Height = 16
        Caption = #1050#1074#1072#1083#1080#1092#1080#1082#1072#1094#1080#1103':'
      end
      object cxdbbeQualification: TcxDBButtonEdit
        Left = 100
        Top = 0
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        Properties.OnButtonClick = cxdbbeQualificationPropertiesButtonClick
        TabOrder = 0
        Width = 483
      end
      object cxcbQualification: TcxCheckBox
        Left = 583
        Top = 0
        Caption = #1082#1072#1082' '#1074' '#1089#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1080
        TabOrder = 1
        OnClick = cxcbQualificationClick
      end
    end
    object TBToolbar3: TTBToolbar
      Left = 0
      Top = 68
      Caption = 'TBToolbar3'
      DockPos = -6
      DockRow = 3
      TabOrder = 9
      object TBControlItem19: TTBControlItem
        Control = Label10
      end
      object TBControlItem20: TTBControlItem
        Control = cxdbbeChairs
      end
      object Label10: TLabel
        Left = 0
        Top = 4
        Width = 65
        Height = 16
        Caption = #1050#1072#1092#1077#1076#1088#1072': '
      end
      object cxdbbeChairs: TcxDBButtonEdit
        Left = 65
        Top = 0
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = cxdbbeChairsPropertiesButtonClick
        TabOrder = 0
        Width = 800
      end
    end
  end
  object btnClose: TcxButton
    Left = 257
    Top = 256
    Width = 446
    Height = 33
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1057#1086#1079#1076#1072#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
end