object TBupdApp: TTBupdApp
  Left = 192
  Top = 109
  BorderStyle = bsDialog
  Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' Mozilla Thunderbir'
  ClientHeight = 167
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 173
    Height = 13
    Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' Mozilla Thunderbird:'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 95
    Height = 13
    Caption = #1060#1072#1081#1083' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103':'
  end
  object eTBPath: TEdit
    Left = 24
    Top = 24
    Width = 273
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object btTBBrowse: TButton
    Left = 304
    Top = 24
    Width = 73
    Height = 25
    Caption = #1054#1073#1079#1086#1088'...'
    TabOrder = 1
    OnClick = btTBBrowseClick
  end
  object eUpdateFile: TEdit
    Left = 24
    Top = 72
    Width = 273
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object btUpdateFileBrowse: TButton
    Left = 304
    Top = 72
    Width = 73
    Height = 25
    Caption = #1054#1073#1079#1086#1088'...'
    TabOrder = 3
    OnClick = btUpdateFileBrowseClick
  end
  object btUpdate: TButton
    Left = 21
    Top = 112
    Width = 107
    Height = 41
    Hint = #1047#1072#1087#1091#1089#1082#1072#1077#1090' '#1087#1088#1086#1094#1077#1089#1089' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
    Caption = '1) '#1054#1073#1085#1086#1074#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btUpdateClick
  end
  object btCleanup: TButton
    Left = 280
    Top = 112
    Width = 97
    Height = 41
    Hint = #1059#1076#1072#1083#1103#1077#1090' '#1092#1072#1081#1083#1099', '#1089#1086#1079#1076#1072#1085#1085#1099#1077' '#1074' '#1087#1088#1086#1094#1077#1089#1089#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103'.'
    Caption = '3) '#1055#1086#1095#1080#1089#1090#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btCleanupClick
  end
  object btCheck: TButton
    Left = 152
    Top = 112
    Width = 97
    Height = 41
    Hint = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
    Caption = '2) '#1055#1088#1086#1074#1077#1088#1080#1090#1100
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btCheckClick
  end
  object odff: TOpenDialog
    Filter = 'Thunderbird.exe|Thunderbird.exe'
    InitialDir = '%programfiles%'
    Left = 344
  end
  object odmar: TOpenDialog
    Filter = #1060#1072#1081#1083#1099' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' (*.mar)|*.mar'
    InitialDir = '.'
    Left = 376
  end
  object XPManifest1: TXPManifest
    Left = 312
  end
end
