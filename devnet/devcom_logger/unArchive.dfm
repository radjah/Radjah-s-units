object fmArchive: TfmArchive
  Left = 596
  Top = 202
  BorderStyle = bsDialog
  Caption = #1040#1088#1093#1080#1074' '#1080#1079#1084#1077#1088#1077#1085#1080#1081
  ClientHeight = 354
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lArcTime: TLabel
    Left = 24
    Top = 280
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
    Left = 24
    Top = 304
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
    Left = 24
    Top = 328
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
    Left = 16
    Top = 16
    Width = 44
    Height = 13
    Caption = #1047#1072#1084#1077#1088#1099':'
  end
  object dbgArchive: TDBGrid
    Left = 16
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
        Width = 105
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
  object ztMeasArchive: TZTable
    Connection = fmDevNetLogger.ZConnection
    ReadOnly = True
    TableName = 'measure'
    Left = 312
    Top = 296
  end
  object dsArchive: TDataSource
    DataSet = ztMeasArchive
    Left = 344
    Top = 296
  end
  object zqArchive: TZQuery
    Connection = fmDevNetLogger.ZConnection
    SQL.Strings = (
      'SELECT * from weight where'
      'meas_id=1')
    Params = <>
    Left = 376
    Top = 296
  end
end
