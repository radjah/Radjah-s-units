object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1079#1074#1083#1077#1095#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 635
  ClientWidth = 755
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
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
    Left = 472
    Top = 422
    Width = 49
    Height = 13
    Caption = #1055#1088#1086#1090#1086#1082#1086#1083
  end
  object Label8: TLabel
    Left = 472
    Top = 213
    Width = 130
    Height = 13
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1076#1083#1103' '#1074#1099#1073#1086#1088#1082#1080':'
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
    Width = 736
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
    Width = 418
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
        FieldName = 'Tag_Index'
        Title.Caption = #1048#1085#1076#1077#1082#1089
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Description'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tag_Comments'
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
        Width = 140
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 415
    Width = 417
    Height = 170
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
      Left = 176
      Top = 31
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
      Left = 176
      Top = 77
      Width = 91
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
    end
    object dtpDateBegin: TDateTimePicker
      Left = 16
      Top = 48
      Width = 145
      Height = 21
      Date = 41193.000000000000000000
      Time = 41193.000000000000000000
      DateFormat = dfLong
      TabOrder = 0
    end
    object dtpDateEnd: TDateTimePicker
      Left = 176
      Top = 50
      Width = 145
      Height = 21
      Date = 41193.345461296300000000
      Time = 41193.345461296300000000
      DateFormat = dfLong
      TabOrder = 2
    end
    object dtpTimeBegin: TDateTimePicker
      Left = 16
      Top = 96
      Width = 145
      Height = 21
      Date = 41193.346280370370000000
      Time = 41193.346280370370000000
      DateFormat = dfLong
      Kind = dtkTime
      TabOrder = 1
    end
    object dtpTimeEnd: TDateTimePicker
      Left = 176
      Top = 96
      Width = 145
      Height = 21
      Date = 41193.346823657400000000
      Time = 41193.346823657400000000
      Kind = dtkTime
      TabOrder = 3
    end
    object cbFillTime: TCheckBox
      Left = 16
      Top = 136
      Width = 186
      Height = 17
      Caption = #1053#1077#1087#1088#1077#1088#1099#1074#1085#1086#1077' '#1074#1088#1077#1084#1103
      TabOrder = 4
    end
    object cbLogScale: TCheckBox
      Left = 176
      Top = 136
      Width = 217
      Height = 17
      Caption = #1051#1086#1075#1072#1088#1080#1092#1084#1080#1095#1077#1089#1082#1072#1103' '#1096#1082#1072#1083#1072' '#1085#1072' '#1075#1088#1072#1092#1080#1082#1077
      TabOrder = 5
      OnClick = cbLogScaleClick
    end
  end
  object btExtract: TButton
    Left = 256
    Top = 602
    Width = 130
    Height = 25
    Caption = #1048#1079#1074#1083#1077#1095#1100' '#1076#1072#1085#1085#1099#1077
    Enabled = False
    TabOrder = 5
    OnClick = btExtractClick
  end
  object mLog: TMemo
    Left = 472
    Top = 441
    Width = 273
    Height = 186
    ScrollBars = ssBoth
    TabOrder = 6
  end
  object btView: TButton
    Left = 8
    Top = 602
    Width = 89
    Height = 25
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088
    Enabled = False
    TabOrder = 7
    OnClick = btViewClick
  end
  object dbgSignalList: TDBGrid
    Left = 472
    Top = 232
    Width = 273
    Height = 177
    DataSource = dsSignalList
    TabOrder = 8
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
        FieldName = 'Table_Name'
        Title.Caption = #1055#1088#1077#1092#1080#1082#1089' '#1090#1072#1073#1083#1080#1094
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tables_Number'
        Title.Caption = #1050#1086#1083'-'#1074#1086' '#1090#1072#1073#1083#1080#1094
        Width = 80
        Visible = True
      end>
  end
  object btAdd: TBitBtn
    Left = 432
    Top = 264
    Width = 34
    Height = 25
    Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088' '#1074' '#1089#1087#1080#1089#1086#1082
    DoubleBuffered = True
    Enabled = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333FF3333333333333447333333333333377FFF33333333333744473333333
      333337773FF3333333333444447333333333373F773FF3333333334444447333
      33333373F3773FF3333333744444447333333337F333773FF333333444444444
      733333373F3333773FF333334444444444733FFF7FFFFFFF77FF999999999999
      999977777777777733773333CCCCCCCCCC3333337333333F7733333CCCCCCCCC
      33333337F3333F773333333CCCCCCC3333333337333F7733333333CCCCCC3333
      333333733F77333333333CCCCC333333333337FF7733333333333CCC33333333
      33333777333333333333CC333333333333337733333333333333}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btAddClick
  end
  object btRemove: TBitBtn
    Left = 432
    Top = 295
    Width = 34
    Height = 25
    Hint = #1059#1073#1088#1072#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088' '#1080#1079' '#1089#1087#1080#1089#1082#1072
    DoubleBuffered = True
    Enabled = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF3333333333333744333333333333F773333333333337
      44473333333333F777F3333333333744444333333333F7733733333333374444
      4433333333F77333733333333744444447333333F7733337F333333744444444
      433333F77333333733333744444444443333377FFFFFFF7FFFFF999999999999
      9999733777777777777333CCCCCCCCCC33333773FF333373F3333333CCCCCCCC
      C333333773FF3337F333333333CCCCCCC33333333773FF373F3333333333CCCC
      CC333333333773FF73F33333333333CCCCC3333333333773F7F3333333333333
      CCC333333333333777FF33333333333333CC3333333333333773}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btRemoveClick
  end
  object btClear: TBitBtn
    Left = 432
    Top = 326
    Width = 34
    Height = 25
    Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1076#1083#1103' '#1074#1099#1073#1086#1088#1082#1080
    DoubleBuffered = True
    Enabled = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
      3333333777777777F3333330F77777703333333733F3F3F73F33330FF0808077
      0333337F37F7F7F37F33330FF0807077033333733737F73F73F330FF77808707
      703337F37F37F37F37F330FF08807807703037F37F37F37F37F700FF08808707
      700377F37337F37F377330FF778078077033373F73F7F3733733330FF0808077
      0333337F37F7F7F37F33330FF08070770333337FF7F7F7FF7F33330000000000
      03333377777777777F33330F888777770333337FFFFFFFFF7F33330000000000
      033333777777777773333333307770333333333337FFF7F33333333330000033
      3333333337777733333333333333333333333333333333333333}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = btClearClick
  end
  object btPlot: TButton
    Left = 121
    Top = 602
    Width = 89
    Height = 25
    Caption = #1043#1088#1072#1092#1080#1082#1080
    Enabled = False
    TabOrder = 12
    OnClick = btPlotClick
  end
  object qExtractor: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    Left = 496
    Top = 9
  end
  object dsTagGroup: TDataSource
    DataSet = IVK_DM.tbTWX_GLOBAL
    Left = 240
    Top = 8
  end
  object dsTagList: TDataSource
    DataSet = IVK_DM.tbTags
    Left = 304
    Top = 8
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
    Left = 368
    Top = 8
  end
  object qClearTmp: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      'delete from #tmpselect')
    Left = 432
    Top = 8
  end
  object qForExport: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      'select SI, TD,SMS, VAL from #tmpselect'
      'order by SI, TD, SMS')
    Left = 568
    Top = 8
  end
  object sdResult: TSaveDialog
    DefaultExt = 'xls'
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
  object qSignalList: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      'CREATE TABLE [dbo].[#signallist]('
      #9'[ID] [int] IDENTITY(1,1),'
      #9'[Tag_Index] [int] NOT NULL,'
      #9'[Logging_Name] [nvarchar](255) NOT NULL,'
      #9'[Table_Name] [nvarchar](60) NOT NULL,'
      #9'[Tables_Number] [int] NOT NULL'
      ')')
    Left = 648
    Top = 176
  end
  object dsSignalList: TDataSource
    DataSet = IVK_DM.tbSignalList
    Left = 592
    Top = 176
  end
  object qClearList: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      'DELETE FROM #signallist')
    Left = 704
    Top = 176
  end
end
