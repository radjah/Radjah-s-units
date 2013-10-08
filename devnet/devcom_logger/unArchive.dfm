object fmArchive: TfmArchive
  Left = 366
  Top = 213
  BorderStyle = bsDialog
  Caption = #1040#1088#1093#1080#1074' '#1080#1079#1084#1077#1088#1077#1085#1080#1081
  ClientHeight = 279
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lArcTime: TLabel
    Left = 464
    Top = 32
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
  object lArcDiff: TLabel
    Left = 464
    Top = 56
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
  object lArcUd: TLabel
    Left = 464
    Top = 80
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
  object Label4: TLabel
    Left = 8
    Top = 16
    Width = 44
    Height = 13
    Caption = #1047#1072#1084#1077#1088#1099':'
  end
  object Label1: TLabel
    Left = 464
    Top = 16
    Width = 66
    Height = 13
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
  end
  object dbgArchive: TDBGrid
    Left = 8
    Top = 32
    Width = 441
    Height = 241
    DataSource = dsArchive
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = dbgArchiveCellClick
    OnColEnter = dbgArchiveColEnter
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
  object btExport: TButton
    Left = 464
    Top = 112
    Width = 81
    Height = 25
    Caption = #1069#1082#1089#1087#1086#1088#1090
    TabOrder = 1
    OnClick = btExportClick
  end
  object btDelete: TButton
    Left = 464
    Top = 144
    Width = 83
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 2
    OnClick = btDeleteClick
  end
  object ztMeasArchive: TZTable
    Connection = fmDevNetLogger.ZConnection
    BeforeScroll = ztMeasArchiveBeforeScroll
    ReadOnly = True
    TableName = 'measure'
    Left = 464
    Top = 184
  end
  object dsArchive: TDataSource
    DataSet = ztMeasArchive
    Left = 496
    Top = 184
  end
  object zqArchive: TZQuery
    Connection = fmDevNetLogger.ZConnection
    SQL.Strings = (
      'SELECT * from weight where'
      'meas_id=1')
    Params = <>
    Left = 528
    Top = 184
  end
  object ztWeight: TZTable
    Connection = fmDevNetLogger.ZConnection
    Filtered = True
    TableName = 'weight'
    MasterFields = 'id'
    MasterSource = dsArchive
    LinkedFields = 'meas_id'
    Left = 464
    Top = 216
  end
  object dsWeight: TDataSource
    DataSet = ztWeight
    Left = 496
    Top = 216
  end
  object sdExport: TSaveDialog
    DefaultExt = 'xls'
    Filter = #1050#1085#1080#1075#1080' Excel (*.xls)|*.xls'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 528
    Top = 216
  end
  object zqDelete: TZQuery
    Connection = fmDevNetLogger.ZConnection
    SQL.Strings = (
      'DELETE from weight where'
      'meas_id=1')
    Params = <>
    Left = 560
    Top = 184
  end
  object zqDelMeas: TZQuery
    Connection = fmDevNetLogger.ZConnection
    SQL.Strings = (
      'DELETE from measure where'
      'id=1')
    Params = <>
    Left = 592
    Top = 184
  end
end
