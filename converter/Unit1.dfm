object Form1: TForm1
  Left = 192
  Top = 109
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1086#1085#1074#1077#1088#1090#1077#1088
  ClientHeight = 149
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 40
    Width = 77
    Height = 13
    Caption = #1050#1072#1095#1077#1089#1090#1074#1086' JPEG'
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'jpeg -> bmp'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 96
    Top = 8
    Width = 75
    Height = 25
    Caption = 'bmp -> jpeg'
    TabOrder = 1
    OnClick = Button2Click
  end
  object TrackBar1: TTrackBar
    Left = 8
    Top = 56
    Width = 457
    Height = 33
    Hint = #1050#1072#1095#1077#1089#1090#1074#1086' jpeg'
    Max = 100
    Min = 1
    PageSize = 5
    Frequency = 10
    Position = 80
    SelEnd = 100
    SelStart = 1
    TabOrder = 2
    OnChange = TrackBar1Change
  end
  object Edit1: TEdit
    Left = 472
    Top = 56
    Width = 33
    Height = 21
    ReadOnly = True
    TabOrder = 3
    Text = '80'
    OnChange = Edit1Change
  end
  object Button3: TButton
    Left = 184
    Top = 8
    Width = 75
    Height = 25
    Caption = 'png -> jpeg'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 272
    Top = 8
    Width = 75
    Height = 25
    Caption = 'jpeg -> jpeg'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = Button4Click
  end
  object UpDown1: TUpDown
    Left = 505
    Top = 56
    Width = 16
    Height = 21
    Associate = Edit1
    Min = 1
    Position = 80
    TabOrder = 6
  end
  object Button5: TButton
    Left = 360
    Top = 8
    Width = 75
    Height = 25
    Caption = 'bmp -> gif'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 448
    Top = 8
    Width = 75
    Height = 25
    Caption = 'gif -> jpeg'
    TabOrder = 8
    OnClick = Button6Click
  end
  object cb: TCheckBox
    Left = 16
    Top = 88
    Width = 241
    Height = 17
    Caption = #1055#1088#1086#1088#1077#1089#1089#1080#1074#1085#1086#1077' '#1082#1086#1076#1080#1088#1086#1074#1072#1085#1080#1077' (JPEG)'
    TabOrder = 9
  end
  object cb2: TCheckBox
    Left = 16
    Top = 112
    Width = 209
    Height = 17
    Caption = #1063'/'#1073' (JPEG)'
    TabOrder = 10
  end
  object sd1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 24
  end
  object opd1: TOpenPictureDialog
  end
  object XPManifest1: TXPManifest
    Top = 64
  end
end
