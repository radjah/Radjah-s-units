object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1079#1074#1083#1077#1095#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 609
  ClientWidth = 755
  Color = clBtnFace
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
    Left = 8
    Top = 53
    Width = 74
    Height = 13
    Caption = #1043#1088#1091#1087#1087#1099' '#1090#1077#1075#1086#1074':'
  end
  object Label2: TLabel
    Left = 8
    Top = 213
    Width = 119
    Height = 13
    Caption = #1057#1087#1080#1089#1086#1082' '#1090#1077#1075#1086#1074' '#1074' '#1075#1088#1091#1087#1087#1077':'
  end
  object Label7: TLabel
    Left = 448
    Top = 415
    Width = 49
    Height = 13
    Caption = #1055#1088#1086#1090#1086#1082#1086#1083
  end
  object btConnect: TButton
    Left = 8
    Top = 8
    Width = 113
    Height = 25
    Caption = #1057#1086#1077#1076#1080#1085#1080#1090#1100#1089#1103
    TabOrder = 0
    OnClick = btConnectClick
  end
  object dbgTagGroup: TDBGrid
    Left = 9
    Top = 72
    Width = 736
    Height = 97
    DataSource = dsTagGroup
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Table_Name'
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tables_Number'
        Title.Caption = #1050#1086#1083'-'#1074#1086' '#1090#1072#1073#1083#1080#1094
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Table_Tags'
        Title.Caption = #1058#1072#1073#1083#1080#1094#1072' '#1090#1077#1075#1086#1074
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Group_Name'
        Title.Caption = #1048#1084#1103' '#1075#1088#1091#1087#1087#1099
        Width = 150
        Visible = True
      end>
  end
  object btGetTags: TButton
    Left = 8
    Top = 175
    Width = 113
    Height = 25
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
    Enabled = False
    TabOrder = 2
    OnClick = btGetTagsClick
  end
  object dbgTagList: TDBGrid
    Left = 8
    Top = 232
    Width = 737
    Height = 177
    DataSource = dsTagList
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Logging_Name'
        Title.Caption = #1048#1084#1103
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Signal_Name'
        Title.Caption = #1058#1077#1075
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tag_Index'
        Title.Caption = #1048#1085#1076#1077#1082#1089
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Description'
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tag_Comments'
        Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
        Width = 150
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 415
    Width = 417
    Height = 138
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1074#1099#1073#1086#1088#1082#1080
    TabOrder = 4
    object Label3: TLabel
      Left = 16
      Top = 29
      Width = 69
      Height = 13
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
    end
    object Label4: TLabel
      Left = 216
      Top = 32
      Width = 87
      Height = 13
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
    end
    object Label5: TLabel
      Left = 16
      Top = 77
      Width = 73
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1085#1072#1095#1072#1083#1072':'
    end
    object Label6: TLabel
      Left = 216
      Top = 77
      Width = 91
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
    end
    object dtpDateBegin: TDateTimePicker
      Left = 16
      Top = 48
      Width = 186
      Height = 21
      Date = 41193.000000000000000000
      Time = 41193.000000000000000000
      DateFormat = dfLong
      TabOrder = 0
    end
    object dtpDateEnd: TDateTimePicker
      Left = 216
      Top = 48
      Width = 186
      Height = 21
      Date = 41193.345461296300000000
      Time = 41193.345461296300000000
      DateFormat = dfLong
      TabOrder = 2
    end
    object dtpTimeBegin: TDateTimePicker
      Left = 16
      Top = 96
      Width = 186
      Height = 21
      Date = 41193.346280370370000000
      Time = 41193.346280370370000000
      DateFormat = dfLong
      Kind = dtkTime
      TabOrder = 1
    end
    object dtpTimeEnd: TDateTimePicker
      Left = 216
      Top = 96
      Width = 186
      Height = 21
      Date = 41193.346823657400000000
      Time = 41193.346823657400000000
      Kind = dtkTime
      TabOrder = 3
    end
  end
  object btExtract: TButton
    Left = 224
    Top = 559
    Width = 130
    Height = 25
    Caption = #1048#1079#1074#1083#1077#1095' '#1076#1072#1085#1085#1099#1077
    Enabled = False
    TabOrder = 5
    OnClick = btExtractClick
  end
  object mLog: TMemo
    Left = 450
    Top = 434
    Width = 297
    Height = 119
    ScrollBars = ssBoth
    TabOrder = 6
  end
  object btView: TButton
    Left = 80
    Top = 559
    Width = 130
    Height = 25
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088
    TabOrder = 7
    OnClick = btViewClick
  end
  object qExtractor: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      
        'SELECT     Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_1' +
        ' as TD, Sample_MSec_1 as SMS, BS3_Analog_Table_1.Sample_Value_1 ' +
        'as VAL'
      'FROM         BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_1 IS NULL)) AND (NOT (Sample_MSec_1' +
        ' IS NULL)) AND (NOT (Sample_Value_1 IS NULL)) and Signal_Index=1'
      'union all'
      
        'select'#9'  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_2 a' +
        's TD, Sample_MSec_2 as SMS, BS3_Analog_Table_1.Sample_Value_2 as' +
        ' VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_2 IS NULL)) AND (NOT (Sample_MSec_2' +
        ' IS NULL)) AND (NOT (Sample_Value_2 IS NULL)) and Signal_Index=1'
      'union all'
      
        'select'#9'  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_3 a' +
        's TD, Sample_MSec_3 as SMS, BS3_Analog_Table_1.Sample_Value_3 as' +
        ' VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_3 IS NULL)) AND (NOT (Sample_MSec_3' +
        ' IS NULL)) AND (NOT (Sample_Value_3 IS NULL)) and Signal_Index=1'
      'union all'
      
        'select'#9'  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_4 a' +
        's TD, Sample_MSec_4 as SMS, BS3_Analog_Table_1.Sample_Value_4 as' +
        ' VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_4 IS NULL)) AND (NOT (Sample_MSec_4' +
        ' IS NULL)) AND (NOT (Sample_Value_4 IS NULL)) and Signal_Index=1'
      'union all'
      
        'select'#9'  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_5 a' +
        's TD, Sample_MSec_5 as SMS, BS3_Analog_Table_1.Sample_Value_5 as' +
        ' VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_5 IS NULL)) AND (NOT (Sample_MSec_5' +
        ' IS NULL)) AND (NOT (Sample_Value_5 IS NULL)) and Signal_Index=1'
      'union all'
      
        'select'#9'  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_6 a' +
        's TD, Sample_MSec_6 as SMS, BS3_Analog_Table_1.Sample_Value_6 as' +
        ' VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_1 IS NULL)) AND (NOT (Sample_MSec_6' +
        ' IS NULL)) AND (NOT (Sample_Value_6 IS NULL)) and Signal_Index=1'
      'union all'
      
        'select'#9'  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_7 a' +
        's TD, Sample_MSec_7 as SMS, BS3_Analog_Table_1.Sample_Value_7 as' +
        ' VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_7 IS NULL)) AND (NOT (Sample_MSec_7' +
        ' IS NULL)) AND (NOT (Sample_Value_7 IS NULL)) and Signal_Index=1'
      'union all'
      
        'select'#9'  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_8 a' +
        's TD, Sample_MSec_8 as SMS, BS3_Analog_Table_1.Sample_Value_8 as' +
        ' VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_8 IS NULL)) AND (NOT (Sample_MSec_8' +
        ' IS NULL)) AND (NOT (Sample_Value_8 IS NULL)) and Signal_Index=1'
      'union all'
      
        'select'#9'  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_9 a' +
        's TD, Sample_MSec_9 as SMS, BS3_Analog_Table_1.Sample_Value_9 as' +
        ' VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_9 IS NULL)) AND (NOT (Sample_MSec_9' +
        ' IS NULL)) AND (NOT (Sample_Value_9 IS NULL)) and Signal_Index=1'
      'union all'
      
        'select'#9'  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_10 ' +
        'as TD, Sample_MSec_10 as SMS, BS3_Analog_Table_1.Sample_Value_10' +
        ' as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_10 IS NULL)) AND (NOT (Sample_MSec_' +
        '10 IS NULL)) AND (NOT (Sample_Value_10 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_11 a' +
        's TD, Sample_MSec_11 as SMS, BS3_Analog_Table_1.Sample_Value_11 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_11 IS NULL)) AND (NOT (Sample_MSec_' +
        '11 IS NULL)) AND (NOT (Sample_Value_11 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_12 a' +
        's TD, Sample_MSec_12 as SMS, BS3_Analog_Table_1.Sample_Value_12 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_12 IS NULL)) AND (NOT (Sample_MSec_' +
        '12 IS NULL)) AND (NOT (Sample_Value_12 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_13 a' +
        's TD, Sample_MSec_13 as SMS, BS3_Analog_Table_1.Sample_Value_13 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_13 IS NULL)) AND (NOT (Sample_MSec_' +
        '13 IS NULL)) AND (NOT (Sample_Value_13 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_14 a' +
        's TD, Sample_MSec_14 as SMS, BS3_Analog_Table_1.Sample_Value_14 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_14 IS NULL)) AND (NOT (Sample_MSec_' +
        '14 IS NULL)) AND (NOT (Sample_Value_14 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_15 a' +
        's TD, Sample_MSec_15 as SMS, BS3_Analog_Table_1.Sample_Value_15 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_15 IS NULL)) AND (NOT (Sample_MSec_' +
        '15 IS NULL)) AND (NOT (Sample_Value_15 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_16 a' +
        's TD, Sample_MSec_16 as SMS, BS3_Analog_Table_1.Sample_Value_16 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_16 IS NULL)) AND (NOT (Sample_MSec_' +
        '16 IS NULL)) AND (NOT (Sample_Value_16 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_17 a' +
        's TD, Sample_MSec_17 as SMS, BS3_Analog_Table_1.Sample_Value_17 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_17 IS NULL)) AND (NOT (Sample_MSec_' +
        '17 IS NULL)) AND (NOT (Sample_Value_17 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_18 a' +
        's TD, Sample_MSec_18 as SMS, BS3_Analog_Table_1.Sample_Value_18 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_18 IS NULL)) AND (NOT (Sample_MSec_' +
        '18 IS NULL)) AND (NOT (Sample_Value_18 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_19 a' +
        's TD, Sample_MSec_19 as SMS, BS3_Analog_Table_1.Sample_Value_19 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_19 IS NULL)) AND (NOT (Sample_MSec_' +
        '19 IS NULL)) AND (NOT (Sample_Value_19 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_20 a' +
        's TD, Sample_MSec_20 as SMS, BS3_Analog_Table_1.Sample_Value_20 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_20 IS NULL)) AND (NOT (Sample_MSec_' +
        '20 IS NULL)) AND (NOT (Sample_Value_20 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_21 a' +
        's TD, Sample_MSec_21 as SMS, BS3_Analog_Table_1.Sample_Value_21 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_21 IS NULL)) AND (NOT (Sample_MSec_' +
        '21 IS NULL)) AND (NOT (Sample_Value_21 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_22 a' +
        's TD, Sample_MSec_22 as SMS, BS3_Analog_Table_1.Sample_Value_22 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_22 IS NULL)) AND (NOT (Sample_MSec_' +
        '22 IS NULL)) AND (NOT (Sample_Value_22 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_23 a' +
        's TD, Sample_MSec_23 as SMS, BS3_Analog_Table_1.Sample_Value_23 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_23 IS NULL)) AND (NOT (Sample_MSec_' +
        '23 IS NULL)) AND (NOT (Sample_Value_23 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_24 a' +
        's TD, Sample_MSec_24 as SMS, BS3_Analog_Table_1.Sample_Value_24 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_24 IS NULL)) AND (NOT (Sample_MSec_' +
        '24 IS NULL)) AND (NOT (Sample_Value_24 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_25 a' +
        's TD, Sample_MSec_25 as SMS, BS3_Analog_Table_1.Sample_Value_25 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_25 IS NULL)) AND (NOT (Sample_MSec_' +
        '25 IS NULL)) AND (NOT (Sample_Value_25 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_26 a' +
        's TD, Sample_MSec_26 as SMS, BS3_Analog_Table_1.Sample_Value_26 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_26 IS NULL)) AND (NOT (Sample_MSec_' +
        '26 IS NULL)) AND (NOT (Sample_Value_26 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_27 a' +
        's TD, Sample_MSec_27 as SMS, BS3_Analog_Table_1.Sample_Value_27 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_27 IS NULL)) AND (NOT (Sample_MSec_' +
        '27 IS NULL)) AND (NOT (Sample_Value_27 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_28 a' +
        's TD, Sample_MSec_28 as SMS, BS3_Analog_Table_1.Sample_Value_28 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_28 IS NULL)) AND (NOT (Sample_MSec_' +
        '28 IS NULL)) AND (NOT (Sample_Value_28 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_29 a' +
        's TD, Sample_MSec_29 as SMS, BS3_Analog_Table_1.Sample_Value_29 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_29 IS NULL)) AND (NOT (Sample_MSec_' +
        '29 IS NULL)) AND (NOT (Sample_Value_29 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_30 a' +
        's TD, Sample_MSec_30 as SMS, BS3_Analog_Table_1.Sample_Value_30 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_30 IS NULL)) AND (NOT (Sample_MSec_' +
        '30 IS NULL)) AND (NOT (Sample_Value_30 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_31 a' +
        's TD, Sample_MSec_31 as SMS, BS3_Analog_Table_1.Sample_Value_31 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_31 IS NULL)) AND (NOT (Sample_MSec_' +
        '31 IS NULL)) AND (NOT (Sample_Value_31 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_32 a' +
        's TD, Sample_MSec_32 as SMS, BS3_Analog_Table_1.Sample_Value_32 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_32 IS NULL)) AND (NOT (Sample_MSec_' +
        '32 IS NULL)) AND (NOT (Sample_Value_32 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_33 a' +
        's TD, Sample_MSec_33 as SMS, BS3_Analog_Table_1.Sample_Value_33 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_33 IS NULL)) AND (NOT (Sample_MSec_' +
        '33 IS NULL)) AND (NOT (Sample_Value_33 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_34 a' +
        's TD, Sample_MSec_34 as SMS, BS3_Analog_Table_1.Sample_Value_34 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_34 IS NULL)) AND (NOT (Sample_MSec_' +
        '34 IS NULL)) AND (NOT (Sample_Value_34 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_35 a' +
        's TD, Sample_MSec_35 as SMS, BS3_Analog_Table_1.Sample_Value_35 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_35 IS NULL)) AND (NOT (Sample_MSec_' +
        '35 IS NULL)) AND (NOT (Sample_Value_35 IS NULL)) and Signal_Inde' +
        'x=1'
      'union all'
      
        'select  Signal_Index as SI, BS3_Analog_Table_1.Sample_TDate_36 a' +
        's TD, Sample_MSec_36 as SMS, BS3_Analog_Table_1.Sample_Value_36 ' +
        'as VAL'
      'from                      BS3_Analog_Table_1'
      
        'WHERE     (NOT (Sample_TDate_36 IS NULL)) AND (NOT (Sample_MSec_' +
        '36 IS NULL)) AND (NOT (Sample_Value_36 IS NULL)) and Signal_Inde' +
        'x=1'
      'order by SI, TD, SMS')
    Left = 480
    Top = 9
  end
  object dsTagGroup: TDataSource
    DataSet = IVK_DM.tbTWX_GLOBAL
    Left = 152
    Top = 8
  end
  object dsTagList: TDataSource
    DataSet = IVK_DM.tbTags
    Left = 216
    Top = 8
  end
  object qGetTabCount: TADOQuery
    Connection = IVK_DM.connIVK_DB
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select Table_Name, Tables_Number from TWX_GLOBAL'
      'where'
      'Table_Tags='#39'GPS_Table_Tags'#39)
    Left = 280
    Top = 8
    object qGetTabCountTables_Number: TIntegerField
      FieldName = 'Tables_Number'
    end
    object qGetTabCountTable_Name: TStringField
      FieldName = 'Table_Name'
      FixedChar = True
      Size = 60
    end
  end
  object qTempTable: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      'create table #tmpselect('
      #9#9'SI int NOT NULL,'
      #9#9'TD datetime NOT NULL,'
      #9#9'SMS int NULL,'
      #9#9'VAL float NOT NULL'
      #9')')
    Left = 352
    Top = 8
  end
  object qClearTmp: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      'delete from #tmpselect')
    Left = 416
    Top = 8
  end
  object qForExport: TADOQuery
    Connection = IVK_DM.connIVK_DB
    Parameters = <>
    SQL.Strings = (
      'select * from #tmpselect'
      'order by SI, TD, SMS')
    Left = 552
    Top = 8
  end
  object sdResult: TSaveDialog
    Filter = #1050#1085#1080#1075#1080' Excel (*.xls)|*.xls'
    Left = 632
    Top = 8
  end
end
