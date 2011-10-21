object fmRename: TfmRename
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1079#1074#1072#1085#1080#1103' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
  ClientHeight = 206
  ClientWidth = 428
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
    Left = 19
    Top = 143
    Width = 255
    Height = 13
    Caption = #1055#1088#1086#1073#1077#1083#1099' '#1074' '#1085#1072#1095#1072#1083#1077' '#1080' '#1082#1086#1085#1094#1077' '#1085#1072#1079#1074#1072#1085#1080#1081' '#1091#1076#1072#1083#1072#1103#1102#1090#1089#1103'.'
  end
  object btRename: TButton
    Left = 123
    Top = 168
    Width = 182
    Height = 25
    Caption = #1047#1072#1076#1072#1090#1100
    TabOrder = 0
    OnClick = btRenameClick
  end
  object gbFull: TGroupBox
    Left = 8
    Top = 16
    Width = 284
    Height = 113
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103
    TabOrder = 1
    object leFullA: TLabeledEdit
      Left = 11
      Top = 36
      Width = 262
      Height = 21
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1072#1088#1072#1084#1077#1090#1088' A'
      TabOrder = 0
    end
    object leFullB: TLabeledEdit
      Left = 11
      Top = 78
      Width = 262
      Height = 21
      EditLabel.Width = 58
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1072#1088#1072#1084#1077#1090#1088' B'
      TabOrder = 1
    end
  end
  object gbShort: TGroupBox
    Left = 298
    Top = 16
    Width = 122
    Height = 113
    Caption = #1054#1073#1086#1079#1085#1072#1095#1077#1085#1080#1103
    TabOrder = 2
    object leShortA: TLabeledEdit
      Left = 12
      Top = 36
      Width = 101
      Height = 21
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1072#1088#1072#1084#1077#1090#1088' A'
      TabOrder = 0
    end
    object leShortB: TLabeledEdit
      Left = 12
      Top = 78
      Width = 101
      Height = 21
      EditLabel.Width = 58
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1072#1088#1072#1084#1077#1090#1088' B'
      TabOrder = 1
    end
  end
end
