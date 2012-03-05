object fmPreview: TfmPreview
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080' '#1101#1082#1089#1087#1086#1088#1090
  ClientHeight = 356
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object chPreview: TChart
    Left = 8
    Top = 8
    Width = 727
    Height = 241
    Legend.Visible = False
    Title.Text.Strings = (
      #1055#1088#1077#1076#1087#1088#1086#1089#1084#1086#1090#1088)
    BottomAxis.Title.Caption = #1042#1088#1077#1084#1103
    LeftAxis.Title.Caption = #1055#1086#1079#1080#1094#1080#1103
    View3D = False
    TabOrder = 0
    ColorPaletteIndex = 13
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Title = 'Preview'
      InvertedStairs = True
      LinePen.Color = 10708548
      LinePen.Width = 3
      LinePen.EndStyle = esSquare
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
  object Button1: TButton
    Left = 352
    Top = 255
    Width = 137
    Height = 60
    Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1092#1072#1081#1083
    TabOrder = 1
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 255
    Width = 321
    Height = 96
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
    TabOrder = 2
    object lbTotalTime: TLabel
      Left = 24
      Top = 24
      Width = 54
      Height = 13
      Caption = 'lbTotalTime'
    end
    object lbSwitchCount: TLabel
      Left = 24
      Top = 56
      Width = 68
      Height = 13
      Caption = 'lbSwitchCount'
    end
  end
end
