object fmNewStage: TfmNewStage
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1099#1081' '#1101#1090#1072#1087
  ClientHeight = 607
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 58
    Width = 121
    Height = 13
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1087#1086#1079#1080#1094#1080#1103':'
  end
  object Label2: TLabel
    Left = 8
    Top = 109
    Width = 231
    Height = 13
    Caption = #1055#1086#1079#1080#1094#1080#1080' '#1080' '#1080#1093' '#1087#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1074' '#1089#1082#1091#1085#1076#1072#1093':'
  end
  object sbPos: TScrollBox
    Left = 8
    Top = 128
    Width = 281
    Height = 281
    VertScrollBar.Smooth = True
    TabOrder = 0
    object udTpl: TUpDown
      Left = 248
      Top = 51
      Width = 17
      Height = 25
      TabOrder = 0
      Visible = False
      OnChanging = udTplChanging
    end
  end
  object eMaxPos: TEdit
    Left = 8
    Top = 77
    Width = 81
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object udMaxPos: TUpDown
    Left = 89
    Top = 77
    Width = 16
    Height = 21
    Associate = eMaxPos
    Min = 1
    Position = 1
    TabOrder = 2
  end
  object btMaxPosSet: TButton
    Left = 120
    Top = 75
    Width = 101
    Height = 26
    Caption = #1047#1072#1076#1072#1090#1100
    TabOrder = 3
    OnClick = btMaxPosSetClick
  end
  object btCreate: TButton
    Left = 76
    Top = 572
    Width = 145
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100
    Enabled = False
    TabOrder = 4
    OnClick = btCreateClick
  end
  object leStageName: TLabeledEdit
    Left = 8
    Top = 31
    Width = 281
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    TabOrder = 5
  end
  object chStagePreview: TChart
    Left = 8
    Top = 415
    Width = 282
    Height = 151
    Legend.Visible = False
    Title.Text.Strings = (
      #1055#1088#1077#1076#1087#1088#1086#1089#1084#1086#1090#1088)
    View3D = False
    TabOrder = 6
    ColorPaletteIndex = 13
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Emboss.Color = 8487297
      Marks.Shadow.Color = 8487297
      Marks.Visible = False
      InvertedStairs = True
      LinePen.Color = 10708548
      LinePen.Width = 4
      Pointer.Brush.Gradient.EndColor = 10708548
      Pointer.Gradient.EndColor = 10708548
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      Stairs = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Data = {0000000000}
    end
  end
  object btAddPos: TButton
    Left = 227
    Top = 75
    Width = 30
    Height = 25
    Caption = '+1'
    TabOrder = 7
    OnClick = btAddPosClick
  end
  object btDelPos: TButton
    Left = 260
    Top = 75
    Width = 30
    Height = 25
    Caption = '-1'
    TabOrder = 8
    OnClick = btDelPosClick
  end
  object zqGetStruct: TZQuery
    Connection = fmMain.ZConnect
    SQL.Strings = (
      'select pid, clevel, ptime from sstruct where'
      'sid=1'
      'order by clevel')
    Params = <>
    Left = 24
    Top = 424
  end
  object zqClearSctruct: TZQuery
    Connection = fmMain.ZConnect
    SQL.Strings = (
      'delete from sstruct where'
      'sid=1')
    Params = <>
    Left = 24
    Top = 472
  end
  object zqGetSCount: TZQuery
    Connection = fmMain.ZConnect
    SQL.Strings = (
      'select count(pid) as pcount from sstruct where'
      'sid=1')
    Params = <>
    Left = 24
    Top = 520
    object zqGetSCountpcount: TWideStringField
      FieldName = 'pcount'
      ReadOnly = True
      Size = 255
    end
  end
  object zqUpdateName: TZQuery
    Connection = fmMain.ZConnect
    SQL.Strings = (
      'update stages'
      'set'
      'sname='#39#1082#1090#1086' '#1079#1072#1073#1099#1083' '#1079#1072#1084#1077#1085#1080#1090#1100' '#1080#1084#1103#39
      'where'
      'sid=1')
    Params = <>
    Left = 104
    Top = 424
  end
end
