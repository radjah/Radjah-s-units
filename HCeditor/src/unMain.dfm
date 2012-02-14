object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1094#1080#1082#1083#1086#1074
  ClientHeight = 490
  ClientWidth = 582
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object dbgCycle: TDBGrid
    Left = 8
    Top = 8
    Width = 329
    Height = 417
    DataSource = dsCycle
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = #1062#1080#1082#1083
        Width = 300
        Visible = True
      end>
  end
  object btCreat: TButton
    Left = 357
    Top = 8
    Width = 217
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1094#1080#1082#1083
    TabOrder = 1
    OnClick = btCreatClick
  end
  object btEdit: TButton
    Left = 357
    Top = 39
    Width = 217
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1094#1080#1082#1083
    TabOrder = 2
  end
  object btStageEditor: TButton
    Left = 357
    Top = 136
    Width = 217
    Height = 25
    Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1101#1090#1072#1087#1086#1074
    TabOrder = 3
    OnClick = btStageEditorClick
  end
  object ZConnect: TZConnection
    Connected = True
    Protocol = 'sqlite-3'
    Database = 'stages.sqlite'
    Left = 64
    Top = 432
  end
  object ztCycle: TZTable
    Connection = ZConnect
    Active = True
    TableName = 'cycle'
    Left = 120
    Top = 432
  end
  object dsCycle: TDataSource
    DataSet = ztCycle
    Left = 168
    Top = 432
  end
  object zuCycle: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM cycle'
      'WHERE'
      '(cycle.cid = :OLD_cid))')
    InsertSQL.Strings = (
      'INSERT INTO cycle'
      '  (cname)'
      'VALUES'
      '  (cname)')
    ModifySQL.Strings = (
      'UPDATE cycle SET'
      '  cname = :cname'
      'WHERE'
      
        '  ((cycle.cid IS NULL AND :OLD_cid IS NULL) OR (cycle.cid = :OLD' +
        '_cid))')
    UseSequenceFieldForRefreshSQL = False
    Left = 280
    Top = 432
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cname'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_cid'
        ParamType = ptUnknown
      end>
  end
  object zqAddCycle: TZQuery
    Connection = ZConnect
    Params = <>
    Left = 344
    Top = 432
  end
end
