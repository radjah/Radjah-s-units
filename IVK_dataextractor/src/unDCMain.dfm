object fmDCMain: TfmDCMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'fmDCMain'
  ClientHeight = 175
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object leDataFile: TLabeledEdit
    Left = 8
    Top = 32
    Width = 289
    Height = 21
    EditLabel.Width = 72
    EditLabel.Height = 13
    EditLabel.Caption = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093':'
    TabOrder = 0
  end
  object leExcelFile: TLabeledEdit
    Left = 8
    Top = 80
    Width = 289
    Height = 21
    EditLabel.Width = 58
    EditLabel.Height = 13
    EditLabel.Caption = #1060#1072#1081#1083' Excel:'
    TabOrder = 1
  end
  object btDataFile: TButton
    Left = 303
    Top = 30
    Width = 75
    Height = 25
    Caption = #1054#1073#1079#1086#1088
    TabOrder = 2
    OnClick = btDataFileClick
  end
  object btExcelFile: TButton
    Left = 303
    Top = 78
    Width = 75
    Height = 25
    Caption = #1054#1073#1079#1086#1088
    TabOrder = 3
    OnClick = btExcelFileClick
  end
  object btConvert: TButton
    Left = 128
    Top = 128
    Width = 132
    Height = 25
    Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100
    TabOrder = 4
    OnClick = btConvertClick
  end
  object odDataFile: TOpenDialog
    DefaultExt = 'msr'
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093' (*.msr)|*.msr'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 32
    Top = 112
  end
  object sdExcelFile: TSaveDialog
    DefaultExt = 'xls'
    Filter = #1050#1085#1080#1075#1080' Excel (*.xls)|*.xls'
    Left = 320
    Top = 120
  end
end
