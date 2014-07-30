object fmMain: TfmMain
  Left = 322
  Top = 317
  Width = 639
  Height = 453
  Caption = 'COM-'#1087#1086#1088#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mPorts: TMemo
    Left = 40
    Top = 32
    Width = 185
    Height = 217
    TabOrder = 0
  end
  object btGetPorts: TButton
    Left = 240
    Top = 32
    Width = 97
    Height = 25
    Caption = #1055#1086#1088#1090#1099
    TabOrder = 1
    OnClick = btGetPortsClick
  end
  object cbPortSelect: TComboBox
    Left = 240
    Top = 64
    Width = 97
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
  object btOpen: TButton
    Left = 240
    Top = 96
    Width = 97
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = btOpenClick
  end
  object btClose: TButton
    Left = 240
    Top = 128
    Width = 97
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Enabled = False
    TabOrder = 4
    OnClick = btCloseClick
  end
  object mMeasure: TMemo
    Left = 352
    Top = 40
    Width = 193
    Height = 217
    ScrollBars = ssVertical
    TabOrder = 5
  end
end
