unit SlideShow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PanelFrame, DiagramBase, Menus, ExtCtrls, Math, ValueEdits, FastBitmap;

type
  TSlideShowForm = class(TForm)
    SlidePanel: TPanelFrame;
    PopupMenu: TPopupMenu;
    NextSlideItem: TMenuItem;
    PreviousSlideItem: TMenuItem;
    CloseItem: TMenuItem;
    N1: TMenuItem;
    RenderTimer: TTimer;
    FirstSlideItem: TMenuItem;
    LastSlideItem: TMenuItem;
    GoToPageItem: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CloseItemClick(Sender: TObject);
    procedure NextSlideItemClick(Sender: TObject);
    procedure PreviousSlideItemClick(Sender: TObject);
    procedure SlidePanelPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PopupMenuPopup(Sender: TObject);
    procedure FirstSlideItemClick(Sender: TObject);
    procedure LastSlideItemClick(Sender: TObject);
    procedure RenderTimerTimer(Sender: TObject);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GoToPageItemClick(Sender: TObject);
  private
    { Private declarations }
    PrevSlide, CurSlide, NextSlide : TFastBitmap;
    procedure RenderSlide(Index: Integer; var Bitmap: TFastBitmap);
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  public
    { Public declarations }
    CanvasInfo : TCanvasInfo;
    Slides : TDiagramContainer;
    Page : Integer;
    Antialiasing : Integer;
  end;

resourcestring
  rsPageNumber = 'Page number:';

implementation

{$R *.dfm}

procedure TSlideShowForm.FormShow(Sender: TObject);
begin
  CanvasInfo.DrawMode:=dmRender;
  CanvasInfo.Container:=Slides;
  //CanvasInfo.DisableFontSmoothing:=Antialiasing>1;
  SlidePanel.Height:=1;
  SlidePanel.Width:=1;
end;

procedure TSlideShowForm.FormDestroy(Sender: TObject);
begin
  Application.OnMessage:=nil;
  PrevSlide.Free;
  CurSlide.Free;
  NextSlide.Free;
end;

procedure TSlideShowForm.WMSysCommand(var Msg: TMessage);
begin
  if Msg.wParam=SC_SCREENSAVE then
    Msg.Result:=1
  else inherited;
end;

procedure TSlideShowForm.CloseItemClick(Sender: TObject);
begin
  Close;
end;

procedure TSlideShowForm.NextSlideItemClick(Sender: TObject);
begin
  if Page<Slides.Count-1 then
  begin
    PrevSlide.Free;
    PrevSlide:=CurSlide;
    CurSlide:=NextSlide;
    NextSlide:=nil;
    Inc(Page);
    SlidePanel.Repaint;
    RenderTimer.Enabled:=False;
    RenderTimer.Enabled:=True;
  end;
end;

procedure TSlideShowForm.PreviousSlideItemClick(Sender: TObject);
begin
  if Page>0 then
  begin
    NextSlide.Free;
    NextSlide:=CurSlide;
    CurSlide:=PrevSlide;
    PrevSlide:=nil;
    Dec(Page);
    SlidePanel.Repaint;
    RenderTimer.Enabled:=False;
    RenderTimer.Enabled:=True;
  end;
end;

procedure TSlideShowForm.FirstSlideItemClick(Sender: TObject);
begin
  if Page=1 then PreviousSlideItemClick(nil)
  else if Page>1 then
  begin
    Page:=0;
    FreeAndNil(CurSlide);
    SlidePanel.Repaint;
    RenderTimer.Enabled:=False;
    FreeAndNil(PrevSlide);
    FreeAndNil(NextSlide);
    RenderTimer.Enabled:=True;
  end;
end;

procedure TSlideShowForm.LastSlideItemClick(Sender: TObject);
begin
  if Page=Slides.Count-2 then NextSlideItemClick(nil)
  else if Page<Slides.Count-2 then
  begin
    Page:=Slides.Count-1;
    FreeAndNil(CurSlide);
    SlidePanel.Repaint;
    RenderTimer.Enabled:=False;
    FreeAndNil(PrevSlide);
    FreeAndNil(NextSlide);
    RenderTimer.Enabled:=True;
  end;
end;

procedure TSlideShowForm.RenderSlide(Index: Integer; var Bitmap: TFastBitmap);
begin
  CanvasInfo.PageIndex:=Index;
  Bitmap:=TFastBitmap.Create;
  with Slides.Pages[Index] do
  begin
    CanvasInfo.Scale.X:=Min(Self.Width/Width,Self.Height/Height)*Antialiasing;
    CanvasInfo.Scale.Y:=CanvasInfo.Scale.X;
    Bitmap.New(Round(Width*CanvasInfo.Scale.X),
               Round(Height*CanvasInfo.Scale.Y),
               pf24bit);
    Draw(Bitmap.Canvas,CanvasInfo);
  end;
  ScaleForAntialiasing(Bitmap,Antialiasing);
end;

procedure TSlideShowForm.SlidePanelPaint(Sender: TObject);
begin
  if CurSlide=nil then RenderSlide(Page,CurSlide);
  SlidePanel.Width:=CurSlide.Width;
  SlidePanel.Height:=CurSlide.Height;
  SlidePanel.Left:=(Width-SlidePanel.Width) div 2;
  SlidePanel.Top:=(Height-SlidePanel.Height) div 2;
  SlidePanel.Canvas.Draw(0,0,CurSlide);
end;

procedure TSlideShowForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_DOWN,
    VK_SPACE,
    VK_RETURN : NextSlideItemClick(nil);
    VK_UP,
    VK_BACK   : PreviousSlideItemClick(nil);
    VK_END    : if ssCtrl in Shift then LastSlideItemClick(nil);
    VK_HOME   : if ssCtrl in Shift then FirstSlideItemClick(nil);
  end;
end;

procedure TSlideShowForm.PopupMenuPopup(Sender: TObject);
begin
  RenderTimer.Enabled:=False;
  NextSlideItem.Enabled:=Page<Slides.Count-1;
  LastSlideItem.Enabled:=Page<Slides.Count-1;
  PreviousSlideItem.Enabled:=Page>0;
  FirstSlideItem.Enabled:=Page>0;
end;

procedure TSlideShowForm.RenderTimerTimer(Sender: TObject);
begin
  RenderTimer.Enabled:=False;
  SetCursorPos(Width-1,Height-1);
  if (NextSlide=nil) and (Page<Slides.Count-1) then RenderSlide(Page+1,NextSlide);
end;

procedure TSlideShowForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  PreviousSlideItemClick(nil);
end;

procedure TSlideShowForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  NextSlideItemClick(nil);
end;

procedure TSlideShowForm.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then NextSlideItemClick(nil);
end;

procedure TSlideShowForm.GoToPageItemClick(Sender: TObject);
var
  NewPage : Integer;
begin
  NewPage:=Page+1;
  if IntegerQuery(StripHotkey(GoToPageItem.Caption),rsPageNumber,NewPage,1,Slides.Count,120,1) then
  begin
    Dec(NewPage);
    if NewPage=Page-1 then PreviousSlideItemClick(nil)
    else if NewPage=Page+1 then NextSlideItemClick(nil)
    else if NewPage<>Page then
    begin
      Page:=NewPage;
      FreeAndNil(CurSlide);
      SlidePanel.Repaint;
      RenderTimer.Enabled:=False;
      FreeAndNil(PrevSlide);
      FreeAndNil(NextSlide);
      RenderTimer.Enabled:=True;
    end;
  end;
end;

end.

