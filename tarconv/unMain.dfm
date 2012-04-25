object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = #1050#1086#1085#1074#1077#1088#1090#1086#1088' '#1090#1072#1088#1080#1088#1086#1074#1086#1095#1085#1099#1093' '#1090#1072#1073#1083#1080#1094
  ClientHeight = 494
  ClientWidth = 452
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 401
    Height = 33
    Caption = 
      #1059#1082#1072#1078#1080#1090#1077' '#1087#1072#1087#1082#1091' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1092#1072#1081#1083#1086#1074' '#1085#1072#1089#1090#1088#1086#1077#1082' '#1076#1083#1103' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1074' '#1073#1083#1086#1082 +
      ' '#1040#1057#1048#1059#1058'. '#1048#1079' '#1086#1076#1085#1086#1081' '#1090#1072#1088#1080#1088#1086#1074#1086#1095#1085#1086#1081' '#1090#1072#1073#1083#1080#1094#1099' '#1087#1086#1083#1091#1095#1072#1077#1090#1089#1103' '#1076#1074#1072' '#1092#1072#1081#1083#1072' '#1085#1072#1089#1090#1088 +
      #1086#1077#1082'.'
    WordWrap = True
  end
  object btConver: TButton
    Left = 353
    Top = 152
    Width = 80
    Height = 25
    Caption = #1054#1073#1079#1086#1088
    TabOrder = 0
    OnClick = btConverClick
  end
  object leFolder: TLabeledEdit
    Left = 24
    Top = 154
    Width = 323
    Height = 21
    EditLabel.Width = 119
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103':'
    TabOrder = 1
  end
  object lePrefix: TLabeledEdit
    Left = 24
    Top = 200
    Width = 323
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1088#1077#1092#1080#1082#1089':'
    TabOrder = 2
  end
  object leTarFile: TLabeledEdit
    Left = 24
    Top = 96
    Width = 323
    Height = 21
    EditLabel.Width = 107
    EditLabel.Height = 13
    EditLabel.Caption = #1060#1072#1081#1083' '#1089' '#1090#1072#1088#1080#1088#1086#1074#1082#1072#1084#1080':'
    TabOrder = 3
  end
  object btTarFile: TButton
    Left = 353
    Top = 94
    Width = 80
    Height = 25
    Caption = #1054#1073#1079#1086#1088
    TabOrder = 4
  end
  object odXLSFile: TOpenDialog
    Left = 256
    Top = 48
  end
end
