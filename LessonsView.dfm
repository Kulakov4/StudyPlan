inherited Lessons_View: TLessons_View
  inherited pnlGrid: TPanel
    inherited cxGrid: TcxGrid
      Top = 31
      Height = 415
      ExplicitTop = 31
      ExplicitHeight = 415
      inherited cxGridDBBandedTableView: TcxGridDBBandedTableView
        OptionsBehavior.PullFocusing = True
        OptionsSelection.MultiSelect = True
      end
    end
    inherited tbdEssenceTop: TTBDock
      Height = 30
      ExplicitHeight = 30
      object tb1: TTBToolbar
        Left = 0
        Top = 0
        Caption = 'tb1'
        Images = tbil1
        TabOrder = 0
        object tbi1: TTBItem
          Action = actEditLessonName
        end
      end
    end
  end
  object cxgrdpmn1: TcxGridPopupMenu
    Grid = cxGrid
    PopupMenus = <
      item
        GridView = cxGridDBBandedTableView
        HitTypes = [gvhtCell]
        Index = 0
        PopupMenu = pm1
      end>
    Left = 267
    Top = 160
  end
  object pm1: TPopupMenu
    Left = 174
    Top = 160
    object N1: TMenuItem
      Action = actEditLessonName
    end
  end
  object actlst1: TActionList
    Images = tbil1
    Left = 433
    Top = 138
    object actEditLessonName: TAction
      Caption = #1042#1074#1077#1089#1090#1080' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1090#1077#1084#1099
      ImageIndex = 0
      OnExecute = actEditLessonNameExecute
    end
  end
  object tbil1: TTBImageList
    Height = 20
    Width = 20
    Left = 258
    Top = 244
    Bitmap = {
      494C010101000400200014001400FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000500000001400000001002000000000000019
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF000000
      0000C6C3C600C6C3C60000000000C6C3C60000000000C6C3C60000000000C6C3
      C60000000000C6C3C6000000000000000000DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF0000000000DEEBEF00FFFF0000DEEBEF00FFFF0000DEEBEF00FFFF0000DEEB
      EF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF000000000000000000000000000000000000000000FFFF0000DEEBEF000000
      0000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF000000000000000000C6C3C60000000000FFFF0000DEEBEF00000000000000
      0000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF00000000000000000000000000FFFF0000DEEBEF0000000000DEEBEF000000
      000000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF000000000000000000FFFF0000DEEBEF0000000000DEEBEF00DEEBEF000000
      00000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF0000000000FFFF0000DEEBEF0000000000DEEBEF00DEEBEF00DEEBEF000000
      000000FFFF008482840000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF0000000000DEEBEF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      000000FFFF00C6C3C60000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF000000000000FFFF0084828400DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF0000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00000000000000840000000000DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
      EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000050000000140000000100010000000000F00000000000000000000000
      000000000000000000000000FFFFFF00FFFFF000000000000000000000001000
      0000000000000000000010000000000000000000000010000000000000000000
      0000100000000000000000000000100000000000000000000000100000000000
      0000000000001000000000000000000000001000000000000000000000001000
      0000000000000000000010000000000000000000000010000000000000000000
      0000100000000000000000000000100000000000000000000000100000000000
      0000000000001000000000000000000000001000000000000000000000001000
      0000000000000000000010000000000000000000000010000000000000000000
      00000000000000000000000000000000000000000000}
  end
end
