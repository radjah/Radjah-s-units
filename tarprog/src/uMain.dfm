object MainForm: TMainForm
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = #1055#1086#1076#1075#1086#1090#1086#1074#1082#1072' '#1090#1072#1073#1083#1080#1094#1099' '#1076#1083#1103' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1090#1072#1088#1080#1088#1086#1074#1082#1080
  ClientHeight = 459
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbSensors: TGroupBox
    Left = 16
    Top = 128
    Width = 409
    Height = 225
    Caption = #1044#1072#1090#1095#1080#1082#1080
    TabOrder = 0
    object Label4: TLabel
      Left = 8
      Top = 24
      Width = 51
      Height = 13
      Caption = #1044#1072#1074#1083#1077#1085#1080#1077
    end
    object lPres1: TLabel
      Left = 8
      Top = 48
      Width = 29
      Height = 13
      Caption = 'lPres1'
    end
    object lPres2: TLabel
      Left = 208
      Top = 48
      Width = 29
      Height = 13
      Caption = 'lPres2'
    end
    object lPres3: TLabel
      Left = 8
      Top = 96
      Width = 29
      Height = 13
      Caption = 'lPres3'
    end
    object lPres4: TLabel
      Left = 208
      Top = 96
      Width = 29
      Height = 13
      Caption = 'lPres4'
    end
    object Label5: TLabel
      Left = 8
      Top = 152
      Width = 67
      Height = 13
      Caption = #1058#1077#1084#1087#1077#1088#1072#1090#1091#1088#1072
    end
    object lTemp2: TLabel
      Left = 209
      Top = 173
      Width = 35
      Height = 13
      Caption = 'lTemp2'
    end
    object lTemp1: TLabel
      Left = 8
      Top = 176
      Width = 35
      Height = 13
      Caption = 'lTemp1'
    end
    object ePres1: TEdit
      Left = 8
      Top = 64
      Width = 185
      Height = 21
      TabOrder = 0
    end
    object ePres2: TEdit
      Left = 208
      Top = 64
      Width = 185
      Height = 21
      TabOrder = 2
    end
    object ePres3: TEdit
      Left = 8
      Top = 112
      Width = 185
      Height = 21
      TabOrder = 3
    end
    object ePres4: TEdit
      Left = 208
      Top = 112
      Width = 185
      Height = 21
      TabOrder = 4
    end
    object bTempFil: TButton
      Left = 120
      Top = 40
      Width = 73
      Height = 17
      Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' >'
      TabOrder = 1
      OnClick = bPresFilClick
    end
    object eTemp2: TEdit
      Left = 208
      Top = 192
      Width = 185
      Height = 21
      TabOrder = 7
    end
    object bPrFil: TButton
      Left = 120
      Top = 168
      Width = 73
      Height = 17
      Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' >'
      TabOrder = 6
      OnClick = bTempFilClick
    end
    object eTemp1: TEdit
      Left = 8
      Top = 192
      Width = 185
      Height = 21
      TabOrder = 5
    end
  end
  object gbSummary: TGroupBox
    Left = 16
    Top = 8
    Width = 409
    Height = 113
    Caption = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 79
      Height = 13
      Caption = #1058#1072#1088#1080#1088#1086#1074#1082#1072' '#1076#1083#1103' '
    end
    object Label2: TLabel
      Left = 216
      Top = 32
      Width = 11
      Height = 13
      Caption = #8470
    end
    object Label3: TLabel
      Left = 8
      Top = 64
      Width = 61
      Height = 13
      Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1099':'
    end
    object eTarFor: TEdit
      Left = 88
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object eTarNum: TEdit
      Left = 232
      Top = 24
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object udPartNum: TUpDown
      Left = 297
      Top = 24
      Width = 16
      Height = 21
      Associate = eTarNum
      Max = 9999
      TabOrder = 2
    end
    object eComp1: TEdit
      Left = 8
      Top = 76
      Width = 121
      Height = 21
      TabOrder = 3
      Text = '0'
      OnChange = eComp1Change
    end
    object udComp1: TUpDown
      Left = 129
      Top = 76
      Width = 16
      Height = 21
      Associate = eComp1
      Max = 9999
      TabOrder = 4
      OnChanging = udComp1Changing
    end
    object eComp2: TEdit
      Left = 152
      Top = 76
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 5
      Text = '0'
      OnChange = eComp2Change
    end
    object cbRO: TCheckBox
      Left = 280
      Top = 80
      Width = 97
      Height = 17
      Caption = #1053#1077#1080#1079#1084#1077#1085#1085#1086
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = cbROClick
    end
  end
  object bMakeTable: TBitBtn
    Left = 156
    Top = 364
    Width = 129
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
    Default = True
    DoubleBuffered = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
      333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
      0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
      07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
      07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
      0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
      B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
      3BB33773333773333773B333333B3333333B7333333733333337}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = bMakeTableClick
  end
  object bNew: TBitBtn
    Left = 156
    Top = 408
    Width = 129
    Height = 25
    Caption = #1053#1086#1074#1072#1103
    DoubleBuffered = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
      333333333333337FF3333333333333903333333333333377FF33333333333399
      03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
      99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
      99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
      03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
      33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
      33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
      3333777777333333333333333333333333333333333333333333}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = bNewClick
  end
  object sdTar: TSaveDialog
    Filter = 'Excel files (*.xls)|*.xls'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 400
    Top = 408
  end
  object XPManifest1: TXPManifest
    Left = 392
    Top = 360
  end
end
