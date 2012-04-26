object fmAdvSettings: TfmAdvSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 653
  ClientWidth = 654
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 301
    Height = 13
    Caption = #1069#1090#1080' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1086#1073#1099#1095#1085#1086' '#1085#1077' '#1080#1079#1084#1077#1085#1103#1102#1090#1089#1103' '#1086#1090' '#1087#1072#1088#1090#1080#1080' '#1082' '#1087#1072#1088#1090#1080#1080'.'
  end
  object Label3: TLabel
    Left = 8
    Top = 45
    Width = 195
    Height = 13
    Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1080' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1086#1074' '#1092#1080#1083#1100#1090#1088#1086#1074':'
  end
  object gb1Sensor: TGroupBox
    Left = 8
    Top = 64
    Width = 201
    Height = 202
    Caption = #1044#1072#1090#1095#1080#1082' '#1076#1072#1074#1083#1077#1085#1080#1103' '#8470'1'
    TabOrder = 1
    object le1Median: TLabeledEdit
      Left = 16
      Top = 88
      Width = 121
      Height = 21
      EditLabel.Width = 63
      EditLabel.Height = 13
      EditLabel.Caption = #1052#1077#1076#1080#1072#1085#1085#1099#1081':'
      TabOrder = 1
      Text = '1'
    end
    object le1Kalman: TLabeledEdit
      Left = 16
      Top = 136
      Width = 121
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1072#1083#1100#1084#1072#1085#1072':'
      TabOrder = 2
      Text = '1'
    end
    object ud1Kalman: TUpDown
      Left = 137
      Top = 136
      Width = 16
      Height = 21
      Associate = le1Kalman
      Min = 1
      Position = 1
      TabOrder = 0
    end
    object ud1Median: TUpDown
      Left = 137
      Top = 88
      Width = 16
      Height = 21
      Associate = le1Median
      Min = 1
      Position = 1
      TabOrder = 3
    end
  end
  object gb2Sensor: TGroupBox
    Left = 223
    Top = 64
    Width = 201
    Height = 202
    Caption = #1044#1072#1090#1095#1080#1082' '#1076#1072#1074#1083#1077#1085#1080#1103' '#8470'2'
    TabOrder = 2
    object le2Median: TLabeledEdit
      Left = 16
      Top = 88
      Width = 121
      Height = 21
      EditLabel.Width = 63
      EditLabel.Height = 13
      EditLabel.Caption = #1052#1077#1076#1080#1072#1085#1085#1099#1081':'
      TabOrder = 1
      Text = '1'
    end
    object le2Kalman: TLabeledEdit
      Left = 16
      Top = 136
      Width = 121
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1072#1083#1100#1084#1072#1085#1072':'
      TabOrder = 2
      Text = '1'
    end
    object ud2Median: TUpDown
      Left = 137
      Top = 88
      Width = 16
      Height = 21
      Associate = le2Median
      Min = 1
      Position = 1
      TabOrder = 3
    end
    object ud2Kalman: TUpDown
      Left = 137
      Top = 136
      Width = 16
      Height = 21
      Associate = le2Kalman
      Min = 1
      Position = 1
      TabOrder = 4
    end
    object le2Aperture: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = #1040#1087#1077#1088#1090#1091#1088#1072':'
      TabOrder = 0
      Text = '1'
    end
  end
  object gbTSensor: TGroupBox
    Left = 440
    Top = 64
    Width = 201
    Height = 202
    Caption = #1044#1072#1090#1095#1080#1082' '#1090#1077#1087#1077#1088#1072#1090#1091#1088#1099
    TabOrder = 3
    object leTMedian: TLabeledEdit
      Left = 16
      Top = 88
      Width = 121
      Height = 21
      EditLabel.Width = 63
      EditLabel.Height = 13
      EditLabel.Caption = #1052#1077#1076#1080#1072#1085#1085#1099#1081':'
      TabOrder = 1
      Text = '1'
    end
    object leTKalman: TLabeledEdit
      Left = 16
      Top = 136
      Width = 121
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1072#1083#1100#1084#1072#1085#1072':'
      TabOrder = 2
      Text = '1'
    end
    object udTMedian: TUpDown
      Left = 137
      Top = 88
      Width = 16
      Height = 21
      Associate = leTMedian
      Min = 1
      Position = 1
      TabOrder = 3
    end
    object udTKalman: TUpDown
      Left = 137
      Top = 136
      Width = 16
      Height = 21
      Associate = leTKalman
      Min = 1
      Position = 1
      TabOrder = 4
    end
    object leTAperture: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = #1040#1087#1077#1088#1090#1091#1088#1072':'
      TabOrder = 0
      Text = '1'
    end
    object UpDown3: TUpDown
      Left = 217
      Top = 13
      Width = 16
      Height = 21
      Associate = leTAperture
      Min = 1
      Position = 1
      TabOrder = 5
    end
  end
  object gbFuel: TGroupBox
    Left = 8
    Top = 272
    Width = 633
    Height = 321
    Caption = #1058#1072#1088#1080#1088#1086#1074#1082#1072' '#1073#1072#1082#1072
    TabOrder = 4
    object Label1: TLabel
      Left = 176
      Top = 21
      Width = 52
      Height = 13
      Caption = #1047#1085#1072#1095#1077#1085#1080#1103':'
    end
    object lePoinsCount: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 93
      EditLabel.Height = 13
      EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1086#1095#1077#1082
      NumbersOnly = True
      TabOrder = 0
      Text = '2'
    end
    object udPointsCount: TUpDown
      Left = 137
      Top = 40
      Width = 16
      Height = 21
      Associate = lePoinsCount
      Min = 2
      Position = 2
      TabOrder = 1
    end
    object btSetFuelPoints: TButton
      Left = 16
      Top = 80
      Width = 137
      Height = 25
      Caption = #1047#1072#1076#1072#1090#1100
      TabOrder = 2
      OnClick = btSetFuelPointsClick
    end
    object sgFuel: TStringGrid
      Left = 176
      Top = 40
      Width = 441
      Height = 265
      ColCount = 3
      RowCount = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      ParentFont = False
      TabOrder = 3
    end
  end
  object btSave: TButton
    Left = 239
    Top = 608
    Width = 177
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 5
    OnClick = btSaveClick
  end
  object le1Aperture: TLabeledEdit
    Left = 24
    Top = 104
    Width = 121
    Height = 21
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = #1040#1087#1077#1088#1090#1091#1088#1072':'
    TabOrder = 0
    Text = '1'
  end
end
