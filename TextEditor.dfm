object TextEditorForm: TTextEditorForm
  Left = 520
  Top = 296
  Width = 458
  Height = 293
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Edit text'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    450
    259)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 128
    Height = 13
    Caption = 'Text formatting codes:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object LabelCode1: TLabel
    Left = 8
    Top = 26
    Width = 57
    Height = 13
    Caption = 'LabelCode1'
    Transparent = True
  end
  object LabelDescription1: TLabel
    Left = 100
    Top = 26
    Width = 85
    Height = 13
    Caption = 'LabelDescription1'
    Transparent = True
  end
  object Label2: TLabel
    Left = 8
    Top = 68
    Width = 99
    Height = 13
    Caption = 'Enter object text:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object LabelCode2: TLabel
    Left = 208
    Top = 26
    Width = 57
    Height = 13
    Caption = 'LabelCode2'
    Transparent = True
  end
  object LabelDescription2: TLabel
    Left = 300
    Top = 26
    Width = 85
    Height = 13
    Caption = 'LabelDescription2'
    Transparent = True
  end
  object RichEdit: TRichEdit
    Left = 4
    Top = 86
    Width = 442
    Height = 136
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    OnChange = RichEditChange
    OnKeyDown = RichEditKeyDown
  end
  object OKButton: TButton
    Left = 370
    Top = 233
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 286
    Top = 233
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Preview: TDoubleBufferedPanel
    Left = 4
    Top = 228
    Width = 275
    Height = 33
    RenderThemeBackground = True
    OnPaint = PreviewPaint
    Anchors = [akLeft, akRight, akBottom]
    UseDockManager = False
    TabOrder = 3
  end
  object ClipPanelFrame: TPanelFrame
    Left = 228
    Top = 64
    Width = 100
    Height = 41
    UseDockManager = False
    TabOrder = 4
    Visible = False
  end
end
