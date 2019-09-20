object ViewSPMain: TViewSPMain
  Left = 0
  Top = 0
  Width = 1387
  Height = 589
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object tbd1: TTBDock
    Left = 0
    Top = 0
    Width = 1387
    Height = 51
    object tbYear: TTBToolbar
      Left = 0
      Top = 0
      Caption = 'tbYear'
      SystemFont = False
      TabOrder = 0
      object tbci1: TTBControlItem
        Control = lbl1
      end
      object TBControlItem3: TTBControlItem
        Control = cxdblcbYears
      end
      object lbl1: TLabel
        Left = 0
        Top = 2
        Width = 34
        Height = 16
        Caption = #1043#1086#1076':  '
      end
      object cxdblcbYears: TcxDBLookupComboBox
        Left = 34
        Top = 0
        Properties.ListColumns = <>
        Properties.OnChange = cxdblcbYearsPropertiesChange
        TabOrder = 0
        Width = 100
      end
    end
    object tbSpecEducation: TTBToolbar
      Left = 144
      Top = 0
      DockPos = 138
      SystemFont = False
      TabOrder = 1
      object tbci2: TTBControlItem
        Control = lbl2
      end
      object TBControlItem15: TTBControlItem
        Control = cxdbelcbSpeciality
      end
      object lbl2: TLabel
        Left = 0
        Top = 2
        Width = 161
        Height = 16
        Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1076#1075#1086#1090#1086#1074#1082#1080':  '
      end
      object cxdbelcbSpeciality: TcxDBExtLookupComboBox
        Left = 161
        Top = 0
        Properties.OnChange = cxdbelcbSpecialityPropertiesChange
        Properties.OnPopup = cxdbelcbSpecialityPropertiesPopup
        TabOrder = 0
        OnMouseDown = cxdbelcbSpecialityMouseDown
        Width = 900
      end
    end
    object tbShortSpeciality: TTBToolbar
      Left = 0
      Top = 26
      Caption = 'tbShortSpeciality'
      DockPos = 0
      DockRow = 1
      TabOrder = 2
      object TBControlItem7: TTBControlItem
        Control = Label3
      end
      object TBControlItem1: TTBControlItem
        Control = cxdblcbShortSpeciality
      end
      object Label3: TLabel
        Left = 0
        Top = 2
        Width = 87
        Height = 16
        Caption = #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077':  '
      end
      object cxdblcbShortSpeciality: TcxDBLookupComboBox
        Left = 87
        Top = 0
        Properties.ListColumns = <>
        TabOrder = 0
        Width = 184
      end
    end
    object tbChairs: TTBToolbar
      Left = 281
      Top = 26
      DockPos = 10
      DockRow = 1
      SystemFont = False
      TabOrder = 3
      object TBControlItem9: TTBControlItem
        Control = Label4
      end
      object TBControlItem2: TTBControlItem
        Control = cxdblcbChair
      end
      object Label4: TLabel
        Left = 0
        Top = 2
        Width = 65
        Height = 16
        Caption = #1050#1072#1092#1077#1076#1088#1072':  '
      end
      object cxdblcbChair: TcxDBLookupComboBox
        Left = 65
        Top = 0
        Properties.ListColumns = <>
        TabOrder = 0
        Width = 550
      end
    end
    object tbActions: TTBToolbar
      Left = 1215
      Top = 0
      DockPos = 1000
      Images = cxImageList
      SystemFont = False
      TabOrder = 4
      object TBSubmenuItem2: TTBSubmenuItem
        Caption = '...'
        Options = [tboDropdownArrow]
        object TBItem3: TTBItem
          Action = actCreateStudyPlan
        end
        object TBItem6: TTBItem
          Action = actEditStudyPlan
          Images = cxImageList
        end
        object TBItem1: TTBItem
          Action = actCopyStudyPlan
        end
        object TBItem2: TTBItem
          Action = actDeleteStudyPlan
        end
      end
    end
    object tbIDSpecEd: TTBToolbar
      Left = 1037
      Top = 26
      Caption = 'tbIDSpecEd'
      DockPos = 956
      DockRow = 1
      TabOrder = 5
      object TBControlItemID: TTBControlItem
        Control = cxdblID
      end
      object cxdblID: TcxDBLabel
        Left = 0
        Top = 0
        Height = 21
        Width = 41
      end
    end
    object tbLocked: TTBToolbar
      Left = 906
      Top = 26
      Caption = 'tbLocked'
      DockPos = 900
      DockRow = 1
      TabOrder = 6
      object TBControlItem4: TTBControlItem
        Control = cxdbcbLocked
      end
      object cxdbcbLocked: TcxDBCheckBox
        Left = 0
        Top = 0
        Caption = #1047#1072#1073#1083'.'
        Properties.ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object ActionList: TActionList
    Images = cxImageList
    Left = 32
    Top = 80
    object actEditStudyPlan: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1091#1095#1077#1073#1085#1086#1075#1086' '#1087#1083#1072#1085#1072
      ImageIndex = 0
      OnExecute = actEditStudyPlanExecute
    end
    object actCopyStudyPlan: TAction
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 1
      OnExecute = actCopyStudyPlanExecute
    end
    object actDeleteStudyPlan: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnExecute = actDeleteStudyPlanExecute
    end
    object actCreateStudyPlan: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100
      ImageIndex = 3
      OnExecute = actCreateStudyPlanExecute
	end
    object actShowAll: TAction
      Caption = #1042#1089#1077' '#1087#1083#1072#1085#1099
      GroupIndex = 1
      OnExecute = actShowAllExecute
    end
    object actActivePlans: TAction
      Caption = #1040#1082#1090#1080#1074#1085#1099#1077' '#1087#1083#1072#1085#1099
      Checked = True
      GroupIndex = 1
      OnExecute = actActivePlansExecute
    end
  end
  object cxImageList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 9961504
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000001F421C11FF30140DEC190A06B30304
          075F0000001B0000000500000000000000000000000000000000000000000000
          00000000000000000000000000000000001E663C2BE7B9C7D2FF7889A2FF2441
          82FF051033AF0000002100000005000000000000000000000000000000000000
          0002000000090000000E0000000F0000002041261BAE879AB2FFC8E3F5FF1F66
          B6FF2B6BA8FF051236AD0000001F000000040000000000000000000000000000
          00088C6657C0C38C7AFFC38C79FFCBA395FFA89894FF488BC3FFDEFEFDFF51B4
          E3FF1F68B7FF3173AEFF061538AA0000001C0000000400000000000000000000
          000CC5917EFFFDFBFAFFFCF8F6FFFAF7F5FFECEAE9FF7CA3BFFF479FD2FFDEFE
          FDFF59BFE9FF216BB9FF367BB3FF07173AA70000001A00000004000000000000
          000CC79481FFFEFBFAFFF9F0EAFFF8F0EAFFF7F0EBFFE8E4E1FF7EA4BFFF4BA5
          D5FFDEFEFDFF61CAEFFF246FBCFF3B83B9FF081A3DA300000018000000000000
          000BC99786FFFEFCFBFFF9F2EDFFF9F2EDFFF9F0EBFFF8F2EDFFEBE7E5FF82A7
          C2FF4EAAD7FFDEFEFDFF68D4F4FF2875BEFF3F8BBEFF091B3F9E000000000000
          000ACB9C8BFFFEFDFCFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF8F2EEFFEDE9
          E7FF85ABC7FF51AEDAFFDEFEFDFF6EDDF8FF2C7BC2FF18448BFF000000000000
          0009CFA08DFFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF8F4
          EFFFEFECE9FF89AECAFF54B1DCFFDEFEFDFF4FA6D4FF102C4E93000000000000
          0009D0A393FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF6F1FFF3EFEDFF83A0B8FF357FBCFF173A598F0000000C000000000000
          0008D3A897FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFAF6F3FFE2CCC4FF000000160000000600000001000000000000
          0007D3AB9AFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFBF6F1FFD1A494FF0000000C0000000000000000000000000000
          0006D8AE9DFFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7
          F5FFFBF7F4FFFCF7F3FFD3A897FF0000000B0000000000000000000000000000
          0006D8B0A0FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8
          F6FFFBF7F6FFFCF7F5FFD4AC9BFF0000000A0000000000000000000000000000
          0005D9B3A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFE
          FEFFFEFEFEFFFEFEFEFFD7AE9EFF000000090000000000000000000000000000
          0003A3867AC0DBB5A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3
          A2FFD9B2A2FFD8B2A2FFA08377C2000000060000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000090000000E0000000F0000000F0000001000000010000000110000
          0011000000100000000B00000003000000000000000000000000000000000000
          00087C5345C0AD725EFFAC725DFFAC715DFFAC6F5BFFAB705CFFAB705CFFAB6E
          5CFFAB6E5AFF7A4E41C30000000B000000000000000000000000000000000000
          000BAF7462FFFDFBF9FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2
          EEFFFAF2ECFFAC715DFF0000000F000000000000000000000000000000000000
          000BB17964FFFDFBFAFFF7EEE7FFF8EDE7FFF7EDE7FFF7EDE6FFF6ECE5FFF6EC
          E5FFFAF2EEFFAE7260FF01010120010101100101010B00000003000000000000
          000BB37C69FFFDFCFBFFF8EFE8FFF7EEE8FFF7EEE8FFF8EEE7FFF7EEE7FFF7EC
          E6FFFAF3EFFFB07863FFC19D92FFB57D6AFF815A4EC30101010B000000000000
          000AB57F6CFFFEFCFBFFF9F0EAFFF8F0EAFFF8EFE9FFF8EFE8FFF8EEE9FFF8EE
          E7FFFBF5F1FFB27A66FFEBE6E2FFFAF3EDFFB6806DFF0101010F000000000000
          0009B98270FFFEFDFCFFF9F2EDFFF9F2EDFFF9F0EBFFF9F0EAFFF8F0EAFFF8F0
          E9FFFBF6F3FFB37D6AFFE9E1DAFFFAF3EFFFB88170FF01010110000000000000
          0008BB8775FFFEFDFDFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF9F1EBFFF9F0
          EBFFFCF8F5FFB6806DFFEAE1DBFFFAF4F0FFB98673FF0101010F000000000000
          0007BF8B78FFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF9F3
          EDFFFCF9F7FFBA8471FFECE4DDFFFBF5F2FFBB8876FF0101010E000000000000
          0007C18E7EFFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFDFAF8FFBC8978FFEDE7E0FFFBF6F4FFBC8B7AFF0101010D000000000000
          0006C49382FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFDFBF9FFBF8C7CFFEFE8E3FFFCF8F5FFBF8E7CFF0101010D000000000000
          0005C49785FFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFDFDFFFEFD
          FDFFFEFDFCFFC2907FFFF0EBE6FFFCF9F7FFC29180FF0101010C000000000000
          0003967265C0C89988FFC99887FFC79887FFC59786FFC79785FFC79784FFC596
          84FFC59683FFCDA79AFFF4EFEAFFFDFAF8FFC49686FF0101010B000000000000
          000100000003000000040000000BD8BBB0FFF8F8F8FFF5F0EFFFF5F0EFFFF5EF
          EDFFF5EFEDFFF7F0EEFFFAF4F1FFFDFBF9FFC7998AFF0000000A000000000000
          0000000000000000000000000005CCA392FFFFFEFEFFFEFEFEFFFEFEFEFFFEFE
          FEFFFEFEFDFFFEFDFDFFFEFDFDFFFEFDFCFFCA9D8DFF00000009000000000000
          00000000000000000000000000039A7B6FC0CEA495FFCFA494FFCDA494FFCCA3
          93FFCDA392FFCDA391FFCCA291FFCCA290FF97776BC200000006}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000020000000A00000010000000090000000200000000000000000000
          00020000000A000000120000000C000000030000000000000000000000000000
          00020000000F0F0742921D0F7EEF0603347A0000000E00000002000000020000
          000F0804347C1D0F7EF00F084194000000120000000200000000000000000000
          0008120B47923233AFFF3648CCFF1D1EA5FF0603357A0000000F0000000F0703
          357C1F20A5FF3747CCFF2D2FAEFF120B46950000000B00000000000000000000
          000C281C8DF1596CD8FF3B51D3FF3A4FD2FF1E22A6FF0602347D0502357E2022
          A6FF3A50D3FF3A50D3FF4C5FD4FF291D8CF10000001000000000000000000000
          0006130F3C734D4FBAFF667EE0FF415AD6FF415AD7FF1F24A7FF2529A8FF415A
          D7FF415AD7FF5B72DEFF484AB8FF130F3C790000000900000000000000000000
          00010000000A16123F73585CC1FF758DE6FF4A64DBFF4A65DBFF4A65DBFF4A64
          DBFF6983E3FF5356C0FF16123F780000000C0000000200000000000000000000
          0000000000010000000A191643755D63C7FF6783E5FF5774E2FF5774E2FF5774
          E2FF565CC6FF1916437A0000000D000000020000000000000000000000000000
          00000000000100000009100E3D734A50BEFF7492EBFF6383E7FF6483E7FF6383
          E7FF3840B6FF0B0839780000000C000000020000000000000000000000000000
          0001000000071413416E555CC5FF85A1EFFF7897EDFF9CB6F4FF9DB7F5FF7997
          EEFF7796EDFF414ABCFF0E0C3C730000000A0000000100000000000000000000
          00041818456B636CCFFF93AFF3FF83A1F1FFA6BFF7FF676DCAFF7E87DDFFAFC7
          F8FF83A3F2FF83A1F1FF5058C4FF121040710000000600000000000000000000
          00065759C3EFAFC6F6FF8EADF4FFABC4F8FF6F76D0FF1817456F24244F70868E
          E1FFB5CCF9FF8DACF4FFA1B8F4FF5758C3EF0000000900000000000000000000
          000331326B8695A0EAFFC0D3F9FF7880D7FF1C1C496B00000006000000072527
          526C8B93E6FFC1D3F9FF949EE9FF303168870000000500000000000000000000
          00010000000431336B825E62CBEC1F204D680000000500000001000000010000
          00052728536B5E62CBEC31326883000000070000000100000000000000000000
          0000000000000000000200000004000000020000000100000000000000000000
          0001000000030000000500000004000000010000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000A170D0738542D1894814626D193502AEA924F2AE87F45
          25D0522C17931209053000000009000000010000000000000000000000000000
          00030201011159311B97A96239FAC58957FFD6A36DFFDDAF75FFDDAF74FFD6A4
          6BFFC58956FFA46137F53C2112730000000F0000000300000000000000020201
          0110744226B9BC7C4DFFDDAE77FFDEB076FFE2B782FFE3BB87FFE3BC86FFE1B7
          82FFDEAF74FFDBAB72FFBD7E4EFF6F3E24B50000001000000002000000085C36
          2095BE8053FFE0B37CFFDFB076FFDEB177FFB78254FFAA7144FFAB7245FFBC88
          59FFDFB279FFDFB277FFDEB077FFC08253FF55321D920000000A190F0932B070
          47FADFB27DFFDFB27AFFE0B37BFFE0B57DFFA56B3FFFF5EFEAFFF8F3EEFFAB72
          45FFE2B67EFFE0B47CFFE0B47BFFDEB079FFB3734AFB130B072F613C2795CD9B
          6FFFE2B780FFE5BD89FFE7C291FFE8C393FFA56B3FFFF1E6DEFFF9F5F1FFAA71
          44FFE8C494FFE8C393FFE5BF8CFFE1B77FFFD09C6EFF5434218B935E3DD2DCB3
          83FFE3B781FFBA8659FFA97043FFAB7245FFAC7346FFF5EDE6FFFAF6F3FFAD75
          47FFB0784AFFB17A4BFFC29162FFE4B983FFDEB17EFF8E5B3BD0B0744CF2E3BF
          8FFFE4BB84FFA56B3FFFF3EBE6FFFAF6F3FFF6EFE8FFF7F0EAFFFBF7F5FFFAF7
          F4FFFAF7F3FFFAF6F2FFAB7245FFE5BD87FFE5BE8BFFAB714CEEAE764FECE9C9
          A0FFE5BE89FFA56B3FFFE0D2CAFFE1D3CCFFE3D5CFFFF2EAE4FFF8F3EFFFEADF
          D9FFE6DAD4FFE9DED9FFAA7144FFE7C08CFFEACA9DFFAE764FEE9A6A49D0E9CD
          ACFFEAC796FFB78456FFA56B3FFFA56B3FFFA56B3FFFF1EAE5FFFAF6F3FFA56B
          3FFFA56B3FFFA56B3FFFB78457FFEACA99FFEBD1ADFF996A49D46E4E3697DDBB
          9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFA56B3FFFF0EAE7FFFDFCFBFFA56B
          3FFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FF6246318F1C140E2BC794
          6CFCF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFA56B3FFFDECFC9FFDFD1CBFFA56B
          3FFFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFC69470FA1A120D2E000000036F52
          3C92D7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFB98A5FFFA56B3FFFA56B3FFFBA8A
          5FFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FF664B368C00000006000000010202
          0107906C4EB8D9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
          CAFFF8EED0FFF4E8CDFFD7AF8BFF88664AB30202010B00000001000000000000
          00010202010770543F8FCFA078FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
          B9FFE3C5A3FFC59973F24C392A67000000060000000100000000000000000000
          000000000001000000022019122C6C543E89A47E5FCCC59770F1C19570EEA47E
          60CD6C543F8B16110D2200000003000000010000000000000000}
      end>
  end
  object PopupMenu: TPopupMenu
    Left = 32
    Top = 216
    object N1: TMenuItem
      Action = actActivePlans
    end
    object N2: TMenuItem
      Action = actShowAll
    end
  end
end
