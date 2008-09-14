object FormatAssociateForm: TFormatAssociateForm
  Left = 291
  Top = 129
  BorderStyle = bsDialog
  Caption = 'Associate file formats with'
  ClientHeight = 277
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnMouseWheel = ScrollBoxMouseWheel
  DesignSize = (
    405
    277)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 220
    Width = 289
    Height = 55
    Anchors = [akLeft, akTop, akBottom]
    AutoSize = False
    Caption = 
      'Note that this action cannot be undone, and file format registra' +
      'tions will NOT be restored to the previous setting if the progra' +
      'm is uninstalled.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object AssociateButton: TButton
    Left = 308
    Top = 8
    Width = 91
    Height = 25
    Hint = 'Associate program with selected file formats'
    Anchors = [akLeft, akTop, akRight]
    Caption = '&OK'
    TabOrder = 0
    OnClick = AssociateButtonClick
  end
  object CancelButton: TButton
    Left = 308
    Top = 40
    Width = 91
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object NoneButton: TButton
    Left = 308
    Top = 190
    Width = 91
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = '&Deselect all'
    TabOrder = 4
    OnClick = SelectButtonClick
  end
  object Panel: TPanel
    Left = 4
    Top = 8
    Width = 293
    Height = 207
    BevelOuter = bvLowered
    TabOrder = 5
    object ScrollBox: TScrollBox
      Left = 1
      Top = 1
      Width = 291
      Height = 205
      HorzScrollBar.Visible = False
      VertScrollBar.Tracking = True
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
      OnMouseWheel = ScrollBoxMouseWheel
    end
  end
  object DescriptionBox: TCheckBox
    Left = 308
    Top = 88
    Width = 97
    Height = 17
    Hint = 
      'Include format description in file views instead of just "XYZ Fi' +
      'le"'
    Caption = 'Description'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object AllButton: TButton
    Left = 308
    Top = 162
    Width = 91
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = '&Select all'
    TabOrder = 3
    OnClick = SelectButtonClick
  end
end
