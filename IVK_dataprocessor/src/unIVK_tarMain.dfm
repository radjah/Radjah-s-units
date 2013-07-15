object fmIVK_tarMain: TfmIVK_tarMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1058#1072#1088#1080#1088#1086#1074#1082#1072' '#1082#1072#1089#1089#1077#1090#1099
  ClientHeight = 536
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
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
      Height = 380
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
    object btSave: TButton
      Left = 16
      Top = 455
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 4
      OnClick = btSaveClick
    end
    object btLoad: TButton
      Left = 112
      Top = 455
      Width = 75
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
      TabOrder = 5
      OnClick = btLoadClick
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
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 1
    end
  end
  object odTar: TOpenDialog
    DefaultExt = 'ini'
    Filter = #1058#1072#1073#1083#1080#1094#1072' '#1079#1085#1072#1095#1077#1085#1080#1081' (*.ini)|*.ini'
    Options = [ofEnableSizing]
    Left = 216
    Top = 464
  end
  object sdTar: TSaveDialog
    DefaultExt = 'ini'
    Filter = #1058#1072#1073#1083#1080#1094#1072' '#1079#1085#1072#1095#1077#1085#1080#1081' (*.ini)|*.ini'
    Left = 264
    Top = 464
  end
end
