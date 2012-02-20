object fmAddSigGroup: TfmAddSigGroup
  Left = 237
  Top = 235
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'fmAddSigGroup'
  ClientHeight = 150
  ClientWidth = 783
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
    Top = 48
    Width = 66
    Height = 13
    Caption = #1058#1080#1087' '#1089#1080#1075#1085#1072#1083#1072':'
  end
  object Label2: TLabel
    Left = 616
    Top = 48
    Width = 62
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
  end
  object dbcbSig: TDBLookupComboBox
    Left = 16
    Top = 64
    Width = 593
    Height = 21
    KeyField = 'sigid'
    ListField = 'sig'
    ListSource = dsSig
    TabOrder = 0
  end
  object eQuant: TEdit
    Left = 616
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btAdd: TButton
    Left = 336
    Top = 112
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = btAddClick
  end
  object btHelp: TButton
    Left = 424
    Top = 112
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 3
    OnClick = btHelpClick
  end
  object qSigName: TADOQuery
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    OnCalcFields = qSigNameCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT signame.*,sysconf.sigquant'
      '  FROM signame,sysconf'
      ' WHERE sysconf.sigquant>0 and sysconf.sigid=signame.sigid'
      'ORDER BY signame')
    object qSigNamesigtag: TStringField
      FieldName = 'sigtag'
      Size = 10
    end
    object qSigNamesigname: TStringField
      FieldName = 'signame'
      Size = 255
    end
    object qSigNamesigquant: TIntegerField
      FieldName = 'sigquant'
    end
    object qSigNamesig: TStringField
      FieldKind = fkCalculated
      FieldName = 'sig'
      Size = 255
      Calculated = True
    end
    object qSigNamesigid: TAutoIncField
      FieldName = 'sigid'
      ReadOnly = True
    end
  end
  object qAdd: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    Left = 32
  end
  object dsSig: TDataSource
    DataSet = qSigName
    Left = 64
  end
end
