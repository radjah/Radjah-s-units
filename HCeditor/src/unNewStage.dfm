object fmNewStage: TfmNewStage
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1099#1081' '#1101#1090#1072#1087
  ClientHeight = 607
  ClientWidth = 298
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
  object Label1: TLabel
    Left = 8
    Top = 58
    Width = 121
    Height = 13
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1072#1103' '#1087#1086#1079#1080#1094#1080#1103':'
  end
  object sbPos: TScrollBox
    Left = 8
    Top = 112
    Width = 281
    Height = 445
    VertScrollBar.Smooth = True
    TabOrder = 0
  end
  object eMaxPos: TEdit
    Left = 8
    Top = 77
    Width = 81
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object udMaxPos: TUpDown
    Left = 89
    Top = 77
    Width = 16
    Height = 21
    Associate = eMaxPos
    Min = 1
    Position = 1
    TabOrder = 2
  end
  object btMaxPosSet: TButton
    Left = 160
    Top = 72
    Width = 129
    Height = 26
    Caption = #1047#1072#1076#1072#1090#1100
    TabOrder = 3
    OnClick = btMaxPosSetClick
  end
  object btCreate: TButton
    Left = 76
    Top = 572
    Width = 145
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100
    TabOrder = 4
  end
  object LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 31
    Width = 281
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    TabOrder = 5
  end
end