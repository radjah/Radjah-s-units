object fmDevNetLogger: TfmDevNetLogger
  Left = 359
  Top = 201
  BorderStyle = bsDialog
  Caption = #1050#1083#1080#1077#1085#1090' '#1076#1083#1103' DevNet'
  ClientHeight = 600
  ClientWidth = 1159
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbSettings: TGroupBox
    Left = 8
    Top = 256
    Width = 145
    Height = 185
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 0
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
    object btShowHide: TButton
      Left = 16
      Top = 144
      Width = 113
      Height = 25
      Caption = #1054#1082#1085#1086' '#1089#1077#1088#1074#1077#1088#1072
      Enabled = False
      TabOrder = 3
      OnClick = btShowHideClick
    end
  end
  object gbData: TGroupBox
    Left = 176
    Top = 8
    Width = 169
    Height = 433
    Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 95
      Height = 20
      Caption = #1042#1077#1089' '#1073#1088#1091#1090#1090#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 152
      Width = 87
      Height = 20
      Caption = #1042#1077#1089' '#1085#1077#1090#1090#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Top = 264
      Width = 79
      Height = 20
      Caption = #1042#1077#1089' '#1090#1072#1088#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbDiscret: TLabel
      Left = 34
      Top = 397
      Width = 20
      Height = 16
      Alignment = taCenter
      Caption = #1082#1075'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edGross: TEdit
      Left = 25
      Top = 59
      Width = 120
      Height = 44
      TabStop = False
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edNett: TEdit
      Left = 25
      Top = 179
      Width = 120
      Height = 44
      TabStop = False
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edTara: TEdit
      Left = 25
      Top = 291
      Width = 120
      Height = 44
      TabStop = False
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
  end
  object gbButtons: TGroupBox
    Left = 8
    Top = 448
    Width = 337
    Height = 145
    Caption = #1050#1085#1086#1087#1082#1080' '#1085#1072' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1077
    TabOrder = 2
    object btZero: TButton
      Left = 24
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
      Left = 128
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
      Left = 232
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
      Left = 24
      Top = 88
      Width = 81
      Height = 49
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
      Left = 128
      Top = 88
      Width = 81
      Height = 49
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
    Left = 360
    Top = 16
    Width = 281
    Height = 73
    Caption = #1053#1045#1058' '#1047#1040#1052#1045#1056#1040
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object leMeasure: TLabeledEdit
    Left = 368
    Top = 112
    Width = 273
    Height = 21
    EditLabel.Width = 91
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1079#1072#1084#1077#1088#1072
    TabOrder = 4
  end
  object btStart: TButton
    Left = 432
    Top = 144
    Width = 137
    Height = 41
    Caption = #1053#1072#1095#1072#1090#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btStartClick
  end
  object btStop: TButton
    Left = 432
    Top = 200
    Width = 137
    Height = 41
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btStopClick
  end
  object gbBegin: TGroupBox
    Left = 368
    Top = 256
    Width = 129
    Height = 185
    Caption = #1053#1072#1095#1072#1083#1086
    TabOrder = 7
    object leBeginBrutto: TLabeledEdit
      Left = 8
      Top = 40
      Width = 113
      Height = 21
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = #1041#1088#1091#1090#1090#1086':'
      ReadOnly = True
      TabOrder = 0
    end
    object leBeginNetto: TLabeledEdit
      Left = 8
      Top = 96
      Width = 113
      Height = 21
      EditLabel.Width = 33
      EditLabel.Height = 13
      EditLabel.Caption = #1053#1077#1090#1090#1086':'
      ReadOnly = True
      TabOrder = 1
    end
    object leBeginTara: TLabeledEdit
      Left = 8
      Top = 152
      Width = 113
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = #1058#1072#1088#1072':'
      ReadOnly = True
      TabOrder = 2
    end
  end
  object gbEnd: TGroupBox
    Left = 512
    Top = 256
    Width = 129
    Height = 185
    Caption = #1050#1086#1085#1077#1094
    TabOrder = 8
    object leEndBrutto: TLabeledEdit
      Left = 8
      Top = 40
      Width = 113
      Height = 21
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = #1041#1088#1091#1090#1090#1086':'
      ReadOnly = True
      TabOrder = 0
    end
    object leEndNetto: TLabeledEdit
      Left = 8
      Top = 96
      Width = 113
      Height = 21
      EditLabel.Width = 33
      EditLabel.Height = 13
      EditLabel.Caption = #1053#1077#1090#1090#1086':'
      ReadOnly = True
      TabOrder = 1
    end
    object leEndTara: TLabeledEdit
      Left = 8
      Top = 152
      Width = 113
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = #1058#1072#1088#1072':'
      ReadOnly = True
      TabOrder = 2
    end
  end
  object gbResult: TGroupBox
    Left = 368
    Top = 448
    Width = 273
    Height = 145
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099
    TabOrder = 9
    object lTime: TLabel
      Left = 8
      Top = 20
      Width = 8
      Height = 29
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
      Width = 8
      Height = 29
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
      Width = 8
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object gbServer: TGroupBox
    Left = 8
    Top = 8
    Width = 145
    Height = 137
    Caption = #1057#1077#1088#1074#1077#1088' DevNet'
    TabOrder = 10
    object lVersion: TLabel
      Left = 16
      Top = 88
      Width = 113
      Height = 41
      AutoSize = False
      WordWrap = True
    end
    object btConnect: TButton
      Left = 16
      Top = 24
      Width = 113
      Height = 25
      Caption = #1057#1086#1077#1076#1080#1085#1080#1090#1100#1089#1103
      TabOrder = 0
      OnClick = btConnectClick
    end
    object btDisconnect: TButton
      Left = 16
      Top = 56
      Width = 113
      Height = 25
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103
      Enabled = False
      TabOrder = 1
      OnClick = btDisconnectClick
    end
  end
  object gbPort: TGroupBox
    Left = 8
    Top = 152
    Width = 145
    Height = 97
    Caption = #1042#1077#1089#1099
    TabOrder = 11
    object btOpenPort: TButton
      Left = 16
      Top = 24
      Width = 113
      Height = 25
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
      Enabled = False
      TabOrder = 0
      OnClick = btOpenPortClick
    end
    object btClosePort: TButton
      Left = 16
      Top = 56
      Width = 113
      Height = 25
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
      Enabled = False
      TabOrder = 1
      OnClick = btClosePortClick
    end
  end
  object gbArchive: TGroupBox
    Left = 656
    Top = 8
    Width = 489
    Height = 585
    Caption = #1040#1088#1093#1080#1074
    TabOrder = 12
    object Label4: TLabel
      Left = 16
      Top = 16
      Width = 44
      Height = 13
      Caption = #1047#1072#1084#1077#1088#1099':'
    end
    object lArcTime: TLabel
      Left = 16
      Top = 352
      Width = 69
      Height = 24
      Caption = #1042#1088#1077#1084#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lArcDiff: TLabel
      Left = 16
      Top = 392
      Width = 89
      Height = 24
      Caption = #1056#1072#1079#1085#1080#1094#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lArcUd: TLabel
      Left = 16
      Top = 432
      Width = 95
      Height = 24
      Caption = #1063#1072#1089#1086#1074#1086#1081': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbgArchive: TDBGrid
      Left = 16
      Top = 32
      Width = 457
      Height = 297
      DataSource = dsArchive
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = dbgArchiveCellClick
      OnColEnter = dbgArchiveColEnter
      OnEnter = dbgArchiveColEnter
      OnKeyUp = dbgArchiveKeyUp
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Title.Caption = #8470
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'start'
          Title.Caption = #1044#1072#1090#1072
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESC'
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'mtime'
          Title.Caption = #1055#1088#1086#1076#1086#1083#1078'.'
          Visible = True
        end>
    end
  end
  object TimerDevNet: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerDevNetTimer
    Left = 392
    Top = 184
  end
  object XPManifest1: TXPManifest
    Left = 360
    Top = 216
  end
  object ZConnection: TZConnection
    ControlsCodePage = cGET_ACP
    Properties.Strings = (
      'AutoEncodeStrings=ON')
    DesignConnection = True
    Port = 0
    Database = 'devnet_log.sqlite'
    Protocol = 'sqlite-3'
    Left = 360
    Top = 184
  end
  object ztbWeight: TZTable
    Connection = ZConnection
    TableName = 'weight'
    Left = 392
    Top = 152
  end
  object ztbMeasure: TZTable
    Connection = ZConnection
    TableName = 'measure'
    Left = 360
    Top = 152
  end
  object ztMeasArchive: TZTable
    Connection = ZConnection
    ReadOnly = True
    TableName = 'measure'
    Left = 1088
    Top = 392
  end
  object dsArchive: TDataSource
    DataSet = ztMeasArchive
    Left = 1088
    Top = 424
  end
  object zqArchive: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * from weight where'
      'meas_id=1')
    Params = <>
    Left = 1088
    Top = 456
  end
end
