inherited frmEditRetrainingPlan: TfrmEditRetrainingPlan
  PixelsPerInch = 96
  TextHeight = 16
  inherited lblShowOnPortal: TLabel
    Visible = False
  end
  inherited lblStandart: TLabel
    Visible = False
  end
  inherited Label3: TLabel
    Visible = False
  end
  object Label9: TLabel [12]
    Left = 32
    Top = 336
    Width = 39
    Height = 16
    Caption = #1057#1092#1077#1088#1072
  end
  inherited cxdblcbEducations: TcxDBLookupComboBox
    ExplicitHeight = 21
  end
  inherited cxdblcbChairs: TcxDBLookupComboBox
    ExplicitHeight = 21
  end
  inherited cxdbextlcbSpecialitys: TcxDBExtLookupComboBox
    ExplicitHeight = 21
  end
  inherited cxteYears: TcxTextEdit
    ExplicitHeight = 21
  end
  inherited cxteMonths: TcxTextEdit
    ExplicitHeight = 21
  end
  inherited cxteAnnotation: TcxTextEdit
    ExplicitHeight = 21
  end
  inherited cxdblcbQualifications: TcxDBLookupComboBox
    ExplicitHeight = 21
  end
  inherited cxcbLocked: TcxCheckBox
    TabOrder = 13
    ExplicitWidth = 121
  end
  inherited cxcbPortal: TcxCheckBox
    Visible = False
    ExplicitWidth = 121
  end
  inherited cxdblcbStandarts: TcxDBLookupComboBox
    Properties.OnChange = cxdblcbEducationsPropertiesChange
    Visible = False
    ExplicitHeight = 21
  end
  inherited cxcbEnabled: TcxCheckBox
    Visible = False
    ExplicitWidth = 121
  end
  object cxdblcbArea: TcxDBLookupComboBox
    Left = 217
    Top = 333
    Properties.ListColumns = <>
    Properties.OnNewLookupDisplayText = cxdblcbAreaPropertiesNewLookupDisplayText
    TabOrder = 8
    Width = 613
  end
end
