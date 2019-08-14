inherited dsgvQuerys: TdsgvQuerys
  Width = 733
  Height = 494
  ExplicitWidth = 733
  ExplicitHeight = 494
  inherited pnlGrid: TPanel
    Width = 369
    Height = 494
    Align = alLeft
    ExplicitWidth = 369
    ExplicitHeight = 494
    inherited cxGrid: TcxGrid
      Width = 367
      Height = 483
      ExplicitWidth = 367
      ExplicitHeight = 483
      inherited cxGridDBBandedTableView: TcxGridDBBandedTableView
        DataController.DataModeController.GridMode = True
      end
    end
    inherited tbdEssenceTop: TTBDock
      Width = 367
      ExplicitWidth = 367
    end
  end
  object pnlRight: TPanel
    Left = 377
    Top = 0
    Width = 356
    Height = 494
    Align = alClient
    Caption = 'pnlRight'
    TabOrder = 1
    object cxdbmQueryText: TcxDBMemo
      Left = 1
      Top = 1
      Align = alClient
      TabOrder = 0
      Height = 309
      Width = 354
    end
    object cxs2: TcxSplitter
      Left = 1
      Top = 310
      Width = 354
      Height = 8
      AlignSplitter = salBottom
      Control = pnlQueryParameters
    end
    object pnlQueryParameters: TPanel
      Left = 1
      Top = 318
      Width = 354
      Height = 175
      Align = alBottom
      TabOrder = 2
    end
  end
  object cxs1: TcxSplitter
    Left = 369
    Top = 0
    Width = 8
    Height = 494
    HotZoneClassName = 'TcxMediaPlayer8Style'
    Control = pnlGrid
  end
end
