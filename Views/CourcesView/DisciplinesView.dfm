inherited ViewDisciplines: TViewDisciplines
  inherited cxGrid: TcxGrid
    Top = 34
    Height = 438
    ExplicitTop = 34
    ExplicitHeight = 438
    inherited cxGridDBBandedTableView: TcxGridDBBandedTableView
      OptionsView.ColumnAutoWidth = False
    end
  end
  object TBDock1: TTBDock [2]
    Left = 0
    Top = 0
    Width = 893
    Height = 34
    object TBToolbar1: TTBToolbar
      Left = 0
      Top = 0
      Caption = 'TBToolbar1'
      Images = cxImageList
      TabOrder = 0
      object TBItem1: TTBItem
        Action = actAdd
      end
      object TBItem2: TTBItem
        Action = actEdit
      end
      object TBItem3: TTBItem
        Action = actDeleteEx
      end
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
    inherited dxbrMain: TdxBar
      Visible = False
    end
  end
  inherited ActionList: TActionList
    Images = cxImageList
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1080#1089#1094#1080#1087#1083#1080#1085#1091
      ImageIndex = 0
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 1
      OnExecute = actEditExecute
    end
  end
  inherited cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  object cxImageList: TcxImageList
    SourceDPI = 96
    Height = 24
    Width = 24
    FormatVersion = 1
    DesignInfo = 26214440
    ImageInfo = <
      item
        Image.Data = {
          36090000424D3609000000000000360000002800000018000000180000000100
          2000000000000009000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00005A0000005A0000005A0000005A0000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF00008C0800008C0800008C0800005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF00008C0800008C0800008C0800005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF00008C0800008C0800008C0800005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF00008C0800008C0800008C0800005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF0000940800008C0800008C0800005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF00089410000094100000941000005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00005A0000005A0000005A0000005A0000005A0000005A0000005A
          0000FFFFFF00089C1800089C1000089C1000005A0000005A0000005A0000005A
          0000005A0000005A0000005A0000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00005A0000FFFFFF0039D6630031CE5A0029C6520029C64A0021BD420021B5
          390010A5290010A52100089C180008941800089C18000894100000941000008C
          0800008C0800008C0800008C0800005A0000FF00FF00FF00FF00FF00FF00FF00
          FF00005A0000FFFFFF0039D6630031CE5A0029C6520029C64A0021BD420021B5
          390018AD310018A5290010A52100109C2100089C18000894100000941000008C
          0800008C0800008C0800008C0800005A0000FF00FF00FF00FF00FF00FF00FF00
          FF00005A0000FFFFFF0039D66B0031CE630031CE5A0029C6520029C64A0021BD
          420021B5390018AD310018AD290010A5290010A52100089C1800089418000894
          1000008C0800008C0800008C0800005A0000FF00FF00FF00FF00FF00FF00FF00
          FF00005A0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF0021B5390018B5310018AD3100FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00005A0000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00005A0000005A0000005A0000005A0000005A0000005A0000005A
          0000FFFFFF0029BD4A0021BD420021BD4200005A0000005A0000005A0000005A
          0000005A0000005A0000005A0000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF0029C6520029C64A0029C64A00005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF0031CE5A0031CE520031CE5200005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF0039D6630031D6630031D66300005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF0039DE6B0039DE6B0042E77300005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF0042DE730042DE730042E77300005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00005A
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00005A0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00005A0000005A0000005A0000005A0000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36090000424D3609000000000000360000002800000018000000180000000100
          2000000000000009000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF0000000000C6C3C600C6C3C600C6C3C600C6C3C600C6C3
          C600C6C3C600C6C3C600C6C3C600C6C3C600C6C3C600C6C3C600C6C3C600C6C3
          C60000000000DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF0000000000C6C3C60000000000C6C3C60000000000C6C3
          C60000000000C6C3C60000000000C6C3C60000000000C6C3C60000000000C6C3
          C60000000000DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF0000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF0000000000FFFF0000DEEBEF00FFFF0000DEEB
          EF00FFFF0000DEEBEF00FFFF0000DEEBEF0000000000DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF0000000000DEEBEF0000000000000000000000
          000000000000FFFF0000DEEBEF0000000000DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF0000000000FFFF000000000000C6C3C6000000
          0000FFFF0000DEEBEF000000000000000000DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF0000000000DEEBEF000000000000000000FFFF
          0000DEEBEF0000000000DEEBEF000000000000000000DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF0000000000FFFF000000000000FFFF0000DEEB
          EF0000000000DEEBEF00DEEBEF00000000000000000000000000DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF0000000000DEEBEF00FFFF0000DEEBEF000000
          0000DEEBEF00DEEBEF00DEEBEF000000000000FFFF008482840000000000DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF0000000000FFFF0000DEEBEF0000000000DEEB
          EF00DEEBEF00DEEBEF00DEEBEF000000000000FFFF00C6C3C60000000000DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF0000000000DEEBEF0000000000DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000000000FFFF00848284000000
          0000DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF000000000000000000DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF000000000000FFFF00000000000000
          0000DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF0000000000DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF0000000000000084000000
          FF0000000000DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF0000000000000000000000
          0000DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00DEEB
          EF00DEEBEF00DEEBEF00DEEBEF00DEEBEF00FF00FF00FF00FF00FF00FF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36090000424D3609000000000000360000002800000018000000180000000100
          2000000000000009000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0000006B0000006B0000006B0000006B0000006B000000
          6B0000006B0000006B0000006B0000006B0000006B0000006B0000006B000000
          6B0000006B0000006B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000006B007B8CDE000000E7000000E7000000E7000000DE000000
          D6000000CE000000CE000000C6000000BD000000B5000000AD000000A5000000
          A50000009C0000009C0000006B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000006B00E7E7E7000000E7000000E7000000E7000000DE000000
          D6000000CE000000CE000000C6000000BD000000B5000000AD000000A5000000
          A50000009C000000940000006B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000006B00E7E7E7000000DE000000DE000000DE000000DE000000
          D6000000CE000000CE000000C6000000BD000000B5000000B5000000AD000000
          A50000009C0000009C0000006B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000006B00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7
          E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700A5B5DE00A5B5DE007B8C
          DE007B8CDE007B8CDE0000006B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0000006B0000006B0000006B0000006B0000006B000000
          6B0000006B0000006B0000006B0000006B0000006B0000006B0000006B000000
          6B0000006B0000006B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36090000424D3609000000000000360000002800000018000000180000000100
          2000000000000009000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00C66B6B00C6636300CE636300B55252009C6B6B00B5B5B500B5B5
          B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500B573
          730094292900943131009C3939009C4A4A00FF00FF00FF00FF00FF00FF00FF00
          FF00B5847300C66B6B00CE636300CE636300BD5A5A009C6B6B00A58C8C00B584
          8400CEADAD00DECECE00F7F7EF00FFFFF700F7F7F700EFEFE700E7E7E700B573
          730094292900943131009C393900C65A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300C66B6B00CE636300CE636300BD5A5A009C737300A57B7B009C39
          3900B5736B00C69C9C00EFE7E700F7F7F700FFF7F700F7F7EF00EFEFEF00BD7B
          7B0094292900943131009C393900C65A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300C66B6B00CE636300CE636300BD5A5A00A5737300A58484009431
          31009C424200B5737300DEDED600EFEFEF00F7F7F700FFF7F700F7F7F700BD7B
          7B0094292900943131009C393900C65A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300C66B6B00CE636300CE636300BD5A5A00A5737300AD8C8C009431
          3100943131009C4A4A00C6C6C600E7E7DE00EFEFEF00FFF7F700FFFFFF00C67B
          7B0094292900943131009C393900C65A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300C66B6B00CE636300CE636300B5525200AD7B7B00B58C8C009429
          29009429290094313100ADA5A500CECECE00E7E7DE00F7EFEF00FFFFFF00C684
          840094292900943131009C393900C65A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300C66B6B00CE636300CE636300B5525200AD7B7B00C6ADAD00A563
          6300A56363009C6363009C9C9C00B5B5B500D6D6D600EFEFEF00FFFFFF00C684
          840094292900943131009C393900BD5A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300C66B6B00CE636300CE636300BD5A5A00B5737300D6A5A500C69C
          9C00BD9C9C00BD949400AD8C8C00AD8C8C00C69C9C00D6ADAD00E7C6C600C673
          7300A5424200AD424200AD4A4A00C66363009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300C66B6B00CE636300CE636300CE636300CE636300CE636300CE63
          6300CE636300CE636300CE636300CE636300C6636300C6636300C6636300CE63
          6300CE636300CE636300CE636300CE6363009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300C66B6B00BD5A5A00C6636300C66B6B00CE737300CE737300CE73
          7300CE737300CE737300CE737300CE737300CE737300CE737300CE737300CE73
          7300CE737300CE7B7B00CE6B6B00CE6363009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD4A4A00A54A4200B56B6B00C68C8C00CEADAD00D6BDBD00D6BD
          BD00D6BDBD00D6BDBD00D6BDBD00D6BDBD00D6BDBD00D6BDBD00D6BDBD00D6BD
          BD00D6BDBD00DEC6C600CE8C8C00CE6363009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD424200CE9C9C00F7F7EF00F7EFEF00F7EFEF00F7EFEF00F7EF
          EF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EF
          EF00F7EFEF00EFE7E700CE8C8C00C65A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD424200CEA5A500FFFFFF00F7F7F700F7F7F700F7F7F700F7F7
          F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
          F700FFF7F700EFE7E700CE8C8C00BD5A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD424200CEA5A500FFFFFF00F7EFEF00F7EFEF00F7EFEF00F7EF
          EF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EF
          EF00F7F7F700EFE7E700CE8C8C00BD5A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD424200CEA5A500FFFFFF00E7E7E700CEC6C600CECECE00CECE
          CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00C6C6
          C600E7DEDE00EFE7E700CE8C8C00BD5A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD424200CEA5A500FFFFFF00F7EFEF00EFE7E700EFE7E700EFE7
          E700EFE7E700EFE7E700EFE7E700EFE7E700EFE7E700EFE7E700EFE7E700EFE7
          E700F7EFEF00EFE7E700CE8C8C00BD5A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD424200CEA5A500FFFFFF00EFE7E700D6CECE00D6CECE00D6CE
          CE00D6CECE00D6CECE00D6CECE00D6CECE00D6CECE00D6CECE00D6CECE00CECE
          CE00E7E7E700EFE7E700CE8C8C00BD5A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD424200CEA5A500FFFFFF00EFEFE700E7DEDE00E7DEDE00E7DE
          DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
          DE00EFEFEF00EFE7E700CE8C8C00BD5A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD424200CEA5A500FFFFFF00EFEFE700E7DEDE00E7DEDE00E7DE
          DE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DEDE00E7DE
          DE00EFEFEF00EFE7E700CE8C8C00BD5A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD424200CEA5A500FFFFFF00E7E7E700CECECE00D6CECE00D6CE
          CE00D6CECE00D6CECE00D6CECE00D6CECE00D6CECE00D6CECE00D6CECE00CECE
          CE00E7E7E700EFE7E700CE8C8C00BD5A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00B5847300AD424200CEA5A500FFFFFF00FFF7F700FFF7F700FFF7F700FFF7
          F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7
          F700FFF7F700EFE7E700CE8C8C00C65A5A009C4A4A00FF00FF00FF00FF00FF00
          FF00FF00FF00AD424200CE9C9C00C6CECE00C6C6C600C6C6C600C6C6C600C6C6
          C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
          C600C6C6C600C6C6C600C68C8C00B5525200FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36090000424D3609000000000000360000002800000018000000180000000100
          2000000000000009000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001052
          8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF005294BD004A6B9C004A6B9C004A6B9C004A6B9C004A6B9C004A6B9C004A6B
          9C004A6B9C004A6B9C004A6B9C0000427300FF00FF00FF00FF00FF00FF001052
          840000427300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0008639C00ADCEE700ADCEE700ADCEE700ADCEE700CECEDE00CECEDE00CECE
          DE00CECEDE008CB5C60000427300FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000042730010528400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00086BA500DEF7FF00DEF7FF00DEF7FF00E7FFFF00E7FFFF00E7FFFF00E7FF
          FF00C6D6E70010528400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0010528400105284004A6B9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00007BAD00CEF7FF00CEF7FF00CEF7FF00CEF7FF00CEF7FF00DEF7FF00C6D6
          E70010528400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF004A6B9C00739CAD0010528400FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00007BAD00B5E7FF00B5E7FF00B5E7FF00CEF7FF00CEF7FF00ADCEE7001052
          8400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF004A6B9C00739CAD00297BAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF001884C600B5E7FF00B5E7FF00B5E7FF00B5E7FF00B5E7FF00A5DEFF002963
          7B004A6B9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0029637B008CB5C600297BAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0010A5D600A5DEFF00A5DEFF00A5DEFF00A5DEFF00A5DEFF00A5DEFF00A5DE
          FF0029637B0029637B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00739C
          AD0010528400B5E7FF00298CD600FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0010A5D6008CD6FF008CD6FF0084BDE70084BDE7008CD6FF008CD6FF00A5DE
          FF008CD6FF005294BD00004A7B0029637B00739CAD00739CAD00216B9400105A
          940084BDE7008CD6FF00007BAD00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0010A5D6006BC6FF006BC6FF001884C600007BAD0084BDE7008CD6FF008CD6
          FF008CD6FF008CD6FF008CD6FF005294BD005294BD005294BD0084BDE700A5DE
          FF00A5DEFF0042A5DE0084BDE700FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0010A5D6004ABDFF0010A5D600FF00FF00FF00FF001884C60042A5DE006BC6
          FF006BC6FF008CD6FF008CD6FF008CD6FF008CD6FF008CD6FF008CD6FF008CD6
          FF0042A5DE0042A5DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0010A5D60010A5D600FF00FF00FF00FF00FF00FF00FF00FF0042A5DE001884
          C60042A5DE004ABDFF006BC6FF006BC6FF006BC6FF004ABDFF0042A5DE0010A5
          D60042A5DE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0010A5D600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0042A5DE0042A5DE0010A5D60010A5D60010A5D60042A5DE0042A5DE00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end>
  end
end
