object fmSettings: TfmSettings
  Left = 286
  Top = 236
  ActiveControl = deDefDir
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 202
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 186
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1103' '#1087#1086'-'#1091#1084#1086#1083#1095#1072#1085#1080#1102':'
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 329
    Height = 13
    Caption = #1045#1089#1083#1080' '#1085#1077' '#1091#1082#1072#1079#1072#1085#1072', '#1090#1086' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103' '#1087#1072#1087#1082#1072' '#1089' '#1092#1072#1081#1083#1086#1084' '#1089#1090#1072#1088#1086#1081' '#1073#1072#1079#1099'.'
  end
  object Label3: TLabel
    Left = 16
    Top = 88
    Width = 233
    Height = 13
    Caption = #1055#1088#1080#1079#1099#1074' '#1087#1086'-'#1091#1084#1086#1083#1095#1072#1085#1080#1102' ('#1076#1083#1103' 2-10 '#1074#1074#1086#1076#1080#1090#1100' 210):'
  end
  object Label4: TLabel
    Left = 16
    Top = 128
    Width = 203
    Height = 13
    Caption = #1045#1089#1083#1080' '#1085#1077' '#1091#1082#1072#1079#1072#1085', '#1090#1086' '#1073#1091#1076#1077#1090' '#1074#1099#1076#1072#1085' '#1079#1072#1087#1088#1086#1089'.'
  end
  object deDefDir: TsDirectoryEdit
    Left = 16
    Top = 32
    Width = 441
    Height = 21
    AutoSize = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 255
    ParentFont = False
    TabOrder = 0
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
    GlyphMode.Blend = 0
    GlyphMode.Grayed = False
    InitialDir = 'c:\'
    Root = 'rfDesktop'
  end
  object mePR: TsMaskEdit
    Left = 16
    Top = 104
    Width = 31
    Height = 21
    Color = clWhite
    EditMask = '###;1;0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 3
    ParentFont = False
    TabOrder = 1
    Text = '   '
    BoundLabel.Indent = 0
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clWindowText
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'MS Sans Serif'
    BoundLabel.Font.Style = []
    BoundLabel.Layout = sclLeft
    BoundLabel.MaxWidth = 0
    BoundLabel.UseSkinColor = True
    SkinData.SkinSection = 'EDIT'
  end
  object btSave: TsBitBtn
    Left = 151
    Top = 160
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = btSaveClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      555555555555555555555555555555555555555555FF55555555555559055555
      55555555577FF5555555555599905555555555557777F5555555555599905555
      555555557777FF5555555559999905555555555777777F555555559999990555
      5555557777777FF5555557990599905555555777757777F55555790555599055
      55557775555777FF5555555555599905555555555557777F5555555555559905
      555555555555777FF5555555555559905555555555555777FF55555555555579
      05555555555555777FF5555555555557905555555555555777FF555555555555
      5990555555555555577755555555555555555555555555555555}
    NumGlyphs = 2
    SkinData.SkinSection = 'BUTTON'
  end
  object btCancel: TsBitBtn
    Left = 247
    Top = 160
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = btCancelClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
      33333337777FF377FF3333993370739993333377FF373F377FF3399993000339
      993337777F777F3377F3393999707333993337F77737333337FF993399933333
      399377F3777FF333377F993339903333399377F33737FF33377F993333707333
      399377F333377FF3377F993333101933399377F333777FFF377F993333000993
      399377FF3377737FF7733993330009993933373FF3777377F7F3399933000399
      99333773FF777F777733339993707339933333773FF7FFF77333333999999999
      3333333777333777333333333999993333333333377777333333}
    NumGlyphs = 2
    SkinData.SkinSection = 'BUTTON'
  end
end
