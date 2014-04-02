object fmChart: TfmChart
  Left = 238
  Top = 143
  Width = 842
  Height = 606
  Caption = #1043#1088#1072#1092#1080#1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    826
    568)
  PixelsPerInch = 96
  TextHeight = 13
  object chMass: TChart
    Left = 8
    Top = 8
    Width = 809
    Height = 553
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clBlue
    Title.Font.Height = -16
    Title.Font.Name = 'Arial'
    Title.Font.Style = []
    Title.Text.Strings = (
      #1048#1079#1084#1077#1085#1077#1085#1077#1080#1077' '#1084#1072#1089#1089#1099' '#1087#1086' '#1074#1088#1077#1084#1077#1085#1080)
    BottomAxis.Title.Caption = #1042#1088#1077#1084#1103', '#1089
    LeftAxis.Title.Caption = #1052#1072#1089#1089#1072', '#1082#1075
    Legend.Visible = False
    View3D = False
    TabOrder = 0
    Anchors = [akLeft, akTop, akRight, akBottom]
    object sMess: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
end
