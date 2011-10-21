object fmMain: TfmMain
  Left = 454
  Top = 200
  HorzScrollBar.ButtonSize = 10
  HorzScrollBar.Increment = 48
  VertScrollBar.Increment = 57
  ActiveControl = eCount
  Caption = #1054#1076#1085#1086#1092#1072#1082#1090#1086#1088#1085#1099#1081' '#1072#1085#1072#1083#1080#1079
  ClientHeight = 659
  ClientWidth = 512
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
    Top = 43
    Width = 96
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1077#1088#1080#1081':'
  end
  object Label2: TLabel
    Left = 24
    Top = 410
    Width = 63
    Height = 13
    Caption = #1051#1086#1075' '#1088#1072#1073#1086#1090#1099':'
  end
  object eCount: TEdit
    Left = 126
    Top = 40
    Width = 43
    Height = 21
    TabOrder = 0
    Text = '1'
  end
  object udCount: TUpDown
    Left = 169
    Top = 40
    Width = 16
    Height = 21
    Associate = eCount
    Min = 1
    Position = 1
    TabOrder = 1
  end
  object btCreateMemo: TButton
    Left = 191
    Top = 38
    Width = 75
    Height = 25
    Caption = #1047#1072#1076#1072#1090#1100
    TabOrder = 2
    OnClick = btCreateMemoClick
  end
  object btCalc: TButton
    Left = 280
    Top = 38
    Width = 75
    Height = 25
    Caption = #1057#1095#1080#1090#1072#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = btCalcClick
  end
  object cbEmptyStr: TCheckBox
    Left = 376
    Top = 42
    Width = 129
    Height = 17
    Caption = #1055#1091#1089#1090#1072#1103' '#1089#1090#1088#1086#1082#1072' = 0'
    TabOrder = 4
  end
  object mLog: TMemo
    Left = 24
    Top = 429
    Width = 305
    Height = 222
    Lines.Strings = (
      'mLog')
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object btLoad: TBitBtn
    Left = 24
    Top = 8
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
    TabOrder = 6
    OnClick = btLoadClick
  end
  object btSave: TBitBtn
    Left = 119
    Top = 8
    Width = 89
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    DoubleBuffered = True
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
    TabOrder = 7
    OnClick = btSaveClick
  end
  object blClear: TButton
    Left = 335
    Top = 427
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 8
    OnClick = blClearClick
  end
  object pbSaveLoad: TProgressBar
    Left = 214
    Top = 8
    Width = 278
    Height = 24
    Step = 1
    TabOrder = 9
  end
  object sbData: TScrollBox
    Left = 24
    Top = 69
    Width = 468
    Height = 335
    TabOrder = 10
  end
  object sdSave: TSaveDialog
    DefaultExt = 'src'
    Filter = #1044#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1088#1072#1089#1095#1077#1090#1072' (*.src)|*.src'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 384
    Top = 461
  end
  object odLoad: TOpenDialog
    DefaultExt = 'src'
    Filter = #1044#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1088#1072#1089#1095#1077#1090#1072' (*.src)|*.src'
    Left = 384
    Top = 509
  end
  object XPManifest1: TXPManifest
    Left = 384
    Top = 565
  end
end
