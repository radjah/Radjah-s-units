object fmMap: TfmMap
  Left = 185
  Top = 79
  Width = 1014
  Height = 673
  Caption = #1055#1086#1083#1091#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1082#1072#1088#1090#1099' '#1082#1083#1077#1084#1084#1085#1099#1093' '#1087#1086#1083#1077#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnMenu
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 37
    Height = 13
    Caption = #1064#1082#1072#1092#1099
  end
  object Label2: TLabel
    Left = 8
    Top = 352
    Width = 105
    Height = 13
    Caption = #1057#1080#1075#1085#1072#1083#1099' '#1076#1083#1103' '#1096#1082#1072#1092#1072':'
  end
  object Label3: TLabel
    Left = 336
    Top = 16
    Width = 101
    Height = 13
    Caption = #1055#1086#1076#1093#1086#1076#1103#1097#1080#1077' '#1084#1077#1089#1090#1072':'
  end
  object Label4: TLabel
    Left = 656
    Top = 16
    Width = 64
    Height = 13
    Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1103':'
  end
  object Label5: TLabel
    Left = 344
    Top = 352
    Width = 102
    Height = 13
    Caption = #1057#1080#1075#1085#1072#1083#1099' '#1076#1083#1103' '#1084#1077#1089#1090#1072':'
  end
  object dbgUnits: TDBGrid
    Left = 0
    Top = 32
    Width = 233
    Height = 305
    DataSource = dsUnits
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'unid'
        Title.Caption = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'unname'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 128
        Visible = True
      end>
  end
  object dbgSigByUnit: TDBGrid
    Left = 0
    Top = 368
    Width = 233
    Height = 241
    DataSource = dsSigByUnit
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'signame'
        Title.Caption = #1058#1080#1087
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sigcount'
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Visible = True
      end>
  end
  object btFind: TButton
    Left = 240
    Top = 176
    Width = 89
    Height = 33
    Caption = #1053#1072#1081#1090#1080' '#1084#1077#1089#1090#1086' >'
    TabOrder = 2
    OnClick = btFindClick
  end
  object dbgFindPlace: TDBGrid
    Left = 336
    Top = 32
    Width = 215
    Height = 305
    DataSource = dsFindPlace
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id_place'
        Title.Caption = 'ID'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'placename'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 145
        Visible = True
      end>
  end
  object btConnect: TButton
    Left = 560
    Top = 176
    Width = 89
    Height = 33
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100' >'
    Enabled = False
    TabOrder = 4
    OnClick = btConnectClick
  end
  object dbgMap: TDBGrid
    Left = 656
    Top = 32
    Width = 320
    Height = 545
    DataSource = dsMap
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ProbTag'
        Title.Caption = #1042#1086#1079#1076#1077#1081#1089#1090#1074#1080#1077
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'conttag'
        Title.Caption = #1050#1083#1077#1084#1084#1072
        Visible = True
      end>
  end
  object btClear: TButton
    Left = 792
    Top = 584
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 6
    OnClick = btClearClick
  end
  object dbgSigPlace: TDBGrid
    Left = 336
    Top = 368
    Width = 217
    Height = 241
    DataSource = dsSigPlace
    TabOrder = 7
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
        FieldName = 'id_sig'
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Visible = True
      end>
  end
  object dsUnits: TDataSource
    AutoEdit = False
    DataSet = qTestUnits
    Left = 96
  end
  object adsSigByUnit: TADODataSet
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandText = 
      'select testunits.unid,probtags.sigtypeid,COUNT(probtags.sigtypei' +
      'd) as sigcount'#13#10'from unittags,probtags,testunits'#13#10'where unittags' +
      '.tagid=probtags.id and testunits.unid=unittags.unitid'#13#10'group by ' +
      'unid,sigtypeid'#13#10'order by unid'
    DataSource = dsUnits
    IndexFieldNames = 'unid'
    MasterFields = 'unid'
    Parameters = <>
    Left = 128
    object adsSigByUnitunid: TIntegerField
      FieldName = 'unid'
      ReadOnly = True
    end
    object adsSigByUnitsigtypeid: TIntegerField
      FieldName = 'sigtypeid'
    end
    object adsSigByUnitsigcount: TIntegerField
      FieldName = 'sigcount'
      ReadOnly = True
    end
    object adsSigByUnitsigname: TStringField
      FieldKind = fkLookup
      FieldName = 'signame'
      LookupDataSet = tbSigName
      LookupKeyFields = 'sigid'
      LookupResultField = 'sigtag'
      KeyFields = 'sigtypeid'
      Size = 10
      Lookup = True
    end
  end
  object dsSigByUnit: TDataSource
    AutoEdit = False
    DataSet = adsSigByUnit
    Left = 160
  end
  object qFindPlace: TADOQuery
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'SELECT distinct places.id as id_place,places.placename'
      
        'FROM     places INNER JOIN ##contact A1 on A1.id_place=places.id' +
        ' --CROSS JOIN ##contact A2 CROSS JOIN ##contact A3'
      
        'GROUP BY id,placename,A1.id_sig,A1.sigcount--,A2.id_sig,A2.sigco' +
        'unt,A3.id_sig,A3.sigcount'
      
        'HAVING   (A1.id_sig = 8 and A1.sigcount >= 4)-- and (A2.id_sig =' +
        ' 2 and A2.sigcount >= 1) and (A3.id_sig = 3 and A3.sigcount >= 1' +
        ')'
      'ORDER BY id')
    Left = 288
    object qFindPlaceid_place: TIntegerField
      FieldName = 'id_place'
    end
    object qFindPlaceplacename: TStringField
      FieldKind = fkLookup
      FieldName = 'placename'
      LookupDataSet = tbPlace
      LookupKeyFields = 'id'
      LookupResultField = 'placename'
      KeyFields = 'id_place'
      Size = 64
      Lookup = True
    end
  end
  object dsFindPlace: TDataSource
    AutoEdit = False
    DataSet = qFindPlace
    Left = 320
  end
  object tbPlace: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    TableName = 'places'
    Left = 256
  end
  object tbSigName: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    TableName = 'signame'
    Left = 224
  end
  object mnMenu: TMainMenu
    Left = 192
    object mnMap: TMenuItem
      Caption = #1050#1072#1088#1090#1072
      object mnReportMenu: TMenuItem
        Caption = #1054#1090#1095#1077#1090#1099
        object mnPrintReport: TMenuItem
          Caption = #1053#1072' '#1087#1077#1095#1072#1090#1100
          OnClick = mnPrintReportClick
        end
        object mnExcelReport: TMenuItem
          Caption = #1042' Excel'
          OnClick = mnExcelReportClick
        end
      end
      object mnExcelExport: TMenuItem
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
        OnClick = mnExcelExportClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mnClose: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        OnClick = mnCloseClick
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
  object dsMap: TDataSource
    DataSet = qMap
    Left = 888
  end
  object qMap: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    OnCalcFields = qMapCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT     probtags.ProbTag, signame.sigtag,contact.contnum'
      'FROM         map INNER JOIN'
      
        '                      contact ON contact.id = map.contid INNER J' +
        'OIN'
      
        '                      unittags ON map.unittag = unittags.id INNE' +
        'R JOIN'
      
        '                      probtags ON unittags.tagid = probtags.id I' +
        'NNER JOIN'
      '                      signame ON contact.id_sig = signame.sigid')
    Left = 920
    object qMapProbTag: TStringField
      FieldName = 'ProbTag'
      Size = 10
    end
    object qMapsigtag: TStringField
      FieldName = 'sigtag'
      Size = 10
    end
    object qMapcontnum: TIntegerField
      FieldName = 'contnum'
    end
    object qMapconttag: TStringField
      FieldKind = fkCalculated
      FieldName = 'conttag'
      Size = 16
      Calculated = True
    end
  end
  object tbTemp: TADOTable
    Connection = fmDM.ADOConn
    TableName = '##contact'
    Left = 304
    Top = 272
  end
  object qTemp: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    SQL.Strings = (
      'select id_place,id_sig, count(id_sig) as sigcount'
      
        'from connector conn inner join contact cnt on conn.id = cnt.id_c' +
        'onn'
      'group by id_place,id_sig'
      'order by id_place,id_sig')
    Left = 272
    Top = 272
    object qTempid_place: TIntegerField
      FieldName = 'id_place'
    end
    object qTempid_sig: TIntegerField
      FieldName = 'id_sig'
    end
    object qTempsigcount: TIntegerField
      FieldName = 'sigcount'
      ReadOnly = True
    end
  end
  object qCrTemp: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    SQL.Strings = (
      'CREATE TABLE ##contact('
      #9'id_place int NOT NULL,'
      #9'id_sig int NOT NULL,'
      #9'sigcount int NOT NULL)')
    Left = 240
    Top = 272
  end
  object qTestUnits: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'SELECT    DISTINCT testunits.unid, testunits.unname'
      
        'FROM         testunits INNER JOIN unittags ON testunits.unid = u' +
        'nittags.unitid'
      
        'WHERE     (testunits.unid IN (SELECT unitid FROM unittags AS uni' +
        'ttags_1))')
    Left = 64
    object qTestUnitsunid: TIntegerField
      FieldName = 'unid'
      ReadOnly = True
    end
    object qTestUnitsunname: TStringField
      FieldName = 'unname'
      Size = 128
    end
  end
  object qClearTemp: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    SQL.Strings = (
      'delete from ##contact'
      '')
    Left = 272
    Top = 304
  end
  object qClear: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    SQL.Strings = (
      'delete from map')
    Left = 760
    Top = 584
  end
  object adsSigPlace: TADODataSet
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    CommandText = 
      'SELECT     connector.id_place, signame.sigtag, COUNT(contact.id_' +
      'sig) AS id_sig'#13#10'FROM         contact INNER JOIN'#13#10'               ' +
      '       connector ON connector.id = contact.id_conn INNER JOIN'#13#10' ' +
      '                     signame ON contact.id_sig = signame.sigid'#13#10 +
      'GROUP BY connector.id_place, signame.sigtag'#13#10'ORDER BY connector.' +
      'id_place, signame.sigtag'
    DataSource = dsFindPlace
    IndexFieldNames = 'id_place'
    MasterFields = 'id_place'
    Parameters = <>
    Left = 304
    Top = 368
    object adsSigPlaceid_place: TIntegerField
      FieldName = 'id_place'
    end
    object adsSigPlacesigtag: TStringField
      FieldName = 'sigtag'
      Size = 10
    end
    object adsSigPlaceid_sig: TIntegerField
      FieldName = 'id_sig'
      ReadOnly = True
    end
  end
  object dsSigPlace: TDataSource
    DataSet = adsSigPlace
    Left = 272
    Top = 368
  end
end
