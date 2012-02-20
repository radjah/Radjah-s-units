object fmDM: TfmDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 192
  Top = 122
  Height = 150
  Width = 215
  object ADOConn: TADOConnection
    ConnectionString = 'FILE NAME=D:\'#1044#1080#1087#1083#1086#1084'\mainapp\conn.udl'
    LoginPrompt = False
    Provider = 'D:\'#1044#1080#1087#1083#1086#1084'\mainapp\conn.udl'
    Left = 16
    Top = 8
  end
end
