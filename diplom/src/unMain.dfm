object fmMain: TfmMain
  Left = 192
  Top = 122
  Width = 870
  Height = 500
  Caption = #1050#1072#1088#1090#1099' '#1082#1083#1077#1084#1084#1085#1099#1093' '#1087#1086#1083#1077#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnMain
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TplPanel: TPanel
    Left = 624
    Top = 0
    Width = 185
    Height = 41
    Caption = 'TplPanel'
    TabOrder = 0
    Visible = False
    OnClick = TplPanelClick
    OnMouseUp = TplPanelMouseUp
  end
  object DBGrid1: TDBGrid
    Left = 520
    Top = 304
    Width = 320
    Height = 120
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'podsname'
        Width = 200
        Visible = True
      end>
  end
  object TplButton: TButton
    Left = 680
    Top = 48
    Width = 75
    Height = 25
    Caption = 'TplButton'
    TabOrder = 2
    Visible = False
    OnClick = TplButtonClick
  end
  object DBGrid2: TDBGrid
    Left = 520
    Top = 168
    Width = 320
    Height = 120
    DataSource = DataSource2
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id_podst'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'placename'
        Width = 200
        Visible = True
      end>
  end
  object mnMain: TMainMenu
    object mnFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object mnMap: TMenuItem
        Caption = #1057#1086#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1082#1072#1088#1090#1099
        OnClick = mnMapClick
      end
      object mnMapManual: TMenuItem
        Caption = #1056#1091#1095#1085#1086#1077' '#1089#1086#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1082#1072#1088#1090#1099
        OnClick = mnMapManualClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = mnExitClick
      end
    end
    object mnEl: TMenuItem
      Caption = #1069#1083#1077#1084#1077#1085#1090#1099
      object mnPlace: TMenuItem
        Caption = #1055#1086#1076#1089#1090#1072#1074#1082#1072
        OnClick = mnPlaceClick
      end
    end
    object mnSystem: TMenuItem
      Caption = #1057#1080#1089#1090#1077#1084#1072
      object mnCompConf: TMenuItem
        Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' '#1082#1086#1084#1087#1083#1077#1082#1089#1072
        OnClick = mnCompConfClick
      end
      object mnUnitsConf: TMenuItem
        Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
        OnClick = mnUnitsConfClick
      end
      object mnSignal: TMenuItem
        Caption = #1058#1080#1087#1099' '#1089#1080#1075#1085#1072#1083#1086#1074
        OnClick = mnSignalClick
      end
      object mnTags: TMenuItem
        Caption = #1058#1077#1075#1080' '#1074#1086#1079#1076#1077#1081#1089#1090#1074#1080#1081
        OnClick = mnTagsClick
      end
    end
    object mnHelpMenu: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
      object mnHelp: TMenuItem
        Caption = #1057#1087#1088#1072#1074#1082#1072
        OnClick = mnHelpClick
      end
    end
  end
  object mnCont: TPopupMenu
    MenuAnimation = [maLeftToRight, maBottomToTop]
    Left = 32
    object mnPodRnm: TMenuItem
      Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100
      OnClick = mnPodRnmClick
    end
    object mnRemove: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = mnRemoveClick
    end
    object mnCrPlace: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1084#1077#1089#1090#1086
      OnClick = mnCrPlaceClick
    end
  end
  object ADOQuery: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    Left = 64
  end
  object tbPodst: TADOTable
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    TableName = 'podst'
    Left = 96
  end
  object DataSource1: TDataSource
    DataSet = tbPodst
    Left = 128
  end
  object mnContPlace: TPopupMenu
    Left = 32
    Top = 32
    object mnPlaceRename: TMenuItem
      Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100
      OnClick = mnPlaceRenameClick
    end
    object mnConnector: TMenuItem
      Caption = #1056#1072#1079#1098#1105#1084#1099
      OnClick = mnConnectorClick
    end
    object mnPlaceDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = mnPlaceDelClick
    end
  end
  object QPlaces: TADOQuery
    Connection = fmDM.ADOConn
    Parameters = <>
    SQL.Strings = (
      'Select id,placename from places where id_podst=1'
      'order by id')
    Left = 64
    Top = 32
    object QPlacesid: TIntegerField
      FieldName = 'id'
    end
    object QPlacesplacename: TStringField
      FieldName = 'placename'
      Size = 255
    end
  end
  object tbPlaces: TADOTable
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    TableName = 'places'
    Left = 96
    Top = 32
    object tbPlacesid: TIntegerField
      FieldName = 'id'
    end
    object tbPlacesid_podst: TIntegerField
      FieldName = 'id_podst'
    end
    object tbPlacesplacename: TStringField
      FieldName = 'placename'
      Size = 255
    end
  end
  object DataSource2: TDataSource
    DataSet = tbPlaces
    Left = 128
    Top = 32
  end
  object QConnector: TADOQuery
    Parameters = <>
    Left = 64
    Top = 64
  end
end
