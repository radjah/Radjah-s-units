object fmMain: TfmMain
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = #1043#1077#1085#1077#1088#1072#1094#1080#1103' '#1090#1072#1073#1083#1080#1094' '#1076#1083#1103' FTDraw'
  ClientHeight = 561
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 61
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1103' X:'
  end
  object Label2: TLabel
    Left = 200
    Top = 8
    Width = 61
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1103' Y:'
  end
  object Label3: TLabel
    Left = 8
    Top = 505
    Width = 357
    Height = 39
    Caption = 
      #1045#1089#1083#1080' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1086#1076#1085#1086#1081' '#1080#1079' '#1082#1086#1086#1088#1076#1080#1085#1072#1090' '#1073#1086#1083#1100#1096#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1072' '#1079#1085 +
      #1072#1095#1077#1085#1080#1081' '#1076#1088#1091#1075#1086#1081' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1099', '#1090#1086' '#1085#1077#1076#1086#1089#1090#1072#1102#1097#1080#1077' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1079#1072#1084#1077#1085#1103#1102#1090#1089#1103' '#1085#1091#1083 +
      #1103#1084#1080'.'
    WordWrap = True
  end
  object mXcoord: TMemo
    Left = 8
    Top = 24
    Width = 185
    Height = 417
    Lines.Strings = (
      'mXcoord')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object mYcoord: TMemo
    Left = 200
    Top = 24
    Width = 185
    Height = 417
    Lines.Strings = (
      'mYcoord')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object btGen: TButton
    Left = 124
    Top = 464
    Width = 145
    Height = 25
    Caption = #1043#1077#1085#1077#1088#1072#1094#1080#1103
    TabOrder = 2
    OnClick = btGenClick
  end
  object pGenStatus: TPanel
    Left = 112
    Top = 234
    Width = 169
    Height = 93
    Caption = #1042#1099#1087#1086#1083#1085#1103#1077#1090#1089#1103' '#1075#1077#1085#1077#1088#1072#1094#1080#1103
    TabOrder = 3
    Visible = False
    object pbGenState: TProgressBar
      Left = 10
      Top = 64
      Width = 149
      Height = 17
      TabOrder = 0
    end
  end
  object XPMan: TXPManifest
    Left = 320
    Top = 400
  end
  object sdTable: TSaveDialog
    DefaultExt = 'flt'
    Filter = #1058#1072#1073#1083#1080#1094#1072' '#1079#1085#1072#1095#1077#1085#1080#1081' (*.Ftt)|*.Ftt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 320
    Top = 456
  end
end
