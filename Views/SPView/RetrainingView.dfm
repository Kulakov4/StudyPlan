inherited ViewRetraining: TViewRetraining
  inherited tbd1: TTBDock
    inherited tbSpecEducation: TTBToolbar
      ExplicitWidth = 1005
      inherited lbl2: TLabel
        Width = 95
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077': '
        ExplicitWidth = 95
      end
      inherited cxdbelcbSpeciality: TcxDBExtLookupComboBox
        Left = 95
        ExplicitLeft = 95
      end
    end
    inherited tbShortSpeciality: TTBToolbar
      ExplicitWidth = 230
      inherited cxdblcbShortSpeciality: TcxDBLookupComboBox
        Left = 220
        Top = 21
        ExplicitLeft = 220
        ExplicitTop = 21
      end
    end
    inherited tbChairs: TTBToolbar
      Left = 580
      ExplicitLeft = 580
    end
    inherited tbActions: TTBToolbar
      Left = 1149
      ExplicitLeft = 1149
    end
    inherited tbIDSpecEd: TTBToolbar
      Left = 1336
      TabOrder = 7
      ExplicitLeft = 1336
    end
    inherited tbLocked: TTBToolbar
      Left = 1205
      ExplicitLeft = 1205
    end
    object tbArea: TTBToolbar
      Left = 230
      Top = 26
      DockPos = 10
      DockRow = 1
      SystemFont = False
      TabOrder = 5
      object TBControlItem6: TTBControlItem
        Control = Label1
      end
      object TBControlItem5: TTBControlItem
        Control = cxdblcbArea
      end
      object Label1: TLabel
        Left = 0
        Top = 2
        Width = 52
        Height = 16
        Caption = #1057#1092#1077#1088#1072':  '
      end
      object cxdblcbArea: TcxDBLookupComboBox
        Left = 52
        Top = 0
        Properties.ListColumns = <>
        TabOrder = 0
        Width = 288
      end
    end
  end
  inherited cxImageList: TcxImageList
    FormatVersion = 1
  end
end
