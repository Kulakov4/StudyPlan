inherited frmEditRetrainingPlan: TfrmEditRetrainingPlan
  ClientHeight = 525
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 16
  inherited lblLocked: TLabel
    Top = 416
    ExplicitTop = 416
  end
  inherited lblShowOnPortal: TLabel
    Top = 365
    Width = 39
    Caption = #1057#1092#1077#1088#1072
    ExplicitTop = 365
    ExplicitWidth = 39
  end
  inherited lblStandart: TLabel
    Visible = False
  end
  inherited btnClose: TcxButton
    Top = 464
    ExplicitTop = 464
  end
  inherited cxcbLocked: TcxCheckBox
    Left = 209
    Top = 416
    TabOrder = 12
    ExplicitLeft = 209
    ExplicitTop = 416
  end
  inherited cxcbPortal: TcxCheckBox
    Left = 209
    Top = 464
    Visible = False
    ExplicitLeft = 209
    ExplicitTop = 464
  end
  inherited cxdblcbStandarts: TcxDBLookupComboBox
    Properties.OnChange = cxdblcbEducationsPropertiesChange
    Visible = False
  end
  object cxdblcbArea: TcxDBLookupComboBox
    Left = 217
    Top = 365
    Properties.ListColumns = <>
    Properties.OnNewLookupDisplayText = cxdblcbAreaPropertiesNewLookupDisplayText
    TabOrder = 8
    Width = 613
  end
end
