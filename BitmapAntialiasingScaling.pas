unit BitmapAntialiasingScaling;

interface

uses Windows, SysUtils, Graphics, FastBitmap;

procedure BitmapAntialiasingScaleHalf(SourceBitmap,DestBitmap: TFastBitmap);

implementation

uses LinarBitmap;

procedure BitmapAntialiasingScaleHalf(SourceBitmap,DestBitmap: TFastBitmap);
type
  TRGBPixArray = packed array[0..2] of Byte;
  PRGBPixArray = ^TRGBPixArray;

  function BlendPix(const LPix,RPix: TRGBPixArray): TRGBPixArray;
  begin
    // Average with R/B wights similar to Window's font antialiasing
    Result[0]:=(LPix[0]+RPix[0]*3+2) div 4;
    Result[1]:=(LPix[1]+RPix[1]+1) div 2;
    Result[2]:=(LPix[2]*3+RPix[2]+2) div 4;
  end;

var
  X, Y, L : Integer;
  SrcPix, DestPix : PRGBPixArray;
  Pix1, Pix2 : TRGBPixArray;
begin
  Assert(SourceBitmap.PixelFormat=pf24bit);
  Assert(DestBitmap.PixelFormat=pf24bit);
  Assert(DestBitmap.Width*2<=SourceBitmap.Width);
  Assert(DestBitmap.Height*2<=SourceBitmap.Height);
  L:=SourceBitmap.BytesPerLine;
  for Y:=0 to DestBitmap.Height-1 do
  begin
    SrcPix:=@SourceBitmap.ScanLine32[2*Y]^;
    DestPix:=@DestBitmap.ScanLine32[Y]^;
    for X:=1 to DestBitmap.Width do
    begin
      Pix1:=BlendPix(PRGBPixArray(Integer(SrcPix)+0)^,PRGBPixArray(Integer(SrcPix)+3)^);
      Pix2:=BlendPix(PRGBPixArray(Integer(SrcPix)+L)^,PRGBPixArray(Integer(SrcPix)+L+3)^);
      DestPix^[0]:=(Pix1[0]+Pix2[0]+1) div 2;
      DestPix^[1]:=(Pix1[1]+Pix2[1]+1) div 2;
      DestPix^[2]:=(Pix1[2]+Pix2[2]+1) div 2;
      Inc(SrcPix,2);
      Inc(DestPix);
    end;
  end;
end;

procedure BitmapAntialiasingScaleHalf2(SourceBitmap,DestBitmap: TFastBitmap);
type
  TRGBAPixArray = packed array[0..3] of Byte;
  PRGBAPixArray = ^TRGBAPixArray;
var
  X, Y, SrcP, DestP, L : Integer;
begin
  Assert(SourceBitmap.PixelFormat=pf24bit);
  Assert(DestBitmap.PixelFormat=pf24bit);
  Assert(DestBitmap.Width*2<=SourceBitmap.Width);
  Assert(DestBitmap.Height*2<=SourceBitmap.Height);
  L:=SourceBitmap.BytesPerLine;
  for Y:=1 to DestBitmap.Height-2 do
  begin
    SrcP:=Y*L*2+3;
    DestP:=Y*DestBitmap.BytesPerLine+3;

    for X:=1 to (DestBitmap.Width-2)*3 do
    begin
      if (SourceBitmap.Map^[SrcP-3]=SourceBitmap.Map^[SrcP]) and (SourceBitmap.Map^[SrcP]=SourceBitmap.Map^[SrcP+3]) and
         (SourceBitmap.Map^[L+SrcP-3]=SourceBitmap.Map^[L+SrcP]) and (SourceBitmap.Map^[L+SrcP]=SourceBitmap.Map^[L+SrcP+3]) then
      begin
        // Horizontal edge
        // 111
        // 222
        // 111
        if Abs(SourceBitmap.Map^[SrcP]-SourceBitmap.Map^[SrcP-L]-SourceBitmap.Map^[SrcP+L])>
           Abs(SourceBitmap.Map^[L+SrcP]-SourceBitmap.Map^[L+SrcP-L]-SourceBitmap.Map^[L+SrcP+L]) then
          DestBitmap.Map^[DestP]:=SourceBitmap.Map^[SrcP]
        else
          DestBitmap.Map^[DestP]:=SourceBitmap.Map^[L+SrcP];
      end
      {else if (SourceBitmap.Map^[SrcP-L]=SourceBitmap.Map^[SrcP]) and (SourceBitmap.Map^[SrcP]=SourceBitmap.Map^[SrcP+L]) and
              (SourceBitmap.Map^[3+SrcP-L]=SourceBitmap.Map^[3+SrcP]) and (SourceBitmap.Map^[3+SrcP]=SourceBitmap.Map^[3+SrcP+L]) then
      begin
        // Vertical edge
        // 121
        // 121
        // 121
        if Abs(SourceBitmap.Map^[SrcP]-SourceBitmap.Map^[SrcP-3]-SourceBitmap.Map^[SrcP+3])>
           Abs(SourceBitmap.Map^[3+SrcP]-SourceBitmap.Map^[3+SrcP-3]-SourceBitmap.Map^[3+SrcP+3]) then
          DestBitmap.Map^[DestP]:=SourceBitmap.Map^[SrcP]
        else
          DestBitmap.Map^[DestP]:=SourceBitmap.Map^[3+SrcP];
      end}
      else DestBitmap.Map^[DestP]:=(SourceBitmap.Map^[SrcP]+
                                    SourceBitmap.Map^[SrcP+3]+
                                    SourceBitmap.Map^[SrcP+L]+
                                    SourceBitmap.Map^[SrcP+L+3]+
                                    2) div 4;
      if X mod 3=0 then Inc(SrcP,3);
      Inc(SrcP);
      Inc(DestP);
    end;
  end;
end;

end.
