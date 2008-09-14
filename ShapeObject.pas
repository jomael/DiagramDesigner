unit ShapeObject;

interface

uses Monitor, Windows, SysUtils, StreamUtils, Contnrs, MathUtils, Graphics, DiagramBase,
  Types, Streams, Math, Classes;

const
  DefaultLineWidth = 3*DesignerDPpoint div 4;

type
  TTextAlign = -1..3;
            // -1  Left
            //  0  Block left
            //  1  Right
            //  2  Center
            //  3  Block right

  PFontStyles = ^TFontStyles;

  TTextObject = class(TBaseObject)
    protected
      FText : string;
      FTextXAlign : TTextAlign;
      FTextYAlign : TTextAlign;
      FTextColor  : TColor;
      FMargin : Integer;
      FEditTextAfterPlace : Boolean;
      CurrentTextRect : TRect; // Only valid after call to draw
      function GetProperty(Index: TObjectProperty): Integer; override;
      procedure SetProperty(Index: TObjectProperty; Value: Integer); override;
    public
      constructor CreateNew(PropertyObject: TBaseObject=nil); overload; override;
      constructor CreateNew(const Text: string); reintroduce; overload;
      function CreateCopy: TBaseObject; override;
      function ValidProperties: TObjectProperties; override;
      function Hint: string; override;
      function EditTextAfterPlace: Boolean;
      procedure Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer); override;
      class function Identifier: Integer; override;
      procedure SaveToStream(Stream: TBaseStream); override;
      procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); override;
      procedure SetTextAndName(const Text: string);
    end;

  TBaseLineObject = class(TTextObject)
    protected
      FLineColor  : TColor;
      FLineWidth  : LongInt;
      function GetProperty(Index: TObjectProperty): Integer; override;
      procedure SetProperty(Index: TObjectProperty; Value: Integer); override;
    public
      constructor Create;
      function ValidProperties: TObjectProperties; override;
      function GetBounds: TRect; override;
      procedure SaveToStream(Stream: TBaseStream); override;
      procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); override;
    end;

  TShapeObject = class(TBaseLineObject)
    protected
      FFillColor : TColor;
      function GetProperty(Index: TObjectProperty): Integer; override;
      procedure SetProperty(Index: TObjectProperty; Value: Integer); override;
    public
      constructor Create;
      constructor CreateNew(PropertyObject: TBaseObject=nil); override;
      function ValidProperties: TObjectProperties; override;
      function Move(DX,DY: Integer; Handle: Integer; const Grid: TPoint; Shift: TShiftState): TPoint; override;
      procedure SaveToStream(Stream: TBaseStream); override;
      procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); override;
    end;

  TRectangleObject = class(TShapeObject)
    protected
      FCornerRadius : Integer;
      function GetProperty(Index: TObjectProperty): Integer; override;
      procedure SetProperty(Index: TObjectProperty; Value: Integer); override;
    public
      function CreateCopy: TBaseObject; override;
      procedure Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer); override;
      class function Identifier: Integer; override;
      function ValidProperties: TObjectProperties; override;
      procedure SaveToStream(Stream: TBaseStream); override;
      procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); override;
    end;

  TEllipseObject = class(TShapeObject)
    public
      function CreateCopy: TBaseObject; override;
      procedure Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer); override;
      function ValidProperties: TObjectProperties; override;
      class function Identifier: Integer; override;
    end;

function CleaupText(const Text: string): string;

implementation

uses StringUtils, LinarBitmap;

function CleaupText(const Text: string): string;
var
  I, P : Integer;
begin
  Result:=Text;
  I:=Pos('\',Result);
  if I>0 then
    repeat
      if Result[I]='\' then
        case Result[I+1] of
          '0'..'9' : if not (Result[I+2] in ['0'..'9']) then Delete(Result,I,2)
                     else if not (Result[I+3] in ['0'..'9']) then Delete(Result,I,3)
                     else Delete(Result,I,4);
          '"'      : begin
                       P:=I+2;
                       while not (Result[P] in [#0,'"']) do Inc(P);
                       Delete(Result,I,P-I+1);
                     end;
          '\'      : begin
                       Delete(Result,I,1);
                       Inc(I);
                     end;
          'A','N'  : Delete(Result,I,MaxInt);
          'C'      : Delete(Result,I,8);
          else Delete(Result,I,2);
        end
      else Inc(I);
    until I>Length(Result);
end;

//==============================================================================================================================
// TTextObject
//==============================================================================================================================
constructor TTextObject.CreateNew(const Text: string);
begin
  Create;
  FMargin:=DesignerDPpoint*2;
  SetTextAndName(Text);
end;

constructor TTextObject.CreateNew(PropertyObject: TBaseObject);
begin
  CreateNew('abc');
  if Assigned(PropertyObject) then Assign(PropertyObject);
  FEditTextAfterPlace:=True;
end;

function TTextObject.CreateCopy: TBaseObject;
begin
  Result:=TTextObject.Create;
  Result.Assign(Self);
end;

function TTextObject.EditTextAfterPlace: Boolean;
begin
  Result:=FEditTextAfterPlace;
  FEditTextAfterPlace:=False;
end;

function TTextObject.ValidProperties: TObjectProperties;
begin
  Result:=(inherited ValidProperties)+[opText,opPosition,opTextXAlign,opTextYAlign,opMargin,opTextColor];
end;

function TTextObject.GetProperty(Index: TObjectProperty): Integer;
begin
  case Index of
    opText            : Result:=Integer(@FText);
    opTextXAlign      : Result:=FTextXAlign;
    opTextYAlign      : Result:=FTextYAlign;
    opBlockAlignOnly  : Result:=0;
    opTextColor       : Result:=FTextColor;
    opPosition        : Result:=Integer(@FPosition);
    opMargin          : Result:=FMargin;
    else Result:=inherited GetProperty(Index);
  end;
end;

procedure TTextObject.SetProperty(Index: TObjectProperty; Value: Integer);
begin
  case Index of
    opText            : FText:=PString(Value)^;
    opTextXAlign      : FTextXAlign:=Value;
    opTextYAlign      : FTextYAlign:=Value;
    opTextColor       : FTextColor:=Value;
    opPosition        : begin
                          Position:=PRect(Value)^;
                          NotifyMovement;
                        end;
    opMargin          : FMargin:=Value;
    else inherited SetProperty(Index,Value);
  end;
end;

function TTextObject.Hint: string;
var
  P : Integer;
begin
  P:=Pos('\',FText);
  if P=0 then Exit;
  Inc(P);
  while P<Length(FText) do
  begin
    if FText[P] in ['A','N'] then
    begin
      Result:=Copy(FText,P+1,MaxInt);
      Break;
    end;
    while P<Length(FText) do
    begin
      Inc(P);
      if FText[P]='\' then Break;
    end;
    Inc(P);
  end;
end;

procedure TTextObject.SetTextAndName(const Text: string);

  function NameFromText(const Text: string): string;
  begin
    Result:=RemLeadSpace(CleaupText(Text));
    if Length(Result)>16 then SetLength(Result,16);
    Result:=RemTailSpace(Result);
    if Result='' then Result:=ExtractObjectName(ClassName);
  end;

begin
  if (Name='') or (Name=ExtractObjectName(ClassName)) or (Name=NameFromText(FText)) then
    Name:=NameFromText(Text);
  FText:=Text;
end;

procedure TTextObject.Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer);
var
  TextSize : TSize;
  X, Y : Integer;
  Str : string;
  LineWidths : array[0..255] of Integer;
  CanvasRect : TRect;

  procedure ParseText(DoDraw: Boolean);
  var
    P, I, PX, PY, Size, ScriptStartX, OverlineStartX, OverlineMaxY, LineHeight, LineY, Collect : Integer;
    Line : Byte;
    TextMetric : TTextMetric;

    procedure AlignLine;
    begin
      case FTextXAlign of
        -1 : X:=CanvasRect.Left+Round(FMargin*CanvasInfo.Scale.X);
         1 : X:=CanvasRect.Right-Round(FMargin*CanvasInfo.Scale.X)-LineWidths[Line];
         2 : X:=CanvasRect.Left+(CanvasRect.Right-CanvasRect.Left-LineWidths[Line]) div 2;
         3 : X:=CanvasRect.Right-(CanvasRect.Right-CanvasRect.Left-TextSize.CX) div 2-LineWidths[Line];
        else X:=CanvasRect.Left+(CanvasRect.Right-CanvasRect.Left-TextSize.CX) div 2;
      end;
    end;

    procedure Write(const Str: string);
    begin
      with Canvas do
      begin
        if DoDraw then TextOut(PX,PY,Str);
        Inc(PX,TextWidth(Str));
      end;
    end;

    procedure WriteSymbol(const Str: string);
    var
      PrevFont : string;
    begin
      with Canvas do
      begin
        PrevFont:=Font.Name;
        Font.Name:='Symbol';
        Write(Str);
        Font.Name:=PrevFont;
      end;
    end;

  begin
    Line:=0;
    with Canvas do
    begin
      Size:=CanvasInfo.DefaultFont.Size;
      Font:=CanvasInfo.DefaultFont;
      Font.Height:=-Round(Size*DesignerDPpoint*CanvasInfo.Scale.Y);
      if DoDraw then
      begin
        Font.Color:=FTextColor;
        //if CanvasInfo.DisableFontSmoothing then DisableFontSmoothing(Font);
        AlignLine;
        SetTextAlign(Handle,TA_BASELINE);
        GetTextMetrics(Handle,TextMetric);
      end;

      P:=Pos('\',FText);
      if P=0 then // Simple text
      begin
        TextSize:=TextExtent(FText);
        LineWidths[0]:=TextSize.CX;
        if DoDraw then TextOut(X,Y+TextMetric.tmAscent,FText);
      end
      else // Formated text
      begin
        ScriptStartX:=Low(Integer);
        OverlineStartX:=Low(Integer);
        OverlineMaxY:=0;
        PX:=X;
        PY:=Y+TextMetric.tmAscent;
        LineY:=PY;
        LineHeight:=TextHeight('A');
        TextSize.CY:=LineHeight;
        Collect:=P-1;
        repeat
          if FText[P]='\' then
          begin
            if Collect>0 then
            begin
              Write(Copy(FText,P-Collect,Collect));
              Collect:=0;
            end;
            Inc(P);
            case FText[P] of
              'A',
              'N' : P:=MaxInt-1; // Link or hint, skip rest of string
              'I' : Font.Style:=Font.Style+[fsItalic]; // Italic
              'i' : Font.Style:=Font.Style-[fsItalic];
              'B' : Font.Style:=Font.Style+[fsBold]; // Bold
              'b' : Font.Style:=Font.Style-[fsBold];
              'U' : Font.Style:=Font.Style+[fsUnderline]; // Underline
              'u' : Font.Style:=Font.Style-[fsUnderline];
              'L' : begin // Subscript
                      PY:=LineY+Round(Size*(DesignerDPpoint*0.18)*CanvasInfo.Scale.Y);
                      Font.Height:=-Round(Size*(DesignerDPpoint*0.6)*CanvasInfo.Scale.Y);
                      if ScriptStartX=Low(Integer) then ScriptStartX:=PX
                      else PX:=ScriptStartX;
                    end;
              'H' : begin // Superscript
                      PY:=LineY-Round(Size*(DesignerDPpoint*0.55)*CanvasInfo.Scale.Y);
                      Font.Height:=-Round(Size*(DesignerDPpoint*0.6)*CanvasInfo.Scale.Y);
                      if ScriptStartX=Low(Integer) then ScriptStartX:=PX
                      else PX:=ScriptStartX;
                      if OverlineStartX<>Low(Integer) then OverlineMaxY:=Min(OverlineMaxY,PY+Round(Font.Height*0.95));
                    end;
              'l',
              'h' : begin
                      PY:=LineY;
                      Font.Height:=-Round(Size*DesignerDPpoint*CanvasInfo.Scale.Y);
                      ScriptStartX:=Low(Integer);
                    end;
              'O' : if OverlineStartX=Low(Integer) then
                    begin
                      OverlineStartX:=PX;
                      OverlineMaxY:=PY+Round(Font.Height*0.95);
                      if DoDraw then
                      begin
                        Pen.Color:=Font.Color;
                        Pen.Style:=psSolid;
                        Pen.Width:=-Font.Height div 16;
                      end;
                    end;
              'o' : if OverlineStartX=Low(Integer) then Write('•')
                    else
                    begin
                      if DoDraw then
                      begin
                        MoveTo(OverlineStartX,OverlineMaxY);
                        LineTo(PX,OverlineMaxY);
                      end;
                      OverlineStartX:=Low(Integer);
                    end;
              'S' : Font.Name:='Symbol'; // Symbol font
              's' : Font.Name:=CanvasInfo.DefaultFont.Name;
              'n' : begin // New line
                      TextSize.CX:=Max(TextSize.CX,PX-X);
                      LineWidths[Line]:=PX-X;
                      Inc(Line);
                      if DoDraw then AlignLine;
                      PX:=X;
                      Inc(PY,LineHeight);
                      LineY:=PY;
                      Inc(TextSize.CY,LineHeight);   
                    end;
              'p' : begin // Page number
                      Str:=IntToStr(CanvasInfo.PageIndex+1);
                      Write(Str);
                    end;
              'c' : begin // Pages count
                      if CanvasInfo.Container=nil then Str:='?'
                      else Str:=IntToStr(CanvasInfo.Container.Count);
                      Write(Str);
                    end;
              'P' : with CanvasInfo do if Assigned(Container) then // Page name
                    begin
                      Str:=Container.Pages[PageIndex].GetName(PageIndex);
                      Write(Str);
                    end;
              '0'..
              '9' : begin // Font size
                      I:=P;
                      if FText[P+1] in ['0'..'9'] then // 2 digits
                      begin
                        Inc(P);
                        if FText[P+1] in ['0'..'9'] then Inc(P); // 3 digits
                      end;
                      Size:=StrToInt(Copy(FText,I,P-I+1));

                      Font.Height:=-Round(Size*DesignerDPpoint*CanvasInfo.Scale.Y);
                      if OverlineStartX<>Low(Integer) then OverlineMaxY:=Min(OverlineMaxY,PY+Round(Font.Height*0.95));
                      if PX=X then // Update line height if start of new line
                      begin
                        if DoDraw then
                        begin
                          I:=TextMetric.tmAscent;
                          GetTextMetrics(Handle,TextMetric);
                          I:=TextMetric.tmAscent-I;
                          Inc(PY,I);
                          Inc(LineY,I);
                        end;
                        Dec(TextSize.CY,LineHeight);
                        LineHeight:=TextHeight('A');
                        Inc(TextSize.CY,LineHeight);
                      end;
                    end;
              'C' : begin // Text color
                      Font.Color:=RGB2BGR(StrToIntDef('$'+Copy(FText,P+1,6),clBlack));
                      Inc(P,6);
                    end;
              '"' : begin // Font name
                      Inc(P);
                      I:=P;
                      while not (FText[P] in [#0,'"']) do Inc(P);
                      Font.Name:=Copy(FText,I,P-I);
                    end;

              '.' : Write('·');
              '#' : WriteSymbol('¨');
              '+' : Write('±');
              '*' : Write('×');
              '''': Write('°');
              '=' : WriteSymbol('¹');
              '~' : WriteSymbol('»');
              '>' : WriteSymbol('³');
              '<' : WriteSymbol('£');
              '/' : WriteSymbol('Ö');
              '-' : WriteSymbol('¸');

              else Write(FText[P]); // Write "\" in case of "\\"
            end
          end
          else Inc(Collect);
          Inc(P);
        until P>Length(FText);
        if Collect>0 then Write(Copy(FText,P-Collect,Collect));

        if (OverlineStartX<>Low(Integer)) and DoDraw then // If overline active
        begin
          MoveTo(OverlineStartX,OverlineMaxY);
          LineTo(PX,OverlineMaxY);
        end;

        LineWidths[Line]:=PX-X;
        TextSize.CX:=Max(TextSize.CX,PX-X);
      end;
    end;
  end;

begin
  inherited;
  if Ftext<>'' then
  begin
    CanvasRect:=CanvasInfo.CanvasRect(Position);
    Canvas.Brush.Style:=bsClear;
    // Align text
    TextSize.CX:=0;
    if (FTextXAlign<>-1) or (FTextYAlign<>-1) then ParseText(False);
    case FTextYAlign of
      -1 : Y:=CanvasRect.Top+Round(FMargin*CanvasInfo.Scale.Y);
       1 : Y:=CanvasRect.Bottom-Round(FMargin*CanvasInfo.Scale.Y)-TextSize.CY;
      else Y:=CanvasRect.Top+((CanvasRect.Bottom-CanvasRect.Top)-TextSize.CY) div 2;
    end;
    // Do actual drawing
    ParseText(True);
    // Determine bounding box
    case FTextXAlign of
      -1 : CurrentTextRect:=Bounds(X,Y,TextSize.CX+1,TextSize.CY+1);
       1 : CurrentTextRect:=Bounds(CanvasRect.Right-Round(FMargin*CanvasInfo.Scale.X)-TextSize.CX,Y,TextSize.CX+1,TextSize.CY+1);
      else CurrentTextRect:=Bounds(CanvasRect.Left+(CanvasRect.Right-CanvasRect.Left-TextSize.CX) div 2,Y,TextSize.CX+1,TextSize.CY+1);
    end;
    // Draw rectangle in Z-buffer
    if Assigned(CanvasInfo.ZBuffer) then with CanvasInfo.ZBuffer.Canvas do
    begin
      Brush.Color:=Index;
      FillRect(CurrentTextRect);
    end;
  end
  else if Assigned(CanvasInfo.ZBuffer) then
  begin
    with CanvasInfo.CanvasPoint(CenterPoint(Position)) do CanvasInfo.ZBuffer.Canvas.Pixels[X,Y]:=Index;
  end;
end;

class function TTextObject.Identifier: Integer;
begin
  Result:=otTextObject;
end;

procedure TTextObject.SaveToStream(Stream: TBaseStream);
begin
  inherited;
  SaveString(FText,Stream);
  Stream.Write(FTextXAlign,1);
  Stream.Write(FTextYAlign,1);
  Stream.Write(FTextColor,4);
  Stream.Write(FMargin,4);
end;

procedure TTextObject.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
var
  Align : ShortInt;
  I : Integer;
begin
  inherited;
  LoadString(FText,Stream);
  if FileVersion<8 then // Change \U to \H
  begin
    I:=1;
    while I<Length(FText) do
    begin
      if FText[I]='\' then
      begin
        Inc(I);
        case FText[I] of
          'U' : FText[I]:='H';
          'u' : FText[I]:='h';
        end;
      end;
      Inc(I);
    end;
  end;

  Stream.Read(Align,1); FTextXAlign:=Align;
  Stream.Read(Align,1); FTextYAlign:=Align;
  Stream.Read(FTextColor,4);
  if FileVersion>=11 then Stream.Read(FMargin,4)
  else FMargin:=DesignerDPpoint*2;
end;

//==============================================================================================================================
// TLineObject
//==============================================================================================================================
constructor TBaseLineObject.Create;
begin
  if Links=nil then
  begin
    SetLength(Links,2);
    Links[0]:=FloatPoint(0,0);
    Links[1]:=FloatPoint(1,1);
  end;
  inherited;
end;

function TBaseLineObject.ValidProperties: TObjectProperties;
begin
  Result:=(inherited ValidProperties)+[opLineWidth,opLineColor];
end;

function TBaseLineObject.GetBounds: TRect;
var
  HalfLineWidth : Integer;
begin
  if FLineColor=clNone then HalfLineWidth:=0
  else HalfLineWidth:=(FLineWidth+1) div 2;
  Result:=FPosition;
  Dec(Result.Left,HalfLineWidth);
  Dec(Result.Top,HalfLineWidth);
  Inc(Result.Right,HalfLineWidth);
  Inc(Result.Bottom,HalfLineWidth);
end;

function TBaseLineObject.GetProperty(Index: TObjectProperty): Integer;
begin
  case Index of
    opLineWidth : Result:=FLineWidth;
    opLineColor : Result:=FLineColor;
    else Result:=inherited GetProperty(Index);
  end;
end;

procedure TBaseLineObject.SetProperty(Index: TObjectProperty; Value: Integer);
begin
  case Index of
    opLineWidth  : FLineWidth:=Value;
    opLineColor  : FLineColor:=Value;
    else inherited SetProperty(Index,Value);
  end;
end;

procedure TBaseLineObject.SaveToStream(Stream: TBaseStream);
begin
  inherited;
  Stream.Write(FLineWidth,4);
  Stream.Write(FLineColor,4);
end;

procedure TBaseLineObject.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
begin
  inherited;
  Stream.Read(FLineWidth,4);
  Stream.Read(FLineColor,4);
end;

//==============================================================================================================================
// TShapeObject
//==============================================================================================================================
constructor TShapeObject.Create;
begin
  SetLength(Links,5);
  Links[0]:=FloatPoint(0.5,0.5);
  Links[1]:=FloatPoint(0,0.5);
  Links[2]:=FloatPoint(1,0.5);
  Links[3]:=FloatPoint(0.5,0);
  Links[4]:=FloatPoint(0.5,1);
  inherited;
end;

constructor TShapeObject.CreateNew(PropertyObject: TBaseObject);
begin
  Create;
  FFillColor:=clWhite;
  FLineWidth:=DefaultLineWidth;
  Name:=ExtractObjectName(ClassName);
  FMargin:=DesignerDPpoint*2;
  if Assigned(PropertyObject) then Assign(PropertyObject);
end;

function TShapeObject.ValidProperties: TObjectProperties;
begin
  Result:=(inherited ValidProperties)+[opFillColor,opTextXAlign,opTextYAlign];
end;

function TShapeObject.GetProperty(Index: TObjectProperty): Integer;
begin
  case Index of
    opFillColor : Result:=FFillColor;
    else Result:=inherited GetProperty(Index);
  end;
end;

procedure TShapeObject.SetProperty(Index: TObjectProperty; Value: Integer);
begin
  case Index of
    opFillColor  : FFillColor:=Value;
    else inherited SetProperty(Index,Value);
  end;
end;

function TShapeObject.Move(DX,DY,Handle: Integer; const Grid: TPoint; Shift: TShiftState): TPoint;

  function OffsetX(X: Integer): Integer;
  begin
    Result:=RoundInt(X+DX,Grid.X);
  end;

  function OffsetY(Y: Integer): Integer;
  begin
    Result:=RoundInt(Y+DY,Grid.Y);
  end;

begin
  //  1 5 2
  //  7 0 8
  //  3 6 4
  if (ssCtrl in Shift) and (Handle in [1..4]) then
  begin
    case Handle of
      1 : begin
            Result.X:=Min(OffsetX(FPosition.Left),FPosition.Right)-FPosition.Left;
            Inc(FPosition.Left,Result.X);
            Result.Y:=(FPosition.Bottom-Width)-FPosition.Top;
            Inc(FPosition.Top,Result.Y);
          end;
      2 : begin
            Result.X:=Max(OffsetX(FPosition.Right),FPosition.Left)-FPosition.Right;
            Inc(FPosition.Right,Result.X);
            Result.Y:=(FPosition.Bottom-Width)-FPosition.Top;
            Inc(FPosition.Top,Result.Y);
          end;
      3 : begin
            Result.X:=Min(OffsetX(FPosition.Left),FPosition.Right)-FPosition.Left;
            Inc(FPosition.Left,Result.X);
            Result.Y:=(FPosition.Top+Width)-FPosition.Bottom;
            Inc(FPosition.Bottom,Result.Y);
          end;
      4 : begin
            Result.X:=Max(OffsetX(FPosition.Right),FPosition.Left)-FPosition.Right;
            Inc(FPosition.Right,Result.X);
            Result.Y:=(FPosition.Top+Width)-FPosition.Bottom;
            Inc(FPosition.Bottom,Result.Y);
          end;
    end;
    NotifyMovement;
  end
  else Result:=inherited Move(DX,DY,Handle,Grid,Shift);
end;

procedure TShapeObject.SaveToStream(Stream: TBaseStream);
begin
  inherited;
  Stream.Write(FFillColor,4);
end;

procedure TShapeObject.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
begin
  inherited;
  Stream.Read(FFillColor,4);
end;

//==============================================================================================================================
// TRectangleObject
//==============================================================================================================================
function TRectangleObject.CreateCopy: TBaseObject;
begin
  Result:=TRectangleObject.Create;
  Result.Assign(Self);
end;

function TRectangleObject.ValidProperties: TObjectProperties;
begin
  Result:=(inherited ValidProperties)+[opCornerRadius];
end;

function TRectangleObject.GetProperty(Index: TObjectProperty): Integer;
begin
  case Index of
    opCornerRadius : Result:=FCornerRadius;
    else Result:=inherited GetProperty(Index);
  end;
end;

procedure TRectangleObject.SetProperty(Index: TObjectProperty; Value: Integer);
begin
  case Index of
    opCornerRadius : FCornerRadius:=Value;
    else inherited SetProperty(Index,Value);
  end;
end;

procedure TRectangleObject.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
begin
  inherited;
  if FileVersion>=15 then Stream.Read(FCornerRadius,4);
end;

procedure TRectangleObject.SaveToStream(Stream: TBaseStream);
begin
  inherited;
  Stream.Write(FCornerRadius,4);
end;

procedure TRectangleObject.Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer);
var
  DrawRect : TRect;
  Diameter : TPoint;
begin
  DrawRect:=CanvasInfo.CanvasRect1(Position);
  with Canvas do
  begin
    if FLineColor=clNone then Pen.Style:=psClear
    else
    begin
      Pen.Style:=psSolid;
      Pen.Color:=FLineColor;
      Pen.Width:=Round(FLineWidth*CanvasInfo.Scale.X);
    end;
    if FFillColor=clNone then Brush.Style:=bsClear
    else
    begin
      Brush.Style:=bsSolid;
      Brush.Color:=FFillColor;
    end;
    if FCornerRadius=0 then Rectangle(DrawRect)
    else
    begin
      Diameter:=RoundPoint(FCornerRadius*CanvasInfo.Scale.X*2,FCornerRadius*CanvasInfo.Scale.Y*2);
      RoundRect(DrawRect.Left,DrawRect.Top,DrawRect.Right,DrawRect.Bottom,Diameter.X,Diameter.Y);
    end;
  end;
  if Assigned(CanvasInfo.ZBuffer) then with CanvasInfo.ZBuffer.Canvas do
  begin
    if FLineColor=clNone then Pen.Width:=0
    else Pen.Width:=Max(Canvas.Pen.Width,3);
    Pen.Style:=psSolid;
    Pen.Color:=Index;
    if FFillColor=clNone then Brush.Style:=bsClear
    else
    begin
      Brush.Style:=bsSolid;
      Brush.Color:=Index;
    end;
    if FCornerRadius=0 then Rectangle(DrawRect)
    else RoundRect(DrawRect.Left,DrawRect.Top,DrawRect.Right,DrawRect.Bottom,Diameter.X,Diameter.Y);
  end;
  inherited;
end;

class function TRectangleObject.Identifier: Integer;
begin
  Result:=otRectangleObject;
end;

//==============================================================================================================================
// TEllipseObject
//==============================================================================================================================
function TEllipseObject.CreateCopy: TBaseObject;
begin
  Result:=TEllipseObject.Create;
  Result.Assign(Self);
end;

procedure TEllipseObject.Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer);
var
  DrawRect : TRect;
begin
  DrawRect:=CanvasInfo.CanvasRect1(Position);
  with Canvas do
  begin
    if FLineColor=clNone then Pen.Style:=psClear
    else
    begin
      Pen.Style:=psSolid;
      Pen.Color:=FLineColor;
      Pen.Width:=Round(FLineWidth*CanvasInfo.Scale.X);
    end;
    if FFillColor=clNone then Brush.Style:=bsClear
    else
    begin
      Brush.Style:=bsSolid;
      Brush.Color:=FFillColor;
    end;
    Ellipse(DrawRect);
  end;
  if Assigned(CanvasInfo.ZBuffer) then with CanvasInfo.ZBuffer.Canvas do
  begin
    if FLineColor=clNone then Pen.Width:=0
    else Pen.Width:=Max(Canvas.Pen.Width,3);
    Pen.Style:=psSolid;
    Pen.Color:=Index;
    if FFillColor=clNone then Brush.Style:=bsClear
    else
    begin
      Brush.Style:=bsSolid;
      Brush.Color:=Index;
    end;
    Ellipse(DrawRect);
  end;
  inherited;
end;

class function TEllipseObject.Identifier: Integer;
begin
  Result:=otEllipseObject;
end;

function TEllipseObject.ValidProperties: TObjectProperties;
begin
  Result:=(inherited ValidProperties)-[opTextYAlign,opMargin]+[opBlockAlignOnly];
end;

end.

