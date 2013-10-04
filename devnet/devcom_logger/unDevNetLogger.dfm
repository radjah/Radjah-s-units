object fmDevNetLogger: TfmDevNetLogger
  Left = 555
  Top = 151
  Width = 350
  Height = 641
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
    Left = 250
    Top = 101
    Width = 79
    Height = 20
    Alignment = taRightJustify
    Caption = '+/- ___ '#1082#1075
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gbButtons: TGroupBox
    Left = 8
    Top = 128
    Width = 321
    Height = 121
    Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077
    TabOrder = 0
    object btZero: TButton
      Left = 8
      Top = 24
      Width = 145
      Height = 49
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
      Left = 168
      Top = 24
      Width = 145
      Height = 49
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
    object btUnZero: TButton
      Left = 8
      Top = 80
      Width = 145
      Height = 25
      Caption = 'UNDO'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btUnZeroClick
    end
    object btUnTara: TButton
      Left = 168
      Top = 80
      Width = 145
      Height = 25
      Caption = 'UNDO'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btUnTaraClick
    end
  end
  object edNett: TEdit
    Left = 8
    Top = 8
    Width = 321
    Height = 89
    TabStop = False
    Color = clBlack
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object eTemp: TEdit
    Left = 16
    Top = 96
    Width = 41
    Height = 21
    TabOrder = 2
    Text = 'eTemp'
    Visible = False
  end
  object gmMeasure: TGroupBox
    Left = 8
    Top = 256
    Width = 321
    Height = 321
    Caption = #1047#1072#1084#1077#1088
    TabOrder = 3
    object gbResult: TGroupBox
      Left = 8
      Top = 176
      Width = 305
      Height = 137
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099
      TabOrder = 0
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
        Top = 60
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
        Top = 100
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
    object btStop: TButton
      Left = 184
      Top = 128
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
      TabOrder = 1
      OnClick = btStopClick
    end
    object btStart: TButton
      Left = 8
      Top = 128
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
      TabOrder = 2
      OnClick = btStartClick
    end
    object leMeasure: TLabeledEdit
      Left = 8
      Top = 100
      Width = 305
      Height = 21
      EditLabel.Width = 91
      EditLabel.Height = 13
      EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1079#1072#1084#1077#1088#1072
      TabOrder = 3
    end
    object pMeasure: TPanel
      Left = 8
      Top = 16
      Width = 297
      Height = 57
      BevelOuter = bvNone
      Caption = #1053#1077#1090' '#1079#1072#1084#1077#1088#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object TimerDevNet: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerDevNetTimer
    Left = 192
    Top = 96
  end
  object XPManifest1: TXPManifest
    Left = 128
    Top = 96
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
    Left = 160
    Top = 96
  end
  object ztbWeight: TZTable
    Connection = ZConnection
    TableName = 'weight'
    Left = 96
    Top = 96
  end
  object ztbMeasure: TZTable
    Connection = ZConnection
    TableName = 'measure'
    Left = 64
    Top = 96
  end
  object mmDevNet: TMainMenu
    Left = 224
    Top = 96
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
