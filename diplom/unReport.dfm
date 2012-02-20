object fmReport: TfmReport
  Left = 118
  Top = 116
  Width = 1162
  Height = 500
  Caption = 'fmReport'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object QuickRep1: TQuickRep
    Left = 0
    Top = 0
    Width = 1123
    Height = 794
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    DataSet = qReport
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poLandscape
    Page.PaperSize = A4
    Page.Values = (
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.OutputBin = Auto
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    object ColumnHeaderBand1: TQRBand
      Left = 38
      Top = 78
      Width = 1047
      Height = 40
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        2770.187500000000000000)
      BandType = rbColumnHeader
      object QRLabel1: TQRLabel
        Left = 0
        Top = 0
        Width = 561
        Height = 41
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          108.479166666666700000
          0.000000000000000000
          0.000000000000000000
          1484.312500000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1080#1075#1085#1072#1083#1072
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel2: TQRLabel
        Left = 560
        Top = 0
        Width = 89
        Height = 41
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          108.479166666666700000
          1481.666666666667000000
          0.000000000000000000
          235.479166666666700000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1048#1076#1077#1085#1090'-'#1088
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel3: TQRLabel
        Left = 648
        Top = 16
        Width = 105
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          66.145833333333340000
          1714.500000000000000000
          42.333333333333340000
          277.812500000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1059#1089#1090#1088#1086#1081#1089#1090#1074#1086
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel4: TQRLabel
        Left = 752
        Top = 16
        Width = 105
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          66.145833333333340000
          1989.666666666667000000
          42.333333333333340000
          277.812500000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1052#1077#1089#1090#1086
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel5: TQRLabel
        Left = 856
        Top = 16
        Width = 97
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          66.145833333333340000
          2264.833333333333000000
          42.333333333333340000
          256.645833333333400000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1050#1086#1085#1090#1072#1082#1090
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel6: TQRLabel
        Left = 952
        Top = 0
        Width = 97
        Height = 41
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          108.479166666666700000
          2518.833333333333000000
          0.000000000000000000
          256.645833333333400000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1058#1077#1075#1080' '#1069#1047#1040#1053#1072
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel7: TQRLabel
        Left = 648
        Top = 0
        Width = 105
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          44.979166666666670000
          1714.500000000000000000
          0.000000000000000000
          277.812500000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1050#1091#1076#1072' '#1080#1076#1077#1090
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRLabel8: TQRLabel
        Left = 752
        Top = 0
        Width = 201
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          44.979166666666670000
          1989.666666666667000000
          0.000000000000000000
          531.812500000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = #1054#1090#1082#1091#1076#1072' '#1080#1076#1077#1090
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
    object PageHeaderBand1: TQRBand
      Left = 38
      Top = 38
      Width = 1047
      Height = 40
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        105.833333333333300000
        2770.187500000000000000)
      BandType = rbPageHeader
      object QRLabel9: TQRLabel
        Left = 440
        Top = 8
        Width = 282
        Height = 30
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          79.375000000000000000
          1164.166666666667000000
          21.166666666666670000
          746.125000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = #1050#1072#1088#1090#1072' '#1082#1083#1077#1084#1084#1085#1099#1093' '#1087#1086#1083#1077#1081
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 18
      end
    end
    object DetailBand1: TQRBand
      Left = 38
      Top = 118
      Width = 1047
      Height = 25
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        66.145833333333340000
        2770.187500000000000000)
      BandType = rbDetail
      object QRDBText2: TQRDBText
        Left = 560
        Top = 0
        Width = 89
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          66.145833333333340000
          1481.666666666667000000
          0.000000000000000000
          235.479166666666700000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = qReport
        DataField = 'ProbTag'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText1: TQRDBText
        Left = 0
        Top = 0
        Width = 561
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          66.145833333333340000
          0.000000000000000000
          0.000000000000000000
          1484.312500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = qReport
        DataField = 'ProbName'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText3: TQRDBText
        Left = 648
        Top = 0
        Width = 105
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          66.145833333333340000
          1714.500000000000000000
          0.000000000000000000
          277.812500000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = qReport
        DataField = 'unname'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText4: TQRDBText
        Left = 752
        Top = 0
        Width = 105
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          66.145833333333340000
          1989.666666666667000000
          0.000000000000000000
          277.812500000000000000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = qReport
        DataField = 'placename'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText5: TQRDBText
        Left = 856
        Top = 0
        Width = 97
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          66.145833333333340000
          2264.833333333333000000
          0.000000000000000000
          256.645833333333400000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = qReport
        DataField = 'connname'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
      object QRDBText6: TQRDBText
        Left = 952
        Top = 0
        Width = 97
        Height = 25
        Frame.Color = clBlack
        Frame.DrawTop = True
        Frame.DrawBottom = True
        Frame.DrawLeft = True
        Frame.DrawRight = True
        Size.Values = (
          66.145833333333340000
          2518.833333333333000000
          0.000000000000000000
          256.645833333333400000)
        Alignment = taCenter
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Color = clWhite
        DataSet = qReport
        DataField = 'conttag'
        Transparent = False
        WordWrap = True
        FontSize = 10
      end
    end
  end
  object qReport: TADOQuery
    Active = True
    Connection = fmDM.ADOConn
    CursorType = ctStatic
    OnCalcFields = qReportCalcFields
    Parameters = <>
    SQL.Strings = (
      
        'SELECT     probtags.ProbName, probtags.ProbTag, testunits.unname' +
        ', places.placename, connector.connname, signame.sigtag, contact.' +
        'contnum'
      'FROM         map INNER JOIN'
      
        '                      contact ON map.contid = contact.id INNER J' +
        'OIN'
      
        '                      unittags ON map.unittag = unittags.id INNE' +
        'R JOIN'
      
        '                      connector ON connector.id = contact.id_con' +
        'n INNER JOIN'
      
        '                      probtags ON unittags.tagid = probtags.id I' +
        'NNER JOIN'
      
        '                      testunits ON unittags.unitid = testunits.u' +
        'nid INNER JOIN'
      
        '                      signame ON contact.id_sig = signame.sigid ' +
        'INNER JOIN'
      '                      places ON connector.id_place = places.id')
    Left = 16
    Top = 16
    object qReportProbName: TStringField
      FieldName = 'ProbName'
      Size = 255
    end
    object qReportProbTag: TStringField
      FieldName = 'ProbTag'
      Size = 10
    end
    object qReportunname: TStringField
      FieldName = 'unname'
      Size = 128
    end
    object qReportplacename: TStringField
      FieldName = 'placename'
      Size = 255
    end
    object qReportconnname: TStringField
      FieldName = 'connname'
      Size = 255
    end
    object qReportsigtag: TStringField
      FieldName = 'sigtag'
      Size = 10
    end
    object qReportcontnum: TIntegerField
      FieldName = 'contnum'
    end
    object qReportconttag: TStringField
      FieldKind = fkCalculated
      FieldName = 'conttag'
      Size = 32
      Calculated = True
    end
  end
end
