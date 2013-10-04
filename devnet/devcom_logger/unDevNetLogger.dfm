object fmDevNetLogger: TfmDevNetLogger
  Left = 556
  Top = 293
  Width = 1015
  Height = 587
  Caption = #1050#1083#1080#1077#1085#1090' '#1076#1083#1103' DevNet'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mmDevNet
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbDiscret: TLabel
    Left = 178
    Top = 189
    Width = 79
    Height = 20
    Alignment = taCenter
    Caption = '+/- ___ '#1082#1075
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 16
    Top = 40
    Width = 109
    Height = 37
    Caption = #1041#1088#1091#1090#1090#1086':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 88
    Width = 95
    Height = 37
    Caption = #1053#1077#1090#1090#1086':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 136
    Width = 83
    Height = 37
    Caption = #1058#1072#1088#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 168
    Top = 8
    Width = 76
    Height = 24
    Caption = #1058#1077#1082#1091#1097#1077#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 320
    Top = 8
    Width = 64
    Height = 24
    Caption = #1053#1072#1095#1072#1083#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 464
    Top = 8
    Width = 56
    Height = 24
    Caption = #1050#1086#1085#1077#1094
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object gbButtons: TGroupBox
    Left = 8
    Top = 224
    Width = 297
    Height = 145
    Caption = #1050#1085#1086#1087#1082#1080' '#1085#1072' '#1074#1077#1089#1072#1093
    TabOrder = 0
    Visible = False
    object btZero: TButton
      Left = 8
      Top = 24
      Width = 81
      Height = 57
      Caption = '>0<'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btZeroClick
    end
    object btTara: TButton
      Left = 104
      Top = 24
      Width = 81
      Height = 57
      Caption = #1058#1040#1056#1040
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btTaraClick
    end
    object btBN: TButton
      Left = 200
      Top = 24
      Width = 81
      Height = 57
      Caption = #1041'/'#1053
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btBNClick
    end
    object btUnZero: TButton
      Left = 8
      Top = 88
      Width = 81
      Height = 33
      Caption = 'UNDO'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btUnZeroClick
    end
    object btUnTara: TButton
      Left = 104
      Top = 88
      Width = 81
      Height = 33
      Caption = 'UNDO'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btUnTaraClick
    end
  end
  object pMeasure: TPanel
    Left = 320
    Top = 232
    Width = 265
    Height = 57
    BevelOuter = bvNone
    Caption = #1053#1077#1090' '#1079#1072#1084#1077#1088#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object leMeasure: TLabeledEdit
    Left = 608
    Top = 216
    Width = 273
    Height = 21
    EditLabel.Width = 91
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1079#1072#1084#1077#1088#1072
    TabOrder = 2
  end
  object btStart: TButton
    Left = 608
    Top = 248
    Width = 129
    Height = 41
    Caption = #1053#1072#1095#1072#1090#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btStartClick
  end
  object btStop: TButton
    Left = 752
    Top = 248
    Width = 129
    Height = 41
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btStopClick
  end
  object gbResult: TGroupBox
    Left = 608
    Top = 24
    Width = 273
    Height = 161
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099
    TabOrder = 5
    object lTime: TLabel
      Left = 8
      Top = 20
      Width = 89
      Height = 29
      Caption = #1042#1088#1077#1084#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lDiff: TLabel
      Left = 8
      Top = 68
      Width = 115
      Height = 29
      Caption = #1056#1072#1079#1085#1080#1094#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lUd: TLabel
      Left = 8
      Top = 116
      Width = 113
      Height = 29
      Caption = #1063#1072#1089#1086#1074#1086#1081':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object edGross: TEdit
    Left = 168
    Top = 40
    Width = 129
    Height = 41
    TabStop = False
    Color = clBlack
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
  end
  object edNett: TEdit
    Left = 168
    Top = 88
    Width = 129
    Height = 41
    TabStop = False
    Color = clBlack
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  object edTara: TEdit
    Left = 168
    Top = 136
    Width = 129
    Height = 41
    TabStop = False
    Color = clBlack
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
  end
  object eBeginBrutto: TEdit
    Left = 320
    Top = 40
    Width = 129
    Height = 43
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object eBeginNetto: TEdit
    Left = 320
    Top = 88
    Width = 129
    Height = 43
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object eBeginTara: TEdit
    Left = 320
    Top = 136
    Width = 129
    Height = 43
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object eEndBrutto: TEdit
    Left = 456
    Top = 40
    Width = 129
    Height = 43
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object eEndNetto: TEdit
    Left = 456
    Top = 88
    Width = 129
    Height = 43
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object eEndTara: TEdit
    Left = 456
    Top = 136
    Width = 129
    Height = 43
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object TimerDevNet: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerDevNetTimer
    Left = 448
    Top = 192
  end
  object XPManifest1: TXPManifest
    Left = 384
    Top = 192
  end
  object ZConnection: TZConnection
    ControlsCodePage = cGET_ACP
    AutoEncodeStrings = False
    Properties.Strings = (
      'AutoEncodeStrings=ON')
    DesignConnection = True
    Port = 0
    Database = 'devnet_log.sqlite'
    Protocol = 'sqlite-3'
    Left = 416
    Top = 192
  end
  object ztbWeight: TZTable
    Connection = ZConnection
    TableName = 'weight'
    Left = 352
    Top = 192
  end
  object ztbMeasure: TZTable
    Connection = ZConnection
    TableName = 'measure'
    Left = 320
    Top = 192
  end
  object mmDevNet: TMainMenu
    Left = 480
    Top = 192
    object mDevNetServer: TMenuItem
      Caption = 'DevNet'
      object mConnect: TMenuItem
        Caption = #1057#1086#1077#1076#1080#1085#1080#1090#1100#1089#1103
        OnClick = btConnectClick
      end
      object mDisconnect: TMenuItem
        Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103
        Enabled = False
        OnClick = btDisconnectClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mPortDlg: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086#1088#1090#1072
        Enabled = False
        OnClick = btPortDlgClick
      end
      object mParamDlg: TMenuItem
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        Enabled = False
        OnClick = btParamDlgClick
      end
      object mSelectDevDlg: TMenuItem
        Caption = #1055#1088#1080#1073#1086#1088#1099
        Enabled = False
        OnClick = btSelectDevDlgClick
      end
      object mShowHide: TMenuItem
        Caption = #1054#1082#1085#1086' '#1089#1077#1088#1074#1077#1088#1072
        Enabled = False
        OnClick = btShowHideClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = mExitClick
      end
    end
    object mScales: TMenuItem
      Caption = #1042#1077#1089#1099
      object mOpenPort: TMenuItem
        Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100
        Enabled = False
        OnClick = btOpenPortClick
      end
      object mClosePort: TMenuItem
        Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100
        Enabled = False
        OnClick = btClosePortClick
      end
      object mScaleButtons: TMenuItem
        Caption = #1050#1085#1086#1087#1082#1080' '#1091#1087#1088#1072#1083#1077#1085#1080#1103
        OnClick = mScaleButtonsClick
      end
    end
    object N3: TMenuItem
      Caption = #1040#1088#1093#1080#1074
      object mMeas: TMenuItem
        Caption = #1047#1072#1084#1077#1088#1099
        OnClick = mMeasClick
      end
    end
  end
end
