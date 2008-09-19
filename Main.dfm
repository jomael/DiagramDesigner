object MainForm: TMainForm
  Left = 260
  Top = 170
  Width = 999
  Height = 625
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 121
    Top = 50
    Height = 529
    ResizeStyle = rsUpdate
    OnMoved = Splitter1Moved
  end
  object Splitter2: TSplitter
    Left = 804
    Top = 50
    Height = 529
    Align = alRight
    ResizeStyle = rsUpdate
  end
  object TreeView: TTreeView
    Left = 0
    Top = 50
    Width = 121
    Height = 529
    Align = alLeft
    HideSelection = False
    Indent = 19
    PopupMenu = PopupMenu
    TabOrder = 0
    OnChange = TreeViewChange
    OnDblClick = TreeViewDblClick
    OnEdited = TreeViewEdited
    OnEditing = TreeViewEditing
    OnEnter = TreeViewEnter
    OnExit = TreeViewExit
    OnKeyDown = TreeViewKeyDown
    OnMouseDown = TreeViewMouseDown
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 26
    Width = 991
    Height = 24
    AutoSize = True
    Color = clBtnFace
    Flat = True
    Images = ImageList
    ParentColor = False
    TabOrder = 2
    TabStop = True
    Transparent = False
    object ToolButton3: TToolButton
      Left = 0
      Top = 0
      Action = NewAction
    end
    object ToolButton1: TToolButton
      Left = 23
      Top = 0
      Action = OpenAction
      DropdownMenu = ResentFilesMenu
      Style = tbsDropDown
    end
    object SaveButton: TToolButton
      Left = 59
      Top = 0
      Action = SaveAction
    end
    object Separator1: TToolButton
      Left = 82
      Top = 0
      Width = 8
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 90
      Top = 0
      Action = CutAction
    end
    object ToolButton6: TToolButton
      Left = 113
      Top = 0
      Action = CopyAction
    end
    object ToolButton7: TToolButton
      Left = 136
      Top = 0
      Action = PasteAction
    end
    object Separator2: TToolButton
      Left = 159
      Top = 0
      Width = 8
      ImageIndex = 0
      Style = tbsSeparator
    end
    object ToolButton9: TToolButton
      Left = 167
      Top = 0
      Action = UndoAction
    end
    object ToolButton10: TToolButton
      Left = 190
      Top = 0
      Action = RedoAction
    end
    object Separator3: TToolButton
      Left = 213
      Top = 0
      Width = 8
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ZoomBox: TComboBox
      Left = 221
      Top = 0
      Width = 63
      Height = 21
      Hint = 'Zoom'
      AutoComplete = False
      ItemHeight = 13
      TabOrder = 0
      OnClick = ZoomBoxClick
      OnEnter = ZoomBoxEnter
      OnKeyDown = ZoomBoxKeyDown
      Items.Strings = (
        '25%'
        '50%'
        '75%'
        '100%'
        '150%'
        '200%'
        '400%'
        '800%')
    end
    object ToolButtonZoom: TToolButton
      Left = 284
      Top = 0
      Action = ZoomAction
      Grouped = True
      Style = tbsCheck
    end
    object ToolButton13: TToolButton
      Left = 307
      Top = 0
      Action = MoveCanvasAction
      Style = tbsCheck
    end
    object ToolButton14: TToolButton
      Left = 330
      Top = 0
      Action = MouseEditAction
      Style = tbsCheck
    end
    object Separator4: TToolButton
      Left = 353
      Top = 0
      Width = 8
      ImageIndex = 15
      Style = tbsSeparator
    end
    object ToolButton15: TToolButton
      Left = 361
      Top = 0
      Action = DrawLineAction
    end
    object ToolButton16: TToolButton
      Left = 384
      Top = 0
      Action = DrawArrowAction
    end
    object ToolButton17: TToolButton
      Left = 407
      Top = 0
      Action = DrawConnectorAction
    end
    object ToolButton18: TToolButton
      Left = 430
      Top = 0
      Action = DrawCurveAction
    end
    object ToolButton2: TToolButton
      Left = 453
      Top = 0
      Action = DrawTextAction
    end
    object ToolButton20: TToolButton
      Left = 476
      Top = 0
      Action = DrawRectangleAction
    end
    object ToolButton21: TToolButton
      Left = 499
      Top = 0
      Action = DrawEllipseAction
    end
    object Separator5: TToolButton
      Left = 522
      Top = 0
      Width = 8
      ImageIndex = 23
      Style = tbsSeparator
    end
    object LineWidthButton: TSpeedButton
      Tag = -1
      Left = 530
      Top = 0
      Width = 23
      Height = 22
      Action = LineWidthAction
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Transparent = False
    end
    object CornerRadiusButton: TSpeedButton
      Tag = -1
      Left = 553
      Top = 0
      Width = 23
      Height = 22
      Action = CornerRadiusAction
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF000000000000000000000000000000000000FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000
        000000000000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000
        0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FF}
      Transparent = False
    end
    object LineColorButton: TSpeedButton
      Left = 576
      Top = 0
      Width = 23
      Height = 22
      Action = LineColorAction
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080008080
        8000808080008080800080808000808080008080800080808000808080008080
        80008080800080808000808080008080800080808000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00008000000080
        00000080000000800000008000000080000000800000FF00FF00FF00FF0000FF
        FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000080000000
        80000000800000008000000080000000800000008000FF00FF00FF00FF00FF00
        0000FF000000FF000000FF000000FF000000FF000000FF000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Transparent = False
    end
    object FillColorButton: TSpeedButton
      Tag = 16777215
      Left = 599
      Top = 0
      Width = 23
      Height = 22
      Action = FillColorAction
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00808080008080
        8000808080008080800080808000808080008080800080808000808080008080
        80008080800080808000808080008080800080808000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000C60000CC000000CC0000FF000000FF000000FF00
        000000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000C60000CC000000CC0000FF000000FF000000FF00
        000000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000C6000000C60000CC000000CC0000FF000000FF00
        000000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000C6000000C60000CC000000CC000000CC0000FF00
        0000FF00000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00}
      Transparent = False
    end
    object TextColorButton: TSpeedButton
      Left = 622
      Top = 0
      Width = 23
      Height = 22
      Action = TextColorAction
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000FFFFFF00808080008080
        8000808080008080800080808000808080008080800080808000808080008080
        80008080800080808000808080008080800080808000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        00000000000000000000FF00FF00000000000000000000000000FF00FF000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
        FF0000000000FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
        FF000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
        FF0000000000FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
        FF0000000000FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000000000FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
        00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00}
      Transparent = False
    end
  end
  object ActionMainMenuBar: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 991
    Height = 26
    UseSystemFont = False
    ActionManager = ActionManager
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    PersistentHotKeys = True
    Spacing = 0
  end
  object TemplateScrollBox: TScrollBox
    Left = 807
    Top = 50
    Width = 184
    Height = 529
    Hint = 'Template palette - drag objects from here to diagram'
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alRight
    ParentShowHint = False
    PopupMenu = TemplatePopupMenu
    ShowHint = False
    TabOrder = 4
    OnMouseDown = TemplateScrollBoxMouseDown
    OnResize = StatusBarResize
    object TemplateFrame: TDoubleBufferedPanel
      Left = 0
      Top = 0
      Width = 100
      Height = 41
      OnPaint = TemplateFramePaint
      UseDockManager = False
      TabOrder = 0
      OnDblClick = TemplateFrameDblClick
      OnMouseDown = TemplateFrameMouseDown
    end
  end
  object DrawPanel: TPanel
    Left = 124
    Top = 50
    Width = 680
    Height = 529
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnResize = DrawPanelResize
    object ScrollBarX: TScrollBar
      Left = 0
      Top = 229
      Width = 301
      Height = 16
      LargeChange = 128
      PageSize = 0
      SmallChange = 16
      TabOrder = 0
      TabStop = False
      OnChange = ScrollBarChange
    end
    object ScrollBarY: TScrollBar
      Left = 255
      Top = 0
      Width = 16
      Height = 205
      Kind = sbVertical
      LargeChange = 128
      PageSize = 0
      SmallChange = 16
      TabOrder = 1
      TabStop = False
      OnChange = ScrollBarChange
    end
    object CanvasFrame: TDoubleBufferedPanel
      Left = 0
      Top = 0
      Width = 233
      Height = 205
      OnPaint = CanvasFramePaint
      UseDockManager = False
      PopupMenu = PopupMenu
      TabOrder = 2
      OnDblClick = CanvasFrameDblClick
      OnDragDrop = CanvasFrameDragDrop
      OnDragOver = CanvasFrameDragOver
      OnMouseDown = CanvasFrameMouseDown
      OnMouseMove = CanvasFrameMouseMove
      OnMouseUp = CanvasFrameMouseUp
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 579
    Width = 991
    Height = 19
    Panels = <
      item
        Width = 400
      end
      item
        Bevel = pbNone
        Width = 100
      end
      item
        Bevel = pbNone
        Width = 120
      end
      item
        Width = 50
      end>
    OnMouseDown = StatusBarMouseDown
    OnResize = StatusBarResize
  end
  object ActionManager: TActionManager
    ActionBars = <
      item
      end
      item
        Items = <
          item
            Caption = '&File'
          end
          item
            Items = <
              item
                Action = CopyAction
                Caption = '&Copy'
                ShortCut = 16429
              end
              item
                Action = CutAction
                Caption = 'C&ut'
                ShortCut = 8238
              end
              item
                Action = PasteAction
                Caption = '&Paste'
                ShortCut = 8237
              end
              item
                Action = DeleteAction
                Caption = '&Delete'
                ShortCut = 46
              end>
            Caption = '&Edit'
          end
          item
            Items = <
              item
                Action = AboutAction
                Caption = '&About...'
                ShortCut = 112
              end>
            Caption = '&Help'
          end>
      end
      item
        Items.HideUnused = False
        Items = <
          item
            Items.HideUnused = False
            Items = <
              item
                Action = NewAction
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = OpenAction
                Caption = '&Open...'
                ShortCut = 16463
              end
              item
                Action = ReloadAction
                Caption = '&Reload'
              end
              item
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = SaveAction
                Caption = '&Save'
                ShortCut = 16467
              end
              item
                Action = ExportAction
              end
              item
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = ExitAction
                Caption = '&Close'
              end>
            Caption = '&File'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = CutAction
                Caption = '&Cut'
                ShortCut = 8238
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = CopyAction
                Caption = 'C&opy'
                ShortCut = 16429
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = PasteAction
                Caption = '&Paste'
                ShortCut = 8237
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = DeleteAction
                Caption = '&Delete'
                ShortCut = 46
              end>
            Caption = '&Edit'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = AboutAction
                Caption = '&About...'
                ShortCut = 112
              end>
            Caption = '&Help'
          end>
      end
      item
        Items = <
          item
            Action = OpenAction
            Caption = '&Open...'
            ShortCut = 16463
          end
          item
            Action = SaveAction
            Caption = '&Save'
            ShortCut = 16467
          end
          item
            Action = CutAction
            Caption = '&Cut'
            ShortCut = 8238
          end
          item
            Action = CopyAction
            Caption = 'Co&py'
            ShortCut = 16429
          end
          item
            Action = PasteAction
            Caption = 'P&aste'
            ShortCut = 8237
          end>
      end
      item
        Items.HideUnused = False
        Items.CaptionOptions = coAll
        Items = <
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = NewAction
                Caption = '&New...'
                ImageIndex = 0
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = OpenAction
                Caption = '&Open...'
                ImageIndex = 2
                ShortCut = 16463
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = OpenNewAction
                Caption = 'Open &in new window...'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = ReloadAction
                Caption = '&Reload'
                ImageIndex = 49
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = SaveAction
                Caption = '&Save'
                ImageIndex = 1
                ShortCut = 16467
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = SaveAsAction
                Caption = 'S&ave as...'
                ShortCut = 123
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = ExportAction
                Caption = '&Export page...'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = PrintAction
                Caption = 'Prin&t...'
                ImageIndex = 16
                ShortCut = 16464
              end
              item
                Action = PrintPreviewAction
                Caption = 'Pre&view mode'
                ImageIndex = 21
              end
              item
                Action = SlideShowAction
                Caption = 'S&lide show'
                ImageIndex = 29
                ShortCut = 115
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items = <
                  item
                    Action = LoadTemplateAction
                    Caption = '&Load template palette...'
                  end
                  item
                    Action = SaveTemplateAction
                    Caption = '&Save template palette...'
                  end
                  item
                    Caption = '-'
                  end
                  item
                    Action = TemplateToPageAction
                    Caption = '&Copy templates to page'
                  end
                  item
                    Action = PageToTemplateAction
                    Caption = '&Make palette from active layer'
                  end>
                Action = TemplatePaletteMenuAction
                Caption = 'Te&mplate palette'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = OptionsAction
                Caption = 'O&ptions'
                ImageIndex = 44
                ShortCut = 120
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = ExitAction
                Caption = '&Close'
                ImageIndex = 35
              end>
            Action = FileMenuAction
            Caption = '&File'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = UndoAction
                Caption = '&Undo'
                ImageIndex = 10
                ShortCut = 16474
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = RedoAction
                Caption = '&Redo'
                ImageIndex = 9
                ShortCut = 16473
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = SelectAllAction
                Caption = '&Select all'
                ShortCut = 16449
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = CutAction
                Caption = '&Cut'
                ImageIndex = 3
                ShortCut = 8238
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = CopyAction
                Caption = 'C&opy'
                ImageIndex = 4
                ShortCut = 16429
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = PasteAction
                Caption = '&Paste'
                ImageIndex = 5
                ShortCut = 8237
              end
              item
                Action = PasteSpecialAction
                Caption = 'P&aste special'
                ShortCut = 16450
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = DeleteAction
                Caption = '&Delete'
                ImageIndex = 7
                ShortCut = 46
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = InsertPictureAction
                Caption = '&Insert picture...'
                ImageIndex = 50
              end
              item
                Action = InheritLayerAction
                Caption = 'I&nsert inherited layer...'
              end>
            Action = EditMenuAction
            Caption = '&Edit'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Action = SpellCheckAction
                Caption = 'Spe&ll checker...'
                ImageIndex = 37
                ShortCut = 16502
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = DiagramFontAction
                Caption = '&Default font...'
                ImageIndex = 46
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = PagePropertiesAction
                Caption = '&Page properties...'
                ImageIndex = 15
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = NewPageAction
                Caption = '&New page'
                ImageIndex = 17
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = ReorderPagesAction
                Caption = '&Rearrange pages...'
                ShortCut = 16466
              end
              item
                Caption = '-'
              end
              item
                Items = <
                  item
                    Action = EditLayer1Action
                  end
                  item
                    Action = EditLayer2Action
                  end
                  item
                    Action = EditLayer3Action
                  end
                  item
                    Caption = '-'
                  end
                  item
                    Action = EditStencilAction
                    Caption = '&Global stencil'
                  end>
                Action = EditLayerMenuAction
                Caption = '&Edit layer'
              end
              item
                Action = ConnectLinksAction
                Caption = '&Connect links'
                ShortCut = 16460
              end
              item
                Action = SetLayerColorAction
                Caption = '&Set layer color...'
              end>
            Action = DiagramMenuAction
            Caption = '&Diagram'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = PropertiesAction
                Caption = '&Properties...'
                ImageIndex = 15
                ShortCut = 32781
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = EditTextAction
                Caption = '&Edit text...'
                ShortCut = 113
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = BringToFrontAction
                Caption = '&Bring to front'
                ImageIndex = 12
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = SendToBackAction
                Caption = '&Send to back'
                ImageIndex = 11
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = GroupAction
                Caption = '&Group'
                ShortCut = 16455
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = UngroupAction
                Caption = '&Ungroup'
                ShortCut = 16469
              end
              item
                Items = <
                  item
                    Action = FlipLRAction
                    Caption = '&Mirror'
                    ImageIndex = 39
                  end
                  item
                    Action = FlipUDAction
                    Caption = '&Flip'
                    ImageIndex = 38
                  end
                  item
                    Caption = '-'
                  end
                  item
                    Action = Rotate90Action
                    Caption = '&Rotate 90'#176
                    ImageIndex = 40
                  end
                  item
                    Action = Rotate180Action
                    Caption = 'R&otate 180'#176
                    ImageIndex = 41
                  end
                  item
                    Action = Rotate270Action
                    Caption = 'Ro&tate 270'#176
                    ImageIndex = 42
                  end
                  item
                    Action = RotateAction
                    Caption = '&Any angle...'
                  end>
                Action = RotateMenuAction
                Caption = '&Rotate'
                UsageCount = 1
              end
              item
                Items = <
                  item
                    Action = AlignLeftAction
                    Caption = '&Left'
                    ImageIndex = 32
                  end
                  item
                    Action = AlignCenterHAction
                    Caption = '&Center'
                    ImageIndex = 30
                  end
                  item
                    Action = AlignRightAction
                    Caption = '&Right'
                    ImageIndex = 31
                  end
                  item
                    Caption = '-'
                  end
                  item
                    Action = AlignTopAction
                    Caption = '&Top'
                    ImageIndex = 34
                  end
                  item
                    Action = AlignCenterVAction
                    Caption = 'C&enter'
                    ImageIndex = 36
                  end
                  item
                    Action = AlignBottomAction
                    Caption = '&Bottom'
                    ImageIndex = 33
                  end
                  item
                    Caption = '-'
                  end
                  item
                    Action = AlignPageAction
                    Caption = '&Fill'
                    ImageIndex = 43
                  end>
                Action = AlignMenuAction
                Caption = 'A&lign'
                UsageCount = 1
              end
              item
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = MakePolygonAction
                Caption = '&Convert to polygon'
              end
              item
                Action = MakeMetafileAction
                Caption = 'C&onvert to metafile'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = AddTemplateAction
                Caption = '&Add template'
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Action = ShowTreeAction
                Caption = 'S&how object tree'
                ImageIndex = 47
              end>
            Action = ObjectMenuAction
            Caption = '&Object'
          end
          item
            Items = <
              item
                Action = HelpFileAction
                Caption = '&Help Contents'
                ImageIndex = 48
              end
              item
                Action = InternetHelpAction
                Caption = '&Internet help page'
              end
              item
                Action = ExpressionEvaluator
                Caption = '&Expression evaluator...'
                ImageIndex = 8
                ShortCut = 122
              end
              item
                Action = CheckForUpdatesAction
                Caption = '&Check for updates'
              end
              item
                Action = SupportAction
                Caption = '&Support Diagram Designer...'
              end
              item
                Action = AboutAction
                Caption = '&About...'
                ImageIndex = 45
                ShortCut = 112
              end>
            Caption = '&Help'
          end>
        ActionBar = ActionMainMenuBar
      end>
    Images = ImageList
    Left = 248
    Top = 56
    StyleName = 'XP Style'
    object NewAction: TAction
      Category = 'File'
      Caption = 'New...'
      Hint = 'New diagram'
      ImageIndex = 0
      OnExecute = NewActionExecute
    end
    object OpenAction: TAction
      Category = 'File'
      Caption = 'Open...'
      ImageIndex = 2
      ShortCut = 16463
      SecondaryShortCuts.Strings = (
        'F3')
      OnExecute = OpenActionExecute
    end
    object FlipLRAction: TAction
      Category = 'Rotate'
      Caption = 'Mirror'
      ImageIndex = 39
      OnExecute = RotateActionExecute
    end
    object FlipUDAction: TAction
      Category = 'Rotate'
      Caption = 'Flip'
      ImageIndex = 38
      OnExecute = RotateActionExecute
    end
    object ReloadAction: TAction
      Category = 'File'
      Caption = 'Reload'
      ImageIndex = 49
      OnExecute = ReloadActionExecute
    end
    object SaveAction: TAction
      Category = 'File'
      Caption = 'Save'
      ImageIndex = 1
      ShortCut = 16467
      OnExecute = SaveActionExecute
    end
    object AlignCenterVAction: TAction
      Category = 'Align'
      Caption = 'Center'
      ImageIndex = 36
      OnExecute = AlignActionExecute
    end
    object SaveAsAction: TAction
      Category = 'File'
      Caption = 'Save as...'
      ShortCut = 123
      OnExecute = SaveAsActionExecute
    end
    object ExportAction: TAction
      Category = 'File'
      Caption = 'Export page...'
      Hint = 'Export page to bitmap or metafile'
      OnExecute = ExportActionExecute
    end
    object ExitAction: TAction
      Category = 'File'
      Caption = 'Close'
      ImageIndex = 35
      OnExecute = ExitActionExecute
    end
    object HelpFileAction: TAction
      Category = 'Help'
      Caption = 'Help Contents'
      ImageIndex = 48
      OnExecute = HelpFileActionExecute
    end
    object InternetHelpAction: TAction
      Category = 'Help'
      Caption = 'Internet help page'
      Hint = 'http://meesoft.logicnet.dk/DiagramDesigner/help.htm'
      OnExecute = InternetHelpActionExecute
    end
    object ExpressionEvaluator: TAction
      Category = 'Help'
      Caption = 'Expression evaluator...'
      ImageIndex = 8
      ShortCut = 122
      OnExecute = ExpressionEvaluatorExecute
    end
    object CutAction: TAction
      Category = 'Edit'
      Caption = 'Cut'
      ImageIndex = 3
      ShortCut = 8238
      SecondaryShortCuts.Strings = (
        'Ctrl+X')
      OnExecute = CutActionExecute
    end
    object CopyAction: TAction
      Category = 'Edit'
      Caption = 'Copy'
      ImageIndex = 4
      ShortCut = 16429
      SecondaryShortCuts.Strings = (
        'Ctrl+C')
      OnExecute = CopyActionExecute
    end
    object PasteAction: TAction
      Category = 'Edit'
      Caption = 'Paste'
      ImageIndex = 5
      ShortCut = 8237
      SecondaryShortCuts.Strings = (
        'Ctrl+V')
      OnExecute = PasteActionExecute
    end
    object PasteSpecialAction: TAction
      Category = 'Edit'
      Caption = 'Paste special'
      ShortCut = 16450
      OnExecute = PasteActionExecute
    end
    object DeleteAction: TAction
      Category = 'Edit'
      Caption = 'Delete'
      ImageIndex = 7
      ShortCut = 46
      OnExecute = DeleteActionExecute
    end
    object EditTextAction: TAction
      Category = 'Object'
      Caption = 'Edit text...'
      ShortCut = 113
      OnExecute = EditTextActionExecute
    end
    object BringToFrontAction: TAction
      Category = 'Object'
      Caption = 'Bring to front'
      ImageIndex = 12
      OnExecute = BringToFrontActionExecute
    end
    object SendToBackAction: TAction
      Category = 'Object'
      Caption = 'Send to back'
      ImageIndex = 11
      OnExecute = SendToBackActionExecute
    end
    object SelectAllAction: TAction
      Category = 'Edit'
      Caption = 'Select all'
      ShortCut = 16449
      OnExecute = SelectAllActionExecute
    end
    object ZoomAction: TAction
      Category = 'Mouse'
      Caption = 'Zoom'
      ImageIndex = 6
      ShortCut = 117
      OnExecute = ZoomActionExecute
    end
    object UndoAction: TAction
      Category = 'Edit'
      Caption = 'Undo'
      ImageIndex = 10
      ShortCut = 16474
      SecondaryShortCuts.Strings = (
        'Alt+BkSp')
      OnExecute = UndoRedoExecute
    end
    object RedoAction: TAction
      Category = 'Edit'
      Caption = 'Redo'
      ImageIndex = 9
      ShortCut = 16473
      SecondaryShortCuts.Strings = (
        'Shift+Alt+BkSp')
      OnExecute = UndoRedoExecute
    end
    object MoveCanvasAction: TAction
      Category = 'Mouse'
      Caption = 'Move canvas'
      ImageIndex = 13
      ShortCut = 118
      OnExecute = MoveCanvasActionExecute
    end
    object MouseEditAction: TAction
      Category = 'Mouse'
      Caption = 'Edit'
      Checked = True
      ImageIndex = 14
      ShortCut = 119
      OnExecute = MouseEditActionExecute
    end
    object OptionsAction: TAction
      Category = 'File'
      Caption = 'Options'
      ImageIndex = 44
      ShortCut = 120
      OnExecute = OptionsActionExecute
    end
    object PropertiesAction: TAction
      Category = 'Object'
      Caption = 'Properties...'
      Hint = 'Object properties'
      ImageIndex = 15
      ShortCut = 32781
      OnExecute = PropertiesActionExecute
    end
    object GroupAction: TAction
      Category = 'Object'
      Caption = 'Group'
      Hint = 'Group selected objects'
      ShortCut = 16455
      OnExecute = GroupActionExecute
    end
    object UngroupAction: TAction
      Category = 'Object'
      Caption = 'Ungroup'
      Hint = 'Ungroup active object'
      ShortCut = 16469
      OnExecute = UngroupActionExecute
    end
    object OpenNewAction: TAction
      Category = 'File'
      Caption = 'Open in new window...'
      OnExecute = OpenNewActionExecute
    end
    object InsertPictureAction: TAction
      Category = 'Edit'
      Caption = 'Insert picture...'
      Hint = 'Insert picture from file'
      ImageIndex = 50
      OnExecute = InsertPictureActionExecute
    end
    object NewPageAction: TAction
      Category = 'Diagram'
      Caption = 'New page'
      ImageIndex = 17
      OnExecute = NewPageActionExecute
    end
    object ReorderPagesAction: TAction
      Category = 'Diagram'
      Caption = 'Rearrange pages...'
      Hint = 'Reorder or delete pages'
      ShortCut = 16466
      OnExecute = ReorderPagesActionExecute
    end
    object PagePropertiesAction: TAction
      Category = 'Diagram'
      Caption = 'Page properties...'
      ImageIndex = 15
      OnExecute = PagePropertiesActionExecute
    end
    object MakePolygonAction: TAction
      Category = 'Object'
      Caption = 'Convert to polygon'
      Hint = 'Convert group object consisting of connected lines to polygon'
      OnExecute = MakePolygonActionExecute
    end
    object PrintAction: TAction
      Category = 'File'
      Caption = 'Print...'
      ImageIndex = 16
      ShortCut = 16464
      OnExecute = PrintActionExecute
    end
    object DiagramFontAction: TAction
      Category = 'Diagram'
      Caption = 'Default font...'
      Hint = 'Set diagram font'
      ImageIndex = 46
      OnExecute = DiagramFontActionExecute
    end
    object MakeMetafileAction: TAction
      Category = 'Object'
      Caption = 'Convert to metafile'
      Hint = 'Group selected objects in metafile object'
      OnExecute = MakeMetafileActionExecute
    end
    object AddTemplateAction: TAction
      Category = 'Object'
      Caption = 'Add template'
      Hint = 'Add to template palette'
      OnExecute = AddTemplateActionExecute
    end
    object SaveTemplateAction: TAction
      Category = 'Template'
      Caption = 'Save template palette...'
      OnExecute = SaveTemplateActionExecute
    end
    object LoadTemplateAction: TAction
      Category = 'Template'
      Caption = 'Load template palette...'
      OnExecute = LoadTemplateActionExecute
    end
    object DeleteTemplateAction: TAction
      Category = 'Template'
      Caption = 'Delete template object'
      ImageIndex = 7
      OnExecute = DeleteTemplateActionExecute
    end
    object TemplatePropertiesAction: TAction
      Category = 'Template'
      Caption = 'Properties'
      ImageIndex = 15
      OnExecute = TemplatePropertiesActionExecute
    end
    object DrawLineAction: TAction
      Category = 'Mouse'
      Caption = 'Draw line'
      ImageIndex = 18
      OnExecute = DrawObjectActionExecute
    end
    object DrawArrowAction: TAction
      Category = 'Mouse'
      Caption = 'Draw arrow'
      ImageIndex = 19
      OnExecute = DrawObjectActionExecute
    end
    object DrawConnectorAction: TAction
      Category = 'Mouse'
      Caption = 'Draw connector'
      ImageIndex = 20
      OnExecute = DrawObjectActionExecute
    end
    object PrintPreviewAction: TAction
      Category = 'File'
      Caption = 'Preview mode'
      ImageIndex = 21
      OnExecute = PrintPreviewActionExecute
    end
    object DrawCurveAction: TAction
      Category = 'Mouse'
      Caption = 'Draw curve'
      ImageIndex = 22
      OnExecute = DrawObjectActionExecute
    end
    object DrawTextAction: TAction
      Category = 'Mouse'
      Caption = 'Insert text'
      ImageIndex = 51
      OnExecute = DrawObjectActionExecute
    end
    object DrawRectangleAction: TAction
      Category = 'Mouse'
      Caption = 'Draw rectangle'
      ImageIndex = 27
      OnExecute = DrawObjectActionExecute
    end
    object DrawEllipseAction: TAction
      Category = 'Mouse'
      Caption = 'Draw ellipse'
      ImageIndex = 26
      OnExecute = DrawObjectActionExecute
    end
    object ShowTreeAction: TAction
      Category = 'Object'
      Caption = 'Show object tree'
      ImageIndex = 47
      OnExecute = ShowTreeActionExecute
    end
    object CheckForUpdatesAction: TAction
      Category = 'Help'
      Caption = 'Check for updates'
      OnExecute = CheckForUpdatesActionExecute
    end
    object SupportAction: TAction
      Category = 'Help'
      Caption = 'Support Diagram Designer...'
      Hint = 'http://meesoft.logicnet.dk/DiagramDesigner/support.htm'
      OnExecute = SupportActionExecute
    end
    object AboutAction: TAction
      Category = 'Help'
      Caption = 'About...'
      ImageIndex = 45
      ShortCut = 112
      OnExecute = AboutActionExecute
    end
    object EditStencilAction: TAction
      Tag = -1
      Category = 'Layer'
      Caption = 'Global stencil'
      OnExecute = SetLayerActionExecute
    end
    object EditLayer1Action: TAction
      Category = 'Layer'
      Caption = 'Layer &1'
      OnExecute = SetLayerActionExecute
    end
    object EditLayer2Action: TAction
      Tag = 1
      Category = 'Layer'
      Caption = 'Layer &2'
      OnExecute = SetLayerActionExecute
    end
    object EditLayer3Action: TAction
      Tag = 2
      Category = 'Layer'
      Caption = 'Layer &3'
      OnExecute = SetLayerActionExecute
    end
    object TemplateToPageAction: TAction
      Category = 'Template'
      Caption = 'Copy templates to page'
      OnExecute = TemplateToPageActionExecute
    end
    object PageToTemplateAction: TAction
      Category = 'Template'
      Caption = 'Make palette from active layer'
      OnExecute = PageToTemplateActionExecute
    end
    object SetLayerColorAction: TAction
      Category = 'Layer'
      Caption = 'Set layer color...'
      Hint = 'Change color of all objects in active layer'
      OnExecute = SetLayerColorActionExecute
    end
    object ConnectLinksAction: TAction
      Category = 'Layer'
      Caption = 'Connect links'
      Hint = 'Glue connectors to adjoining object link points in active layer'
      ShortCut = 16460
      OnExecute = ConnectLinksActionExecute
    end
    object LineWidthAction: TAction
      Category = 'Mouse'
      Hint = 'Line width'
      ImageIndex = 23
      OnExecute = LineWidthActionExecute
    end
    object CornerRadiusAction: TAction
      Category = 'Mouse'
      Hint = 'Corner radius'
      OnExecute = CornerRadiusActionExecute
    end
    object LineColorAction: TAction
      Category = 'Mouse'
      Hint = 'Line color'
      ImageIndex = 25
      OnExecute = LineColorActionExecute
    end
    object FillColorAction: TAction
      Category = 'Mouse'
      Hint = 'Fill color'
      ImageIndex = 24
      OnExecute = FillColorActionExecute
    end
    object TextColorAction: TAction
      Category = 'Mouse'
      Hint = 'Text color'
      ImageIndex = 28
      OnExecute = TextColorActionExecute
    end
    object SlideShowAction: TAction
      Category = 'File'
      Caption = 'Slide show'
      ImageIndex = 29
      ShortCut = 115
      OnExecute = SlideShowActionExecute
    end
    object AlignLeftAction: TAction
      Category = 'Align'
      Caption = 'Left'
      ImageIndex = 32
      OnExecute = AlignActionExecute
    end
    object AlignCenterHAction: TAction
      Category = 'Align'
      Caption = 'Center'
      Hint = 'Align single object to page or multiple objects to group'
      ImageIndex = 30
      OnExecute = AlignActionExecute
    end
    object AlignRightAction: TAction
      Category = 'Align'
      Caption = 'Right'
      ImageIndex = 31
      OnExecute = AlignActionExecute
    end
    object AlignTopAction: TAction
      Category = 'Align'
      Caption = 'Top'
      ImageIndex = 34
      OnExecute = AlignActionExecute
    end
    object AlignBottomAction: TAction
      Category = 'Align'
      Caption = 'Bottom'
      ImageIndex = 33
      OnExecute = AlignActionExecute
    end
    object SpellCheckAction: TAction
      Category = 'Diagram'
      Caption = 'Spell checker...'
      ImageIndex = 37
      ShortCut = 16502
      OnExecute = SpellCheckActionExecute
    end
    object Rotate90Action: TAction
      Category = 'Rotate'
      Caption = 'Rotate 90'#176
      ImageIndex = 40
      OnExecute = RotateActionExecute
    end
    object Rotate180Action: TAction
      Category = 'Rotate'
      Caption = 'Rotate 180'#176
      ImageIndex = 41
      OnExecute = RotateActionExecute
    end
    object Rotate270Action: TAction
      Category = 'Rotate'
      Caption = 'Rotate 270'#176
      ImageIndex = 42
      OnExecute = RotateActionExecute
    end
    object RotateAction: TAction
      Category = 'Rotate'
      Caption = 'Any angle...'
      Hint = 
        'Rotate selected objects counter-clockwise. Note that not all obj' +
        'ect types support this operation.'
      OnExecute = RotateActionExecute
    end
    object AlignPageAction: TAction
      Category = 'Align'
      Caption = 'Fill'
      ImageIndex = 43
      OnExecute = AlignActionExecute
    end
    object InheritLayerAction: TAction
      Category = 'Edit'
      Caption = 'Insert inherited layer...'
      OnExecute = InheritLayerActionExecute
    end
    object FileMenuAction: TAction
      Category = 'Menus'
      Caption = 'File'
    end
    object EditMenuAction: TAction
      Category = 'Menus'
      Caption = 'Edit'
    end
    object DiagramMenuAction: TAction
      Category = 'Menus'
      Caption = 'Diagram'
    end
    object HelpMenuAction: TAction
      Category = 'Menus'
      Caption = 'Help'
    end
    object ObjectMenuAction: TAction
      Category = 'Menus'
      Caption = 'Object'
    end
    object TemplatePaletteMenuAction: TAction
      Category = 'Menus'
      Caption = 'Template palette'
    end
    object EditLayerMenuAction: TAction
      Category = 'Menus'
      Caption = 'Edit layer'
    end
    object RotateMenuAction: TAction
      Category = 'Menus'
      Caption = 'Rotate'
    end
    object AlignMenuAction: TAction
      Category = 'Menus'
      Caption = 'Align'
    end
  end
  object ImageList: TImageList
    Left = 276
    Top = 56
    Bitmap = {
      494C010134003600040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000E0000000010020000000000000E0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008000800000000000000000000000
      00000000000000000000000000000000000000000000B6857B00A5787300A578
      7300A5787300A5787300A5787300A5787300A5787300A5787300A5787300A578
      7300A5787300986D67000000000000000000525252004A4A4A004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000C0C0C000FFFFFF00C0C0C00080008000000000000000
      00000000000000000000000000000000000000000000B6857B00F8EFE300EDE2
      CC00EADEC400EDDBBB00EBD8B200EBD4AA00EAD0A000E4CC9C00E4CC9C00E4CC
      9C00EAD0A000986D6700000000000000000073848C006B7B7B006B8484006B84
      84006B8484006B8484006B8484006B8484006B8484006B8484006B8484006B84
      84006B8484006B8484006B8484005A6352000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000C0C0C000FFFFFF00FFFFFF0080808000C0C0C000C0C0C000800080000000
      00000000000000000000000000000000000000000000B2817700F8EFE300EFE6
      D400EDE2CC00EADEC400E6CE9D000189020001890200DDC59400E4CC9C00E4CC
      9C00EAD0A000986D67000000000000000000738C8C004A8C390042B542004AA5
      390042B5420039BD730018DECE0018DEBD004AAD39004AAD420042B542004AA5
      3900398C310039B539005AB573006B7B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C000FFFF
      FF00FFFFFF0080808000808080000000000080808000C0C0C000C0C0C0008000
      80000000000000000000000000000000000000000000B2817700FBF4EC00F3EB
      DD0001890200EBD6AF0001890200E6CE9D00DFC8970001890200DDC59400E6CE
      9D00EAD0A000986D67000000000000000000738C8C004294310042A5290042B5
      310042AD310039BD310018D6940010DEAD0039A52900296B3900296339002984
      6300296B2900216B18005AAD63006B7B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000800080808000FFFFFF008080
      8000808080000000000000000000800080000000000080808000C0C0C000C0C0
      C0008000800000000000000000000000000000000000C18D7E00FEFCFA00F8EF
      E3000189020001890200EBD6AF00EADEC400EDDBBB00DFC8970001890200EAD0
      A000EAD0A000986D67000000000000000000738C8C00428C290042AD29002973
      180042AD310039B5310029BD730018D694002963180018295A00080810001021
      4200294A420039BD31005AAD63006B7B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000800080808000808080000000
      000000000000800080008000800080008000800080000000000080808000C0C0
      C000C0C0C00080008000000000000000000000000000C18D7E00FEFDFC00FBF4
      EC00018902000189020001890200EDE2CC00EADEC400EDDBBB00EBD8B200EBD4
      AA00EBD2A500986D67000000000000000000738C8C00399C210042842900185A
      100031A5290039B531004AA5290021CE4A003173210018314A00182942001829
      42001839310042AD31005AAD63006B7B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000800000000000000000008000
      8000800080008000800080008000800080008000800080008000000000008080
      8000C0C0C000C0C0C000800080000000000000000000CE9A8300FEFDFC00FDF9
      F600FBF4EC00F8EFE300F3EBDD00EFE6D400018902000189020001890200EBD8
      B200EBD6AF00986D67000000000000000000738C8C004A6B3100007B00002173
      1000218410004A84390039A5290031BD2900429C290021631800185A18001842
      1000296318003184210052735A006B7B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000800080808000800080008000
      8000800080008000800000FFFF00008080008000800080008000800080000000
      000080808000C0C0C000000000000000000000000000CE9A8300FEFDFC00FEFD
      FC0001890200EDE2CC00F8EFE300F3EBDD00EBD8B2000189020001890200EDDB
      B900EDDBB900986D67000000000000000000738C8C009C8C840021841000314A
      2100529C4200D6C6BD00B5A59C008C847B009C9484008C8C7B009C8C84005A63
      39004A4A39006B8452004A635A006B7B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080008000808080008000
      8000800080008000800080008000C0C0C00000FFFF0000FFFF00800080008000
      80000000000080808000000000000000000000000000D5A18100FEFDFC00FEFD
      FC00F3EBDD0001890200ECDFC800EADEC40001890200EBD8B20001890200EADE
      C400EBDAB600986D67000000000000000000738C8C00BDAD8C004A732900186B
      1000318C3100F7DEB500F7DEB500F7DEB500F7DEB500F7DEB500F7DEB500F7DE
      B500F7DEB500F7DEB500C6C6B5006B7B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800080008080
      8000800080008000800000808000008080008000800000FFFF0000FFFF008000
      80008000800000000000000000000000000000000000D5A18100FEFDFC00FEFD
      FC00FEFDFC00F3EBDD000189020001890200EADEC400F3EBDD00F8EFE300EADE
      C400DDBB9500986D67000000000000000000738C8C00B5A56B00397B18003184
      1800427B3100EFC67B00EFCE8400EFC67B00EFCE8400EFC67B00EFCE8400EFC6
      7B00EFCE8400EFC67B00CEC69C006B7B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      800080808000800080008000800000FFFF0000FFFF0000FFFF00008080008000
      80008000800080008000000000000000000000000000E0B19600FEFDFC00FEFD
      FC00FEFDFC00FEFDFC00FEFDFC00FCF8F300FBF4EC00EFE6D400B2817700B281
      7700B2817700B28177000000000000000000738C8C00C6843100BDA531005284
      2100DE942100FFA53900FF9C3100FFA53900FF9C3100FFA53900FF9C3100FFA5
      3900FF9C3100FFA53900D6A56B006B7B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800080008080800080008000800080008000800080008000800080008000
      80008000800000000000000000000000000000000000E0B19600FEFDFC00FEFD
      FC00FEFDFC00FEFDFC00FEFDFC00FEFDFC00FEFDFB00ECDFC800B2817700E0B1
      9600D5A18100BA887C000000000000000000738C9400635A39006B6339006B63
      39006B6339006B6339006B6339006B6339006B6339006B6339006B6339006B63
      39006B6339006B63390073735A006B7B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000800080808000800080008000800080008000800080000000
      00000000000000000000000000000000000000000000DEBD9400FEFDFC00FEFD
      FC00FEFDFC00FEFDFC00FEFDFC00FEFDFC00FEFDFC00ECDFC800B2817700DDC5
      9400C9958200000000000000000000000000425A6B00425A6B00425A6B008C9C
      AD008CA5AD0073849400425A6B00425A6B00425A6B00425A6B00738494008CA5
      AD008C9CAD00425A6B00425A6B00394242000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080008000808080008000800000000000000000000000
      00000000000000000000000000000000000000000000DEBD9400FCF8F300FCF8
      F300FCF8F300FCF8F300FCF8F300FCF8F300FCF8F300ECDFC800B2817700D09C
      8300000000000000000000000000000000000000000000000000000000000000
      00004A4A4A006B6B6B005A5A5A0039393900393939008C8C8C00393939004A4A
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800080000000000000000000000000000000
      00000000000000000000000000000000000000000000DEBD9400D5A18100D5A1
      8100D5A18100D5A18100D5A18100D5A18100D5A18100D5A18100B28177000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A4A4A002929290000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007A89000000000005AAB70009AFB70000828D00007C8A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BC4C00000000000000000000000000008424040084240400842404008424
      0400842404000000000000000000000000000000000000000000000000000000
      00000FB1B80005AAB7000000000005D1D9001BE1E30001A5B1000000000021BF
      C2000000000000000000000000000000000000000000000000000E1110001212
      12000608080001020200060A0900121514000E12120003040400020202000C0C
      0D0010141400080A0A0000000000000000000000000080000000800000008000
      0000800000000000000000000000000000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000BC4C0000BC4C0000BC4C0000BE4F040084240400F2937800E18C4100D06D
      21008424040000000000000000000000000000000000000000000000000017B5
      B80050E6DC0021BFC2000CCBD30000DCE4000DDDE5002DE4E10021BFC20086E8
      D60062E6DB000000000000000000000000000000000005060600C5CBCC00F8F9
      F90037413E000D12120046505000F9FBFB00D9DFDE00222D2C000E121200828B
      8B00F9FBFB008B8F900000000000000000000000000000000000808080008000
      0000000000000000000000000000000000000000000080808000800000008000
      0000808080000000000000000000000000000000000000000000000000000000
      0000BC4C00000000000000000000000000008323040084240400842304008323
      040084240400000000000000000000000000000000001DBABC0017B5B80021BF
      C20062E6DB0059E7DA0026E1E30000DFE70000DCE40026E1E30043E9E20048E8
      E100000000000000000000000000000000000000000006080800ADB9B900FBFB
      FB006D7A7A001F272700939C9C00FBFBFB00F9FBFB005A6B69001E272700B0B7
      B700FBFBFB006A76760000000000000000000000000000000000000000008000
      0000800000000000000000000000000000000000000080808000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BC4C00000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000005AAB7000FC9
      D1004CE8DD0062E6DB003CE6E3001DBABC0017B5B8000CCBD30000DAE30000DA
      E30000DAE30001D5DD00000000000000000000000000040605008D999700FBFB
      FB009FA8A80035464500D1D6D600FBFBFB00FBFBFB009EA5A60033434100D0D5
      D500F9FBFB0045504F0000000000000000000000000000000000000000008080
      8000800000000000000000000000000000000000000080000000800000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000BC4C00000000000000000000000000008424040084240400842404008424
      040084240400000000000000000000000000000000000000000005AAB70011C5
      CC0039E4E20062E6DB000000000000000000000000000000000017B5B80000DA
      E30000DAE30000DAE30000000000000000000000000003040400626E6C00FBFB
      FB00C3CDCD005F767300F6F9F800DFE9E900EFF4F400D7DBDC00536E6B00E8EC
      EC00E8ECEC00313F3E0000000000000000000000000000000000000000000000
      0000800000008000000080000000800000008000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BC4C0000BC4C0000BC4C0000BC4C000084240400F2937800E18C4100D06D
      210084240400000000000000000000000000000000000000000005AAB70009AF
      B70026E1E30000000000DAD8D900879D8700898D8900CEA0A3000000000026E1
      E30068E6D80086E8D600008F9B0000000000000000000102020039444500F2F7
      F700DFEAE900AFC3C200FBFBFB009BACB200C9D0D400F8F9F90093ADA900F3F7
      F700CBCFCF0024302F0000000000000000000000000000000000000000000000
      0000808080008000000000000000000000008000000080000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BC4C00000000000000000000000000008323040084240400842304008323
      04008424040000000000000000000000000000000000000000000000000005AA
      B7000CCBD30000000000DAD8D90084A48400898D8900CEA0A3000000000048E8
      E1007AE8D60059E7DA0000A1AD0000000000000000000000000026323300DEE2
      E300F4F5F600E6F0EF00F1F5F5004E647100838E9600FBFBFB00DDE9E900FBFB
      FB00AAB2B3001A23220000000000000000000000000000000000000000000000
      0000000000008000000080000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BC4C00000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000788200009C
      A9000FC9D10000000000DAD8D90084A48400898D8900CEA0A3000000000033E4
      E20033E4E20000757F00000000000000000000000000000000001C242400BDC5
      C600FBFBFB00F9FBFB00CDD1D200272DB20049588C00F0F1F100F7FBFB00FBFB
      FB00899695000D12120000000000000000000000000000000000000000000000
      0000000000008080800080000000800000008000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BC4C00000000000000000000000000008424040084240400842404008424
      0400842404000000000000000000000000000000000000000000000000000000
      00000000000000000000DAD8D90084A48400898D8900C2B0A100000000000094
      9F0000879700000000000000000000000000000000000000000013181800A0A8
      A800FBFBFB00FBFBFB0099A3B400120DF2003033B700C6CAD000FBFBFB00F9FB
      FB0069757400070A0A0000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BC4C0000BC4C0000BC4C0000BC4C000084240400F2937800E18C4100D06D
      2100842404000000000000000000000000000000000000000000000000000000
      00000000000000000000DAD8D90084A48400898D8900C2B0A100000000000000
      0000000000000000000000000000000000000000000000000000080C0C007A82
      8200FBFBFB00F8F8FB005A5DAC003737FA001317EC009297AC00FBFBFB00F7FB
      FB0045514F000506060000000000000000000000000000000000000000000000
      0000000000000000000080808000800000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BC4C00000000000000000000000000008323040084240400842304008323
      0400842404000000000000000000000000000000000000000000000000000000
      00000000000000000000879D87000000000000000000898D8900000000000000
      0000000000000000000000000000000000000000000000000000020404003B45
      4400AAB2B000949AA3002B2CB1006E6EFA000B0AF20043478700ABB1B6009EAA
      A700192020000102020000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000842404008424
      0400842404008424040084240400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DAD8D9009FCDA500898D8900859F8100000000000000
      000000000000000000000000000000000000000000000000000000000000060A
      07001116160014191C001A1E3200272B460022274100151A260013181A000D12
      1200040605000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084240400F293
      7800E18C4100D06D210084240400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DAD8D900DAD8D9009ECCA400898D8900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000030204000302040000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000832304008424
      0400842304008323040084240400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000CE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000CE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006363C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000CE000000CE000000CE000000CE000000CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000CE000000CE000000CE000000CE000000CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      C6000000CE000000CE0000000000000000000000CE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      C6000000CE000000CE000000000000000000000000000000CE000000CE006363
      C60000000000000000000000000000000000000000000000000000000000E763
      6300FF000000FF0000000000000000000000FF00000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      CE000000000000000000000000000000CE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      CE00000000000000000000000000000000000000000000000000000000000000
      CE0000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000FF0000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000000000CE000000
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      CE000000CE000000000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000000000CE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000CE000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000006363C6000000CE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000E76363000000000000000000FF00000000000000FF0000000000
      0000FF00000000000000000000000000000000000000000000000000CE000000
      00000000CE00000000000000CE000000000000000000E7636300FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000E76363000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      CE000000CE000000CE0000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000CE000000000000000000000000000000000000000000FF000000FF00
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000000000000000000000000000FF00
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000000000000000000FF000000FF000000E763
      630000000000000000000000000000000000000000000000000000000000E763
      6300FF000000FF000000000000000000000000000000FF000000FF000000E763
      630000000000000000000000000000000000000000000000000000000000E763
      6300FF000000FF000000000000000000000000000000FF000000FF000000E763
      630000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E76363000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E76363000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF6C6C00FF6C6C00FF6C6C00FF6C6C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000840000008400
      000084000000FFFFFF008400000084000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000084000000840000008400
      0000FFFFFF0000000000000000008400000084000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF000000000000000000000000000000000084000000FFFF
      FF000000000000000000000000000000000084000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      0000000000000000000000000000000000000000000000000000C14A4A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C14A4A0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      00000000000000000000000000000000000000000000C14A4A00C14A4A00C14A
      4A00C14A4A00C14A4A00C14A4A00C14A4A00C14A4A00C14A4A00C14A4A00C14A
      4A00C14A4A00C14A4A00C14A4A00000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      00000000000000000000000000000000000000000000C14A4A00C14A4A00C14A
      4A00C14A4A00C14A4A00C14A4A00C14A4A00C14A4A00C14A4A00C14A4A00C14A
      4A00C14A4A00C14A4A00C14A4A00000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      0000000000000000000000000000000000000000000000000000C14A4A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C14A4A0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF6C6C00FF6C6C00FF6C6C00FF6C6C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF6C6C00FF6C6C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      840084848400848484008484840084848400848484008484840000000000C6C6
      C60084848400C6C6C60000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      840084848400848484008484840084848400848484008484840084848400FFFF
      FF0084848400FFFFFF0084848400FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A57300007B5A00007B5A00007B5A
      00004A4A4A004A4A4A00848484008484840084848400FFFFFF00FFFFFF00FFFF
      FF007B5A00007B5A00007B5A0000A57300000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B5A
      0000A5730000A57300004A4A4A004A4A4A0084848400FFFFFF00FFFFFF00FFFF
      FF007B5A00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B5A
      0000A5730000A5730000A57300004A4A4A00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF007B5A00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B5A
      0000A5730000A5730000A57300004A4A4A00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF007B5A00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B5A
      0000A5730000A5730000A57300004A4A4A00FFFFDE00FFFF8400F7EF7300FFFF
      00007B5A00000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000007B5A
      0000A5730000A5730000A57300004A4A4A00FFFF8400FFFF8400FFFF8400FFFF
      84007B5A00000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000007B5A
      0000A5730000A5730000A57300004A4A4A00FFFF8400FFFF8400FFFF8400FFFF
      84007B5A00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000007B5A
      0000A5730000A5730000A57300004A4A4A00FFFF0000FFFF8400FFFF8400FFFF
      DE007B5A00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF000000000000000000000000000000000000000000A573
      00007B5A00007B5A00007B5A00007B5A00007B5A00007B5A00007B5A00007B5A
      0000A57300000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000006B6B6B004A4A4A004A4A4A004A4A4A004A4A4A006B6B6B000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000004A4A4A0000DE000000DE000000DE000000DE00004A4A4A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006B6B6B004A4A4A004A4A4A004A4A4A004A4A4A006B6B6B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF008484840000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF008484840000000000848484000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000FFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF008484840000000000848484000000
      000000000000000000000000000000FFFF00000000000000000000000000FFFF
      FF00C6C6C600C6C6C600FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000FFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000840000008400000084000000
      84000000000000FFFF000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      840000008400000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      84000000000000FFFF000000000000000000000000000000000000000000FFFF
      FF00C6C6C600C6C6C600FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000000000000000000000000000000000FFFF
      FF00C6C6C600C6C6C600FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF00000000000000000000000000FFFF
      FF00FFFFFF00C6C6C600FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000C60000CE000000CE0000FF000000FF000000FF00000000FFFF0000FF
      FF00000000000000000000000000000000000084000000840000008400000084
      0000008400000084000000840000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000C60000CE000000CE0000FF000000FF000000FF00000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000C6000000C60000CE000000CE0000FF000000FF00000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000C6000000C60000CE000000CE000000CE0000FF000000FF00000000FF
      FF00000000000000000000000000000000000000840000008400000084000000
      84000000840000008400000084000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C6008484
      8400000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C600FFFF00008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6C6008484
      8400C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C6C6C600FFFF0000C6C6C600C6C6C6008484
      8400C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000084848400FFFF0000FFFF0000C6C6C6008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000084848400C6C6C600C6C6C6008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000008400
      00008400000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000008400
      0000F7CEA50084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000008400
      0000F7CEA50084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000F7CEA50084000000840000008400000084000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000084000000F7CEA500F7CEA500F7CE
      A500F7CEA500F7CEA500F7CEA500F7CEA50084000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000008400000084000000840000008400
      0000F7CEA50084000000840000008400000084000000FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000008400
      0000F7CEA50084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000F7CEA5008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FF000000840000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      00000000000084000000FF000000840000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6C6C6000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      00000000000084000000FF000000840000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400C6C6C600000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400000000008484
      8400C6C6C60000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000008484840084848400000000000000000000000000000000000000
      000000000000C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF00000000008484840084848400000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000848484008484840084848400C6C6
      C6000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400C6C6C600C6C6
      C600C6C6C60000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008484840084848400C6C6C600C6C6C6000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF0000000000C6C6C60000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000848484008484
      84000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400C6C6C60000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000C6C6
      C60000000000FFFFFF0000000000C6C6C60000000000C6C6C600000000000000
      0000000000000000000084000000840000000000000000000000848484008484
      840000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000C6C6C6000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6
      C600C6C6C6000000000084000000840000000000000000000000848484008484
      84000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF0000000000000000000000000000000000FFC66B00FFC66B00FFC66B00FFC6
      6B00FFC66B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084000000840000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF0000000000000000000000000000000000FFC66B00FFC66B00FFC66B000000
      0000FFC66B0000000000FFC66B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084000000840000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFC66B00FFC66B00FFC66B00FFC6
      6B00FFC66B00FFC66B00FFC66B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFC66B00FFC66B00FFC66B000000
      0000FFC66B0000000000FFC66B00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFC66B00FFC66B00FFC66B00FFC6
      6B00FFC66B00FFC66B00FFC66B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000848484000000
      8400848484000000000000000000000000000000000084000000840000008400
      0000000000000000000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000000084008484
      8400000084000000000000000000000000008400000084000000000000000000
      0000840000008400000084848400848484000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000000000848484008484
      8400848484008484840084848400000000000000000084848400000084000000
      0000000084000000000000000000840000008400000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF0000000000848484008484
      8400848484008484840084848400000000000000840000008400848484000000
      0000000084000000000000000000840000008400000000000000000000000000
      0000000000008400000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000008400848484000000
      0000000084008484840000000000840000008400000000000000000000000000
      0000000000008400000084848400000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF00FFFFFF0000FFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000848484000000840000000000000000008400000084000000000000000000
      0000840000008400000084000000848484000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000840000008400000000000000000000000000000000000000840000008400
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000848484008484
      840084848400848484008484840000000000FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000084000000840000008400
      0000848484000000000084848400840000000000000000000000000000008400
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000008400000000000000000000000000000000000000840000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000848484008484
      84008484840084848400848484000000000000FFFF00FFFFFF0000FFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000848484008484
      840084848400848484008484840000000000FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000840084848400848484008484840084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000084000000840000008400000084000000
      8400000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000C6C6C6008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000C6C6
      C600840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000084848400008484008484
      8400008484008484840084000000FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000C6C6C6008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000848400848484000084
      8400848484000084840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00840000000000000000000000000000000000
      00000000000000000000000000000000000084000000C6C6C600840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000084848400008484008484
      8400008484008484840084000000FFFFFF00000000000000000000000000FFFF
      FF00840000008400000084000000840000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600FFFFFF008484840084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000848400848484000084
      8400848484000084840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000FFFFFF008400000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000084848400008484008484
      8400008484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00840000008400000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFFFF008400
      0000840000008400000084000000000000000000000000848400848484000084
      8400848484000084840084000000840000008400000084000000840000008400
      00008400000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000FFFFFF008400000000000000000000000000000084848400008484008484
      8400008484008484840000848400848484000084840084848400008484008484
      84000084840000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000840000000000000000000000000000000000000000848400848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      84008484840000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000084000000840000008400000084000000840000008400
      0000000000000000000000000000000000000000000084848400848484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000008484
      84000084840000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400848484000084
      84000000000000FFFF00000000000000000000FFFF0000000000848484000084
      8400848484000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFF0000FFFF0000C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C60084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000084000000000000000000000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000084840000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000084000000000000008400000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000084840000000000000000000000000000FFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000008400
      0000000000000000000084000000000000008400000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000848400000000000000000000000000FFFFFF0000FFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000000000008400000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000000000000000000084000000000000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000084840000848400000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000000000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000084840000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000848400000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000084840000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000E00000000100010000000000000700000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FE7FFFFFFFFFFFFFF83F80030000FFFF
      E01F80030000FFFF800F80030000FFFF000780030000FFFF0003800300009539
      00018003000064D600008003000075D700008003000085D780018003000074D6
      C001800300008D39E00180030000FDFFF00180030000FDFFF80780070000FFFF
      FC1F800FF00FFFFFFE7F801FFE7FFFFFFE3F0000FFFFFFFFE0070000FFFFF707
      E00700008703F00780030000CF87F70780010000E78FF7FF80010000E78FF707
      80010000F01FF00780010000F31FF70780010000F93FF7FFC0030000F83FF707
      E0070000FC7FF007F81F0000FC7FF707F81F0000FEFFC1FFF81F0000FFFFC1FF
      F81F0000FFFFC1FFFC3F0000FFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFEFFFFFF
      FF7FFEFFFF7FFFFFF83FF83FF83FC003E37FE38FE37FC003EEFFEFEFEEFFC003
      CFFFDFE7CFFFC003DFFF8FF7DFFFC0039FF357D59FF3C003FFF7DFE3DFF7C003
      FFE7CFF7CFE7C003FEEFEFEFEFEFC003FD8FE38FE38FC003F83FF83FF83FC003
      FDFFFEFFFEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFE7FFFFFFC3FF9FFFC3FFFFF
      FC3FF0FFF81FFFFF8421E0FFF00FFFFF8421C07FFC3FEFF78421863FFC3FCFF3
      8421CF3FFC3F80018421FF9FFC3F00008421FFCFFC3F00008421FFE7FC3F8001
      8421A9C3FC3FCFF38421AAB9FC3FEFF7FC3F89BDF00FFFFFFC3FAABFF81FFFFF
      FFFFD9CFFC3FFFFFFFFFFFFFFE7FFFFFFFFFFFFFFFFF0022803F8421FFFF0000
      803F8421FC3F0000803F8421FC3FE007803F8421FC3FE007FFFF8421FC3FE007
      800384218421E007800384218421E007800384218421E007800384218421E007
      FFFFFC3F8421E007803FFC3F8421FFFF803FFC3F8421F81F803FFC3F8421F81F
      803FFFFF8421F81FFFFFFFFFFFFFFFFF80005FFBFFFFFFFF00005FF8E00FFC01
      00005FF0E00FFC0100005F80E00FFC0100005F40E00FFC0100005EC0FFFFFFFF
      00000DC08003C00100010BC08003C001FFFF07C08003C00188870BC08003C001
      DDDBFDC0FFFFFFFFC1DBFEC0E00FFC01EBC7FF40E00FFC01E3D7FF80E00FFC01
      F7D7FFF0E00FFC01F78FFFFCFFFFFFFF80008000FFFFFFFF00000000FFFFFFFF
      00000000FFFFFFFF00000000FFFFFFFF00000000F03F800300000000CFCFBFFB
      00000000BFF7BFFB000100017FFBBFFBFFFFFFFF7FFBBFFBFFFFFFFF7FFBBFFB
      E007FFFFBFF7BFFBE0070180CFCFBFFBE007FFFFF03F8003E007FFFFFFFFFFFF
      E0070180FFFFFFFFE007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFF000CFFF7FFFF
      F1FF0008FFF7FFFFE0FF0001FFF7FFFFFBFF0003FFF7FFFFFBFF0003FFF7FFFF
      FBFF0003FFF7FFFFFBFF0003F9EF0000F80F0003F6EF0000FFEF0007EF6F0000
      FFEF000FDF9FFFFFFFEF000FDFFFFFFFFFEF000FDFFFFFFFFFEF001FDFFFFFFF
      FFEF003FDFFFFFFFFFFF007FFFFFFFFFFFFFFFFFFFFFFFFFC007FFFFFFFFFFFF
      8003E003FFFFFFFF0001E003FFF7FF070001E003FFEFFF870001E003FFDFFFC7
      0000E003FFBFFFA70000E003FF7FFF778000E003FEFFFEFFC000E003FDFFFDFF
      E0010003FBFFFBFFE0070003F7FFF7FFF0070007EFFFEFFFF003E00FDFFFDFFF
      F803E01FFFFFFFFFFFFFE3FFFFFFFFFFFFFFF00FFFFDFFFFFF80F00FFFF8000F
      FF80F00FFF70000FFF80F00FFF21000FF000F00FFE03000FF000F007FE07000F
      F000E007EA07000FF000E007FE01000F8007C007EC03000F8007C007FC1F0004
      8007C007006F00008007C007007F00008007E00700EFF80080FFF00F00FFFC00
      80FFF01F00AFFE04FFFFFC3F00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80
      FFFFFFFFFFFFFF80EFFFFFFFFFFFFF80C78CFFFFFFFFF000C730E7FFFFE7F000
      967BCF83C1F3F000167BDFC3C3FBF0009279DFE3C7FB8007F330DFD3CBFB8007
      FB84CF3BDCF38007FBFFE0FFFF078007F800FFFFFFFF8007F800FFFFFFFF80FF
      FFFFFFFFFFFF80FFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FFFFFFFFFC00FFE1FFFF
      FC018000FFC1EFFDFC010000FF83C7FFFC010000F007C3FB00010000C00FE3F7
      00010001801FF1E700010003801FF8CF00010003000FFC1F00030003000FFE3F
      00070003000FFC1F000F0003000FF8CF00FF0003801FE1E701FF8007801FC3F3
      03FFF87FC03FC7FDFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFC001FFFFF3FF
      E0038001001FED9FE0038001000FED6FE00380010007ED6FE00380010003F16F
      E00380010001FD1FE00380010000FC7FE0038001001FFEFFE0038001001FFC7F
      E0038001001FFD7FE00380018FF1F93FE0078001FFF9FBBFE00F8001FF75FBBF
      E01F8001FF8FFBBFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenu: TPopupMenu
    Images = ImageList
    Left = 248
    Top = 136
    object Properties1: TMenuItem
      Action = PropertiesAction
    end
    object Edittext1: TMenuItem
      Action = EditTextAction
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Bringtofront1: TMenuItem
      Action = BringToFrontAction
    end
    object Sendtoback1: TMenuItem
      Action = SendToBackAction
    end
    object Group1: TMenuItem
      Action = GroupAction
    end
    object Ungroup1: TMenuItem
      Action = UngroupAction
    end
    object Rotate1: TMenuItem
      Caption = 'Rotate'
      object Mirror1: TMenuItem
        Action = FlipLRAction
      end
      object Flip1: TMenuItem
        Action = FlipUDAction
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object About1: TMenuItem
        Action = Rotate90Action
      end
      object Rotate1801: TMenuItem
        Action = Rotate180Action
      end
      object Addtemplate1: TMenuItem
        Action = Rotate270Action
      end
      object Anyangle1: TMenuItem
        Action = RotateAction
      end
    end
    object AlignMenu: TMenuItem
      Caption = 'Align'
      object Left1: TMenuItem
        Action = AlignLeftAction
      end
      object Center1: TMenuItem
        Action = AlignCenterHAction
      end
      object Right1: TMenuItem
        Action = AlignRightAction
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object op1: TMenuItem
        Action = AlignTopAction
      end
      object Center2: TMenuItem
        Action = AlignCenterVAction
      end
      object Bottom1: TMenuItem
        Action = AlignBottomAction
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object Page1: TMenuItem
        Action = AlignPageAction
      end
    end
    object Convert1: TMenuItem
      Caption = 'Convert'
      object Converttopolygon1: TMenuItem
        Action = MakePolygonAction
      end
      object Converttometafile1: TMenuItem
        Action = MakeMetafileAction
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Cut1: TMenuItem
      Action = CutAction
    end
    object Copy1: TMenuItem
      Action = CopyAction
    end
    object Paste1: TMenuItem
      Action = PasteAction
    end
    object Delete1: TMenuItem
      Action = DeleteAction
    end
  end
  object PageMenu: TPopupMenu
    Images = ImageList
    OnPopup = PageMenuPopup
    Left = 408
    Top = 392
    object Deletepage1: TMenuItem
      Action = PagePropertiesAction
    end
    object Newpage1: TMenuItem
      Action = NewPageAction
    end
    object Reorderpages1: TMenuItem
      Action = ReorderPagesAction
    end
    object N3: TMenuItem
      Caption = '-'
    end
  end
  object PrintDialog: TPrintDialog
    Options = [poPageNums, poWarning]
    Left = 132
    Top = 56
  end
  object TemplatePopupMenu: TPopupMenu
    Images = ImageList
    OnPopup = TemplatePopupMenuPopup
    Left = 505
    Top = 96
    object TemplatePropertiesItem: TMenuItem
      Action = TemplatePropertiesAction
      Default = True
    end
    object Deletetemplateobject1: TMenuItem
      Action = DeleteTemplateAction
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object LoadTemplatePaletteMenu: TMenuItem
      Caption = 'Load template palette'
      Hint = 'Load template palette from library'
      OnClick = LoadTemplatePaletteMenuClick
      object DefaultPaletteItem: TMenuItem
        Caption = 'Default'
        OnClick = LoadTemplatePaletteItemClick
      end
      object N9: TMenuItem
        Caption = '-'
      end
    end
    object Loadtemplatepalette1: TMenuItem
      Action = LoadTemplateAction
    end
    object Savetemplatepalette1: TMenuItem
      Action = SaveTemplateAction
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Properties2: TMenuItem
      Action = TemplateToPageAction
    end
    object Copypagetotemplates1: TMenuItem
      Action = PageToTemplateAction
    end
  end
  object ResentFilesMenu: TPopupMenu
    OnPopup = ResentFilesMenuPopup
    Left = 24
    Top = 52
  end
  object LayerMenu: TPopupMenu
    Left = 504
    Top = 392
    object About2: TMenuItem
      Action = EditLayer1Action
    end
    object Layer21: TMenuItem
      Action = EditLayer2Action
    end
    object Layer31: TMenuItem
      Action = EditLayer3Action
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object Globalstencil1: TMenuItem
      Action = EditStencilAction
    end
  end
end
