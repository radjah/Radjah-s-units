object btAdvSettings: TbtAdvSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 613
  ClientWidth = 654
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 301
    Height = 13
    Caption = #1069#1090#1080' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1086#1073#1099#1095#1085#1086' '#1085#1077' '#1080#1079#1084#1077#1085#1103#1102#1090#1089#1103' '#1086#1090' '#1087#1072#1088#1090#1080#1080' '#1082' '#1087#1072#1088#1090#1080#1080'.'
  end
  object gb1Sensor: TGroupBox
    Left = 8
    Top = 40
    Width = 201
    Height = 209
    Caption = #1044#1072#1090#1095#1080#1082' '#1076#1072#1074#1083#1077#1085#1080#1103' '#8470'1'
    TabOrder = 0
  end
  object gb2Sensor: TGroupBox
    Left = 224
    Top = 40
    Width = 201
    Height = 209
    Caption = #1044#1072#1090#1095#1080#1082' '#1076#1072#1074#1083#1077#1085#1080#1103' '#8470'2'
    TabOrder = 1
  end
  object gbTSensor: TGroupBox
    Left = 440
    Top = 40
    Width = 201
    Height = 209
    Caption = #1044#1072#1090#1095#1080#1082' '#1090#1077#1087#1077#1088#1072#1090#1091#1088#1099
    TabOrder = 2
  end
  object gbFuel: TGroupBox
    Left = 8
    Top = 264
    Width = 633
    Height = 289
    Caption = #1058#1072#1088#1080#1088#1086#1074#1082#1072' '#1073#1072#1082#1072
    TabOrder = 3
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
    object Button1: TButton
      Left = 16
      Top = 80
      Width = 137
      Height = 25
      Caption = #1047#1072#1076#1072#1090#1100
      TabOrder = 2
      OnClick = Button1Click
    end
    object sgFuel: TStringGrid
      Left = 176
      Top = 40
      Width = 441
      Height = 233
      ColCount = 3
      RowCount = 3
      TabOrder = 3
    end
  end
  object btSave: TButton
    Left = 224
    Top = 568
    Width = 177
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 4
  end
end
