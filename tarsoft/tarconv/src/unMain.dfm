object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1086#1085#1074#1077#1088#1090#1086#1088' '#1090#1072#1088#1080#1088#1086#1074#1086#1095#1085#1099#1093' '#1090#1072#1073#1083#1080#1094
  ClientHeight = 393
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 400
    Height = 26
    Caption = 
      #1059#1082#1072#1078#1080#1090#1077' '#1087#1072#1087#1082#1091' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1092#1072#1081#1083#1086#1074' '#1085#1072#1089#1090#1088#1086#1077#1082' '#1076#1083#1103' '#1079#1072#1075#1088#1091#1079#1082#1080' '#1074' '#1073#1083#1086#1082 +
      ' '#1040#1057#1048#1059#1058'. '#1048#1079' '#1086#1076#1085#1086#1081' '#1090#1072#1088#1080#1088#1086#1074#1086#1095#1085#1086#1081' '#1090#1072#1073#1083#1080#1094#1099' '#1087#1086#1083#1091#1095#1072#1077#1090#1089#1103' '#1076#1074#1072' '#1092#1072#1081#1083#1072' '#1085#1072#1089#1090#1088 +
      #1086#1077#1082'.'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 24
    Top = 219
    Width = 395
    Height = 26
    Caption = 
      #1055#1088#1077#1092#1080#1082#1089' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1087#1088#1086#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' '#1087#1077#1088#1077#1076' '#1085#1086#1084#1077#1088#1086#1084' '#1073#1083#1086#1082#1072' '#1074' '#1080#1084#1077#1085#1080' ' +
      #1092#1072#1081#1083#1072' '#1085#1072#1089#1090#1088#1086#1077#1082'.'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 24
    Top = 269
    Width = 325
    Height = 13
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' ('#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099' '#1080' '#1090#1072#1088#1080#1088#1086#1074#1082#1072' '#1073#1072#1082#1072')'
  end
  object btConver: TButton
    Left = 353
    Top = 138
    Width = 80
    Height = 25
    Caption = #1054#1073#1079#1086#1088
    TabOrder = 0
    OnClick = btConverClick
  end
  object leFolder: TLabeledEdit
    Left = 24
    Top = 140
    Width = 323
    Height = 21
    EditLabel.Width = 119
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103':'
    TabOrder = 1
  end
  object lePrefix: TLabeledEdit
    Left = 24
    Top = 184
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
    OnClick = btTarFileClick
  end
  object btAdvSettings: TButton
    Left = 353
    Top = 264
    Width = 80
    Height = 25
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 5
    OnClick = btAdvSettingsClick
  end
  object btConvert: TButton
    Left = 158
    Top = 344
    Width = 137
    Height = 25
    Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100'!'
    TabOrder = 6
    OnClick = btConvertClick
  end
  object cbSaveSettings: TCheckBox
    Left = 24
    Top = 304
    Width = 161
    Height = 17
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1091#1090#1100' '#1080' '#1087#1088#1077#1092#1080#1082#1089'.'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object odXLSFile: TOpenDialog
    FileName = 
      'E:\proj\stat\tarprog\'#1058#1072#1088#1080#1088#1086#1074#1082#1072' '#1076#1083#1103' 2'#1058#1069'116 '#8470'0140 (192, 193 '#1082#1086#1084#1087#1083#1077 +
      #1082#1090').xls'
    Filter = #1060#1072#1081#1083#1099' '#1090#1072#1088#1080#1088#1086#1074#1086#1082' (*.xls)|*.xls'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
    Left = 256
    Top = 48
  end
end
