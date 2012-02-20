object fmNewDig: TfmNewDig
  Left = 192
  Top = 122
  Width = 336
  Height = 168
  Caption = #1042#1074#1086#1076' '#1095#1080#1089#1083#1086#1074#1086#1075#1086' '#1079#1085#1072#1095#1077#1085#1080#1103
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
  object gbDig: TGroupBox
    Left = 24
    Top = 16
    Width = 273
    Height = 65
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1080#1083#1080' '#1074#1099#1073#1077#1088#1080#1090#1077' '#1095#1080#1089#1083#1086#1074#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
    TabOrder = 0
    object cbDig: TComboBox
      Left = 16
      Top = 24
      Width = 241
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = '100'
      Items.Strings = (
        '10'
        '50'
        '100'
        '200'
        '300'
        '400'
        '500')
    end
  end
  object btOK: TButton
    Left = 24
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btOKClick
  end
  object btCancel: TButton
    Left = 120
    Top = 96
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btCancelClick
  end
  object btHelp: TButton
    Left = 216
    Top = 96
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 3
    OnClick = btHelpClick
  end
end
