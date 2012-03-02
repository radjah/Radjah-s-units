object fmConnector: TfmConnector
  Left = 192
  Top = 122
  Width = 716
  Height = 523
  Caption = 'fmConnector'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 51
    Height = 13
    Caption = #1056#1072#1079#1098#1077#1084#1099':'
  end
  object Label2: TLabel
    Left = 392
    Top = 24
    Width = 80
    Height = 13
    Caption = #1050#1083#1077#1084#1084#1099' '#1080' '#1090#1077#1075#1080':'
  end
  object Label3: TLabel
    Left = 24
    Top = 232
    Width = 134
    Height = 13
    Caption = #1057#1080#1075#1085#1072#1083#1099' '#1087#1086' '#1090#1080#1087#1072#1084' ('#1074#1089#1077#1075#1086'):'
  end
  object dbgConnector: TDBGrid
    Left = 16
    Top = 40
    Width = 361
    Height = 177
    DataSource = DSConnect
    ReadOnly = True
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
        Title.Caption = 'ID'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'connname'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 300
        Visible = True
      end>
  end
  object dbgContact: TDBGrid
    Left = 384
    Top = 40
    Width = 313
    Height = 425
    DataSource = DSContact
    ReadOnly = True
    TabOrder = 1
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
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'contnum'
        Title.Caption = #1053#1086#1084#1077#1088
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'conttag'
        Title.Caption = #1058#1077#1075
        Visible = True
      end>
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 248
    Width = 361
    Height = 217
    DataSource = dsSigByType
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
        FieldName = 'sigcount'
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Width = 100
        Visible = True
      end>
  end
  object MainMenu1: TMainMenu
    object mnConn: TMenuItem
      Caption = #1069#1083#1077#1084#1077#1085#1090#1099
      object mnConnCr: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1088#1072#1079#1098#1105#1084
        OnClick = mnConnCrClick
      end
      object mnCrGroup: TMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1075#1088#1091#1087#1087#1091' '#1082#1083#1077#1084#1084
        OnClick = mnCrGroupClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnClose: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
      end
    end
    object mnHelpMenu: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
      object mnHelp: TMenuItem
        Caption = #1057#1087#1088#1072#1074#1082#1072
        OnClick = mnHelpClick
      end
    end
  end
  object QConnector: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT connector.id as id,connname,places.placename as plname'
      'FROM connector,places'
      'where connector.id_place=places.id and connector.id_place=2')
    Left = 32
    object QConnectorid: TIntegerField
      FieldName = 'id'
    end
    object QConnectorconnname: TStringField
      FieldName = 'connname'
      Size = 255
    end
    object QConnectorplname: TStringField
      FieldName = 'plname'
      Size = 255
    end
  end
  object QContacts: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    Left = 64
  end
  object DSConnect: TDataSource
    DataSet = QConnector
    Left = 312
  end
  object DSContact: TDataSource
    DataSet = adodsContacts
    Left = 672
  end
  object tbPlace: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    TableName = 'places'
    Left = 96
  end
  object adodsContacts: TADODataSet
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    OnCalcFields = adodsContactsCalcFields
    CommandText = 'select id,id_conn, id_sig, contnum from contact'
    DataSource = DSConnect
    IndexFieldNames = 'id_conn'
    MasterFields = 'id'
    Parameters = <>
    Left = 640
    object adodsContactsid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object adodsContactsid_conn: TIntegerField
      FieldName = 'id_conn'
    end
    object adodsContactssigtag: TStringField
      FieldKind = fkLookup
      FieldName = 'sigtag'
      LookupDataSet = tbSigName
      LookupKeyFields = 'sigid'
      LookupResultField = 'sigtag'
      KeyFields = 'id_sig'
      Size = 10
      Lookup = True
    end
    object adodsContactsid_sig: TIntegerField
      FieldName = 'id_sig'
    end
    object adodsContactscontnum: TIntegerField
      FieldName = 'contnum'
    end
    object adodsContactsconttag: TStringField
      FieldKind = fkCalculated
      FieldName = 'conttag'
      Calculated = True
    end
  end
  object ADOQuery: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    Left = 264
  end
  object tbSigName: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    TableName = 'signame'
    Left = 608
  end
  object qSigByTpe: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT     contact.id_sig, COUNT(contact.id_sig) AS sigcount'
      'FROM         connector INNER JOIN'
      
        '                      places ON connector.id_place = places.id I' +
        'NNER JOIN'
      '                      contact ON connector.id = contact.id_conn'
      'WHERE     (places.id = 1)'
      'GROUP BY contact.id_sig, places.id')
    Left = 56
    Top = 400
    object qSigByTpeid_sig: TIntegerField
      FieldName = 'id_sig'
    end
    object qSigByTpesigcount: TIntegerField
      FieldName = 'sigcount'
      ReadOnly = True
    end
    object qSigByTpesigtag: TStringField
      FieldKind = fkLookup
      FieldName = 'sigtag'
      LookupDataSet = tbSigName
      LookupKeyFields = 'sigid'
      LookupResultField = 'sigtag'
      KeyFields = 'id_sig'
      Size = 10
      Lookup = True
    end
  end
  object dsSigByType: TDataSource
    DataSet = qSigByTpe
    Left = 88
    Top = 400
  end
end
