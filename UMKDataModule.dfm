object UMKDM: TUMKDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 159
  Width = 227
  object WA: TWordApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 48
    Top = 24
  end
  object WD: TWordDocument
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 48
    Top = 88
  end
end
