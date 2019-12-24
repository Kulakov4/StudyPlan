object FireDACDM: TFireDACDM
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=cdb_win_studyplan'
      'Password=studyplan'
      'DriverID=Ora')
    LoginPrompt = False
    AfterConnect = FDConnectionAfterConnect
    Left = 48
    Top = 24
  end
  object fdqLogin: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'begin StudyPlanPack.logon(:username, :password);  end;')
    Left = 48
    Top = 88
    ParamData = <
      item
        Name = 'USERNAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PASSWORD'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
