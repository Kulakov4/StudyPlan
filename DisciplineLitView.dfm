inherited viewDisciplineLit: TviewDisciplineLit
  inherited pnlGrid: TPanel
    inherited cxGrid: TcxGrid
      Top = 26
      Height = 420
      ExplicitTop = 26
      ExplicitHeight = 420
    end
    inherited tbdEssenceTop: TTBDock
      Height = 25
      ExplicitHeight = 25
      object TBToolbar1: TTBToolbar
        Left = 0
        Top = 0
        Caption = 'TBToolbar1'
        TabOrder = 0
        object TBItem1: TTBItem
          Action = actAdd
        end
      end
    end
  end
  object ActionList: TActionList
    Left = 248
    Top = 208
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnExecute = actAddExecute
    end
  end
end
