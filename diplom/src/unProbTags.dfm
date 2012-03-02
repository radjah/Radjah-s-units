object fmProbTags: TfmProbTags
  Left = 251
  Top = 129
  Width = 720
  Height = 624
  Caption = #1058#1077#1075#1080' '#1074#1086#1079#1076#1077#1081#1089#1090#1074#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 24
    Top = 16
    Width = 153
    Height = 13
    Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1090#1077#1075#1080' '#1074#1086#1079#1076#1077#1081#1089#1090#1074#1080#1081':'
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 32
    Width = 681
    Height = 425
    DataSource = dsTags
    TabOrder = 0
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
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 500
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sigtag'
        Title.Caption = #1058#1080#1087
        Visible = True
      end>
  end
  object gbAdd: TGroupBox
    Left = 8
    Top = 464
    Width = 681
    Height = 121
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1077#1075
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 18
      Height = 13
      Caption = #1058#1077#1075
    end
    object Label3: TLabel
      Left = 88
      Top = 32
      Width = 76
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    end
    object Label4: TLabel
      Left = 592
      Top = 32
      Width = 63
      Height = 13
      Caption = #1058#1080#1087' '#1089#1080#1075#1085#1072#1083#1072
    end
    object eTag: TEdit
      Left = 16
      Top = 48
      Width = 65
      Height = 21
      TabOrder = 0
    end
    object eName: TEdit
      Left = 88
      Top = 48
      Width = 497
      Height = 21
      TabOrder = 1
    end
    object btAdd: TButton
      Left = 256
      Top = 88
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 2
      OnClick = btAddClick
    end
    object cbSigType: TDBLookupComboBox
      Left = 592
      Top = 48
      Width = 73
      Height = 21
      KeyField = 'sigid'
      ListField = 'sigtag'
      ListSource = dsSigType
      TabOrder = 3
    end
    object btHelp: TButton
      Left = 352
      Top = 88
      Width = 75
      Height = 25
      Caption = #1057#1087#1088#1072#1074#1082#1072
      TabOrder = 4
      OnClick = btHelpClick
    end
  end
  object tbTags: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    TableName = 'probtags'
    Left = 224
    object tbTagsid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object tbTagsProbName: TStringField
      FieldName = 'ProbName'
      Size = 255
    end
    object tbTagsProbTag: TStringField
      FieldName = 'ProbTag'
      Size = 10
    end
    object tbTagsSigTypeID: TIntegerField
      FieldName = 'SigTypeID'
    end
    object tbTagssigtag: TStringField
      FieldKind = fkLookup
      FieldName = 'sigtag'
      LookupDataSet = tbSigName
      LookupKeyFields = 'sigid'
      LookupResultField = 'sigtag'
      KeyFields = 'SigTypeID'
      Size = 10
      Lookup = True
    end
  end
  object dsTags: TDataSource
    DataSet = tbTags
    Left = 256
  end
  object tbSigName: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    TableName = 'signame'
    Left = 288
  end
  object dsSigType: TDataSource
    DataSet = tbSigName
    Left = 624
    Top = 536
  end
end
