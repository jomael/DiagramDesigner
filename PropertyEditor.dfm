object PropertyEditorForm: TPropertyEditorForm
  Left = 736
  Top = 260
  Width = 285
  Height = 489
  Caption = 'Properties'
  Color = clBtnFace
  Constraints.MinWidth = 220
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanelFrame
    Left = 0
    Top = 424
    Width = 277
    Height = 38
    RenderThemeBackground = True
    Align = alBottom
    UseDockManager = False
    TabOrder = 0
    DesignSize = (
      277
      38)
    object OkButton: TButton
      Left = 117
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelButton: TButton
      Left = 197
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 277
    Height = 424
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'General'
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 269
        Height = 396
        Align = alClient
        ParentBackground = True
        TabOrder = 0
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Name'
          TabOrder = 0
          DesignSize = (
            265
            24)
          object NameEdit: TEdit
            Left = 64
            Top = 2
            Width = 200
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            OnChange = NameEditChange
          end
        end
        object Panel2: TPanel
          Left = 0
          Top = 24
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Text'
          TabOrder = 1
          DesignSize = (
            265
            24)
          object TextEdit: TEdit
            Left = 64
            Top = 2
            Width = 200
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            OnChange = TextEditChange
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 72
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Vertical text alignment'
          TabOrder = 3
          DesignSize = (
            265
            24)
          object TextYAlignBox: TComboBox
            Left = 136
            Top = 2
            Width = 128
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 0
            OnChange = TextYAlignBoxChange
            Items.Strings = (
              'Top'
              'Center'
              'Bottom')
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 48
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Horizontal text alignment'
          TabOrder = 2
          DesignSize = (
            265
            24)
          object TextXAlignBox: TComboBox
            Left = 136
            Top = 2
            Width = 128
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 0
            OnChange = TextXAlignBoxChange
            Items.Strings = (
              'Left'
              'Center'
              'Right'
              'Block left'
              'Block right')
          end
        end
        object Panel8: TPanel
          Left = 0
          Top = 192
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Height'
          TabOrder = 8
          DesignSize = (
            265
            24)
          object HeightEditLabel: TLabel
            Left = 223
            Top = 5
            Width = 11
            Height = 13
            Anchors = [akTop, akRight]
            Caption = '@'
          end
          object HeightEdit: TFloatEdit
            Left = 136
            Top = 2
            Width = 83
            Height = 21
            Alignment = taRightJustify
            OnChangeValue = PositionChangeValue
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            Max = 1E100
            SpinIncrement = 1.000000000000000000
            FormatString = '0.##'
          end
        end
        object Panel9: TPanel
          Left = 0
          Top = 168
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Width'
          TabOrder = 7
          DesignSize = (
            265
            24)
          object WidthEditLabel: TLabel
            Left = 223
            Top = 5
            Width = 11
            Height = 13
            Anchors = [akTop, akRight]
            Caption = '@'
          end
          object WidthEdit: TFloatEdit
            Left = 136
            Top = 2
            Width = 83
            Height = 21
            Alignment = taRightJustify
            OnChangeValue = PositionChangeValue
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            Max = 1E100
            SpinIncrement = 1.000000000000000000
            FormatString = '0.##'
          end
        end
        object Panel10: TPanel
          Left = 0
          Top = 144
          Width = 265
          Height = 24
          Hint = 'Distance from top left corner'
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Top'
          TabOrder = 6
          DesignSize = (
            265
            24)
          object TopEditLabel: TLabel
            Left = 223
            Top = 5
            Width = 11
            Height = 13
            Anchors = [akTop, akRight]
            Caption = '@'
          end
          object TopEdit: TFloatEdit
            Left = 136
            Top = 2
            Width = 83
            Height = 21
            Alignment = taRightJustify
            OnChangeValue = PositionChangeValue
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            Max = 1E100
            Min = -1E100
            SpinIncrement = 1.000000000000000000
            FormatString = '0.##'
          end
        end
        object Panel11: TPanel
          Left = 0
          Top = 120
          Width = 265
          Height = 24
          Hint = 'Distance from top left corner'
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Left'
          TabOrder = 5
          DesignSize = (
            265
            24)
          object LeftEditLabel: TLabel
            Left = 223
            Top = 5
            Width = 11
            Height = 13
            Anchors = [akTop, akRight]
            Caption = '@'
          end
          object LeftEdit: TFloatEdit
            Left = 136
            Top = 2
            Width = 83
            Height = 21
            Alignment = taRightJustify
            OnChangeValue = PositionChangeValue
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            Max = 1E100
            Min = -1E100
            SpinIncrement = 1.000000000000000000
            FormatString = '0.##'
          end
        end
        object Panel15: TPanel
          Left = 0
          Top = 240
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Bitmap'
          TabOrder = 10
          object EditBitmapButton: TButton
            Left = 136
            Top = 2
            Width = 63
            Height = 20
            Caption = 'Edit'
            TabOrder = 0
            OnClick = EditBitmapButtonClick
          end
          object ExportBitmapButton: TButton
            Left = 200
            Top = 2
            Width = 63
            Height = 20
            Caption = 'Export'
            TabOrder = 1
            OnClick = ExportBitmapButtonClick
          end
        end
        object Panel17: TPanel
          Left = 0
          Top = 264
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Metafile'
          TabOrder = 11
          object ExportMetafileButton: TButton
            Left = 136
            Top = 2
            Width = 63
            Height = 20
            Caption = 'Export'
            TabOrder = 0
            OnClick = ExportMetafileButtonClick
          end
        end
        object PanelLinks: TPanel
          Left = 0
          Top = 288
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          TabOrder = 12
          object EditLinksButton: TButton
            Left = 136
            Top = 2
            Width = 63
            Height = 20
            Caption = 'Edit'
            TabOrder = 0
            OnClick = EditLinksButtonClick
          end
          object ClearLinksButton: TButton
            Left = 200
            Top = 2
            Width = 63
            Height = 20
            Caption = 'Clear'
            TabOrder = 1
            OnClick = ClearLinksButtonClick
          end
        end
        object Panel19: TPanel
          Left = 0
          Top = 216
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Rotation angle'
          TabOrder = 9
          DesignSize = (
            265
            24)
          object Label1: TLabel
            Left = 223
            Top = 5
            Width = 4
            Height = 13
            Anchors = [akTop, akRight]
            Caption = #176
          end
          object AngleEdit: TFloatEdit
            Left = 136
            Top = 2
            Width = 83
            Height = 21
            Alignment = taRightJustify
            OnChangeValue = AngleEditChangeValue
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            Max = 1000.000000000000000000
            Min = -1000.000000000000000000
            SpinIncrement = 90.000000000000000000
            FormatString = '0.##'
          end
        end
        object BoundsPanel: TPanel
          Left = 0
          Top = 312
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Link positions'
          TabOrder = 13
          object InnerBoundsBox: TCheckBox
            Left = 136
            Top = 4
            Width = 113
            Height = 17
            Caption = 'Inner bounds'
            TabOrder = 0
            OnClick = InnerBoundsBoxClick
          end
        end
        object Panel21: TPanel
          Left = 0
          Top = 96
          Width = 265
          Height = 24
          Hint = 'Margin for non-centered text'
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Text margin'
          TabOrder = 4
          DesignSize = (
            265
            24)
          object MarginEditLabel: TLabel
            Left = 223
            Top = 5
            Width = 37
            Height = 13
            Anchors = [akTop, akRight]
            Caption = #188' points'
          end
          object MarginEdit: TFloatEdit
            Left = 136
            Top = 2
            Width = 83
            Height = 21
            Alignment = taRightJustify
            OnChangeValue = MarginEditChangeValue
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            Max = 1E100
            SpinIncrement = 8.000000000000000000
            FormatString = '0.##'
          end
        end
        object PanelAnchors: TPanel
          Left = 0
          Top = 336
          Width = 265
          Height = 40
          Hint = 'Anchors used when resizing group'
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Anchors'
          TabOrder = 14
          object LeftAnchorBox: TCheckBox
            Left = 136
            Top = 4
            Width = 33
            Height = 17
            Hint = 'Left'
            Caption = #172
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = AnchorBoxClick
          end
          object RightAnchorBox: TCheckBox
            Left = 200
            Top = 4
            Width = 32
            Height = 17
            Hint = 'Right'
            Caption = #174
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = AnchorBoxClick
          end
          object TopAnchorBox: TCheckBox
            Left = 168
            Top = 4
            Width = 32
            Height = 17
            Hint = 'Top'
            Caption = #173
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = AnchorBoxClick
          end
          object BottomAnchorBox: TCheckBox
            Left = 232
            Top = 4
            Width = 32
            Height = 17
            Hint = 'Bottom'
            Caption = #175
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = AnchorBoxClick
          end
          object HorzScaleAnchorBox: TCheckBox
            Left = 136
            Top = 20
            Width = 32
            Height = 17
            Hint = 'Horizontal scaling'
            Caption = #219
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = AnchorBoxClick
          end
          object VertScaleAnchorBox: TCheckBox
            Left = 168
            Top = 19
            Width = 32
            Height = 17
            Hint = 'Vertical scaling'
            Caption = ']['
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = AnchorBoxClick
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Style'
      ImageIndex = 1
      object ScrollBox2: TScrollBox
        Left = 0
        Top = 0
        Width = 269
        Height = 396
        Align = alClient
        ParentBackground = True
        TabOrder = 0
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Line width'
          TabOrder = 0
          DesignSize = (
            265
            24)
          object LineWidthEditLabel: TLabel
            Left = 220
            Top = 5
            Width = 45
            Height = 13
            Alignment = taCenter
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = #188' points'
          end
          object LineWidthEdit: TFloatEdit
            Left = 136
            Top = 2
            Width = 82
            Height = 21
            Alignment = taRightJustify
            OnChangeValue = LineWidthEditChangeValue
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            Max = 100.000000000000000000
            SpinIncrement = 1.000000000000000000
            FormatString = '0.##'
          end
        end
        object Panel12: TPanel
          Left = 0
          Top = 24
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Line start'
          TabOrder = 1
          DesignSize = (
            265
            24)
          object LineStartBox: TComboBox
            Left = 136
            Top = 2
            Width = 82
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 0
            OnChange = LineStartBoxChange
          end
          object LineStartEdit: TIntegerEdit
            Left = 224
            Top = 2
            Width = 38
            Height = 21
            OnChangeValue = LineStartBoxChange
            Anchors = [akTop, akRight]
            TabOrder = 1
            Min = 1
            Value = 2
          end
        end
        object Panel13: TPanel
          Left = 0
          Top = 48
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Line end'
          TabOrder = 2
          DesignSize = (
            265
            24)
          object LineEndBox: TComboBox
            Left = 136
            Top = 2
            Width = 82
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 0
            OnChange = LineEndBoxChange
          end
          object LineEndEdit: TIntegerEdit
            Left = 224
            Top = 2
            Width = 38
            Height = 21
            OnChangeValue = LineEndBoxChange
            Anchors = [akTop, akRight]
            TabOrder = 1
            Min = 1
            Value = 2
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 144
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Line color'
          TabOrder = 4
          DesignSize = (
            265
            24)
          object Button1: TButton
            Left = 220
            Top = 3
            Width = 43
            Height = 18
            Anchors = [akTop, akRight]
            Caption = 'Clear'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -3
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = Button1Click
          end
          object LineColorPanel: TPanel
            Left = 136
            Top = 2
            Width = 82
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            ParentBackground = False
            TabOrder = 0
            OnClick = ColorPanelClick
          end
        end
        object Panel6: TPanel
          Left = 0
          Top = 168
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Fill color'
          TabOrder = 5
          DesignSize = (
            265
            24)
          object Button2: TButton
            Left = 220
            Top = 3
            Width = 43
            Height = 18
            Anchors = [akTop, akRight]
            Caption = 'Clear'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -3
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = Button2Click
          end
          object FillColorPanel: TPanel
            Left = 136
            Top = 2
            Width = 82
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            ParentBackground = False
            TabOrder = 0
            OnClick = ColorPanelClick
          end
        end
        object Panel14: TPanel
          Left = 0
          Top = 192
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Text color'
          TabOrder = 6
          DesignSize = (
            265
            24)
          object TextColorPanel: TPanel
            Left = 136
            Top = 2
            Width = 82
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            ParentBackground = False
            TabOrder = 0
            OnClick = ColorPanelClick
          end
        end
        object Panel16: TPanel
          Left = 0
          Top = 240
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Bitmap scaling'
          TabOrder = 7
          object HalftoneCheckBox: TCheckBox
            Left = 136
            Top = 4
            Width = 125
            Height = 17
            Caption = 'Halftone'
            TabOrder = 0
            OnClick = HalftoneCheckBoxClick
          end
        end
        object Panel18: TPanel
          Left = 0
          Top = 264
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Layout'
          TabOrder = 8
          DesignSize = (
            265
            24)
          object LayoutBox: TComboBox
            Left = 136
            Top = 2
            Width = 127
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 0
            OnChange = LayoutBoxChange
          end
        end
        object Panel20: TPanel
          Left = 0
          Top = 72
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Line style'
          TabOrder = 3
          DesignSize = (
            265
            24)
          object LineStyleBox: TComboBox
            Left = 136
            Top = 2
            Width = 127
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            DropDownCount = 15
            ItemHeight = 13
            TabOrder = 0
            OnChange = LineStyleBoxChange
            Items.Strings = (
              'Solid'
              #183#183#183#183#183#183#183#183#183#183#183#183#183#183#183#183#183
              #183' '#183' '#183' '#183' '#183' '#183' '#183' '#183' '#183
              '-----------------'
              '- - - - - - - - -'
              '-- -- -- -- -- --'
              '--  --  --  --  -'
              '-'#183'-'#183'-'#183'-'#183'-'#183'-'#183'-'#183'-'#183'-'
              '--'#183'--'#183'--'#183'--'#183'--'#183'--'
              '-- - -- - -- - --'
              '========')
          end
        end
        object Panel22: TPanel
          Left = 0
          Top = 120
          Width = 265
          Height = 24
          Hint = 'Radius of corner arc'
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Corner radius'
          TabOrder = 9
          DesignSize = (
            265
            24)
          object RadiusEditLabel: TLabel
            Left = 223
            Top = 5
            Width = 11
            Height = 13
            Anchors = [akTop, akRight]
            Caption = '@'
          end
          object CornerRadiusEdit: TFloatEdit
            Left = 136
            Top = 2
            Width = 83
            Height = 21
            Alignment = taRightJustify
            OnChangeValue = CornerRadiusEditChangeValue
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            Max = 1E100
            SpinIncrement = 0.100000000000000000
            FormatString = '0.##'
          end
        end
        object Panel23: TPanel
          Left = 0
          Top = 288
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Curve type'
          TabOrder = 10
          DesignSize = (
            265
            24)
          object CurveTypeBox: TComboBox
            Left = 136
            Top = 2
            Width = 127
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 0
            OnChange = CurveTypeBoxChange
          end
        end
        object Panel24: TPanel
          Left = 0
          Top = 96
          Width = 265
          Height = 24
          Hint = 'Radius of corner arc'
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Opacity'
          TabOrder = 11
          DesignSize = (
            265
            24)
          object Label2: TLabel
            Left = 223
            Top = 5
            Width = 8
            Height = 13
            Anchors = [akTop, akRight]
            Caption = '%'
          end
          object AlphaValueEdit: TFloatEdit
            Left = 136
            Top = 2
            Width = 83
            Height = 21
            Alignment = taRightJustify
            OnChangeValue = AlphaValueEditChangeValue
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
            Max = 100.000000000000000000
            SpinIncrement = 10.000000000000000000
            FormatString = '0'
          end
        end
        object Panel25: TPanel
          Left = 0
          Top = 216
          Width = 265
          Height = 24
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Transparent color key'
          TabOrder = 12
          object ColorKeyButton: TButton
            Left = 136
            Top = 2
            Width = 81
            Height = 21
            Caption = 'Set'
            TabOrder = 0
            OnClick = ColorKeyButtonClick
          end
        end
      end
    end
  end
end
