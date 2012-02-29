object fmCycleEditor: TfmCycleEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1094#1080#1082#1083#1072
  ClientHeight = 554
  ClientWidth = 687
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
    Top = 5
    Width = 73
    Height = 13
    Caption = #1057#1086#1089#1090#1072#1074' '#1094#1080#1082#1083#1072':'
  end
  object dbgCStruct: TDBGrid
    Left = 8
    Top = 24
    Width = 305
    Height = 329
    DataSource = dsCStruct
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'corder'
        Title.Caption = #8470
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sname'
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1101#1090#1072#1087#1072
        Width = 220
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 368
    Top = 24
    Width = 305
    Height = 331
    DataSource = dsStages
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid2CellClick
    OnKeyUp = DBGrid2KeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'sname'
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1101#1090#1072#1087#1072
        Width = 270
        Visible = True
      end>
  end
  object btAdd: TButton
    Left = 319
    Top = 104
    Width = 43
    Height = 25
    Caption = '<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btAddClick
  end
  object btDel: TButton
    Left = 319
    Top = 135
    Width = 43
    Height = 25
    Caption = '>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btDelClick
  end
  object btUp: TButton
    Left = 8
    Top = 359
    Width = 75
    Height = 25
    Caption = #1042#1099#1096#1077
    TabOrder = 4
    Visible = False
    OnClick = btUpClick
  end
  object btDown: TButton
    Left = 89
    Top = 359
    Width = 75
    Height = 25
    Caption = #1053#1080#1078#1077
    TabOrder = 5
    Visible = False
  end
  object btClose: TButton
    Left = 265
    Top = 518
    Width = 157
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 6
    OnClick = btCloseClick
  end
  object chStagePreview: TChart
    Left = 368
    Top = 361
    Width = 305
    Height = 151
    Legend.Visible = False
    Title.Text.Strings = (
      #1055#1088#1077#1076#1087#1088#1086#1089#1084#1086#1090#1088)
    View3D = False
    TabOrder = 7
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
  object ztCStruct: TZTable
    Connection = fmMain.ZConnect
    SortedFields = 'corder'
    ReadOnly = True
    TableName = 'cstruct'
    MasterFields = 'cid'
    MasterSource = fmMain.dsCycle
    LinkedFields = 'cid'
    IndexFieldNames = 'corder Asc'
    Left = 16
    Top = 464
    object ztCStructid: TIntegerField
      FieldName = 'id'
    end
    object ztCStructcid: TIntegerField
      FieldName = 'cid'
      Required = True
    end
    object ztCStructcorder: TIntegerField
      FieldName = 'corder'
      Required = True
    end
    object ztCStructsid: TIntegerField
      FieldName = 'sid'
      Required = True
    end
    object ztCStructsname: TStringField
      FieldKind = fkLookup
      FieldName = 'sname'
      LookupDataSet = ztStages
      LookupKeyFields = 'sid'
      LookupResultField = 'sname'
      KeyFields = 'sid'
      Size = 128
      Lookup = True
    end
  end
  object dsCStruct: TDataSource
    DataSet = ztCStruct
    Left = 88
    Top = 464
  end
  object ztStages: TZTable
    Connection = fmMain.ZConnect
    ReadOnly = True
    TableName = 'stages'
    Left = 168
    Top = 400
  end
  object dsStages: TDataSource
    DataSet = ztStages
    Left = 224
    Top = 400
  end
  object zqGetOrder: TZQuery
    Connection = fmMain.ZConnect
    SQL.Strings = (
      'SELECT  MAX(cstruct.corder) AS maxord FROM  cstruct WHERE'
      'cid = 1')
    Params = <>
    Left = 168
    Top = 464
    object zqGetOrdermaxord: TWideStringField
      FieldName = 'maxord'
      ReadOnly = True
      Size = 255
    end
  end
  object zqCheckEmpty: TZQuery
    Connection = fmMain.ZConnect
    SQL.Strings = (
      'select count(sid) as scount from cstruct where'
      'cid=1')
    Params = <>
    Left = 88
    Top = 400
  end
  object zqCommon: TZQuery
    Connection = fmMain.ZConnect
    Params = <>
    Left = 16
    Top = 400
  end
end
