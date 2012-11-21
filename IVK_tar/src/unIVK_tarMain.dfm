object fmIVK_tarMain: TfmIVK_tarMain
  Left = 0
  Top = 0
  Caption = #1058#1072#1088#1080#1088#1086#1074#1082#1072' '#1082#1072#1089#1089#1077#1090#1099
  ClientHeight = 534
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 289
    Height = 505
    Caption = #1058#1072#1073#1083#1080#1094#1072' '#1079#1085#1072#1095#1077#1085#1080#1081
    TabOrder = 0
    object leCount: TLabeledEdit
      Left = 18
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 108
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1072#1084#1077#1088#1086#1074':'
      TabOrder = 0
      Text = '3'
    end
    object btSet: TButton
      Left = 175
      Top = 38
      Width = 98
      Height = 25
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
      TabOrder = 1
      OnClick = btSetClick
    end
    object sgData: TStringGrid
      Left = 16
      Top = 69
      Width = 257
      Height = 425
      ColCount = 3
      DefaultRowHeight = 18
      RowCount = 4
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      TabOrder = 2
    end
    object udCount: TUpDown
      Left = 139
      Top = 40
      Width = 16
      Height = 21
      Associate = leCount
      Min = 3
      Position = 3
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 303
    Top = 8
    Width = 313
    Height = 505
    Caption = #1056#1072#1089#1095#1077#1090
    TabOrder = 1
    object btCalc: TButton
      Left = 16
      Top = 38
      Width = 97
      Height = 25
      Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
      TabOrder = 0
      OnClick = btCalcClick
    end
    object sgResult: TStringGrid
      Left = 15
      Top = 69
      Width = 134
      Height = 80
      ColCount = 2
      DefaultRowHeight = 18
      RowCount = 4
      TabOrder = 1
    end
    object cbAddit: TCheckBox
      Left = 16
      Top = 274
      Width = 209
      Height = 17
      Caption = #1055#1086#1087#1088#1072#1074#1086#1095#1085#1099#1081' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1088#1080' a*x'
      TabOrder = 2
      Visible = False
      OnClick = cbAdditClick
    end
    object leAddit: TLabeledEdit
      Left = 16
      Top = 309
      Width = 121
      Height = 21
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = #1047#1085#1072#1095#1077#1085#1080#1077
      Enabled = False
      TabOrder = 3
      Visible = False
    end
  end
end
