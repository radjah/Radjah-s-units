object fmDevNetLogger: TfmDevNetLogger
  Left = 359
  Top = 201
  Width = 807
  Height = 675
  Caption = 'fmDevNetLogger'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object leVersion: TLabel
    Left = 32
    Top = 72
    Width = 27
    Height = 13
    Caption = '         '
  end
  object btConnect: TButton
    Left = 32
    Top = 40
    Width = 113
    Height = 25
    Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1077
    TabOrder = 0
    OnClick = btConnectClick
  end
  object gbSettings: TGroupBox
    Left = 16
    Top = 104
    Width = 145
    Height = 145
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 1
    object btPortDlg: TButton
      Left = 16
      Top = 24
      Width = 113
      Height = 25
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      Enabled = False
      TabOrder = 0
      OnClick = btPortDlgClick
    end
    object btParamDlg: TButton
      Left = 16
      Top = 64
      Width = 113
      Height = 25
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      Enabled = False
      TabOrder = 1
      OnClick = btParamDlgClick
    end
    object btSelectDevDlg: TButton
      Left = 16
      Top = 104
      Width = 113
      Height = 25
      Caption = #1055#1088#1080#1073#1086#1088#1099
      Enabled = False
      TabOrder = 2
      OnClick = btSelectDevDlgClick
    end
  end
  object btList: TButton
    Left = 32
    Top = 264
    Width = 113
    Height = 25
    Caption = #1057#1087#1080#1089#1086#1082
    Enabled = False
    TabOrder = 2
    OnClick = btListClick
  end
end
