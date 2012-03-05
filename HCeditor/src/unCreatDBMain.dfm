object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1054#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077' '#1073#1072#1079#1099
  ClientHeight = 480
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 181
    Width = 61
    Height = 13
    Caption = 'SQL-'#1079#1072#1087#1088#1086#1089':'
  end
  object Label2: TLabel
    Left = 287
    Top = 181
    Width = 57
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object btCreateDB: TButton
    Left = 24
    Top = 24
    Width = 201
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1073#1072#1079#1091
    TabOrder = 0
    OnClick = btCreateDBClick
  end
  object btOptim: TButton
    Left = 24
    Top = 55
    Width = 201
    Height = 25
    Caption = #1054#1087#1090#1080#1084#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1073#1072#1079#1091
    TabOrder = 1
    OnClick = btOptimClick
  end
  object btOpenDB: TButton
    Left = 24
    Top = 104
    Width = 201
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1073#1072#1079#1091
    TabOrder = 2
    OnClick = btOpenDBClick
  end
  object mmSQL: TMemo
    Left = 24
    Top = 200
    Width = 257
    Height = 209
    TabOrder = 3
  end
  object dbgResult: TDBGrid
    Left = 287
    Top = 200
    Width = 375
    Height = 255
    DataSource = dsCommon
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btOpenDS: TButton
    Left = 24
    Top = 415
    Width = 75
    Height = 25
    Caption = 'Open'
    Enabled = False
    TabOrder = 5
    OnClick = btOpenDSClick
  end
  object btExec: TButton
    Left = 120
    Top = 415
    Width = 75
    Height = 25
    Caption = 'ExecSQL'
    Enabled = False
    TabOrder = 6
    OnClick = btExecClick
  end
  object btCloseDB: TButton
    Left = 24
    Top = 135
    Width = 201
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1073#1072#1079#1091
    Enabled = False
    TabOrder = 7
    OnClick = btCloseDBClick
  end
  object btAbout: TButton
    Left = 461
    Top = 24
    Width = 201
    Height = 25
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    TabOrder = 8
    OnClick = btAboutClick
  end
  object odOpenDB: TOpenDialog
    DefaultExt = 'sqlite'
    Filter = #1041#1072#1079#1072#1094#1080#1082#1083#1086#1074' (stages.sqlite)|*.sqlite'
    Left = 280
    Top = 80
  end
  object zConn: TZConnection
    Protocol = 'sqlite-3'
    Left = 280
    Top = 32
  end
  object zqCommon: TZQuery
    Connection = zConn
    ReadOnly = True
    Params = <>
    Left = 336
    Top = 32
  end
  object dsCommon: TDataSource
    DataSet = zqCommon
    Left = 408
    Top = 32
  end
  object sdSaveDB: TSaveDialog
    DefaultExt = 'sqlite'
    Filter = #1041#1072#1079#1072' '#1094#1080#1082#1083#1086#1074' (stages.sqlite)|*.sqlite'
    Left = 280
    Top = 128
  end
end
