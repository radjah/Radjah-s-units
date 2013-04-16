object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = #1041#1080#1088#1082#1080' '#1085#1072' '#1040#1057#1048#1059#1058
  ClientHeight = 183
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object gbBlock: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 81
    Caption = #1041#1080#1088#1082#1080' '#1085#1072' '#1073#1083#1086#1082#1080
    TabOrder = 0
    object leBlock: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 76
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1077#1088#1074#1099#1081' '#1085#1086#1084#1077#1088':'
      TabOrder = 0
    end
    object btMakeBlock: TButton
      Left = 160
      Top = 38
      Width = 121
      Height = 25
      Caption = #1057#1086#1079#1076#1072#1090#1100
      TabOrder = 1
    end
  end
  object gbSensor: TGroupBox
    Left = 8
    Top = 95
    Width = 305
    Height = 82
    Caption = #1041#1080#1088#1082#1080' '#1085#1072' '#1076#1072#1090#1095#1080#1082#1080
    TabOrder = 1
    object leSensor: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 76
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1077#1088#1074#1099#1081' '#1085#1086#1084#1077#1088':'
      TabOrder = 0
    end
    object btMakeSensor: TButton
      Left = 160
      Top = 38
      Width = 121
      Height = 25
      Caption = #1057#1086#1079#1076#1072#1090#1100
      TabOrder = 1
    end
  end
  object sdDoc: TSaveDialog
    DefaultExt = '*.doc'
    Filter = #1044#1086#1082#1091#1084#1077#1085#1090#1099' Word|*.doc'
    Left = 176
    Top = 1
  end
end
