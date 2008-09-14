/////////////////////////////////////////////////////////////////////////////////////////////////////
//
// TIFFLoader.pas - Uncompressed TIFF file writer
// ----------------------------------------------
// Version:   2008-04-29
// Maintain:  Michael Vinther    |     mv@logicnet·dk
//
// Last changes:
//
unit TIFFLoader;

interface

uses Windows, Classes, SysUtils, LinarBitmap, Streams, Graphics, FileMappedBitmap;

resourcestring
  rsTIFFImageFile = 'TIFF image';

type
  TTIFFOutputOptions = set of (toWrite8bitAs1bit,       // If set, an 8 bit image is saved to a 1 bit file
                               toWrite8bitAsGrayscale,  // If set, an 8 bit image is saved as grayscale regardless of palette
                               toInvertOutput);         // For 1 bit and grayscale images, signal inverted output

  TTIFFLoader = class(TFileMappedBitmapLoader)
    public
      Options : TTIFFOutputOptions;
      function CanLoad(const Ext: string): Boolean; override;
      function CanSave(const Ext: string): Boolean; override;
      function GetSaveFilter: string; override;
      procedure SaveToStream(Stream: TSeekableStream; const Ext: string; Bitmap: TLinarBitmap); override;
    end;

var
  Default : TTIFFLoader;

implementation

uses MemStream;

//==================================================================================================
// TTIFFLoader
//==================================================================================================

function TTIFFLoader.GetSaveFilter: string;
begin
  Result:=rsTIFFImageFile+' (*.tif)|*.tif;*.tiff';
end;

function TTIFFLoader.CanLoad(const Ext: string): Boolean;
begin
  Result:=False;
end;

function TTIFFLoader.CanSave(const Ext: string): Boolean;
begin
  Result:=(Ext='TIF') or (Ext='TIFF');
end;

type
  TTIFFHeader = packed record
                  II : array[0..1] of Char;
                  FortyTwo : Word;
                  IFDOffset : DWord;
                end;
  TIFDEntry = packed record
                Tag : Word;
                FieldType : Word;
                ValueCount : DWord;
                ValueOrOffset : DWord;
              end;

const // IFD entry field types
  ifdByte     = 1;
  ifdShort    = 3;
  ifdLong     = 4;
  ifdRational = 5;

procedure TTIFFLoader.SaveToStream(Stream: TSeekableStream; const Ext: string; Bitmap: TLinarBitmap);

const
  LongDataOffset = 256;

var
  LongData : TMemStream;

  procedure WriteIFDEntryLongData(Tag,FieldType: Word; ValueCount: DWord; var Data; Size: Integer);
  var
    IFDEntry : TIFDEntry;
  begin
    IFDEntry.Tag:=Tag;
    IFDEntry.FieldType:=FieldType;
    IFDEntry.ValueCount:=ValueCount;
    IFDEntry.ValueOrOffset:=LongDataOffset+LongData.Size;
    Stream.Write(IFDEntry,SizeOf(IFDEntry));
    LongData.Write(Data,Size)
  end;

  procedure WriteIFDEntryIntegerValue(Tag,FieldType: Word; Value: DWord);
  var
    IFDEntry : TIFDEntry;
  begin
    IFDEntry.Tag:=Tag;
    IFDEntry.FieldType:=FieldType;
    IFDEntry.ValueCount:=1;
    IFDEntry.ValueOrOffset:=Value;
    Stream.Write(IFDEntry,SizeOf(IFDEntry))
  end;

  procedure WriteIFDEntryRationalValue(Tag: Word; Numerator,Denominator: DWord); // Numerator/Denominator
  var
    Data : packed record
             V1, V2 : DWord;
           end;
  begin
    Data.V1:=Numerator;
    Data.V2:=Denominator;
    WriteIFDEntryLongData(Tag,ifdRational,1,Data,8);
  end;

  procedure Write1bitImage;
  var
    I, X, StripDataOffset, StripSize : DWord;
    StripData : array of DWord;
    ScanLine : packed array of Byte;
    Pix : PByte;
  begin
    // Write first and only IFD
    I:=10;
    Stream.Write(I,2); // Start of IFD, number of entries

    LongData:=TMemStream.Create;
    try
      WriteIFDEntryIntegerValue($100,ifdLong,Bitmap.Width); // ImageWidth
      WriteIFDEntryIntegerValue($101,ifdLong,Bitmap.Height); // ImageLength
      WriteIFDEntryIntegerValue($103,ifdShort,1); // Compression
      if toInvertOutput in Options then WriteIFDEntryIntegerValue($106,ifdShort,0) // PhotometricInterpretation
      else WriteIFDEntryIntegerValue($106,ifdShort,1);
      SetLength(StripData,Bitmap.Height);
      StripDataOffset:=512+Bitmap.Height*8;
      StripSize:=(Bitmap.Width+7) div 8;
      for I:=0 to Bitmap.Height-1 do StripData[I]:=StripDataOffset+I*StripSize;
      WriteIFDEntryLongData($111,ifdLong,Bitmap.Height,StripData[0],Length(StripData)*4); // StripOffsets
      WriteIFDEntryIntegerValue($116,ifdShort,1); // RowsPerStrip
      for I:=0 to Bitmap.Height-1 do StripData[I]:=StripSize;
      WriteIFDEntryLongData($117,ifdLong,Bitmap.Height,StripData[0],Length(StripData)*4); // StripByteCounts
      WriteIFDEntryRationalValue($11a,1,1); // XResolution
      WriteIFDEntryRationalValue($11b,1,1); // YResolution
      WriteIFDEntryIntegerValue($128,ifdShort,1); // ResolutionUnit

      I:=0;
      Stream.Write(I,4); // End of IFD, 0 signals no more IFDs
      Assert(Stream.Size<=LongDataOffset);
      for I:=Stream.Size to LongDataOffset-1 do Stream.Write(StripSize,1);

      LongData.Position:=0; // Write long data values
      Stream.CopyFrom(LongData);
      Assert(DWord(Stream.Size)<=StripDataOffset);
      for I:=Stream.Size to StripDataOffset-1 do Stream.Write(StripSize,1);
    finally
      LongData.Free;
    end;
    // Write pixel data
    SetLength(ScanLine,StripSize);
    for I:=0 to Bitmap.Height-1 do
    begin
      FillChar(ScanLine[0],StripSize,0);
      Pix:=Bitmap.ScanLineSafe[I];
      for X:=0 to Bitmap.Width-1 do
      begin
        if Pix^>127 then
          ScanLine[X div 8]:=ScanLine[X div 8] or (128 shr (X mod 8));
        Inc(Pix);
      end;
      Stream.Write(ScanLine[0],StripSize);
    end;
  end;

  procedure Write8bitGrayscaleImage;
  var
    I, StripDataOffset, StripSize : DWord;
    StripData : array of DWord;
  begin
    // Write first and only IFD
    I:=11;
    Stream.Write(I,2); // Start of IFD, number of entries

    LongData:=TMemStream.Create;
    try
      WriteIFDEntryIntegerValue($100,ifdLong,Bitmap.Width); // ImageWidth
      WriteIFDEntryIntegerValue($101,ifdLong,Bitmap.Height); // ImageLength
      WriteIFDEntryIntegerValue($102,ifdShort,8); // BitsPerSample
      WriteIFDEntryIntegerValue($103,ifdShort,1); // Compression
      if toInvertOutput in Options then WriteIFDEntryIntegerValue($106,ifdShort,0) // PhotometricInterpretation
      else WriteIFDEntryIntegerValue($106,ifdShort,1); 
      SetLength(StripData,Bitmap.Height);
      StripDataOffset:=512+Bitmap.Height*8;
      StripSize:=Bitmap.Width;
      for I:=0 to Bitmap.Height-1 do StripData[I]:=StripDataOffset+I*StripSize;
      WriteIFDEntryLongData($111,ifdLong,Bitmap.Height,StripData[0],Length(StripData)*4); // StripOffsets
      WriteIFDEntryIntegerValue($116,ifdShort,1); // RowsPerStrip
      for I:=0 to Bitmap.Height-1 do StripData[I]:=StripSize;
      WriteIFDEntryLongData($117,ifdLong,Bitmap.Height,StripData[0],Length(StripData)*4); // StripByteCounts
      WriteIFDEntryRationalValue($11a,1,1); // XResolution
      WriteIFDEntryRationalValue($11b,1,1); // YResolution
      WriteIFDEntryIntegerValue($128,ifdShort,1); // ResolutionUnit

      I:=0;
      Stream.Write(I,4); // End of IFD, 0 signals no more IFDs
      Assert(Stream.Size<=LongDataOffset);
      for I:=Stream.Size to LongDataOffset-1 do Stream.Write(StripSize,1);

      LongData.Position:=0; // Write long data values
      Stream.CopyFrom(LongData);
      Assert(DWord(Stream.Size)<=StripDataOffset);
      for I:=Stream.Size to StripDataOffset-1 do Stream.Write(StripSize,1);
    finally
      LongData.Free;
    end;
    // Write pixel data
    for I:=0 to Bitmap.Height-1 do
      Stream.Write(Bitmap.ScanLineSafe[I]^,StripSize);
  end;

  procedure Write8bitPaletteImage;
  var
    I, StripDataOffset, StripSize : DWord;
    StripData : array of DWord;
    Palette : array of Word;
  begin
    // Write first and only IFD
    I:=12;
    Stream.Write(I,2); // Start of IFD, number of entries

    LongData:=TMemStream.Create;
    try
      WriteIFDEntryIntegerValue($100,ifdLong,Bitmap.Width); // ImageWidth
      WriteIFDEntryIntegerValue($101,ifdLong,Bitmap.Height); // ImageLength
      WriteIFDEntryIntegerValue($102,ifdShort,8); // BitsPerSample
      WriteIFDEntryIntegerValue($103,ifdShort,1); // Compression
      WriteIFDEntryIntegerValue($106,ifdShort,3);
      SetLength(StripData,Bitmap.Height);
      StripDataOffset:=300+256*2*3+Bitmap.Height*8;
      StripSize:=Bitmap.Width;
      for I:=0 to Bitmap.Height-1 do StripData[I]:=StripDataOffset+I*StripSize;
      WriteIFDEntryLongData($111,ifdLong,Bitmap.Height,StripData[0],Length(StripData)*4); // StripOffsets
      WriteIFDEntryIntegerValue($116,ifdShort,1); // RowsPerStrip
      for I:=0 to Bitmap.Height-1 do StripData[I]:=StripSize;
      WriteIFDEntryLongData($117,ifdLong,Bitmap.Height,StripData[0],Length(StripData)*4); // StripByteCounts
      WriteIFDEntryRationalValue($11a,1,1); // XResolution
      WriteIFDEntryRationalValue($11b,1,1); // YResolution
      WriteIFDEntryIntegerValue($128,ifdShort,1); // ResolutionUnit
      SetLength(Palette,3*256);
      for I:=0 to 255 do
        with Bitmap.Palette^[I] do
        begin
          Palette[I+000]:=R*257;
          Palette[I+256]:=G*257;
          Palette[I+512]:=B*257;
        end;
      WriteIFDEntryLongData($140,ifdShort,3*256,Palette[0],3*256*2); // Palette

      I:=0;
      Stream.Write(I,4); // End of IFD, 0 signals no more IFDs
      Assert(Stream.Size<=LongDataOffset);
      for I:=Stream.Size to LongDataOffset-1 do Stream.Write(StripSize,1);

      LongData.Position:=0; // Write long data values
      Stream.CopyFrom(LongData);
      Assert(DWord(Stream.Size)<=StripDataOffset);
      for I:=Stream.Size to StripDataOffset-1 do Stream.Write(StripSize,1);
    finally
      LongData.Free;
    end;
    // Write pixel data
    for I:=0 to Bitmap.Height-1 do
      Stream.Write(Bitmap.ScanLineSafe[I]^,StripSize);
  end;

  procedure Write24bitImage;
  var
    BitsPerSample : packed array[1..3] of Word;
    I, X, StripDataOffset, StripSize : DWord;
    StripData : array of DWord;
    ScanLine : packed array of RGBRec;
    Pix : PRGBRec;
  begin
    // Write first and only IFD
    I:=12;
    Stream.Write(I,2); // Start of IFD, number of entries

    LongData:=TMemStream.Create;
    try
      WriteIFDEntryIntegerValue($100,ifdLong,Bitmap.Width); // ImageWidth
      WriteIFDEntryIntegerValue($101,ifdLong,Bitmap.Height); // ImageLength
      BitsPerSample[1]:=8; BitsPerSample[2]:=8; BitsPerSample[3]:=8;
      WriteIFDEntryLongData($102,ifdShort,3,BitsPerSample,6); // BitsPerSample
      WriteIFDEntryIntegerValue($103,ifdShort,1); // Compression
      WriteIFDEntryIntegerValue($106,ifdShort,2); // PhotometricInterpretation
      SetLength(StripData,Bitmap.Height);
      StripDataOffset:=512+Bitmap.Height*8;
      StripSize:=Bitmap.Width*3;
      for I:=0 to Bitmap.Height-1 do StripData[I]:=StripDataOffset+I*StripSize;
      WriteIFDEntryLongData($111,ifdLong,Bitmap.Height,StripData[0],Length(StripData)*4); // StripOffsets
      WriteIFDEntryIntegerValue($115,ifdShort,3); // SamplesPerPixel
      WriteIFDEntryIntegerValue($116,ifdShort,1); // RowsPerStrip
      for I:=0 to Bitmap.Height-1 do StripData[I]:=StripSize;
      WriteIFDEntryLongData($117,ifdLong,Bitmap.Height,StripData[0],Length(StripData)*4); // StripByteCounts
      WriteIFDEntryRationalValue($11a,1,1); // XResolution
      WriteIFDEntryRationalValue($11b,1,1); // YResolution
      WriteIFDEntryIntegerValue($128,ifdShort,1); // ResolutionUnit

      I:=0;
      Stream.Write(I,4); // End of IFD, 0 signals no more IFDs
      Assert(Stream.Size<=LongDataOffset);
      for I:=Stream.Size to LongDataOffset-1 do Stream.Write(StripSize,1);

      LongData.Position:=0; // Write long data values
      Stream.CopyFrom(LongData);
      Assert(DWord(Stream.Size)<=StripDataOffset);
      for I:=Stream.Size to StripDataOffset-1 do Stream.Write(StripSize,1);
    finally
      LongData.Free;
    end;
    // Write pixel data
    SetLength(ScanLine,Bitmap.Width);
    for I:=0 to Bitmap.Height-1 do
    begin
      Pix:=Bitmap.ScanLineSafe[I];
      for X:=0 to Bitmap.Width-1 do
        with ScanLine[X] do
        begin
          R:=Pix^.B;
          G:=Pix^.G;
          B:=Pix^.R;
          Inc(Pix);
        end;
      Stream.Write(ScanLine[0],StripSize);
    end;
  end;

var
  Header : TTIFFHeader;
begin
  // Write header
  Header.II:='II';
  Header.FortyTwo:=42;
  Header.IFDOffset:=8;
  Stream.Write(Header,SizeOf(Header));
  // Write image data
  if Bitmap.PixelFormat=pf24bit then
    Write24bitImage
  else if (Bitmap.PixelFormat=pf8bit) and (toWrite8bitAs1bit in Options) then
    Write1bitImage
  else if (Bitmap.PixelFormat=pf8bit) and (toWrite8bitAsGrayscale in Options) or Bitmap.IsGrayScale then
    Write8bitGrayscaleImage
  else if Bitmap.PixelFormat=pf8bit then
    Write8bitPaletteImage
  else
    raise Exception.Create(rsInvalidPixelFormat);
end;

initialization
  Default:=TTIFFLoader.Create;
  LinarBitmap.AddLoader(Default);
finalization
  Default.Free;
end.

