object fmResult: TfmResult
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1081
  ClientHeight = 346
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lTime: TLabel
    Left = 13
    Top = 276
    Width = 24
    Height = 13
    Caption = 'lTime'
  end
  object sgResult: TStringGrid
    Left = 13
    Top = 8
    Width = 337
    Height = 262
    RowCount = 10
    TabOrder = 0
  end
  object btClose: TButton
    Left = 144
    Top = 304
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 11
    TabOrder = 1
  end
end
