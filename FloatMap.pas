////////////////////////////////////////////////////////////////////////////////
//
// FloatMap.pas - Floating point and complex number bitmap classes
// ---------------------------------------------------------------
// Version:   2004-04-10
// Maintain:  Michael Vinther    |    mv@logicnet·dk
//
// Last changes:
//
unit FloatMap;

interface

{DEFINE FloatMapFileSupport}

uses Windows, SysUtils, Graphics, StreamUtils, Complex, LinarBitmap,
  MemUtils, Fourier, Math, DiscreteCosine, MathUtils, Consts, Types,
  SysConst, PerformanceTimer, MultiCoreProcessing, Streams;

{$IFDEF EnableInlining}
{$INLINE AUTO}
{$ENDIF}

resourcestring
{$IFDEF FloatMapFileSupport}
  rsMapLoadFilter = 'Map/matrix (*.map,*.mat,*.txt,*.csv)|*.map;*.mat;*.txt;*.csv|';
  rsMapSaveFilter = 'Analyzer map (*.map)|*.map|Text file (*.txt)|*.txt|';
{$ELSE}
  rsMapLoadFilter = '';
  rsMapSaveFilter = '';
{$ENDIF}

type
  TBaseFloatMap = class(TStreamClass)
    protected
      FByteSize : Integer;
      FWidth, FHeight : Integer;
      FBytesPerLine : Integer;
      FSize : LongInt; // Number of pixels
    public
      StreamFormat : (smMAP,smMatlab,smText);
      property Width: Integer read fWidth;
      property Height: Integer read fHeight;
      property BytesPerLine: Integer read fBytesPerLine;
      property ByteSize: Integer read FByteSize;
      // Number of elements
      property Size: Integer read fSize;

      constructor Create(Other: TObject); overload;
      destructor Destroy; override;
      procedure Dispose; virtual; abstract;

      {$IFDEF FloatMapFileSupport}
      class function IsMapFile(const FileName: string): Boolean;
      procedure SaveToFile(const FileName: string); override;
      procedure LoadFromFile(const FileName: string); override;
      procedure GetFromClipboard;
      procedure CopyToClipboard;
      {$ENDIF}
   end;

  TMappingMethod = (mmLinear,mmSqrt,mm16bitLinear,mmLog);

  TComplexMap = class;

  TComplexRepresentation = (crRealPart,crImaginaryPart,crAmplitude,crPhase);

  TFloatMap = class(TBaseFloatMap)
    protected
      function GetScanLine(Y: Integer): Pointer; {$IFDEF EnableInlining} inline; {$ENDIF}
      function GetPixel(X,Y: Integer): PFloat; {$IFDEF EnableInlining} inline; {$ENDIF}

      procedure DFTVertical(Inverse: Boolean=False);
    public
      Map : PFloatArray;

      property ScanLine[Y: Integer]: Pointer read GetScanLine;
      property Pixel[X,Y: Integer]: PFloat read GetPixel; default;
      // Get element value or extrapolate by repeating edge pixels if X,Y is outside
      function Extrapolate(X,Y: Integer): Float; 

      constructor Create(X,Y: Integer); overload;

      // Create new image
      procedure New(X,Y: Integer);
      procedure TakeOver(Other: TFloatMap);
      procedure Assign(Other: TObject); override;
      procedure AssignTo(Other: TObject); override;
      procedure ResizeCanvas(XSiz,YSiz: Integer; XPos: Integer=0; YPos: Integer=0; Background: Float=0);
      procedure Paste(Source: TFloatMap; X,Y: Integer);

      // Release image memory
      procedure Dispose; override;
      procedure DeleteLine(Y: Integer);

      // Clear map
      procedure Clear(Value: Float); overload;
      procedure Clear; overload;

      procedure GetStat(out Min,Max: Float);

      // Transformation
      procedure FourierTransform(Image: TLinarBitmap; Representation: TComplexRepresentation = crAmplitude);
      procedure DiscreteCosineTransform(Image: TLinarBitmap); overload;
      procedure DiscreteCosineTransform(Inverse: Boolean=False); overload;

      procedure GetComplexRepresentation(ComplexMap: TComplexMap; Representation: TComplexRepresentation);

      // Convert to TLinearBitmap
      procedure MakeBitmap(Image: TLinearBitmap; Method: TMappingMethod=mmLinear; const Min: Float=1.0e10; const Max: Float=-1.0e10);

      {$IFDEF FloatMapFileSupport}
      procedure SaveToStream(Stream: TBaseStream); override;
      procedure LoadFromStream(Stream: TBaseStream); override;
      {$ENDIF}
    end;

  TComplexMap = class(TBaseFloatMap)
    protected
      procedure FFTVertical(const Domain: Double; ZeroShift: Boolean);
      procedure FFTVerticalThreadProc(Thread: TSimpleThread; Data: Pointer);

      function GetScanLine(Y: Integer): Pointer;
      function GetPixel(X,Y: Integer): PComplex;
    public
      Map : PComplexArray;

      property ScanLine[Y: Integer]: Pointer read GetScanLine;
      property Pixel[X,Y: Integer]: PComplex read GetPixel; default;

      constructor Create(X,Y: Integer); overload;
      procedure Assign(Other: TObject); override;

      // Create new image
      procedure New(X,Y: Integer);

      // Release image memory
      procedure Dispose; override;

      // Clear map
      procedure Clear(Value: TComplex); overload;
      procedure Clear; overload;

      procedure Multiply(R: Double);

      // Return true if imaginary past is zero for all elements
      function IsReal: Boolean;

      // Resize map and preserve contents
      procedure ResizeCanvas(XSiz,YSiz: Integer; XPos: Integer=0; YPos: Integer=0);

      // Transformation
      procedure FourierTransform(Image: TLinarBitmap; ZeroShift: Boolean = True); overload;
      procedure FourierTransform(Domain: Double = FFT; ZeroShift: Boolean = True); overload;
      procedure DistanceTransform(Image: TLinarBitmap; SearchValue: Byte=0);

      // Calculate mean (Re) and standard deviation (Im) of Image and store result in Map
      procedure ImageStat(Image: TLinarBitmap; WindowSize: Integer); overload;
      procedure ImageStat(Image,Mask: TLinarBitmap; WindowSize: Integer); overload;

      procedure MakeBitmap(Image: TLinarBitmap; Representation: TComplexRepresentation; Method: TMappingMethod=mmLinear; const Min: Float = 1.0e10; const Max: Float = -1.0e10);
      procedure GetFromBitmaps(Real: TLinarBitmap; Imag: TLinarBitmap; Offset: Integer=0);

      {$IFDEF FloatMapFileSupport}
      procedure LoadFromStream(Stream: TBaseStream); override;
      procedure SaveToStream(Stream: TBaseStream); override;
      {$ENDIF}
    end;
      
var
  cfImageAnalyzerMap : Word = 0;

implementation

{$IFDEF FloatMapFileSupport}
uses FileUtils, CompLZ77, MatlabLoader, Deflate, TextStrm, MemStream, Clipbrd;
                       
resourcestring
  rsUnsupportedFileFormatForComplexData = 'Unsupported file format for complex data';
  rsInvalidTextFormat = 'Invalid text format';
  rsTheNumberOfElementsInLineDIsDifferentFromThatInTheFirstLine = 'The number of elements in line %d is different from that in the first line';
  rsInvalidNumberFormatS = 'Invalid number format: %s';

type
  TMapHeader = packed record
                 MAP           : array[1..3] of Char;      // 'MAP'
                 Version       : DWord;                    // 1
                 PixelFormat   : DWord;                    // Int: $01, $02 Float: $40, $80
                 Width, Height : DWord;
                 Planes        : Byte;
                 Compression   : Byte;                     // 0=None, 1=Deflate, 2=LZ77
               end;

{$ENDIF}

//==============================================================================================================================
// TBaseFloatMap
//==============================================================================================================================

constructor TBaseFloatMap.Create(Other: TObject);
begin
  Create;
  Assign(Other);
end;

destructor TBaseFloatMap.Destroy;
begin
  Dispose;
  inherited Destroy;
end;

{$IFDEF FloatMapFileSupport}
procedure TBaseFloatMap.SaveToFile(const FileName: string);
var
  Ext : string;
begin
  Ext:=ExtractFileExtNoDotUpper(FileName);
  if Ext='MAT' then StreamFormat:=smMatlab
  else if Ext='MAP' then StreamFormat:=smMAP
  else if Ext='TXT' then StreamFormat:=smText
  else raise Exception.Create(rsUnsupportedFileFormat);
  inherited;
end;

procedure TBaseFloatMap.LoadFromFile(const FileName: string);
var
  Ext : string;
begin
  Ext:=ExtractFileExtNoDotUpper(FileName);
  if Ext='MAT' then StreamFormat:=smMatlab
  else if Ext='MAP' then StreamFormat:=smMAP
  else StreamFormat:=smText;
  inherited;
end;

class function TBaseFloatMap.IsMapFile(const FileName: string): Boolean;
begin
  Result:=Pos('*'+UpperCase(ExtractFileExt(FileName)),UpperCase(rsMapLoadFilter))>0;
end;

procedure TBaseFloatMap.GetFromClipboard;
var
  MemStream : TMemBlockStream;
  ClipData : THandle;
  ClipDataP : Pointer;
begin
  Assert(cfImageAnalyzerMap<>0,'Clipboard format not registered');
  if OpenClipboard(0) then
  try
    ClipData:=GetClipboardData(cfImageAnalyzerMap);
    if ClipData=0 then RaiseLastWin32Error;

    ClipDataP:=GlobalLock(ClipData);
    try
      MemStream:=TMemBlockStream.Create(ClipDataP);
      try
        MemStream.CanWrite:=False;
        StreamFormat:=smMAP;
        LoadFromStream(MemStream);
      finally
        MemStream.Free;
      end;
    finally
      GlobalUnLock(ClipData);
    end;
  finally
    CloseClipboard;
  end
  else RaiseLastWin32Error;
end;

procedure TBaseFloatMap.CopyToClipboard;
var
  MemStream : TMemStream;
  ClipData : THandle;
  ClipDataP : Pointer;
begin
  Assert(cfImageAnalyzerMap<>0,'Clipboard format not registered');
  MemStream:=TMemStream.Create;
  try
    StreamFormat:=smMAP;
    SaveToStream(MemStream);
    ClipData:=GlobalAlloc(GMEM_DDESHARE or GMEM_MOVEABLE,MemStream.Size);
    ClipDataP:=GlobalLock(ClipData);
    try
      MemStream.Position:=0;
      MemStream.Read(ClipDataP^,MemStream.Size);
    finally
      GlobalUnLock(ClipData);
    end;
    Clipboard.SetAsHandle(cfImageAnalyzerMap,ClipData);
  finally
    MemStream.Free;
  end;
end;

{$ENDIF}

//==================================================================================================
// TFloatMap
//==================================================================================================

constructor TFloatMap.Create(X,Y: Integer);
begin
  Create;
  New(X,Y);
end;

function TFloatMap.GetScanLine(Y: Integer): Pointer;
begin
  Assert((Y>=0) and (Y<Height));
  Result:=@Map^[Y*Width];
end;

function TFloatMap.GetPixel(X,Y: Integer): PFloat;
begin
  Result:=@Map^[Y*Width+X];
end;

function TFloatMap.Extrapolate(X,Y: Integer): Float;
begin
  if Y<=0 then
  begin
    if X<=0 then Result:=Map^[0]
    else if X<Width then Result:=Map^[X]
    else Result:=Map^[Width-1];
  end
  else if Y<Height then
  begin
    if X<=0 then Result:=Map^[Y*Width]
    else if X<Width then Result:=Map^[Y*Width+X]
    else Result:=Map^[(Y+1)*Width-1];
  end
  else // Y>=Height
  begin
    if X<=0 then Result:=Map^[Size-Width+1]
    else if X<Width then Result:=Map^[Size-Width+1+X]
    else Result:=Map^[Size-1];
  end;
  Assert(not IsNan(Result),Format('NaN at %d,%d',[X,Y]));
end;

// Create new map
procedure TFloatMap.New(X,Y: Integer);
begin
  if (X=Width) and (Y=Height) then Exit;
  if Assigned(Map) then FreeMem(Map);
  if Int64(X)*Int64(Y)*SizeOf(Float)>2000000000 then raise EOutOfMemory.Create(SOutOfMemory);
  FSize:=X*Y;
  FWidth:=X;
  FHeight:=Y;
  FBytesPerLine:=Width*SizeOf(Float);
  FByteSize:=Size*SizeOf(Float);
  GetMem(Map,FByteSize);
end;

procedure TFloatMap.TakeOver(Other: TFloatMap);
begin
  FreeAndNilData(Map);
  Map:=Other.Map;
  Other.Map:=nil;
  FWidth:=Other.Width;
  FHeight:=Other.Height;
  FSize:=Other.Size;
  FBytesPerLine:=Other.BytesPerLine;
  FByteSize:=Other.ByteSize;
  Other.Dispose;
end;

procedure TFloatMap.Assign(Other: TObject);
var
  I : Integer;
  Pix : PByte;
begin
  if Other is TFloatMap then
  begin
    New(TFloatMap(Other).Width,TFloatMap(Other).Height);
    Move(TFloatMap(Other).Map^,Map^,ByteSize);
  end
  else if Other is TLinearBitmap then
  begin
    Assert(TLinearBitmap(Other).PixelFormat=pf8bit);
    New(TLinearBitmap(Other).Width,TLinearBitmap(Other).Height);
    Pix:=@TLinearBitmap(Other).Map^;
    for I:=0 to Size-1 do
    begin
      Map^[I]:=Pix^;
      Inc(Pix);
    end;
  end
  else if Other is TComplexMap then GetComplexRepresentation(TComplexMap(Other),crRealPart)
  else inherited;
end;

procedure TFloatMap.AssignTo(Other: TObject);
var
  I, V : Integer;
  Pix : PByte;
begin
  if Other is TLinearBitmap then
  begin
    TLinearBitmap(Other).New(Width,Height,pf8bit);
    Pix:=@TLinearBitmap(Other).Map^;
    for I:=0 to Size-1 do
    begin
      V:=Round(Map^[I]);
      if V>=255 then Pix^:=255
      else if V<=0 then Pix^:=0
      else Pix^:=V;
      Inc(Pix);
    end;
  end
  else inherited;
end;

// Release image map
procedure TFloatMap.Dispose;
begin
  FreeAndNilData(Map);
  fWidth:=0;
  fHeight:=0;
  fSize:=0;
end;

procedure TFloatMap.Clear(Value: Float);
var P : Integer;
begin
  for P:=0 to Size-1 do Map^[P]:=Value;
end;

procedure TFloatMap.Clear;
begin
  ZeroMem(Map^,ByteSize);
end;

procedure TFloatMap.DeleteLine(Y: Integer);
begin
  Move(Map^[(Y+1)*Width],Map^[Y*Width],(Height-Y-1)*BytesPerLine);
  Dec(FHeight);
  Dec(fSize,Width);
  Dec(fByteSize,BytesPerLine);
end;

procedure TFloatMap.GetStat(out Min,Max: Float);
var
  I : Integer;
  P : PFloat;
begin
  Min:=MaxFloat;
  Max:=-MaxFloat;
  P:=@Map^;
  for I:=1 to Size do
  begin
    if P^>Max then Max:=P^;
    if P^<Min then Min:=P^;
    Inc(P);
  end;
end;

procedure TFloatMap.FourierTransform(Image: TLinarBitmap; Representation: TComplexRepresentation);
var ComplexMap : TComplexMap;
begin
  ComplexMap:=TComplexMap.Create;
  try
    ComplexMap.FourierTransform(Image);
    GetComplexRepresentation(ComplexMap,Representation);
  finally
    ComplexMap.Free;
  end;
end;

procedure TFloatMap.GetComplexRepresentation(ComplexMap: TComplexMap; Representation: TComplexRepresentation);
var P : Integer;
begin
  New(ComplexMap.Width,ComplexMap.Height);
  case Representation of
    crAmplitude     : for P:=0 to Size-1 do Map^[P]:=ComplexMap.Map^[P].Modulus;
    crPhase         : for P:=0 to Size-1 do Map^[P]:=ComplexMap.Map^[P].Angle;
    crRealPart      : for P:=0 to Size-1 do Map^[P]:=ComplexMap.Map^[P].Re;
    crImaginaryPart : for P:=0 to Size-1 do Map^[P]:=ComplexMap.Map^[P].Im;
  end;
end;

procedure TFloatMap.MakeBitmap(Image: TLinearBitmap; Method: TMappingMethod; const Min, Max: Float);
var
  MinValue, MaxValue, Divisor : Float;
  P : Integer;
  A : Float;
  Value : PFloat;
  Pix : PByte;
  Pix16 : PWord absolute Pix;
begin
  if Method=mm16bitLinear then Image.New(Width,Height,pf16bit)
  else
  begin
    Image.New(Width,Height,pf8bit);
    Image.Palette^:=GrayPal;
  end;
  if Min>Max then GetStat(MinValue,MaxValue)
  else
  begin
    MinValue:=Min;
    MaxValue:=Max;
  end;
  if IsInfinite(MaxValue) then
  begin
    Image.Clear(0);
    Exit;
  end;
  
  if Abs(MaxValue-MinValue)<0.00000001 then MinValue:=MaxValue-1;
  Divisor:=MaxValue-MinValue;

  Pix:=Pointer(Image.Map);
  Value:=Pointer(Map);
  if Image.PixelFormat=pf8bit then
    for P:=1 to Size do
    begin
      A:=(Value^-MinValue)/Divisor;
      case Method of
        mmLinear : A:=A*255;
        mmSqrt   : if A>0 then A:=Sqrt(A)*255 else A:=0;
      end;
      if A>255 then A:=255
      else if A<0 then A:=0;
      Pix^:=Round(A);
      Inc(Value);
      Inc(Pix);
    end
  else // 16 bit
    for P:=1 to Size do
    begin
      A:=$ffff*(Value^-MinValue)/Divisor;
      if A>$ffff then A:=$ffff
      else if A<0 then A:=0;
      Pix16^:=Round(A);
      Inc(Value);
      Inc(Pix16);
    end
end;

procedure TFloatMap.DFTVertical(Inverse: Boolean);
var
  NewMap, SourceLine, DestLine : PFloatArray;
  X, Y : Integer;
  SourcePix, DestPix : PFloat;
begin
  GetMem(NewMap,Size*SizeOf(Float));
  GetMem(SourceLine,Height*SizeOf(Float));
  GetMem(DestLine,Height*SizeOf(Float));
  try
    for X:=0 to Width-1 do
    begin
      SourcePix:=@Map^[X];
      DestPix:=@SourceLine^[0];
      for Y:=1 to Height do
      begin
        DestPix^:=SourcePix^;
        Inc(SourcePix,Width);
        Inc(DestPix);
      end;
      if Inverse then PerformIDCT(SourceLine^,DestLine^,Height)
      else PerformDCT(SourceLine^,DestLine^,Height);
      SourcePix:=@DestLine^[0];
      DestPix:=@NewMap^[X];
      for Y:=1 to Height do
      begin
        DestPix^:=SourcePix^;
        Inc(SourcePix);
        Inc(DestPix,Width);
      end;
      if Assigned(ProgressUpdate) then ProgressUpdate(50+X*50 div (Width-1));
    end;
  finally
    FreeMem(DestLine);
    FreeMem(SourceLine);
  end;
  FreeMem(Map);
  Map:=NewMap;
end;

procedure TFloatMap.DiscreteCosineTransform(Image: TLinarBitmap);
var
  Y : Integer;
begin
  New(Image.Width,Image.Height);
  for Y:=0 to Height-1 do
  begin
    PerformDCT(TByteArray(Image.ScanLine[Y]^),TFloatArray(ScanLine[Y]^),Width);
    if Assigned(ProgressUpdate) then ProgressUpdate(Y*50 div (Height-1));
  end;
  DFTVertical;
end;

procedure TFloatMap.DiscreteCosineTransform(Inverse: Boolean);
var
  Y : Integer;
  Line : PFloatArray;
begin
  GetMem(Line,Width*SizeOf(Float));
  try
    for Y:=0 to Height-1 do
    begin
      Move(ScanLine[Y]^,Line^,Width*SizeOf(Float));
      if Inverse then PerformIDCT(Line^,TFloatArray(ScanLine[Y]^),Width)
      else PerformDCT(Line^,TFloatArray(ScanLine[Y]^),Width);
      if Assigned(ProgressUpdate) then ProgressUpdate(Y*50 div (Height-1));
    end;
  finally
    FreeMem(Line);
  end;
  DFTVertical(Inverse);
end;

{$IFDEF FloatMapFileSupport}
var TextFileEOL : array[1..2] of Char = #13#10;
procedure TFloatMap.SaveToStream(Stream: TBaseStream);
var
  Header : TMapHeader;
  Pix : PFloat;
  I, Y : Integer;
  MapStream : TBaseStream;
  Element : string;
begin
  if StreamFormat=smText then
  begin
    Pix:=Pointer(Map);
    for Y:=1 to Height do
    begin
      for I:=1 to Width do
      begin                        
        if InRangeR(Abs(Pix^),0.01,999999.99) or (Pix^=0) then Str(Pix^:23:15,Element)
        else Str(Pix^,Element);
        if I<>Width then Element:=Element+' ';
        Stream.Write(Element[1],Length(Element));
        Inc(Pix);
      end;
      Stream.Write(TextFileEOL,SizeOf(TextFileEOL));
      if Assigned(ProgressUpdate) then ProgressUpdate(Y*100 div Height);
    end;
  end
  else if StreamFormat=smMAP then
  begin
    Header.MAP:='MAP';
    Header.Version:=1;
    Header.PixelFormat:=SizeOf(Float)*$10;
    Header.Width:=Width;
    Header.Height:=Height;
    Header.Planes:=1;
    Header.Compression:=1;
    Stream.Write(Header,SizeOf(Header));

    case Header.Compression of
      0 : MapStream:=Stream;
      1 : begin
            MapStream:=TDeflateStream.Create(Stream);
            TDeflateStream(MapStream).CompressionMethod:=cmAutoHuffman;
          end;
      2 : MapStream:=TLZ77Stream.Create(Stream);
      else raise EUnsupportedFileFormat.Create(rsUnsupportedFileFormat);
    end;

    Pix:=Pointer(Map);
    for I:=1 to Size do
    begin
      MapStream.Write(Pix^,SizeOf(Float));
      Inc(Pix);
      if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*100 div Size);
    end;
    if Assigned(ProgressUpdate) then ProgressUpdate(100);
    if MapStream<>Stream then MapStream.Free;
  end
  else raise EUnsupportedFileFormat.Create(rsUnsupportedFileFormat);
end;

procedure TFloatMap.LoadFromStream(Stream: TBaseStream);
var
  DynamicMap : array of array of Float;
  Width, Height : Integer;
  Line : string;

  procedure ParseLine;
  const
    SeparatorChars = [' ',',',';',#9];
  var
    I, Len, X, T : Integer;
    Element : string;
    V : Float;
  begin
    X:=0; I:=1;
    Len:=Length(Line);
    while I<=Len do
    begin
      while (I<=Len) and (Line[I] in SeparatorChars) do Inc(I);
      Element:='';
      while (I<=Len) and not (Line[I] in SeparatorChars) do
      begin
        Element:=Element+Line[I];
        Inc(I);
      end;
      if Element='' then Break;
      Val(Element,V,T);
      if T<>0 then raise Exception.CreateFmt(rsInvalidNumberFormatS,[Element]);
      if X>High(DynamicMap[Height]) then
      begin
        if Height=0 then SetLength(DynamicMap[Height],Length(DynamicMap[Height])*2) // First line
        else raise Exception.CreateFmt(rsTheNumberOfElementsInLineDIsDifferentFromThatInTheFirstLine,[Height+1]);
      end;
      DynamicMap[Height][X]:=V;
      Inc(X);
    end;
    if Height=0 then Width:=X // First line
    else if X<>Width then raise Exception.CreateFmt(rsTheNumberOfElementsInLineDIsDifferentFromThatInTheFirstLine,[Height+1]);
  end;

var
  CompMap : TComplexMap;
  TextFile : TTextStream;
  Y : Integer;
begin
  Dispose;
  if StreamFormat=smText then // Parse text file
  begin
    TextFile:=TTextStream.Create(-1,-1,Stream);
    try
      Width:=0;
      Height:=0;
      Line:=TextFile.GetLine;
      SetLength(DynamicMap,256);
      SetLength(DynamicMap[0],256);
      ParseLine;
      if Width<1 then raise Exception.Create(rsInvalidTextFormat);
      Inc(Height);
      while not TextFile.EOS do
      begin
        Line:=TextFile.GetLine;
        if Line='' then Continue;
        if Height>High(DynamicMap) then SetLength(DynamicMap,Length(DynamicMap)*2); // More lines
        SetLength(DynamicMap[Height],Width);
        ParseLine;
        Inc(Height);
      end;
    finally
      TextFile.Free;
    end;
    New(Width,Height);
    for Y:=0 to Height-1 do Move(DynamicMap[Y][0],Map^[Y*Width],BytesPerLine);
  end
  else // Not text file
  begin
    CompMap:=TComplexMap.Create;
    try
      CompMap.StreamFormat:=StreamFormat;
      CompMap.LoadFromStream(Stream);
      GetComplexRepresentation(CompMap,crRealPart);
    finally
      CompMap.Free;
    end;
  end;
end;                          
{$ENDIF}

procedure TFloatMap.ResizeCanvas(XSiz,YSiz,XPos,YPos: Integer; Background: Float);
var
  OldMap : PByteArray;
  Y, XStart, OldBytesPerLine, LineMove, Bottom : Integer;
begin
  if (XSiz<1) or (YSiz<1) then
  begin
    Dispose;
    Exit;
  end;
  if XSiz<1 then
  begin
    New(XSiz,YSiz);
    Clear(Background);
    Exit;
  end;
  if (XSiz=Width) and (YSiz=Height) and (XPos=0) and (YPos=0) then Exit;

  OldBytesPerLine:=BytesPerLine;
  fBytesPerLine:=XSiz*SizeOf(Float);
  fSize:=XSiz*YSiz;
  fByteSize:=fSize*SizeOf(Float);
  OldMap:=Pointer(Map);
  GetMem(Map,fByteSize);

  XPos:=XPos*SizeOf(Float);
  if XPos>=0 then XStart:=0
  else
  begin
    XStart:=-XPos;
    XPos:=0;
  end;
  LineMove:=OldBytesPerLine-XStart;
  if LineMove+XPos>BytesPerLine then LineMove:=BytesPerLine-XPos;
  Bottom:=Min(Height-1,YSiz-YPos-1);
  fWidth:=XSiz; fHeight:=YSiz;
  Clear(Background);
  if LineMove>0 then for Y:=Max(0,-YPos) to Bottom do
    Move(OldMap^[Y*OldBytesPerLine+XStart],PByteArray(Map)^[(Y+YPos)*BytesPerLine+XPos],LineMove);
  FreeMem(OldMap);
end;

procedure TFloatMap.Paste(Source: TFloatMap; X,Y: Integer);
var
  CopySize : Integer;
  DestRect : TRect;
  SrcLine, DestLine : PFloat;
begin
  if not IntersectRect(DestRect,Rect(0,0,Width,Height),Bounds(X,Y,Source.Width,Source.Height)) then Exit;
  SrcLine:=Source.Pixel[Max(0,-X),Max(0,-Y)];
  DestLine:=Pixel[DestRect.Left,DestRect.Top];
  CopySize:=(DestRect.Right-DestRect.Left)*SizeOf(Float);
  for Y:=DestRect.Top to DestRect.Bottom-1 do
  begin
    Move(SrcLine^,DestLine^,CopySize);
    Inc(SrcLine,Source.Width);
    Inc(DestLine,Width);
  end;
end;

//==================================================================================================
// TComplexMap
//==================================================================================================

constructor TComplexMap.Create(X,Y: Integer);
begin
  Create;
  New(X,Y);
end;

function TComplexMap.GetScanLine(Y: Integer): Pointer;
begin
  Result:=@Map^[Y*Width];
end;

function TComplexMap.GetPixel(X,Y: Integer): PComplex;
begin
  Result:=@Map^[Y*Width+X];
end;

// Create new map
procedure TComplexMap.New(X,Y: Integer);
begin
  if (X=Width) and (Y=Height) then Exit;
  if Assigned(Map) then Dispose;
  if Int64(X)*Int64(Y)*SizeOf(TComplex)>2000000000 then raise EOutOfMemory.Create(SOutOfMemory);
  fSize:=X*Y;
  fWidth:=X;
  fHeight:=Y;
  fBytesPerLine:=Width*SizeOf(TComplex);
  FByteSize:=FSize*SizeOf(TComplex);
  GetMem(Map,Size*SizeOf(TComplex));
end;

// Release image map
procedure TComplexMap.Dispose;
begin
  FreeMem(Map);
  Map:=nil;
  fWidth:=0;
  fHeight:=0;
  fSize:=0;
end;

procedure TComplexMap.Clear(Value: TComplex);
var P : Integer;
begin
  for P:=0 to Size-1 do Map^[P]:=Value;
end;

procedure TComplexMap.Clear;
begin
  ZeroMem(Map^,Size*SizeOf(TComplex));
end;

procedure TComplexMap.FourierTransform(Domain: Double; ZeroShift: Boolean);
var
  TempMap, Line, DestLine : PComplexArray;
  Y, NumBits : Integer;
begin
  if Map=nil then Exit;

  NumBits:=NumberOfBitsNeeded(Width);
  if NumBits<1 then raise Exception.Create(rsMustBeIntegerPowerOf2);

  if Domain>0 then Multiply(1/Size);

  DestLine:=Map;
  GetMem(Line,BytesPerLine);
  try
    if ZeroShift and (Domain<0) then  // Zero shift before transforming
    begin
      TempMap:=Map;
      GetMem(Map,Size*SizeOf(TComplex));
      for Y:=0 to Height-1 do
      begin
        if Assigned(ProgressUpdate) then ProgressUpdate(Y*50 div (Height-1));
        Move(DestLine^,Line^[Width div 2],BytesPerLine div 2);
        Move(DestLine^[Width div 2],Line^,BytesPerLine div 2);
        PerformFFT(Line^,TComplexArray(ScanLine[(Y+Height div 2) mod Height]^),Width,Domain);
        Inc(DestLine,Width);
      end;
      FreeMem(TempMap);
    end
    else
    for Y:=0 to Height-1 do
    begin
      if Assigned(ProgressUpdate) then ProgressUpdate(Y*50 div (Height-1));

      Move(DestLine^,Line^,BytesPerLine);
      PerformFFT(Line^,DestLine^,Width,Domain);
      Inc(DestLine,Width);
    end;
  finally
    FreeMem(Line);
  end;

  FFTVertical(Domain,ZeroShift and (Domain>0));
end;

procedure TComplexMap.FourierTransform(Image: TLinarBitmap; ZeroShift: Boolean);
var
  Line : PComplexArray;
  X, Y, NumBits : Integer;
  Pix : ^Byte;
  Factor : Double;
begin
  if (Image.Map=nil) or (Image.PixelFormat<>pf8bit) then Exit;

  NumBits:=NumberOfBitsNeeded(Image.Width);
  if NumBits<1 then raise Exception.Create(rsMustBeIntegerPowerOf2);

  New(Image.Width,Image.Height);

  Factor:=1/(Image.Width*Image.Height);

  Line:=Map;
  ZeroMem(Line^,Width*SizeOf(TComplex));
  Pix:=Pointer(Image.Map);
  for Y:=0 to Height-1 do
  begin
    if Assigned(ProgressUpdate) then ProgressUpdate(Y*50 div (Height-1));

    for X:=0 to Width-1 do
    begin
      Line^[ReverseBits(X,NumBits)].Re:=Pix^*Factor;
      Inc(Pix);
    end;
    PerformFFT(Line^,Width);
    Inc(Line,Width);
  end;

  FFTVertical(FFT,ZeroShift);
end;

type
  TFFTVerticalData = record
                       XStart, XEnd : Integer;
                       Domain : Double;
                       ZeroShift : Boolean;
                       NumBits : Integer;
                       TempMap : PComplexArray;
                       Thread : TSimpleThread;
                     end;

procedure TComplexMap.FFTVerticalThreadProc(Thread: TSimpleThread; Data: Pointer);
var
  Line : PComplexArray;
  X, Y : Integer;
  CompPix : ^TComplex;
  ThreadData : ^TFFTVerticalData;
begin
  ThreadData:=Data;
  GetMem(Line,Height*SizeOf(TComplex));
  try
    for X:=ThreadData^.XStart to ThreadData.XEnd do
    begin
      if (Thread=nil) and Assigned(ProgressUpdate) then ProgressUpdate(50+X*50 div ThreadData.XEnd);
      CompPix:=@ThreadData.TempMap^[X];
      for Y:=0 to Height-1 do
      begin
        Line^[ReverseBits(Y,ThreadData.NumBits)]:=CompPix^;
        Inc(CompPix,Width);
      end;
      PerformFFT(Line^,Height,ThreadData.Domain);

      if ThreadData.ZeroShift then // Shift zero to center
      begin
        CompPix:=@Map^[(X+Width div 2) mod Width];
        for Y:=Height div 2 to Height-1 do
        begin
          CompPix^:=Line^[Y];
          Inc(CompPix,Width);
        end;
        for Y:=0 to Height div 2-1 do
        begin
          CompPix^:=Line^[Y];
          Inc(CompPix,Width);
        end;
      end
      else
      begin
        CompPix:=@Map^[X];
        for Y:=0 to Height-1 do
        begin
          CompPix^:=Line^[Y];
          Inc(CompPix,Width);
        end;
      end;
    end;
  finally
    FreeMem(Line);
  end;
end;

procedure TComplexMap.FFTVertical(const Domain: Double; ZeroShift: Boolean);
var
  TempMap : PComplexArray;
  NumBits, I, SegmentSize : Integer;
  ThreadData : array of TFFTVerticalData;
begin
  NumBits:=NumberOfBitsNeeded(Height);
  TempMap:=Map;
  GetMem(Map,Size*SizeOf(TComplex));
  try
    SegmentSize:=Max(16,Width div TMultiCoreProcess.NumberOfCores);
    SetLength(ThreadData,Max(1,Width div SegmentSize));
    for I:=0 to High(ThreadData) do
    begin
      ThreadData[I].XStart:=I*SegmentSize;
      if I=High(ThreadData) then ThreadData[I].XEnd:=Width-1
      else ThreadData[I].XEnd:=(I+1)*SegmentSize-1;
      ThreadData[I].Domain:=Domain;
      ThreadData[I].ZeroShift:=ZeroShift;
      ThreadData[I].NumBits:=NumBits;
      ThreadData[I].TempMap:=TempMap;
      if I>0 then ThreadData[I].Thread:=TSimpleThread.Create(FFTVerticalThreadProc,@ThreadData[I]);
    end;
    FFTVerticalThreadProc(nil,@ThreadData[0]);
  finally
    for I:=1 to High(ThreadData) do ThreadData[I].Thread.Free;
    FreeMem(TempMap);
  end;
end;

procedure TComplexMap.MakeBitmap(Image: TLinarBitmap; Representation: TComplexRepresentation; Method: TMappingMethod; const Min,Max: Float);
var
  FloatMap : TFloatMap;
  X, Y : Integer;
  Pix : ^Byte;
  Value : PComplex;
  Divisor, A : Double;
begin
  if (Max<Min) or (Method=mm16bitLinear) then
  begin
    FloatMap:=TFloatMap.Create;
    try
      FloatMap.GetComplexRepresentation(Self,Representation);
      FloatMap.MakeBitmap(Image,Method,Min,Max);
    finally
      FloatMap.Free;
    end;
  end
  else
  begin
    Image.New(Width,Height,pf8bit);
    Divisor:=Max-Min;
    if Divisor=0 then Divisor:=1;
    Pix:=@Image.Map^;
    Value:=@Map^;
    A:=0;
    for Y:=0 to Height-1 do
    begin
      //if Assigned(ProgressUpdate) then ProgressUpdate(Y*100 div (Height-1));

      for X:=0 to Width-1 do
      begin
        case Representation of
          crRealPart      : A:=Value^.Re;
          crImaginaryPart : A:=Value^.Im;
          crAmplitude     : A:=Value^.Modulus;
          crPhase         : A:=Value^.Angle;
        end;

        A:=(A-Min)/Divisor;

        case Method of
          mmLinear : A:=A*255;
          mmSqrt   : if A>0 then A:=Sqrt(A)*255 else A:=0;
          mmLog    : if A>0 then A:=Ln(A)*(255/2.302585092994) else A:=0;
        end;

        if A>255 then A:=255
        else if A<0 then A:=0;
        Pix^:=Round(A);

        Inc(Value);
        Inc(Pix);
      end;
    end;
  end;
end;

procedure TComplexMap.GetFromBitmaps(Real,Imag: TLinarBitmap; Offset: Integer);
var
  P : Integer;
  RePix, ImPix : ^Byte;
  RePix16 : PWord absolute RePix;
  ImPix16 : PWord absolute ImPix;
  RePix24 : PRGBRec absolute RePix;
  Value : PComplex;
begin
  if not ((Real.PixelFormat in [pf8bit,pf16bit,pf24bit]) and ((Imag=nil) or (Imag.PixelFormat in [pf8bit,pf16bit,pf24bit]))) then
    raise Exception.Create(rsInvalidPixelFormat);
  New(Real.Width,Real.Height);
  RePix:=@Real.Map^;
  Value:=@Map^;
  if Assigned(Imag) then
  begin
    if Real.PixelFormat<>Imag.PixelFormat then raise Exception.Create(SInvalidPixelFormat);
    ImPix:=@Imag.Map^;
    if (Real.PixelFormat=pf16bit) and (Imag.PixelFormat=pf16bit) then // 16 bit
      for P:=1 to Size do
      begin
        Value^.Re:=RePix16^+Offset;
        Value^.Im:=ImPix16^+Offset;
        Inc(Value);
        Inc(RePix16);
        Inc(ImPix16);
      end
    else if (Real.PixelFormat=pf8bit) and (Imag.PixelFormat=pf8bit) then // 8 bit
      for P:=1 to Size do
      begin
        Value^.Re:=RePix^+Offset;
        Value^.Im:=ImPix^+Offset;
        Inc(Value);
        Inc(RePix);
        Inc(ImPix);
      end
    else raise Exception.Create(rsInvalidPixelFormat);
  end
  else
  begin
    Clear;
    if Real.PixelFormat=pf16bit then // 16 bit
      for P:=1 to Size do
      begin
        Value^.Re:=RePix16^+Offset;
        Inc(Value);
        Inc(RePix16);
      end
    else if Real.PixelFormat=pf8bit then // 8 bit
      for P:=1 to Size do
      begin
        Value^.Re:=RePix^+Offset;
        Inc(Value);
        Inc(RePix);
      end
    else if Real.PixelFormat=pf24bit then // 24 bit
      for P:=1 to Size do
      begin
        Value^.Re:=(2*RePix24^.R+3*RePix24^.G+RePix24^.B)/6+Offset;
        Inc(Value);
        Inc(RePix24);
      end
    else raise Exception.Create(rsInvalidPixelFormat);
  end;
end;

procedure TComplexMap.Multiply(R: Double);
var
  P : Integer;
  Value : PComplex;
begin
  Value:=@Map^;
  for P:=1 to Size do
  begin
    Value^.Re:=Value^.Re*R;
    Value^.Im:=Value^.Im*R;
    Inc(Value);
  end;
end;

procedure TComplexMap.Assign(Other: TObject);
var
  P : Integer;
  Source : PFloat;
  Dest : PComplex;
begin
  if Other is TComplexMap then
  begin
    New(TComplexMap(Other).Width,TComplexMap(Other).Height);
    Move(TComplexMap(Other).Map^,Map^,Size*SizeOf(TComplex));
  end
  else if Other is TFloatMap then
  begin
    New(TFloatMap(Other).Width,TFloatMap(Other).Height);
    Clear;
    Source:=@TFloatMap(Other).Map^;
    Dest:=@Map^;
    for P:=1 to Size do
    begin
      Dest^.Re:=Source^;
      Inc(Source);
      Inc(Dest);
    end;
  end
  else if Other is TLinearBitmap then GetFromBitmaps(TLinearBitmap(Other),nil)
  else inherited;
end;

procedure TComplexMap.ResizeCanvas(XSiz,YSiz,XPos,YPos: Integer);
var
  OldMap : PByteArray;
  Y, XStart, OldBytesPerLine, LineMove, Bottom : Integer;
begin
  if (XSiz<1) or (YSiz<1) then
  begin
    Dispose;
    Exit;
  end;
  if XSiz<1 then
  begin
    New(XSiz,YSiz);
    Clear;
    Exit;
  end;
  if (XSiz=Width) and (YSiz=Height) and (XPos=0) and (YPos=0) then Exit;

  OldBytesPerLine:=BytesPerLine;
  fBytesPerLine:=XSiz*SizeOf(TComplex);
  fSize:=XSiz*YSiz;
  fByteSize:=fSize*SizeOf(TComplex);
  OldMap:=Pointer(Map);
  GetMem(Map,fByteSize);

  XPos:=XPos*SizeOf(TComplex);
  if XPos>=0 then XStart:=0
  else
  begin
    XStart:=-XPos;
    XPos:=0;
  end;
  LineMove:=OldBytesPerLine-XStart;
  if LineMove+XPos>BytesPerLine then LineMove:=BytesPerLine-XPos;
  Bottom:=Min(Height-1,YSiz-YPos-1);
  fWidth:=XSiz; fHeight:=YSiz;
  Clear;
  if LineMove>0 then for Y:=Max(0,-YPos) to Bottom do
    Move(OldMap^[Y*OldBytesPerLine+XStart],PByteArray(Map)^[(Y+YPos)*BytesPerLine+XPos],LineMove);
  FreeMem(OldMap);
end;

// Note: See Image Analysis, Vision and Computer Graphics, Jens Michael
// Carstensen (2001) for a faster implementation of distance transform
// using filters.
procedure TComplexMap.DistanceTransform(Image: TLinarBitmap; SearchValue: Byte);
type
  TPointList = array[0..0] of TPoint;
var
  X, Y, P, Count, DX, DY, BestDX, BestDY : Integer;
  BestDist, Dist : Cardinal;
  PointList : ^TPointList;
  Point : ^TPoint;
  Pix : ^Byte;
  Dest : PComplex;
begin
  // Count number of non-background pixels
  Count:=0;
  Pix:=@Image.Map^;
  for X:=1 to Image.Size do
  begin
    if Pix^<>SearchValue then Inc(Count);
    Inc(Pix);
  end;

  New(Image.Width,Image.Height);
  Clear;
  if Count=0 then Exit;

  BestDX:=0; BestDY:=0;
  GetMem(PointList,SizeOf(TPoint)*Count);
  try
    // Put non-background pixels in list
    Pix:=@Image.Map^;
    Point:=@PointList^[0];
    for Y:=0 to Height-1 do
    begin
      for X:=0 to Width-1 do
      begin
        if Pix^<>SearchValue then
        begin
          Point^.X:=X;
          Point^.Y:=Y;
          Inc(Point);
        end;
        Inc(Pix);
      end;
    end;

    // Find distance to nearest point in list from each pixel
    Dest:=@Map^;
    Pix:=@Image.Map^;
    for Y:=0 to Height-1 do
    begin
      if Assigned(ProgressUpdate) then ProgressUpdate(Y*100 div (Height-1));
      for X:=0 to Width-1 do
      begin
        if Pix^=SearchValue then
        begin
          BestDist:=High(Cardinal);
          for P:=0 to Count-1 do
          begin
            DX:=PointList^[P].X-X; DY:=PointList^[P].Y-Y;
            Dist:=Sqr(DX)+Sqr(DY);
            if Dist<BestDist then
            begin
              BestDist:=Dist;
              BestDX:=DX;
              BestDY:=DY;
            end;
          end;
          Dest^.Re:=BestDX;
          Dest^.Im:=BestDY;
        end;
        Inc(Dest);
        Inc(Pix);
      end;
    end;
  finally
    FreeMem(PointList);
  end;
end;

procedure TComplexMap.ImageStat(Image: TLinarBitmap; WindowSize: Integer);
var
  X, Y, DX, DY, DMax, DMin, Count, XA, XB, YA, YB : Integer;
  Sum, SqrSum : DWord;
  ScanPix : ^Byte;
  Stat : PComplex;
  Mean : Double;
begin
  Assert(Image.PixelFormat=pf8bit);
  DMin:=-WindowSize div 2;
  DMax:=WindowSize+DMin-1;
  New(Image.Width,Image.Height);

  Stat:=@Map^[0];
  for Y:=0 to Height-1 do
  begin
    if Assigned(ProgressUpdate) then ProgressUpdate(Y*100 div (Height-1));
    YA:=Y+DMin; if YA<0 then YA:=0;
    YB:=Y+DMax; if YB>=Height then YB:=Height-1;
    for X:=0 to Width-1 do
    begin
      Sum:=0; SqrSum:=0;
      Count:=0;
      XA:=X+DMin; if XA<0 then XA:=0;
      XB:=X+DMax; if XB>=Width then XB:=Width-1;
      for DY:=YA to YB do
      begin
        ScanPix:=@Image.Map^[DY*Image.BytesPerLine+XA];
        for DX:=XA to XB do
        begin
          Inc(Sum,ScanPix^);
          Inc(SqrSum,Sqr(Integer(ScanPix^)));
          Inc(Count);
          Inc(ScanPix);
        end;
      end;

      if (Sum=0) or (Count=0) then
      begin
        Stat^:=ComplexZero;
      end
      else
      begin
        Mean:=Sum/Count;
        Stat^.Re:=Mean;
        Stat^.Im:=Sqrt(SqrSum/Count-Sqr(Mean));
      end;

      Inc(Stat);
    end;
  end;
end;

procedure TComplexMap.ImageStat(Image,Mask: TLinarBitmap; WindowSize: Integer);
var
  X, Y, DX, DY, DMax, DMin, Count, XA, XB, YA, YB, P : Integer;
  Sum, SqrSum : DWord;
  ScanPix : ^Byte;
  MaskCenter, MaskPix : ^ByteBool;
  Stat : PComplex;
  Mean : Double;      
begin
  DMin:=-WindowSize div 2;
  DMax:=WindowSize+DMin-1;
  New(Image.Width,Image.Height);
  Clear;

  Sum:=0; SqrSum:=0;
  MaskCenter:=@Mask.Map^[0];
  Stat:=@Map^[0];
  for Y:=0 to Height-1 do
  begin
    if Assigned(ProgressUpdate) then ProgressUpdate(Y*100 div (Height-1));
    YA:=Y+DMin; if YA<0 then YA:=0;
    YB:=Y+DMax; if YB>=Height then YB:=Height-1;
    for X:=0 to Width-1 do
    begin
      Count:=0;
      if MaskCenter^ then
      begin
        Sum:=0; SqrSum:=0;
        XA:=X+DMin; if XA<0 then XA:=0;
        XB:=X+DMax; if XB>=Width then XB:=Width-1;
        for DY:=YA to YB do
        begin
          P:=DY*Image.BytesPerLine+XA;
          ScanPix:=@Image.Map^[P];
          MaskPix:=@Mask.Map^[P];
          for DX:=XA to XB do
          begin
            if MaskPix^ then
            begin
              Inc(Sum,ScanPix^);
              Inc(SqrSum,Sqr(DWord(ScanPix^)));
              Inc(Count);
            end;
            Inc(ScanPix);
            Inc(MaskPix);
          end;
        end;
      end;

      if (Count=0) or (Sum=0) then
      begin
        Stat^.Re:=0;
        Stat^.Im:=0;
      end
      else
      begin
        Mean:=Sum/Count;
        Stat^.Re:=Mean;
        Stat^.Im:=Sqrt(SqrSum/Count-Sqr(Mean));
      end;

      Inc(MaskCenter);
      Inc(Stat);
    end;
  end;
end;

function TComplexMap.IsReal: Boolean;
var
  Pix : ^TComplex;
  I : Integer;
begin
  Result:=True;
  Pix:=Pointer(Map);
  for I:=1 to Size do // See if only real numbers
  begin
    if Pix^.Im<>0 then
    begin
      Result:=False; // Complex number found
      Break;
    end;
    Inc(Pix);
  end;
end;

{$IFDEF FloatMapFileSupport}
procedure TComplexMap.LoadFromStream(Stream: TBaseStream);
var
  Header : TMapHeader;
  Pix : ^TComplex;
  I : Integer;
  MapStream : TBaseStream;
  P1  : Byte;
  P2  : Word;
  P40 : Single;
  P80 : Double;
  FloatMap : TFloatMap;
begin
  Dispose;
  if StreamFormat=smMatlab then LoadMATFile(Stream,Self)
  else if StreamFormat=smText then
  begin
    FloatMap:=TFloatMap.Create;
    try
      FloatMap.StreamFormat:=StreamFormat;
      FloatMap.LoadFromStream(Stream);
      Assign(FloatMap);
    finally
      FloatMap.Free;
    end;
  end
  else if StreamFormat=smMAP then
  begin
    Stream.Read(Header,SizeOf(Header));

    if (Header.MAP<>'MAP') or
       (Header.Version>1) or
       (Header.Planes<1) then raise EUnsupportedFileFormat.Create(rsUnsupportedFileFormat);

    if not (Header.PixelFormat in [$01,$02,$40,$80]) then raise Exception.Create(rsInvalidPixelFormat);

    New(Header.Width,Header.Height);
    if Header.Planes<2 then Clear;

    case Header.Compression of
      0 : MapStream:=Stream;
      1 : MapStream:=TDeflateStream.Create(Stream);
      2 : MapStream:=TLZ77Stream.Create(Stream);
      else raise Exception.Create(rsUnsupportedFileFormat);
    end;

    Pix:=Pointer(Map);
    case Header.PixelFormat of
      $01 : begin
              for I:=1 to Size do
              begin
                MapStream.Read(P1,SizeOf(P1)); Pix^.Re:=P1;
                Inc(Pix);
                if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*200 shr Header.Planes div Size);
              end;
              if Header.Planes>1 then
              begin
                Pix:=Pointer(Map);
                for I:=1 to Size do
                begin
                  MapStream.Read(P1,SizeOf(P1)); Pix^.Im:=P1;
                  Inc(Pix);
                  if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*50 div Size+50);
                end;
              end;
            end;
      $02 : begin
              for I:=1 to Size do
              begin
                MapStream.Read(P2,SizeOf(P2)); Pix^.Re:=P2;
                Inc(Pix);
                if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*100*Header.Planes div Size);
              end;
              if Header.Planes>1 then
              begin
                Pix:=Pointer(Map);
                for I:=1 to Size do
                begin
                  MapStream.Read(P2,SizeOf(P2)); Pix^.Im:=P2;
                  Inc(Pix);
                  if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*50 div Size+50);
                end;
              end;
            end;
      $40 : begin
              for I:=1 to Size do
              begin
                MapStream.Read(P40,SizeOf(P40)); Pix^.Re:=P40;
                Inc(Pix);
                if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*200 shr Header.Planes div Size);
              end;
              if Header.Planes>1 then
              begin
                Pix:=Pointer(Map);
                for I:=1 to Size do
                begin
                  MapStream.Read(P40,SizeOf(P40)); Pix^.Im:=P40;
                  Inc(Pix);
                  if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*50 div Size+50);
                end;
              end;
            end;
      $80 : begin
              for I:=1 to Size do
              begin
                MapStream.Read(P80,SizeOf(P80)); Pix^.Re:=P80;
                Inc(Pix);
                if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*200 shr Header.Planes div Size);
              end;
              if Header.Planes>1 then
              begin
                Pix:=Pointer(Map);
                for I:=1 to Size do
                begin
                  MapStream.Read(P80,SizeOf(P80)); Pix^.Im:=P80;
                  Inc(Pix);
                  if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*50 div Size+50);
                end;
              end;
            end;
      else raise EUnsupportedFileFormat.Create(rsUnsupportedFileFormat);;
    end;
    if MapSTream<>Stream then MapStream.Free;
    if Assigned(ProgressUpdate) then ProgressUpdate(100);
  end
  else raise EUnsupportedFileFormat.Create(rsUnsupportedFileFormat);
end;

procedure TComplexMap.SaveToStream(Stream: TBaseStream);
var
  Header : TMapHeader;
  Pix : ^TComplex;
  I : Integer;
  MapStream : TBaseStream;
  FloatMap : TFloatMap;
begin
  if StreamFormat in [smText] then
  begin
    if not IsReal then raise EUnsupportedFileFormat.Create(rsUnsupportedFileFormatForComplexData);
    FloatMap:=TFloatMap.Create;
    try
      AssignTo(FloatMap);
      FloatMap.StreamFormat:=StreamFormat;
      FloatMap.SaveToStream(Stream);
    finally
      FloatMap.Free;
    end;
  end
  else if StreamFormat=smMAP then
  begin
    Header.MAP:='MAP';
    Header.Version:=1;
    Header.PixelFormat:=SizeOf(Float)*$10;
    Header.Width:=Width;
    Header.Height:=Height;
    if IsReal then Header.Planes:=1
    else Header.Planes:=2; // Complex number found
    Header.Compression:=1;
    Stream.Write(Header,SizeOf(Header));

    case Header.Compression of
      0 : MapStream:=Stream;
      1 : begin
            MapStream:=TDeflateStream.Create(Stream);
            TDeflateStream(MapStream).CompressionMethod:=cmAutoHuffman;
          end;
      2 : MapStream:=TLZ77Stream.Create(Stream);
    else
      raise Exception.Create(rsUnsupportedFileFormat);
    end;

    Pix:=Pointer(Map);
    for I:=1 to Size do
    begin
      MapStream.Write(Pix^.Re,SizeOf(Float));
      Inc(Pix);
      if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*200 shr Header.Planes div Size);
    end;
    if Header.Planes>1 then
    begin
      Pix:=Pointer(Map);
      for I:=1 to Size do
      begin
        MapStream.Write(Pix^.Im,SizeOf(Float));
        Inc(Pix);
        if Assigned(ProgressUpdate) and (I and 2047=0) then ProgressUpdate(I*50 div Size+50);
      end;
    end;
    if MapSTream<>Stream then MapStream.Free;
    if Assigned(ProgressUpdate) then ProgressUpdate(100);
  end
  else raise EUnsupportedFileFormat.Create(rsUnsupportedFileFormat);
end;

initialization
  cfImageAnalyzerMap:=RegisterClipboardFormat('Image Analyzer Map');
{$ENDIF}
end.

