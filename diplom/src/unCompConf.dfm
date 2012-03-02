object fmCompConf: TfmCompConf
  Left = 192
  Top = 122
  Width = 514
  Height = 500
  Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' '#1080#1089#1087#1099#1090#1099#1074#1072#1077#1084#1086#1075#1086' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnMain
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object dbgUnits: TDBGrid
    Left = 16
    Top = 40
    Width = 465
    Height = 401
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
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 350
        Visible = True
      end>
  end
  object btAdd: TButton
    Left = 16
    Top = 8
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 1
    OnClick = mnAddClick
  end
  object btDel: TButton
    Left = 96
    Top = 8
    Width = 75
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 2
    OnClick = mnRemoveClick
  end
  object btTags: TButton
    Left = 176
    Top = 8
    Width = 75
    Height = 25
    Caption = #1058#1077#1075#1080
    TabOrder = 3
    OnClick = mnAddTagsClick
  end
  object mnMain: TMainMenu
    Left = 408
    object mnUnits: TMenuItem
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      object mnAdd: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        OnClick = mnAddClick
      end
      object mnRemove: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        OnClick = mnRemoveClick
      end
      object mnAddTags: TMenuItem
        Caption = #1059#1082#1072#1079#1072#1090#1100' '#1090#1077#1075#1080
        OnClick = mnAddTagsClick
      end
      object N1: TMenuItem
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
  object tbUnit: TADOTable
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    TableName = 'testunits'
    Left = 440
    object tbUnitunid: TAutoIncField
      FieldName = 'unid'
      ReadOnly = True
    end
    object tbUnitunname: TStringField
      FieldName = 'unname'
      Size = 128
    end
  end
  object dsUnits: TDataSource
    DataSet = tbUnit
    Left = 472
  end
  object ADOQuery: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    Left = 376
  end
end
