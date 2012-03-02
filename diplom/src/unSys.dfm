object fmSys: TfmSys
  Left = 192
  Top = 122
  Width = 934
  Height = 500
  Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' '#1082#1086#1084#1087#1083#1077#1082#1089#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 48
    Width = 106
    Height = 13
    Caption = #1057#1080#1075#1085#1072#1083#1099' '#1082#1086#1084#1087#1083#1077#1082#1089#1072':'
  end
  object Label2: TLabel
    Left = 392
    Top = 48
    Width = 138
    Height = 13
    Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1090#1080#1087#1099' '#1089#1080#1075#1085#1072#1083#1086#1074':'
  end
  object dbgSysConf: TDBGrid
    Left = 24
    Top = 64
    Width = 265
    Height = 313
    DataSource = dsSysConf
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sigtag'
        Title.Caption = #1058#1080#1087
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sigquant'
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Visible = True
      end>
  end
  object btAddSig: TButton
    Left = 296
    Top = 152
    Width = 75
    Height = 25
    Caption = '< '#1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 1
    OnClick = btAddSigClick
  end
  object dbgAvSigs: TDBGrid
    Left = 376
    Top = 64
    Width = 513
    Height = 313
    DataSource = dsAvSigs
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'sigtag'
        Title.Caption = #1058#1080#1087
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'signame'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 400
        Visible = True
      end>
  end
  object btDelSig: TButton
    Left = 296
    Top = 192
    Width = 75
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' >'
    TabOrder = 3
    OnClick = btDelSigClick
  end
  object btHelp: TButton
    Left = 296
    Top = 232
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 4
    OnClick = btHelpClick
  end
  object MainMenu1: TMainMenu
    Left = 64
  end
  object dsSysConf: TDataSource
    DataSet = qSysConf
    Left = 160
  end
  object qSysConf: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT sysconf.id as id'
      '      ,sysconf.sigid as sigid'
      '      ,signame.sigtag as sigtag'
      '      ,sysconf.sigquant as sigquant'
      '  FROM sysconf,signame'
      'where  sysconf.sigid = signame.sigid')
    Left = 96
    object qSysConfid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object qSysConfsigtag: TStringField
      FieldName = 'sigtag'
      Size = 10
    end
    object qSysConfsigid: TIntegerField
      FieldName = 'sigid'
    end
    object qSysConfsigquant: TIntegerField
      FieldName = 'sigquant'
    end
  end
  object qAvSigs: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      '  FROM signame'
      'where  signame.sigid not in (select sigid from sysconf)')
    Left = 128
    object qAvSigssigtag: TStringField
      FieldName = 'sigtag'
      Size = 10
    end
    object qAvSigssigname: TStringField
      FieldName = 'signame'
      Size = 255
    end
    object qAvSigssigid: TAutoIncField
      FieldName = 'sigid'
      ReadOnly = True
    end
  end
  object ADOQuery: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    Left = 32
  end
  object dsAvSigs: TDataSource
    DataSet = qAvSigs
    Left = 192
  end
end
