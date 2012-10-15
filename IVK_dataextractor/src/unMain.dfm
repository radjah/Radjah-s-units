object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1079#1074#1083#1077#1095#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 599
  ClientWidth = 739
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 53
    Width = 74
    Height = 13
    Caption = #1043#1088#1091#1087#1087#1099' '#1090#1077#1075#1086#1074':'
  end
  object Label2: TLabel
    Left = 8
    Top = 213
    Width = 119
    Height = 13
    Caption = #1057#1087#1080#1089#1086#1082' '#1090#1077#1075#1086#1074' '#1074' '#1075#1088#1091#1087#1087#1077':'
  end
  object Label7: TLabel
    Left = 440
    Top = 422
    Width = 49
    Height = 13
    Caption = #1055#1088#1086#1090#1086#1082#1086#1083
  end
  object btConnect: TButton
    Left = 8
    Top = 8
    Width = 113
    Height = 25
    Caption = #1057#1086#1077#1076#1080#1085#1080#1090#1100#1089#1103
    TabOrder = 0
    OnClick = btConnectClick
  end
  object dbgTagGroup: TDBGrid
    Left = 9
    Top = 72
    Width = 719
    Height = 97
    DataSource = dsTagGroup
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Table_Name'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tables_Number'
        Title.Caption = #1050#1086#1083'-'#1074#1086' '#1090#1072#1073#1083#1080#1094
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Table_Tags'
        Title.Caption = #1058#1072#1073#1083#1080#1094#1072' '#1090#1077#1075#1086#1074
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Group_Name'
        Title.Caption = #1048#1084#1103' '#1075#1088#1091#1087#1087#1099
        Width = 150
        Visible = True
      end>
  end
  object btGetTags: TButton
    Left = 8
    Top = 175
    Width = 113
    Height = 25
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
    Enabled = False
    TabOrder = 2
    OnClick = btGetTagsClick
  end
  object dbgTagList: TDBGrid
    Left = 8
    Top = 232
    Width = 720
    Height = 177
    DataSource = dsTagList
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Logging_Name'
        Title.Caption = #1048#1084#1103
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Signal_Name'
        Title.Caption = #1058#1077#1075
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tag_Index'
        Title.Caption = #1048#1085#1076#1077#1082#1089
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Description'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tag_Comments'
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
        Width = 150
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 415
    Width = 417
    Height = 138
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1074#1099#1073#1086#1088#1082#1080
    TabOrder = 4
    object Label3: TLabel
      Left = 16
      Top = 29
      Width = 69
      Height = 13
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
    end
    object Label4: TLabel
      Left = 216
      Top = 32
      Width = 87
      Height = 13
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
    end
    object Label5: TLabel
      Left = 16
      Top = 77
      Width = 73
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1085#1072#1095#1072#1083#1072':'
    end
    object Label6: TLabel
      Left = 216
      Top = 77
      Width = 91
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
    end
    object dtpDateBegin: TDateTimePicker
      Left = 16
      Top = 48
      Width = 186
      Height = 21
      Date = 41193.000000000000000000
      Time = 41193.000000000000000000
      DateFormat = dfLong
      TabOrder = 0
    end
    object dtpDateEnd: TDateTimePicker
      Left = 216
      Top = 48
      Width = 186
      Height = 21
      Date = 41193.345461296300000000
      Time = 41193.345461296300000000
      DateFormat = dfLong
      TabOrder = 2
    end
    object dtpTimeBegin: TDateTimePicker
      Left = 16
      Top = 96
      Width = 186
      Height = 21
      Date = 41193.346280370370000000
      Time = 41193.346280370370000000
      DateFormat = dfLong
      Kind = dtkTime
      TabOrder = 1
    end
    object dtpTimeEnd: TDateTimePicker
      Left = 216
      Top = 96
      Width = 186
      Height = 21
      Date = 41193.346823657400000000
      Time = 41193.346823657400000000
      Kind = dtkTime
      TabOrder = 3
    end
  end
  object btExtract: TButton
    Left = 224
    Top = 559
    Width = 130
    Height = 25
    Caption = #1048#1079#1074#1083#1077#1095#1100' '#1076#1072#1085#1085#1099#1077
    Enabled = False
    TabOrder = 5
    OnClick = btExtractClick
  end
  object mLog: TMemo
    Left = 440
    Top = 441
    Width = 288
    Height = 143
    ScrollBars = ssBoth
    TabOrder = 6
  end
  object btView: TButton
    Left = 80
    Top = 559
    Width = 130
    Height = 25
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088
    Enabled = False
    TabOrder = 7
    OnClick = btViewClick
  end
  object qExtractor: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    Left = 480
    Top = 9
  end
  object dsTagGroup: TDataSource
    DataSet = IVK_DM.tbTWX_GLOBAL
    Left = 152
    Top = 8
  end
  object dsTagList: TDataSource
    DataSet = IVK_DM.tbTags
    Left = 216
    Top = 8
  end
  object qGetTabCount: TADOQuery
    Connection = IVK_DM.connIVK_DB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select Table_Name, Tables_Number from TWX_GLOBAL'
      'where'
      'Table_Tags='#39'GPS_Table_Tags'#39)
    Left = 280
    Top = 8
    object qGetTabCountTables_Number: TIntegerField
      FieldName = 'Tables_Number'
    end
    object qGetTabCountTable_Name: TStringField
      FieldName = 'Table_Name'
      FixedChar = True
      Size = 60
    end
  end
  object qTempTable: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      'create table #tmpselect('
      #9#9'SI int NOT NULL,'
      #9#9'TD datetime NOT NULL,'
      #9#9'SMS int NULL,'
      #9#9'VAL float NOT NULL'
      #9')')
    Left = 352
    Top = 8
  end
  object qClearTmp: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      'delete from #tmpselect')
    Left = 416
    Top = 8
  end
  object qForExport: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      'select SI, TD,SMS, VAL from #tmpselect'
      'order by SI, TD, SMS')
    Left = 552
    Top = 8
  end
  object sdResult: TSaveDialog
    Filter = #1050#1085#1080#1075#1080' Excel (*.xls)|*.xls|'#1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093' (*.msr)|*.msr'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofNoNetworkButton, ofEnableSizing]
    Left = 632
    Top = 8
  end
  object odConn: TOpenDialog
    DefaultExt = '*.udl'
    Filter = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103' (*.udl)|*.udl'
    Left = 688
    Top = 8
  end
end
