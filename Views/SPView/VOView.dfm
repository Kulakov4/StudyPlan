inherited ViewVO: TViewVO
  inherited tbd1: TTBDock
    Height = 56
    ExplicitHeight = 56
    inherited tbYear: TTBToolbar
      ExplicitHeight = 28
      inherited lbl1: TLabel
        Top = 4
        ExplicitTop = 4
      end
      inherited cxdblcbYears: TcxDBLookupComboBox
        ExplicitHeight = 24
      end
    end
    inherited tbSpecEducation: TTBToolbar
      ExplicitHeight = 28
      inherited lbl2: TLabel
        Top = 4
        ExplicitTop = 4
      end
      inherited cxdbelcbSpeciality: TcxDBExtLookupComboBox
        ExplicitHeight = 24
      end
    end
    inherited tbShortSpeciality: TTBToolbar
      Top = 28
      ExplicitTop = 28
      ExplicitHeight = 28
      inherited Label3: TLabel
        Top = 4
        ExplicitTop = 4
      end
      inherited cxdblcbShortSpeciality: TcxDBLookupComboBox
        ExplicitHeight = 24
      end
    end
    inherited tbChairs: TTBToolbar
      Top = 28
      ExplicitTop = 28
      ExplicitHeight = 28
      inherited Label4: TLabel
        Top = 4
        ExplicitTop = 4
      end
      inherited cxdblcbChair: TcxDBLookupComboBox
        ExplicitHeight = 24
      end
    end
    inherited tbActions: TTBToolbar
      DockPos = 600
      ExplicitHeight = 28
    end
    inherited tbIDSpecEd: TTBToolbar
      Left = 972
      Top = 28
      ExplicitLeft = 972
      ExplicitTop = 28
      ExplicitHeight = 28
      inherited cxdblID: TcxDBLabel
        Top = 1
        ExplicitTop = 1
      end
    end
    inherited tbLocked: TTBToolbar
      Top = 28
      ExplicitTop = 28
      ExplicitWidth = 66
      ExplicitHeight = 28
      inherited cxdbcbLocked: TcxDBCheckBox
        ExplicitWidth = 56
        ExplicitHeight = 24
      end
    end
  end
  inherited cxImageList: TcxImageList
    FormatVersion = 1
  end
end
