unit TextEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StyleForm, StdCtrls, ComCtrls, PanelFrame, ShapeObject, DiagramBase,
  Consts;

resourcestring
  rsBold = 'Bold';
  rsItalic = 'Italic';
  rsUnderline = 'Underline';
  rsOverline = 'Overline';
  rsSuperscript = 'Superscript';
  rsSubscript = 'Subscript';
  rsSymbolFont = 'Symbol font';
  rsSetFontByName = 'Set font by name';
  rsFont = 'Font';
  rsThreeDigitFontSize = 'Three-digit font size';
  rsNewLine = 'New line';
  rsPageNumber = 'Page number';
  rsPageCount = 'Page count';
  rsPageTitle = 'Page title';
  rsHTMLFormattedColor = 'HTML formatted color';
  rsDiagramOrInternetLink = 'Diagram or Internet link';
  rsPopupNote = 'Popup note';

type
  TTextEditorForm = class(TStyleForm)
    RichEdit: TRichEdit;
    OKButton: TButton;
    CancelButton: TButton;
    Label1: TLabel;
    LabelCode1: TLabel;
    LabelDescription1: TLabel;
    Label2: TLabel;
    LabelCode2: TLabel;
    LabelDescription2: TLabel;
    Preview: TDoubleBufferedPanel;
    ClipPanelFrame: TPanelFrame;
    procedure RichEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RichEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PreviewPaint(Sender: TObject);
  private
    PreviewObject : TTextObject;
    CanvasInfo : TCanvasInfo;
    function ObjectText: string;
  public
    class function Execute(var AText: string): Boolean;
  end;

implementation

uses Main, MathUtils;

{$R *.dfm}

{ TTextEditorForm }

class function TTextEditorForm.Execute(var AText: string): Boolean;
var
  InString : Boolean;
  I : Integer;
  Str : string;
begin
  with Create(nil) do
  try
    InString:=False;
    Str:=AText;
    for I:=1 to Length(Str)-1 do
    begin
      if (Str[I]='"') and (I>1) and (InString or (Str[I-1]='\')) then InString:=not InString;
      if not InString and (Str[I]='\') and (Str[I+1]='n') then
      begin
        Str[I]:=#13;
        Str[I+1]:=#10;
      end;
    end;
    RichEdit.Lines.Text:=Str;
    RichEdit.SelStart:=0;
    RichEdit.SelLength:=Length(Str);
    Result:=ShowModal=mrOk;
    if Result then AText:=ObjectText;
  finally
    Free;
  end;
end;

procedure TTextEditorForm.FormCreate(Sender: TObject);

  procedure AddFormatCode1(const Code,Description: string);
  begin
    with LabelCode1 do Caption:=Caption+Code+#13;
    with LabelDescription1 do Caption:=Caption+Description+#13;
  end;

  procedure AddFormatCode2(const Code,Description: string);
  begin
    with LabelCode2 do Caption:=Caption+Code+#13;
    with LabelDescription2 do Caption:=Caption+Description+#13;
  end;

begin
  UseBackgroundTheme:=True;
  // Create help
  LabelDescription1.Caption:='';
  LabelCode1.Caption:='';
  LabelDescription2.Caption:='';
  LabelCode2.Caption:='';
  AddFormatCode1('\B ... \b',rsBold);
  AddFormatCode2('\I ... \i',rsItalic);
  AddFormatCode1('\U ... \u',rsUnderline);
  AddFormatCode2('\O ... \o',rsOverline);
  AddFormatCode1('\H ... \h',rsSuperscript);
  AddFormatCode2('\L ... \l',rsSubscript);
  AddFormatCode1('\S ... \s',rsSymbolFont);
  AddFormatCode2('\P',rsPageTitle);
  AddFormatCode1('\p',rsPageNumber);
  AddFormatCode2('\c',rsPageCount);
  AddFormatCode1('\###',rsThreeDigitFontSize);
  AddFormatCode2('','');
  AddFormatCode1('\"'+rsFont+'"',rsSetFontByName);
  AddFormatCode2('','');
  AddFormatCode1('\C######',rsHTMLFormattedColor);
  AddFormatCode2('','');
  AddFormatCode1('\n',rsNewLine);
  AddFormatCode2('\N',rsPopupNote);
  AddFormatCode1('\\','\');
  AddFormatCode2('\A',rsDiagramOrInternetLink);
  // Prepare controls
  Label2.Top:=LabelCode1.BoundsRect.Bottom;
  RichEdit.Top:=Label2.BoundsRect.Bottom+4;
  ClientHeight:=RichEdit.BoundsRect.Bottom+OKButton.Height+10;
  RichEdit.Anchors:=[akLeft,akTop,akRight,akBottom];
  Preview.Top:=ClientHeight-Preview.Height;
  OKButton.Top:=ClientHeight-OKButton.Height-4;
  CancelButton.Top:=OKButton.Top;
  Constraints.MinHeight:=Height;
  Constraints.MinWidth:=Width;
  OKButton.Hint:=SmkcCtrl+SmkcEnter;
  ClientWidth:=LabelDescription2.Left+LabelDescription2.Width+8;
  RichEdit.Width:=ClientWidth-8;
  OKButton.Left:=ClientWidth-8-OKButton.Width;
  CancelButton.Left:=OKButton.Left-8-CancelButton.Width;
  Preview.Width:=CancelButton.Left-8;
  // Prepare preview
  PreviewObject:=TTextObject.Create;
  PreviewObject.Properties[opTextXAlign]:=-1;
  CanvasInfo.DefaultFont:=MainForm.DrawPanel.Font;
  CanvasInfo.Offset.Y:=Preview.Height div 2;
  CanvasInfo.Scale:=FloatPoint(MainForm.ScreenScale,MainForm.ScreenScale);;
end;

procedure TTextEditorForm.FormDestroy(Sender: TObject);
begin
  PreviewObject.Free;
end;

function TTextEditorForm.ObjectText: string;
var
  I : Integer;
begin
  Result:=RichEdit.Lines[0];
  for I:=1 to RichEdit.Lines.Count-1 do Result:=Result+'\n'+RichEdit.Lines[I];
end;

procedure TTextEditorForm.RichEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN : if ssCtrl in Shift then
                begin
                  Key:=0;
                  ModalResult:=mrOk;
                end;
    VK_ESCAPE : ModalResult:=mrCancel;
  end;
end;

procedure TTextEditorForm.RichEditChange(Sender: TObject);
var
  Str : string;
  I, CodeLength, SelStart, SelLength : Integer;
begin
  // Update preview
  Str:=ObjectText;
  PreviewObject.Properties[opText]:=Integer(@Str);
  Preview.Invalidate;
  // Update syntax highlighting
  SelStart:=RichEdit.SelStart;
  SelLength:=RichEdit.SelLength;
  Str:=RichEdit.Text;
  ClipPanelFrame.BoundsRect:=RichEdit.BoundsRect; // Prevent painting while working
  ClipPanelFrame.Visible:=True;
  RichEdit.SelectAll;
  RichEdit.SelAttributes.Color:=clWindowText;
  I:=Pos('\',Str);
  if I>0 then
    repeat
      if Str[I]='\' then
      begin
        case Str[I+1] of
          '0'..'9' : if not (Str[I+2] in ['0'..'9']) then CodeLength:=2
                     else if not (Str[I+3] in ['0'..'9']) then CodeLength:=3
                     else CodeLength:=4;
          '"'      : begin
                       CodeLength:=2;
                       while not (Str[I+CodeLength] in [#0,'"']) do Inc(CodeLength);
                       Inc(CodeLength);
                     end;
          'A','N'  : CodeLength:=Length(Str);
          'C'      : CodeLength:=8;
          else CodeLength:=2;
        end;
        RichEdit.SelStart:=I-1;
        RichEdit.SelLength:=CodeLength;
        RichEdit.SelAttributes.Color:=$ff8080;
        Inc(I,CodeLength);
      end
      else Inc(I);
    until I>Length(Str);
  RichEdit.SelStart:=SelStart;
  RichEdit.SelLength:=SelLength;
  ClipPanelFrame.Visible:=False;
end;

procedure TTextEditorForm.PreviewPaint(Sender: TObject);
begin
  Preview.Clear(Color,False);
  PreviewObject.Draw(Preview.BitmapCanvas,CanvasInfo,0);
end;

end.

