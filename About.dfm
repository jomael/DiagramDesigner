object AboutBox: TAboutBox
  Left = 385
  Top = 272
  ActiveControl = OKButton
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 238
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    262
    238)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanelFrame
    Left = 4
    Top = 4
    Width = 253
    Height = 197
    RenderThemeBackground = True
    Anchors = [akLeft, akTop, akRight]
    UseDockManager = False
    TabOrder = 0
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 253
      Height = 169
      Align = alTop
      Shape = bsBottomLine
    end
    object ProgramIcon: TImage
      Left = 208
      Top = 8
      Width = 32
      Height = 32
      AutoSize = True
      Stretch = True
      IsControl = True
    end
    object ProductName: TLabel
      Left = 8
      Top = 16
      Width = 126
      Height = 22
      Caption = 'ProductName'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      IsControl = True
    end
    object ProductName2: TLabel
      Left = 8
      Top = 52
      Width = 154
      Height = 19
      Caption = 'Open source edition'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      IsControl = True
    end
    object Version: TLabel
      Left = 8
      Top = 80
      Width = 35
      Height = 13
      Caption = 'Version'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
      IsControl = True
    end
    object WWWLabel: TLabel
      Left = 124
      Top = 140
      Width = 123
      Height = 13
      Hint = 'http://meesoft.logicnet.dk'
      Caption = 'http://meesoft.logicnet.dk'
      Transparent = True
    end
    object Label3: TLabel
      Left = 8
      Top = 140
      Width = 39
      Height = 13
      Caption = 'Internet:'
      Transparent = True
    end
    object InfoLabel: TLabel
      Left = 8
      Top = 176
      Width = 44
      Height = 13
      Caption = 'InfoLabel'
      Transparent = True
      WordWrap = True
    end
    object Label1: TLabel
      Left = 8
      Top = 110
      Width = 91
      Height = 16
      Caption = 'Michael Vinther'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object OKButton: TButton
    Left = 102
    Top = 208
    Width = 66
    Height = 26
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    IsControl = True
  end
end
