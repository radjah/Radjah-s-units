object fmCycleEditor: TfmCycleEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1094#1080#1082#1083#1072
  ClientHeight = 457
  ClientWidth = 687
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
    Left = 8
    Top = 5
    Width = 73
    Height = 13
    Caption = #1057#1086#1089#1090#1072#1074' '#1094#1080#1082#1083#1072':'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 24
    Width = 305
    Height = 345
    DataSource = dsCStruct
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'corder'
        Title.Caption = #8470
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sname'
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1101#1090#1072#1087#1072
        Width = 250
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 368
    Top = 24
    Width = 305
    Height = 345
    DataSource = dsStages
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'sname'
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1101#1090#1072#1087#1072
        Width = 270
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 319
    Top = 120
    Width = 43
    Height = 25
    Caption = '<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 319
    Top = 151
    Width = 43
    Height = 25
    Caption = '>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object ztCStruct: TZTable
    Connection = fmMain.ZConnect
    Active = True
    ReadOnly = True
    TableName = 'cstruct'
    MasterFields = 'cid'
    MasterSource = fmMain.dsCycle
    LinkedFields = 'cid'
    Left = 16
    Top = 384
    object ztCStructid: TIntegerField
      FieldName = 'id'
    end
    object ztCStructcid: TIntegerField
      FieldName = 'cid'
      Required = True
    end
    object ztCStructcorder: TIntegerField
      FieldName = 'corder'
      Required = True
    end
    object ztCStructsid: TIntegerField
      FieldName = 'sid'
      Required = True
    end
    object ztCStructsname: TStringField
      FieldKind = fkLookup
      FieldName = 'sname'
      LookupDataSet = ztStages
      LookupKeyFields = 'sid'
      LookupResultField = 'sname'
      KeyFields = 'sid'
      Size = 128
      Lookup = True
    end
  end
  object dsCStruct: TDataSource
    DataSet = ztCStruct
    Left = 72
    Top = 384
  end
  object ztStages: TZTable
    Connection = fmMain.ZConnect
    Active = True
    ReadOnly = True
    TableName = 'stages'
    Left = 144
    Top = 384
  end
  object dsStages: TDataSource
    DataSet = ztStages
    Left = 200
    Top = 384
  end
end
