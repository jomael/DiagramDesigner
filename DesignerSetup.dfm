object DesignerSetupForm: TDesignerSetupForm
  Left = 411
  Top = 164
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 233
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    373
    233)
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 148
    Top = 63
    Width = 83
    Height = 13
    Caption = 'Undo history size:'
  end
  object Label4: TLabel
    Left = 148
    Top = 39
    Width = 114
    Height = 13
    Caption = 'Clipboard metafile scale:'
  end
  object Label5: TLabel
    Left = 12
    Top = 112
    Width = 27
    Height = 13
    Caption = 'Units:'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 191
    Width = 373
    Height = 42
    Align = alBottom
    Shape = bsTopLine
  end
  object Label6: TLabel
    Left = 148
    Top = 15
    Width = 86
    Height = 13
    Caption = 'Antialiasing factor:'
  end
  object GridBox: TGroupBox
    Left = 8
    Top = 8
    Width = 121
    Height = 93
    Caption = 'GridBox'
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 23
      Width = 10
      Height = 13
      Caption = 'X:'
    end
    object Label2: TLabel
      Left = 12
      Top = 45
      Width = 10
      Height = 13
      Caption = 'Y:'
    end
    object GridXEdit: TFloatEdit
      Left = 32
      Top = 20
      Width = 73
      Height = 21
      Alignment = taRightJustify
      TabOrder = 0
      Max = 1000.000000000000000000
      SpinIncrement = 1.000000000000000000
      FormatString = '0.##'
    end
    object GridYEdit: TFloatEdit
      Left = 32
      Top = 42
      Width = 73
      Height = 21
      Alignment = taRightJustify
      TabOrder = 1
      Max = 1000.000000000000000000
      SpinIncrement = 1.000000000000000000
      FormatString = '0.##'
    end
    object ShowGridBox: TCheckBox
      Left = 12
      Top = 68
      Width = 105
      Height = 17
      Caption = 'Show grid'
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 290
    Top = 203
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 9
  end
  object Button2: TButton
    Left = 210
    Top = 203
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 8
  end
  object UndoHistoryEdit: TIntegerEdit
    Left = 312
    Top = 60
    Width = 53
    Height = 21
    Hint = 'Maximum number of undos/redos'
    Anchors = [akTop, akRight]
    TabOrder = 4
    SpinIncrement = 1
  end
  object ClipboardScaleEdit: TIntegerEdit
    Left = 312
    Top = 36
    Width = 53
    Height = 21
    Hint = 'Size of design when pasting from clipboard to other application'
    Anchors = [akTop, akRight]
    TabOrder = 3
    Max = 16
    Min = 1
    SpinIncrement = 1
    Value = 1
  end
  object UnitsBox: TComboBox
    Left = 8
    Top = 128
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = UnitsBoxChange
    Items.Strings = (
      'Millimeters'
      'Centimeters'
      'Inches'
      'points'
      '300 DPI dots'
      '600 DPI dots')
  end
  object LanguageButton: TBitBtn
    Left = 148
    Top = 122
    Width = 215
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Set program language'
    TabOrder = 6
    OnClick = LanguageButtonClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFB6B2B29992928C84848B8282918A8AADABABFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFDDD8D8A99B9BDBD4D4EBE7E7E3D6D6D9
      C1C1CEBEBEB7A7A7786C6CDFDFDFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      D7C6C6E8DFDEFFFFFFE5DEDFB69899B08788D3BCBCE7DCDCB5A0A0D8D8D8FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDFD2D2C1B6BAC5B0B0AF847F9B
      6760A38988B5ABACE3E0E0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFD3D0D1A179657D4529732E1E5500005500005619178B8B8BFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFBAB4B6B776486E3210006820540000FF
      2B15FF0000E20000AA00003F3F3FFF00FFFF00FFFF00FFFF00FFFF00FFDCDADB
      BC896D7D6C1B009C31009C31006820A8401FFF6331FE4220FE00000031004F4F
      4FFF00FFFF00FFFF00FFFF00FFB2A0A1D2844B0AA6314CE83163FF3120BD3100
      3410FF762071691A007610006300004200AAAAAAFF00FFFF00FFFF00FFC1A29C
      44902F94E899AAFF9941DE310A8010706C0554750015A526009C310063000058
      00394F39FF00FFFF00FFFF00FFC8A9A2009B3154BC7574DD74006300FFAC10FF
      CE3100630098ED9810AC31006300006300002100FF00FFFF00FFFF00FFC5AAAC
      FF6331C6E99955A725A98810FFB02BFFC82BFF9C0082843D5FB44810AC31006F
      0A002100FF00FFFF00FFFF00FFC8AAAFE1996AC6965354802620AA318C682BFF
      B02BFFBD20FF7C1AC6632610861000590A727C72FF00FFFF00FFFF00FFDDD0D0
      CDAAAB53BB74DDFEDD31CE3120AA31A88710FE9B00FFA930FF6331FF6331AB44
      23ACACACFF00FFFF00FFFF00FFFF00FFCCB4B6A5A58C83CB96DEFFDE65DE652C
      A342007631C57C1BFF6331FF6331C88E8EFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFD7C2C3A0A38E54BC757CD2926FDE6F20BD31547C31FF6331FFCBBBFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFF0EAEAC8B2B484B49000
      9C31009C3155BD75FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object DictionaryPathButton: TButton
    Left = 148
    Top = 92
    Width = 215
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Set dictionary path'
    TabOrder = 5
    OnClick = DictionaryPathButtonClick
  end
  object FileFormatAssociationsButton: TButton
    Left = 148
    Top = 152
    Width = 215
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'File format associations'
    TabOrder = 7
    OnClick = FileFormatAssociationsButtonClick
  end
  object AntialiasingEdit: TIntegerEdit
    Left = 312
    Top = 12
    Width = 53
    Height = 21
    Hint = 'Antialiasing for slide show and bitmap export'
    Anchors = [akTop, akRight]
    TabOrder = 2
    Max = 8
    Min = 1
    SpinIncrement = 1
    Value = 1
  end
end
