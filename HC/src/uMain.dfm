object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 728
  ClientWidth = 718
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 120
    Top = 88
    Width = 186
    Height = 58
    Caption = #1055#1086#1079#1080#1094#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -48
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lPosition: TLabel
    Left = 376
    Top = 8
    Width = 231
    Height = 178
    Caption = '%n'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clYellow
    Font.Height = -160
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 120
    Top = 240
    Width = 153
    Height = 35
    Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lNextPosition: TLabel
    Left = 376
    Top = 205
    Width = 98
    Height = 77
    Caption = '%p'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -64
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 120
    Top = 304
    Width = 123
    Height = 35
    Caption = #1054#1089#1090#1072#1083#1086#1089#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lTime: TLabel
    Left = 376
    Top = 296
    Width = 48
    Height = 45
    Caption = '%t'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -37
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object pbTime: TProgressBar
    Left = 58
    Top = 392
    Width = 601
    Height = 49
    TabOrder = 0
  end
  object Chart: TChart
    Left = 16
    Top = 488
    Width = 694
    Height = 146
    Legend.Title.Visible = False
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3D = False
    BevelOuter = bvNone
    Color = clBlack
    TabOrder = 1
    PrintMargins = (
      15
      37
      15
      37)
    ColorPaletteIndex = 10
    object Series1: TBarSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clAqua
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
  object btGo: TButton
    Left = 194
    Top = 656
    Width = 331
    Height = 64
    Caption = #1055#1086#1077#1093#1072#1083#1080'!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btGoClick
  end
  object btEditor: TButton
    Left = 624
    Top = 656
    Width = 75
    Height = 25
    Caption = #1056#1077#1076#1072#1082#1090#1086#1088
    TabOrder = 3
  end
  object btLoad: TButton
    Left = 624
    Top = 695
    Width = 75
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
    TabOrder = 4
  end
  object StageTimer: TTimer
    Enabled = False
    OnTimer = StageTimerTimer
    Left = 672
    Top = 16
  end
end
