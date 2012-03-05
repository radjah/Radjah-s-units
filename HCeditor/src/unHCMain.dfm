object HCMain: THCMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1062#1080#1082#1083' '#1080#1089#1087#1099#1090#1072#1085#1080#1081' '#1090#1077#1087#1083#1086#1074#1086#1079#1086#1074' '#1080' '#1087#1091#1090#1077#1074#1099#1093' '#1084#1072#1096#1080#1085
  ClientHeight = 730
  ClientWidth = 791
  Color = clBlack
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
    Left = 329
    Top = 8
    Width = 304
    Height = 178
    AutoSize = False
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
    Left = 329
    Top = 205
    Width = 440
    Height = 77
    AutoSize = False
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
    Left = 329
    Top = 296
    Width = 121
    Height = 45
    AutoSize = False
    Caption = '%t'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -37
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 456
    Top = 296
    Width = 65
    Height = 45
    Caption = #1089#1077#1082'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -37
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lStages: TLabel
    Left = 646
    Top = 99
    Width = 137
    Height = 45
    AutoSize = False
    Caption = '%s'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -37
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 646
    Top = 68
    Width = 53
    Height = 25
    Caption = #1069#1090#1072#1087':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object pbTime: TProgressBar
    Left = 63
    Top = 392
    Width = 650
    Height = 49
    Step = 1
    TabOrder = 0
  end
  object Chart: TChart
    Left = 8
    Top = 488
    Width = 775
    Height = 146
    Legend.Title.Visible = False
    Legend.Visible = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3D = False
    BevelOuter = bvNone
    Color = clSilver
    TabOrder = 1
    PrintMargins = (
      15
      37
      15
      37)
    ColorPaletteIndex = 10
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 20
      Marks.Visible = False
      SeriesColor = clYellow
      InvertedStairs = True
      LinePen.Color = clYellow
      LinePen.Width = 3
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      Stairs = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = clRed
      InvertedStairs = True
      LinePen.Color = clRed
      LinePen.Width = 3
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      Stairs = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object btGo: TButton
    Left = 229
    Top = 656
    Width = 331
    Height = 64
    Caption = #1055#1086#1077#1093#1072#1083#1080'!'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btGoClick
  end
  object btLoad: TButton
    Left = 624
    Top = 695
    Width = 75
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100
    TabOrder = 3
    OnClick = btLoadClick
  end
  object Button1: TButton
    Left = 63
    Top = 695
    Width = 90
    Height = 25
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    TabOrder = 4
    OnClick = Button1Click
  end
  object odOpen: TOpenDialog
    Filter = #1063#1072#1089#1086#1074#1099#1077' '#1094#1080#1082#1083#1099' (*.hcf)|*.hcf'
    Left = 128
    Top = 24
  end
end
