object PagePropertiesForm: TPagePropertiesForm
  Left = 286
  Top = 157
  BorderStyle = bsDialog
  Caption = 'Page properties'
  ClientHeight = 157
  ClientWidth = 297
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 16
    Width = 31
    Height = 13
    Caption = 'Width:'
  end
  object Label2: TLabel
    Left = 12
    Top = 44
    Width = 34
    Height = 13
    Caption = 'Height:'
  end
  object UnitLabel1: TLabel
    Left = 136
    Top = 16
    Width = 51
    Height = 13
    Caption = 'UnitLabel1'
  end
  object UnitLabel2: TLabel
    Left = 136
    Top = 44
    Width = 51
    Height = 13
    Caption = 'UnitLabel2'
  end
  object OKBtn: TButton
    Left = 213
    Top = 6
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object CancelBtn: TButton
    Left = 213
    Top = 38
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object WidthEdit: TFloatEdit
    Left = 72
    Top = 12
    Width = 61
    Height = 21
    Alignment = taRightJustify
    OnChangeValue = ChangeValue
    TabOrder = 0
    Max = 1E100
    Min = 0.000000000100000000
    Value = 0.000000000100000000
    FormatString = '0.##'
  end
  object HeightEdit: TFloatEdit
    Left = 72
    Top = 40
    Width = 61
    Height = 21
    Alignment = taRightJustify
    OnChangeValue = ChangeValue
    TabOrder = 1
    Max = 1E100
    Min = 0.000000000100000000
    Value = 0.000000000100000000
    FormatString = '0.##'
  end
  object PrinterButton: TButton
    Left = 8
    Top = 98
    Width = 181
    Height = 25
    Caption = '&Get printer page format'
    TabOrder = 3
    OnClick = PrinterButtonClick
  end
  object FlipButton: TButton
    Left = 9
    Top = 70
    Width = 180
    Height = 25
    Caption = '&Flip'
    TabOrder = 2
    OnClick = FlipButtonClick
  end
  object ApplyToAllBox: TCheckBox
    Left = 12
    Top = 132
    Width = 277
    Height = 17
    Caption = '&Apply to all pages'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object PrinterSetupDialog: TPrinterSetupDialog
    Left = 4
    Top = 4
  end
end
