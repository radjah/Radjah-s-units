object fmArchive: TfmArchive
  Left = 366
  Top = 213
  BorderStyle = bsDialog
  Caption = #1040#1088#1093#1080#1074' '#1080#1079#1084#1077#1088#1077#1085#1080#1081
  ClientHeight = 392
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbInfo: TGroupBox
    Left = 472
    Top = 72
    Width = 241
    Height = 185
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
    TabOrder = 0
    object lArcTime: TLabel
      Left = 93
      Top = 93
      Width = 4
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lArcDiff: TLabel
      Left = 93
      Top = 117
      Width = 4
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lArcUd: TLabel
      Left = 93
      Top = 141
      Width = 4
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 10
      Top = 93
      Width = 53
      Height = 20
      Caption = #1042#1088#1077#1084#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 10
      Top = 117
      Width = 67
      Height = 20
      Caption = #1056#1072#1079#1085#1080#1094#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 10
      Top = 141
      Width = 73
      Height = 20
      Caption = #1063#1072#1089#1086#1074#1086#1081': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 10
      Top = 21
      Width = 43
      Height = 20
      Caption = #1044#1072#1090#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 10
      Top = 45
      Width = 62
      Height = 20
      Caption = #1053#1072#1095#1072#1083#1086':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lDate: TLabel
      Left = 93
      Top = 21
      Width = 4
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lStart: TLabel
      Left = 93
      Top = 45
      Width = 4
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lEndTime: TLabel
      Left = 93
      Top = 69
      Width = 4
      Height = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 10
      Top = 69
      Width = 50
      Height = 20
      Caption = #1050#1086#1085#1077#1094':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object gbArch: TGroupBox
    Left = 8
    Top = 8
    Width = 457
    Height = 377
    Caption = #1048#1079#1084#1077#1088#1077#1085#1080#1103
    TabOrder = 1
    object dbgArchive: TDBGrid
      Left = 8
      Top = 16
      Width = 441
      Height = 353
      DataSource = dsArchive
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = dbgArchiveCellClick
      OnColEnter = dbgArchiveColEnter
      OnDblClick = btChartClick
      OnKeyUp = dbgArchiveKeyUp
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Title.Caption = #8470
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'start'
          Title.Caption = #1044#1072#1090#1072
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESC'
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 256
          Visible = True
        end>
    end
  end
  object gbData: TGroupBox
    Left = 472
    Top = 8
    Width = 241
    Height = 57
    Caption = #1060#1080#1083#1100#1090#1088' '#1087#1086' '#1076#1072#1090#1077
    TabOrder = 2
    object dtData: TDateTimePicker
      Left = 8
      Top = 20
      Width = 201
      Height = 21
      Date = 41555.681063993060000000
      Time = 41555.681063993060000000
      TabOrder = 0
      OnChange = dtDataChange
    end
    object btResetFilter: TButton
      Left = 212
      Top = 20
      Width = 21
      Height = 21
      Hint = #1057#1073#1088#1086#1089' '#1092#1080#1083#1100#1090#1088#1072
      Caption = 'X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btResetFilterClick
    end
  end
  object gbActions: TGroupBox
    Left = 472
    Top = 264
    Width = 241
    Height = 121
    Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
    TabOrder = 3
    object btExport: TButton
      Left = 8
      Top = 24
      Width = 105
      Height = 25
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1079#1072#1084#1077#1088#1072
      TabOrder = 0
      OnClick = btExportClick
    end
    object btDelete: TButton
      Left = 128
      Top = 24
      Width = 105
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 1
      OnClick = btDeleteClick
    end
    object btSumExport: TButton
      Left = 8
      Top = 88
      Width = 225
      Height = 25
      Caption = #1057#1074#1086#1076#1085#1072#1103' '#1087#1086' '#1092#1080#1083#1100#1090#1088#1091
      TabOrder = 2
      OnClick = btSumExportClick
    end
    object btChart: TButton
      Left = 8
      Top = 56
      Width = 225
      Height = 25
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1075#1088#1072#1092#1080#1082
      TabOrder = 3
      OnClick = btChartClick
    end
  end
  object ztMeasArchive: TZTable
    Connection = fmDevNetLogger.ZConnection
    BeforeScroll = ztMeasArchiveBeforeScroll
    ReadOnly = True
    TableName = 'measure'
    Left = 24
    Top = 216
  end
  object dsArchive: TDataSource
    DataSet = ztMeasArchive
    Left = 56
    Top = 216
  end
  object zqArchive: TZQuery
    Connection = fmDevNetLogger.ZConnection
    SQL.Strings = (
      'SELECT * from weight where'
      'meas_id=1')
    Params = <>
    Left = 88
    Top = 216
  end
  object ztWeight: TZTable
    Connection = fmDevNetLogger.ZConnection
    Filtered = True
    TableName = 'weight'
    MasterFields = 'id'
    MasterSource = dsArchive
    LinkedFields = 'meas_id'
    Left = 152
    Top = 216
  end
  object dsWeight: TDataSource
    DataSet = ztWeight
    Left = 184
    Top = 216
  end
  object sdExport: TSaveDialog
    DefaultExt = 'xls'
    Filter = #1050#1085#1080#1075#1080' Excel (*.xls)|*.xls'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 216
    Top = 216
  end
  object zqDelete: TZQuery
    Connection = fmDevNetLogger.ZConnection
    SQL.Strings = (
      'DELETE from weight where'
      'meas_id=1')
    Params = <>
    Left = 120
    Top = 216
  end
  object zqDelMeas: TZQuery
    Connection = fmDevNetLogger.ZConnection
    SQL.Strings = (
      'DELETE from measure where'
      'id=1')
    Params = <>
    Left = 248
    Top = 216
  end
end
