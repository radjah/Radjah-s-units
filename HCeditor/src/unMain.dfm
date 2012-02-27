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
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
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
        FieldName = 'cname'
        Title.Caption = #1062#1080#1082#1083
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
    OnClick = btEditClick
  end
  object btStageEditor: TButton
    Left = 357
    Top = 176
    Width = 217
    Height = 25
    Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1101#1090#1072#1087#1086#1074
    TabOrder = 3
    OnClick = btStageEditorClick
  end
  object btDelete: TButton
    Left = 357
    Top = 70
    Width = 217
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1094#1080#1082#1083
    TabOrder = 4
    OnClick = btDeleteClick
  end
  object btExport: TButton
    Left = 357
    Top = 101
    Width = 217
    Height = 25
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080' '#1101#1082#1089#1087#1086#1088#1090
    Enabled = False
    TabOrder = 5
    OnClick = btExportClick
  end
  object ZConnect: TZConnection
    SQLHourGlass = True
    Protocol = 'sqlite-3'
    Left = 64
    Top = 432
  end
  object ztCycle: TZTable
    Connection = ZConnect
    ReadOnly = True
    TableName = 'cycle'
    Left = 120
    Top = 432
  end
  object dsCycle: TDataSource
    DataSet = ztCycle
    Left = 168
    Top = 432
  end
  object zqCommon: TZQuery
    Connection = ZConnect
    Params = <>
    Left = 248
    Top = 432
  end
  object zqCreateDB: TZQuery
    Connection = ZConnect
    SQL.Strings = (
      
        'CREATE TABLE cstruct (id integer NOT NULL PRIMARY KEY AUTOINCREM' +
        'ENT UNIQUE,cid integer NOT NULL,corder integer NOT NULL,sid inte' +
        'ger NOT NULL);'
      'CREATE TABLE cycle ('
      '  cid    integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,'
      '  cname  varchar(128) NOT NULL'
      ');'
      
        'CREATE TABLE sstruct (pid integer NOT NULL PRIMARY KEY AUTOINCRE' +
        'MENT UNIQUE,sid integer NOT NULL,clevel integer NOT NULL,ptime i' +
        'nteger NOT NULL);'
      'CREATE TABLE stages ('
      '  sid    integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,'
      '  sname  varchar(128) NOT NULL'
      ');'
      'CREATE INDEX cindex ON sstruct(sid);'
      'CREATE INDEX sindex ON cstruct(sid);')
    Params = <>
    Left = 328
    Top = 432
  end
  object sdExport: TSaveDialog
    DefaultExt = 'hcf'
    Filter = #1060#1072#1081#1083' '#1094#1080#1082#1083#1072' (*.hcf)|*.hcf'
    Options = [ofEnableSizing]
    Left = 392
    Top = 432
  end
  object zqExport: TZQuery
    Connection = ZConnect
    SQL.Strings = (
      
        'SELECT   cstruct.corder AS corder, sstruct.clevel AS clevel, sst' +
        'ruct.ptime AS ptime'
      'FROM  cstruct, sstruct'
      'WHERE'
      'cstruct.cid = 10'
      'AND  cstruct.sid = sstruct.sid'
      'ORDER BY  cstruct.corder, sstruct.clevel')
    Params = <>
    Left = 456
    Top = 432
  end
end
