inherited viewDisciplinePurpose: TviewDisciplinePurpose
  Width = 628
  Height = 355
  ExplicitWidth = 628
  ExplicitHeight = 355
  object gpMain: TGridPanel
    Left = 0
    Top = 9
    Width = 628
    Height = 346
    Align = alClient
    ColumnCollection = <
      item
        Value = 20.015357051446120000
      end
      item
        Value = 79.984642948553880000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = cxlbl1
        Row = 0
      end
      item
        Column = 1
        Control = cxdbmPurpose
        Row = 0
      end
      item
        Column = 0
        Control = cxLabel1
        Row = 1
      end
      item
        Column = 1
        Control = cxdbmTask
        Row = 1
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    TabOrder = 0
    ExplicitWidth = 499
    ExplicitHeight = 416
    DesignSize = (
      628
      346)
    object cxlbl1: TcxLabel
      Left = 48
      Top = 78
      Anchors = []
      Caption = #1062#1077#1083#1100
      ExplicitLeft = 35
      ExplicitTop = 96
    end
    object cxdbmPurpose: TcxDBMemo
      AlignWithMargins = True
      Left = 129
      Top = 4
      Align = alClient
      DataBinding.DataField = 'Purpose'
      TabOrder = 1
      ExplicitLeft = 103
      ExplicitWidth = 392
      ExplicitHeight = 201
      Height = 166
      Width = 495
    end
    object cxLabel1: TcxLabel
      Left = 43
      Top = 250
      Anchors = []
      Caption = #1047#1072#1076#1072#1095#1080
      ExplicitLeft = 30
      ExplicitTop = 303
    end
    object cxdbmTask: TcxDBMemo
      AlignWithMargins = True
      Left = 129
      Top = 176
      Align = alClient
      DataBinding.DataField = 'Task'
      TabOrder = 3
      ExplicitLeft = 103
      ExplicitTop = 211
      ExplicitWidth = 392
      ExplicitHeight = 201
      Height = 166
      Width = 495
    end
  end
  object tbdckTop: TTBDock
    Left = 0
    Top = 0
    Width = 628
    Height = 9
    ExplicitWidth = 499
  end
end
