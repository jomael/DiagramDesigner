object QuickMenuSearchForm: TQuickMenuSearchForm
  Left = 428
  Top = 218
  Width = 393
  Height = 249
  BorderStyle = bsSizeToolWin
  Caption = 'Menu search'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 196
    Width = 385
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ListView: TListView
    Left = 0
    Top = 21
    Width = 385
    Height = 175
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'Title'
      end
      item
        AutoSize = True
        Caption = 'Menu'
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnDblClick = ListViewDblClick
    OnSelectItem = ListViewSelectItem
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object SearchEdit: TEdit
      Left = 0
      Top = 0
      Width = 337
      Height = 21
      AutoSelect = False
      PopupMenu = DummyMenu
      TabOrder = 0
      Text = 'SearchEdit'
      OnChange = SearchEditChange
      OnKeyDown = FormKeyDown
    end
  end
  object DummyMenu: TPopupMenu
    Left = 8
    Top = 52
  end
end
