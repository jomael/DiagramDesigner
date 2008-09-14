////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// FastBitmap.pas - TBitmap descendant with fast access to bitmap memory
// ---------------------------------------------------------------------
// Changed:   2002-09-24
// Auther:  Michael Vinther
//
// Last change:
//
unit FastBitmap;

interface

uses SysUtils, Windows, Monitor, Graphics, MemUtils, Math, MathUtils, Types, LinarBitmap;

type
  TFastBitmap = class(TBitmap)
    private
      FWidth, FHeight : Integer;
      function GetScanLine24(Y: Integer): PRGBRec;
      function GetScanLine32(Y: Integer): PIntegerArray;
    public
      BytesPerLine : Integer;
      Map : PByteArray;
      Map32 : PIntegerArray;
      property Width: Integer read FWidth;
      property Height: Integer read FHeight;
      property ScanLine24[Y: Integer]: PRGBRec read GetScanLine24;
      property ScanLine32[Y: Integer]: PIntegerArray read GetScanLine32; // Note: 0 is bottom line
      procedure UpdateMap;
      procedure Clear; overload;
      procedure Clear(Color: TColor); overload;
      // pfCustom means no change
      procedure New(X,Y: Integer; PixFormat: TPixelFormat=pfCustom);

      procedure Smooth(WindowSize: Integer);
    end;

// Merge Image and Alpha to 32 bit bitmap with alpha channel
function CreatePremultipliedAlphaBitmap(Image,Alpha: TLinearBitmap): TFastBitmap;
// Draw bitmap to canvas with alpha blending using alpha channel
procedure AlphaBlendDrawPremultipliedAlpha(Bitmap: TBitmap; Dest: TCanvas; const DestRect: TRect; AlphaValue: Byte=255);
// Draw bitmap to canvas with alpha blending using fixed alpha value
procedure AlphaBlendDraw(Source: TBitmap; Dest: TCanvas; const DestRect: TRect; AlphaValue: Byte);
// Draw bitmap to canvas stretching with halftoning
procedure HalftoneStretchDraw(Source: TBitmap; Dest: TCanvas; const DestRect: TRect);

implementation

// Merge Image and Alpha to 32 bit bitmap with premultiplied alpha channel
function CreatePremultipliedAlphaBitmap(Image,Alpha: TLinearBitmap): TFastBitmap;
var
  X, Y : Integer;
  SrcPix : PByte;
  DestPix : ^TRGBQuad;
begin
  Assert(Alpha.PixelFormat=pf8bit);
  Assert(Alpha.Width=Image.Width);
  Assert(Alpha.Height=Image.Height);
  Result:=TFastBitmap.Create;
  Image.AssignTo(Result);
  Result.PixelFormat:=pf32bit;
  Result.UpdateMap;
  for Y:=0 to Alpha.Height-1 do
  begin
    SrcPix:=Alpha.ScanLine[Y];
    DestPix:=@Result.ScanLine32[Alpha.Height-1-Y]^;
    for X:=1 to Alpha.Width do
    begin
      DestPix^.rgbBlue:=Round(DestPix^.rgbBlue*SrcPix^/255);
      DestPix^.rgbGreen:=Round(DestPix^.rgbGreen*SrcPix^/255);
      DestPix^.rgbRed:=Round(DestPix^.rgbRed*SrcPix^/255);
      DestPix^.rgbReserved:=SrcPix^;
      Inc(SrcPix);
      Inc(DestPix);
    end;
  end;
end;

// Draw bitmap to canvas with alpha blending using fixed alpha value
procedure AlphaBlendDraw(Source: TBitmap; Dest: TCanvas; const DestRect: TRect; AlphaValue: Byte);
var
  Blend : TBlendFunction;
begin
  Blend.BlendOp:=AC_SRC_OVER;
  Blend.BlendFlags:=0;
  Blend.SourceConstantAlpha:=AlphaValue;
  Blend.AlphaFormat:=0;
  Windows.AlphaBlend(Dest.Handle,DestRect.Left,DestRect.Top,DestRect.Right-DestRect.Left,DestRect.Bottom-DestRect.Top,
                     Source.Canvas.Handle,0,0,Source.Width,Source.Height,
                     Blend);
end;

// Draw bitmap to canvas with alpha blending using alpha channel
procedure AlphaBlendDrawPremultipliedAlpha(Bitmap: TBitmap; Dest: TCanvas; const DestRect: TRect; AlphaValue: Byte);
var
  Blend : TBlendFunction;
begin
  Blend.BlendOp:=AC_SRC_OVER;
  Blend.BlendFlags:=0;
  Blend.SourceConstantAlpha:=AlphaValue;
  Blend.AlphaFormat:=AC_SRC_ALPHA;
  Windows.AlphaBlend(Dest.Handle,DestRect.Left,DestRect.Top,DestRect.Right-DestRect.Left,DestRect.Bottom-DestRect.Top,
                     Bitmap.Canvas.Handle,0,0,Bitmap.Width,Bitmap.Height,
                     Blend);
end;

// Draw bitmap to canvas stretching with halftoning
procedure HalftoneStretchDraw(Source: TBitmap; Dest: TCanvas; const DestRect: TRect);
begin
  SetStretchBltMode(Dest.Handle,STRETCH_HALFTONE);
  StretchBlt(Dest.Handle,DestRect.Left,DestRect.Top,DestRect.Right-DestRect.Left,DestRect.Bottom-DestRect.Top,
             Source.Canvas.Handle,0,0,Source.Width,Source.Height,cmSrcCopy);
end;

//==============================================================================================================================
// TFastBitmap
//==============================================================================================================================
procedure TFastBitmap.UpdateMap;
var
  MapA, MapB : DWord;
begin
  FWidth:=inherited Width;
  FHeight:=inherited Height;
  case PixelFormat of
    pf8bit  : BytesPerLine:=Ceil4(Width);
    pf24bit : BytesPerLine:=Ceil4(Width*3);
    pf32bit : BytesPerLine:=Width*4;
  else raise Exception.Create('Unsupported pixel format');
  end;
  MapA:=DWord(ScanLine[0]);
  MapB:=DWord(ScanLine[Height-1]);
  if MapA<MapB then Map:=Pointer(MapA)
  else Map:=Pointer(MapB);
  Map32:=Pointer(Map);
end;

procedure TFastBitmap.New(X,Y: Integer; PixFormat: TPixelFormat=pfCustom);
begin
  if PixFormat<>pfCustom then PixelFormat:=PixFormat;
  inherited Width:=X;
  inherited Height:=Y;
  UpdateMap;
end;

procedure TFastBitmap.Clear;
var
  Y : Integer;
begin
  for Y:=0 to Height-1 do ZeroMem(Pointer(Integer(Map)+Y*BytesPerLine)^,Width*4);
end;

procedure TFastBitmap.Clear(Color: TColor);
begin
  if Color=0 then Clear
  else with Canvas do
  begin
    Brush.Color:=Color;
    FillRect(Rect(0,0,Width,Height));
  end;
end;

function TFastBitmap.GetScanLine32(Y: Integer): PIntegerArray;
begin
  Result:=PIntegerArray(Integer(Map)+Y*BytesPerLine);
end;

function TFastBitmap.GetScanLine24(Y: Integer): PRGBRec;          
begin
  Assert((Y>=0) and (Y<Height));
  Result:=PRGBRec(Integer(Map)+(Height-1-Y)*BytesPerLine);
end;

procedure TFastBitmap.Smooth(WindowSize: Integer);
var
  NewMap : PIntegerArray;
  X, Y, DX, DY, DMax, DMin, XA, XB, YA, YB, P : Integer;
  CenterPix, ScanPix : PByte;
  Sum : Integer;
  Scale : Double;
begin
  Assert(PixelFormat=pf32bit);

  DMin:=-WindowSize div 2;
  DMax:=WindowSize+DMin-1;
  Scale:=1/Sqr(WindowSize);
  GetMem(NewMap,BytesPerLine*Height);
  for P:=0 to 2 do
  begin
    for Y:=1 to Height-2 do
    begin
      CenterPix:=Pointer(Integer(NewMap)+Y*BytesPerLine+4+P);
      YA:=Y+DMin;
      YB:=Y+DMax; if YB>=Height then YB:=Height-1;
      for X:=1 to Width-2 do
      begin
        Sum:=0;
        XA:=X+DMin;
        XB:=X+DMax;
        for DY:=YA to YB do
        begin
          ScanPix:=@Map^[DY*BytesPerLine+XA*4+P];
          for DX:=XA to XB do
          begin
            Sum:=Sum+ScanPix^;
            Inc(ScanPix,4);
          end;
        end;
        CenterPix^:=Round(Sum*Scale);
        Inc(CenterPix,4);
      end;
    end;
  end;
  Move(NewMap^,Map^,BytesPerLine*Height);
  FreeMem(NewMap);
end;

end.

