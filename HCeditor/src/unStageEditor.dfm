object fmStageEditor: TfmStageEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1101#1090#1072#1087#1086#1074' '#1094#1080#1082#1083#1072
  ClientHeight = 617
  ClientWidth = 668
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 37
    Height = 13
    Caption = #1069#1090#1072#1087#1099':'
  end
  object Label2: TLabel
    Left = 334
    Top = 13
    Width = 72
    Height = 13
    Caption = #1057#1086#1089#1090#1072#1074' '#1101#1090#1072#1087#1072':'
  end
  object dbgStage: TDBGrid
    Left = 8
    Top = 32
    Width = 320
    Height = 313
    DataSource = dsStage
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'sname'
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 300
        Visible = True
      end>
  end
  object dbgSStruct: TDBGrid
    Left = 334
    Top = 32
    Width = 320
    Height = 313
    DataSource = dsSStruct
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'clevel'
        Title.Caption = #1055#1086#1079#1080#1094#1080#1103
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ptime'
        Title.Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
        Width = 150
        Visible = True
      end>
  end
  object btSCreate: TButton
    Left = 8
    Top = 351
    Width = 75
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100
    TabOrder = 2
    OnClick = btSCreateClick
  end
  object btSDelete: TButton
    Left = 89
    Top = 351
    Width = 75
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 3
  end
  object btPosDel: TButton
    Left = 334
    Top = 351
    Width = 155
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1079#1080#1094#1080#1102
    TabOrder = 4
  end
  object Chart1: TChart
    Left = 8
    Top = 416
    Width = 650
    Height = 185
    Legend.Visible = False
    Title.Text.Strings = (
      #1055#1088#1077#1076#1087#1088#1086#1089#1084#1086#1090#1088)
    BottomAxis.Title.Caption = #1042#1088#1077#1084#1103
    LeftAxis.Title.Caption = #1055#1086#1079#1080#1094#1080#1103
    View3D = False
    TabOrder = 5
    ColorPaletteIndex = 13
    object Series1: TLineSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      Title = 'Preview'
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
  object ztStage: TZTable
    Connection = fmMain.ZConnect
    TableName = 'stages'
    Left = 472
    Top = 384
  end
  object ztSStruct: TZTable
    Connection = fmMain.ZConnect
    TableName = 'sstruct'
    MasterFields = 'sid'
    MasterSource = dsStage
    LinkedFields = 'sid'
    Left = 520
    Top = 384
  end
  object dsStage: TDataSource
    DataSet = ztStage
    Left = 576
    Top = 384
  end
  object dsSStruct: TDataSource
    DataSet = ztSStruct
    Left = 624
    Top = 384
  end
end
