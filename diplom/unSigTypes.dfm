object fmSigTypes: TfmSigTypes
  Left = 192
  Top = 114
  Width = 747
  Height = 510
  Caption = #1058#1080#1087#1099' '#1089#1080#1075#1085#1072#1083#1086#1074
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
  object DBGrid1: TDBGrid
    Left = 8
    Top = 48
    Width = 705
    Height = 281
    DataSource = dsSig
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'sigtag'
        Title.Caption = #1058#1077#1075
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'signame'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 600
        Visible = True
      end>
  end
  object gbNew: TGroupBox
    Left = 8
    Top = 336
    Width = 713
    Height = 121
    Caption = #1053#1086#1074#1099#1081' '#1090#1077#1075
    TabOrder = 1
    object leTag: TLabeledEdit
      Left = 8
      Top = 40
      Width = 73
      Height = 21
      EditLabel.Width = 18
      EditLabel.Height = 13
      EditLabel.Caption = #1058#1077#1075
      MaxLength = 10
      TabOrder = 0
    end
    object leName: TLabeledEdit
      Left = 88
      Top = 40
      Width = 593
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      TabOrder = 1
    end
    object btAdd: TButton
      Left = 240
      Top = 80
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 2
      OnClick = btAddClick
    end
    object btHelp: TButton
      Left = 352
      Top = 80
      Width = 75
      Height = 25
      Caption = #1057#1087#1088#1072#1074#1082#1072
      TabOrder = 3
      OnClick = btHelpClick
    end
  end
  object dsSig: TDataSource
    DataSet = qSig
    Left = 288
    Top = 16
  end
  object qSig: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from signame')
    Left = 320
    Top = 16
  end
  object qSigAdd: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    Left = 352
    Top = 16
  end
end
