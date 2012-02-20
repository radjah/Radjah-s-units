object fmMapManual: TfmMapManual
  Left = 195
  Top = 121
  Width = 870
  Height = 586
  Caption = #1056#1091#1095#1085#1086#1077' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1082#1072#1088#1090#1099' '#1082#1083#1077#1084#1084#1085#1099#1093' '#1087#1086#1083#1077#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnMenu
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 76
    Height = 13
    Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077':'
  end
  object Label2: TLabel
    Left = 216
    Top = 16
    Width = 95
    Height = 13
    Caption = #1058#1077#1075#1080' '#1074#1086#1079#1076#1077#1081#1089#1090#1074#1080#1081':'
  end
  object Label3: TLabel
    Left = 8
    Top = 224
    Width = 35
    Height = 13
    Caption = #1052#1077#1089#1090#1072':'
  end
  object Label4: TLabel
    Left = 216
    Top = 224
    Width = 46
    Height = 13
    Caption = #1050#1083#1077#1084#1084#1099':'
  end
  object Label5: TLabel
    Left = 592
    Top = 16
    Width = 64
    Height = 13
    Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1103':'
  end
  object dbgTestUnits: TDBGrid
    Left = 0
    Top = 32
    Width = 201
    Height = 161
    DataSource = dsTestUnits
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
        Width = 100
        Visible = True
      end>
  end
  object dbgTags: TDBGrid
    Left = 208
    Top = 32
    Width = 233
    Height = 161
    DataSource = dsUnitTags
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = dbgTagsCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'probtag'
        Title.Caption = #1042#1086#1079#1076#1077#1081#1089#1090#1074#1080#1077
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'signame'
        Title.Caption = #1057#1080#1075#1085#1072#1083
        Visible = True
      end>
  end
  object dbgPlace: TDBGrid
    Left = 0
    Top = 240
    Width = 201
    Height = 225
    DataSource = dsPlace
    TabOrder = 2
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
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'placename'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 100
        Visible = True
      end>
  end
  object dbCont: TDBGrid
    Left = 208
    Top = 240
    Width = 233
    Height = 225
    DataSource = dsCont
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'contid'
        Title.Caption = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'conttag'
        Title.Caption = #1058#1077#1075' '#1082#1083#1077#1084#1084#1099
        Visible = True
      end>
  end
  object btCon: TButton
    Left = 472
    Top = 344
    Width = 75
    Height = 25
    Caption = #1050#1086#1085#1090#1072#1082#1090#1099
    TabOrder = 4
    OnClick = btConClick
  end
  object dbgMap: TDBGrid
    Left = 584
    Top = 32
    Width = 256
    Height = 433
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
        FieldName = 'probtag'
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
  object btReport: TButton
    Left = 336
    Top = 496
    Width = 75
    Height = 25
    Caption = #1054#1090#1095#1077#1090
    TabOrder = 6
    OnClick = btReportClick
  end
  object btAdd: TButton
    Left = 472
    Top = 144
    Width = 75
    Height = 161
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' >'
    TabOrder = 7
    OnClick = btAddClick
  end
  object btExcel: TButton
    Left = 424
    Top = 496
    Width = 129
    Height = 25
    Caption = #1054#1090#1095#1077#1090' '#1074' Excel'
    TabOrder = 8
    OnClick = btExcelClick
  end
  object btExport: TButton
    Left = 656
    Top = 480
    Width = 137
    Height = 25
    Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
    TabOrder = 9
    OnClick = btExportClick
  end
  object btDel: TButton
    Left = 472
    Top = 312
    Width = 75
    Height = 25
    Caption = '< '#1059#1076#1072#1083#1080#1090#1100
    TabOrder = 10
    OnClick = btDelClick
  end
  object dbnUnits: TDBNavigator
    Left = 0
    Top = 192
    Width = 200
    Height = 25
    DataSource = dsTestUnits
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    TabOrder = 11
  end
  object dbnUnitTags: TDBNavigator
    Left = 208
    Top = 192
    Width = 230
    Height = 25
    DataSource = dsUnitTags
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    TabOrder = 12
  end
  object dbnPlace: TDBNavigator
    Left = 0
    Top = 464
    Width = 200
    Height = 25
    DataSource = dsPlace
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
    TabOrder = 13
  end
  object dbnContact: TDBNavigator
    Left = 208
    Top = 464
    Width = 230
    Height = 25
    DataSource = dsCont
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
    TabOrder = 14
  end
  object adsUnitTags: TADODataSet
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    AfterScroll = adsUnitTagsAfterScroll
    CommandText = 
      'SELECT     unittags.id,unittags.unitid, unittags.tagid, probtags' +
      '.SigTypeID'#13#10'FROM         unittags INNER JOIN'#13#10'                  ' +
      '    probtags ON unittags.tagid = probtags.id'#13#10'WHERE    unittags.' +
      'id not in (select unittag from map)'
    DataSource = dsTestUnits
    IndexFieldNames = 'unitid'
    MasterFields = 'unid'
    Parameters = <>
    Left = 240
    Top = 152
    object adsUnitTagsid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object adsUnitTagsunitid: TIntegerField
      FieldName = 'unitid'
    end
    object adsUnitTagstagid: TIntegerField
      FieldName = 'tagid'
    end
    object adsUnitTagsSigTypeID: TIntegerField
      FieldName = 'SigTypeID'
    end
    object adsUnitTagsprobtag: TStringField
      FieldKind = fkLookup
      FieldName = 'probtag'
      LookupDataSet = tbProbTags
      LookupKeyFields = 'id'
      LookupResultField = 'ProbTag'
      KeyFields = 'tagid'
      Size = 10
      Lookup = True
    end
    object adsUnitTagssigname: TStringField
      FieldKind = fkLookup
      FieldName = 'signame'
      LookupDataSet = tbSigType
      LookupKeyFields = 'sigid'
      LookupResultField = 'sigtag'
      KeyFields = 'SigTypeID'
      Size = 10
      Lookup = True
    end
  end
  object dsTestUnits: TDataSource
    DataSet = qTestUnits
    Left = 40
    Top = 120
  end
  object dsUnitTags: TDataSource
    DataSet = adsUnitTags
    Left = 272
    Top = 152
  end
  object tbProbTags: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    TableName = 'probtags'
    Left = 336
    Top = 152
  end
  object dsPlace: TDataSource
    DataSet = qPlace
    Left = 40
    Top = 368
  end
  object tbPlace: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    TableName = 'places'
    Left = 8
    Top = 368
  end
  object tbSigType: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    TableName = 'signame'
    Left = 304
    Top = 152
  end
  object dsCont: TDataSource
    DataSet = adsCont
    Left = 352
    Top = 272
  end
  object adsCont: TADODataSet
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    OnCalcFields = adsContCalcFields
    CommandText = 
      'SELECT connector.id_place, contact.id_conn, contact.id as contid' +
      ', contact.id_sig, contact.contnum FROM connector INNER JOIN cont' +
      'act ON connector.id = contact.id_conn where contact.id_sig=1 and' +
      ' contact.id   not in (SELECT contid from map)'
    DataSource = dsPlace
    IndexFieldNames = 'id_place'
    MasterFields = 'id'
    Parameters = <>
    Left = 232
    Top = 272
    object adsContid_place: TIntegerField
      FieldName = 'id_place'
    end
    object adsContid_conn: TIntegerField
      FieldName = 'id_conn'
    end
    object adsContcontid: TIntegerField
      FieldName = 'contid'
      ReadOnly = True
    end
    object adsContid_sig: TIntegerField
      FieldName = 'id_sig'
    end
    object adsContcontnum: TIntegerField
      FieldName = 'contnum'
    end
    object adsContconttag: TStringField
      FieldKind = fkCalculated
      FieldName = 'conttag'
      Size = 16
      Calculated = True
    end
    object adsContsigtag: TStringField
      FieldKind = fkLookup
      FieldName = 'sigtag'
      LookupDataSet = tbSigType
      LookupKeyFields = 'sigid'
      LookupResultField = 'sigtag'
      KeyFields = 'id_sig'
      Size = 10
      Lookup = True
    end
  end
  object tbMap: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    TableName = 'map'
    Left = 592
    Top = 72
    object tbMapid: TIntegerField
      FieldName = 'id'
      ReadOnly = True
    end
    object tbMapunittag: TIntegerField
      FieldName = 'unittag'
    end
    object tbMapcontid: TIntegerField
      FieldName = 'contid'
    end
    object tbMapprobtag: TStringField
      FieldKind = fkLookup
      FieldName = 'probtag'
      LookupDataSet = tbUnitTags
      LookupKeyFields = 'id'
      LookupResultField = 'tagname'
      KeyFields = 'unittag'
      Size = 16
      Lookup = True
    end
    object tbMapconttag: TStringField
      FieldKind = fkLookup
      FieldName = 'conttag'
      LookupDataSet = tbCont
      LookupKeyFields = 'id'
      LookupResultField = 'conttag'
      KeyFields = 'contid'
      Size = 16
      Lookup = True
    end
  end
  object dsMap: TDataSource
    DataSet = tbMap
    Left = 624
    Top = 72
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
    Left = 8
    Top = 120
    object qTestUnitsunid: TIntegerField
      FieldName = 'unid'
      ReadOnly = True
    end
    object qTestUnitsunname: TStringField
      FieldName = 'unname'
      Size = 128
    end
  end
  object qPlace: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT places.id, places.placename'
      
        'FROM connector INNER JOIN contact ON connector.id = contact.id_c' +
        'onn INNER JOIN places ON connector.id_place = places.id'
      
        'WHERE (places.id IN (SELECT id_place FROM connector AS connector' +
        '_1 WHERE (contact.id_conn IN (SELECT id_conn FROM contact AS con' +
        'tact_1))))')
    Left = 8
    Top = 400
    object qPlaceid: TIntegerField
      FieldName = 'id'
    end
    object qPlaceplacename: TStringField
      FieldName = 'placename'
      Size = 255
    end
  end
  object qAddDel: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    Left = 488
    Top = 264
  end
  object tbUnitTags: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    LockType = ltReadOnly
    TableName = 'unittags'
    Left = 592
    Top = 104
    object tbUnitTagsid: TIntegerField
      FieldName = 'id'
      ReadOnly = True
    end
    object tbUnitTagsunitid: TIntegerField
      FieldName = 'unitid'
    end
    object tbUnitTagstagid: TIntegerField
      FieldName = 'tagid'
    end
    object tbUnitTagstagname: TStringField
      FieldKind = fkLookup
      FieldName = 'tagname'
      LookupDataSet = tbProbTags
      LookupKeyFields = 'id'
      LookupResultField = 'ProbTag'
      KeyFields = 'tagid'
      Size = 16
      Lookup = True
    end
  end
  object tbCont: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    OnCalcFields = tbContCalcFields
    TableName = 'contact'
    Left = 592
    Top = 136
    object tbContid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object tbContid_conn: TIntegerField
      FieldName = 'id_conn'
    end
    object tbContid_sig: TIntegerField
      FieldName = 'id_sig'
    end
    object tbContcontnum: TIntegerField
      FieldName = 'contnum'
    end
    object tbContsigtag: TStringField
      FieldKind = fkLookup
      FieldName = 'sigtag'
      LookupDataSet = tbSigType
      LookupKeyFields = 'sigid'
      LookupResultField = 'sigtag'
      KeyFields = 'id_sig'
      Size = 10
      Lookup = True
    end
    object tbContconttag: TStringField
      FieldKind = fkCalculated
      FieldName = 'conttag'
      Size = 16
      Calculated = True
    end
  end
  object mnMenu: TMainMenu
    Left = 96
    object N1: TMenuItem
      Caption = #1050#1072#1088#1090#1072
      object mnReportMenu: TMenuItem
        Caption = #1054#1090#1095#1077#1090#1099
        object mnPrint: TMenuItem
          Caption = #1044#1083#1103' '#1087#1077#1095#1072#1090#1080
          OnClick = btReportClick
        end
        object mnReportExcel: TMenuItem
          Caption = #1042' Excel'
          OnClick = btExcelClick
        end
      end
      object mnExcelExport: TMenuItem
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
        OnClick = btExcelClick
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
end
