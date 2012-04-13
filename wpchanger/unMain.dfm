object fmMain: TfmMain
  Left = 219
  Top = 154
  Width = 237
  Height = 152
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1052#1077#1085#1103#1083#1082#1072' '#1086#1073#1086#1077#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button2: TButton
    Left = 8
    Top = 8
    Width = 209
    Height = 49
    Caption = #1057#1084#1077#1085#1080#1090#1100
    TabOrder = 0
    OnClick = Button2Click
  end
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 64
    Width = 193
    Height = 49
    Caption = #1060#1086#1088#1084#1072#1090
    TabOrder = 1
  end
  object RadioButton1: TRadioButton
    Left = 88
    Top = 80
    Width = 49
    Height = 17
    Caption = 'BMP'
    TabOrder = 2
  end
  object RadioButton2: TRadioButton
    Left = 32
    Top = 80
    Width = 57
    Height = 17
    Caption = 'JPEG'
    Checked = True
    TabOrder = 3
    TabStop = True
  end
  object RadioButton3: TRadioButton
    Left = 144
    Top = 80
    Width = 57
    Height = 17
    Caption = 'PNG'
    TabOrder = 4
  end
  object XPManifest1: TXPManifest
    Left = 40
    Top = 8
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 8
    Top = 8
  end
end
