object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1074#1091#1093#1092#1072#1082#1090#1086#1088#1085#1099#1081' '#1072#1085#1072#1083#1080#1079
  ClientHeight = 757
  ClientWidth = 562
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
  object gbSaveLoad: TGroupBox
    Left = 8
    Top = 8
    Width = 226
    Height = 145
    Caption = #1044#1072#1085#1085#1099#1077
    TabOrder = 0
    object btLoad: TBitBtn
      Left = 16
      Top = 27
      Width = 89
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
      DoubleBuffered = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        555555555555555555555555555555555555555FFFFFFFFFF555550000000000
        55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
        B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
        000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
        555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
        55555575FFF75555555555700007555555555557777555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = btLoadClick
    end
    object btSave: TBitBtn
      Left = 111
      Top = 27
      Width = 89
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      DoubleBuffered = True
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = btSaveClick
    end
    object pbSaveLoad: TProgressBar
      Left = 16
      Top = 86
      Width = 184
      Height = 25
      Step = 1
      TabOrder = 2
    end
  end
  object gbParam: TGroupBox
    Left = 240
    Top = 8
    Width = 313
    Height = 145
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 1
    object lA: TLabel
      Left = 16
      Top = 18
      Width = 11
      Height = 13
      Caption = 'A:'
    end
    object lB: TLabel
      Left = 16
      Top = 60
      Width = 10
      Height = 13
      Caption = 'B:'
    end
    object eA: TEdit
      Left = 16
      Top = 37
      Width = 43
      Height = 21
      TabOrder = 0
      Text = '2'
    end
    object eB: TEdit
      Left = 16
      Top = 79
      Width = 43
      Height = 21
      TabOrder = 1
      Text = '2'
    end
    object udA: TUpDown
      Left = 59
      Top = 37
      Width = 16
      Height = 21
      Associate = eA
      Min = 2
      Position = 2
      TabOrder = 2
    end
    object udB: TUpDown
      Left = 59
      Top = 79
      Width = 16
      Height = 21
      Associate = eB
      Min = 2
      Position = 2
      TabOrder = 3
    end
    object btCreate: TButton
      Left = 184
      Top = 113
      Width = 113
      Height = 25
      Caption = #1047#1072#1076#1072#1090#1100
      TabOrder = 4
      OnClick = btCreateClick
    end
    object btRaname: TButton
      Left = 16
      Top = 113
      Width = 121
      Height = 25
      Caption = #1053#1072#1079#1074#1072#1085#1080#1103
      TabOrder = 5
      OnClick = btRanameClick
    end
  end
  object gbData: TGroupBox
    Left = 8
    Top = 159
    Width = 545
    Height = 362
    Caption = #1047#1085#1072#1095#1077#1085#1080#1103
    TabOrder = 2
    object sbData: TScrollBox
      Left = 16
      Top = 24
      Width = 513
      Height = 321
      TabOrder = 0
    end
  end
  object gbLog: TGroupBox
    Left = 8
    Top = 527
    Width = 273
    Height = 218
    Caption = #1055#1088#1086#1090#1086#1082#1086#1083' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'.'
    TabOrder = 3
    object mLog: TMemo
      Left = 16
      Top = 26
      Width = 243
      Height = 151
      Lines.Strings = (
        'mLog')
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object btClear: TButton
      Left = 99
      Top = 183
      Width = 75
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 1
      OnClick = FormShow
    end
  end
  object gbCalc: TGroupBox
    Left = 287
    Top = 529
    Width = 266
    Height = 218
    Caption = #1042#1099#1095#1080#1089#1083#1077#1085#1080#1077
    TabOrder = 4
    object Label6: TLabel
      Left = 33
      Top = 103
      Width = 88
      Height = 13
      Caption = #1058#1086#1095#1085#1086#1089#1090#1100' (10^x):'
    end
    object btResult: TButton
      Left = 27
      Top = 172
      Width = 207
      Height = 25
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
      TabOrder = 0
      OnClick = btResultClick
    end
    object btCalc: TButton
      Left = 27
      Top = 141
      Width = 207
      Height = 25
      Caption = #1057#1095#1080#1090#1072#1090#1100
      Enabled = False
      TabOrder = 1
      OnClick = btCalcClick
    end
    object udPrsn: TUpDown
      Left = 186
      Top = 98
      Width = 16
      Height = 21
      Associate = ePrsn
      Min = -100
      Position = -3
      TabOrder = 2
    end
    object ePrsn: TEdit
      Left = 144
      Top = 98
      Width = 42
      Height = 21
      TabOrder = 3
      Text = '-3'
    end
    object cbDebug: TCheckBox
      Left = 33
      Top = 32
      Width = 97
      Height = 17
      Caption = #1054#1090#1083#1072#1076#1082#1072
      TabOrder = 4
    end
    object cbSpaces: TCheckBox
      Left = 32
      Top = 64
      Width = 177
      Height = 17
      Caption = #1045#1089#1090#1100' '#1085#1077#1087#1088#1086#1074#1077#1076#1077#1085#1085#1099#1077' '#1086#1087#1099#1090#1099
      TabOrder = 5
    end
  end
  object odLoad: TOpenDialog
    DefaultExt = 'src'
    Filter = #1044#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1088#1072#1089#1095#1077#1090#1072' (*.src)|*.src'
    Left = 288
    Top = 192
  end
  object sdSave: TSaveDialog
    DefaultExt = 'src'
    Filter = #1044#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1088#1072#1089#1095#1077#1090#1072' (*.src)|*.src'
    Left = 360
    Top = 192
  end
end
