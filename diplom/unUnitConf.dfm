object fmUnitConf: TfmUnitConf
  Left = 182
  Top = 129
  Width = 1100
  Height = 622
  Caption = 'fmUnitConf'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 88
    Width = 95
    Height = 13
    Caption = #1058#1077#1075#1080' '#1074#1086#1079#1076#1077#1081#1089#1090#1074#1080#1081':'
  end
  object Label2: TLabel
    Left = 448
    Top = 8
    Width = 85
    Height = 13
    Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1090#1077#1075#1080':'
  end
  object Label3: TLabel
    Left = 16
    Top = 448
    Width = 96
    Height = 13
    Caption = #1057#1080#1075#1085#1072#1083#1099' '#1087#1086' '#1090#1080#1087#1072#1084':'
  end
  object dbgUnitTags: TDBGrid
    Left = 8
    Top = 104
    Width = 353
    Height = 337
    DataSource = dsUnitConf
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
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tagname'
        Title.Caption = #1058#1077#1075' '#1074#1086#1079#1076#1077#1081#1089#1090#1074#1080#1103
        Width = 100
        Visible = True
      end>
  end
  object dbgTags: TDBGrid
    Left = 450
    Top = 104
    Width = 625
    Height = 473
    DataSource = dsProbTags
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ProbTag'
        Title.Caption = #1058#1077#1075
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ProbName'
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1074#1086#1079#1076#1077#1081#1089#1090#1074#1080#1103
        Width = 450
        Visible = True
      end>
  end
  object btAdd: TButton
    Left = 368
    Top = 208
    Width = 75
    Height = 25
    Caption = '< '#1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = btAddClick
  end
  object btDel: TButton
    Left = 368
    Top = 248
    Width = 75
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' >'
    TabOrder = 3
    OnClick = btDelClick
  end
  object gbSearch: TGroupBox
    Left = 440
    Top = 24
    Width = 553
    Height = 73
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 4
    object leByTag: TLabeledEdit
      Left = 24
      Top = 32
      Width = 57
      Height = 21
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1086' '#1090#1077#1075#1091':'
      TabOrder = 0
      OnChange = leByTagChange
    end
    object leByName: TLabeledEdit
      Left = 88
      Top = 32
      Width = 449
      Height = 21
      EditLabel.Width = 96
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102':'
      TabOrder = 1
      OnChange = leByNameChange
    end
  end
  object dbgSigs: TDBGrid
    Left = 8
    Top = 464
    Width = 353
    Height = 120
    DataSource = dsSigQuant
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'SigType'
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
  object btHelp: TButton
    Left = 368
    Top = 288
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 6
    OnClick = btHelpClick
  end
  object tbProbTags: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    TableName = 'probtags'
    Left = 408
    Top = 136
    object tbProbTagsid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object tbProbTagsProbName: TStringField
      FieldName = 'ProbName'
      Size = 255
    end
    object tbProbTagsProbTag: TStringField
      FieldName = 'ProbTag'
      Size = 10
    end
    object tbProbTagsSigTypeID: TIntegerField
      FieldName = 'SigTypeID'
    end
    object tbProbTagsSigType: TStringField
      FieldName = 'SigType'
      Size = 10
    end
  end
  object qUnitConf: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT unittags.id as id,probtags.ProbTag as tagname'
      '  FROM unittags,probtags'
      'WHERE  unittags.tagid=probtags.id and unitid=1')
    Left = 376
    Top = 136
    object qUnitConfid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object qUnitConftagname: TStringField
      FieldName = 'tagname'
      Size = 10
    end
  end
  object dsUnitConf: TDataSource
    DataSet = qUnitConf
    Left = 376
    Top = 168
  end
  object dsProbTags: TDataSource
    DataSet = tbProbTags
    Left = 408
    Top = 168
  end
  object ADOQuery: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    Left = 376
    Top = 104
  end
  object qSigQuant: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT probtags.SigType,COUNT(probtags.SigTypeid) as sigcount'
      '  FROM probtags'
      
        ' WHERE id in (SELECT tagid FROM unittags where unittags.unitid=1' +
        ')'
      'GROUP BY probtags.SigType')
    Left = 376
    Top = 72
    object qSigQuantSigType: TStringField
      FieldName = 'SigType'
      Size = 10
    end
    object qSigQuantsigcount: TIntegerField
      FieldName = 'sigcount'
      ReadOnly = True
    end
  end
  object dsSigQuant: TDataSource
    DataSet = qSigQuant
    Left = 408
    Top = 72
  end
end
