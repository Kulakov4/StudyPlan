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
  inherited cxcbLocked: TcxCheckBox
    TabOrder = 13
  end
  inherited cxcbPortal: TcxCheckBox
    Visible = False
  end
  inherited cxdblcbStandarts: TcxDBLookupComboBox
    Properties.OnChange = cxdblcbEducationsPropertiesChange
    Visible = False
  end
  inherited cxcbEnabled: TcxCheckBox
    Visible = False
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
