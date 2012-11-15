object fmChart: TfmChart
  Left = 0
  Top = 0
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1075#1088#1072#1092#1080#1082#1086#1074
  ClientHeight = 469
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object chPreview: TChart
    Left = 0
    Top = 0
    Width = 738
    Height = 469
    Legend.Alignment = laBottom
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    View3D = False
    View3DOptions.Orthogonal = False
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 24
    ExplicitTop = 32
    ExplicitWidth = 400
    ExplicitHeight = 250
    ColorPaletteIndex = 13
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      ValueFormat = '#.##0.###'
      LinePen.Color = 10708548
      Pointer.Brush.Gradient.EndColor = 10708548
      Pointer.Gradient.EndColor = 10708548
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
end
