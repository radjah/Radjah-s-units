object fmName: TfmName
  Left = 192
  Top = 122
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1042#1074#1086#1076' '#1089#1090#1088#1086#1082#1086#1074#1086#1075#1086' '#1079#1085#1072#1095#1077#1085#1080#1103
  ClientHeight = 118
  ClientWidth = 416
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
  object btOK: TButton
    Left = 80
    Top = 80
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btOKClick
  end
  object btCancel: TButton
    Left = 176
    Top = 80
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = btCancelClick
  end
  object btHelp: TButton
    Left = 272
    Top = 80
    Width = 75
    Height = 25
    Caption = #1057#1087#1088#1072#1074#1082#1072
    TabOrder = 2
    OnClick = btHelpClick
  end
  object gbString: TGroupBox
    Left = 24
    Top = 8
    Width = 369
    Height = 65
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077
    TabOrder = 3
    object edName: TEdit
      Left = 16
      Top = 24
      Width = 337
      Height = 21
      TabOrder = 0
    end
  end
end
