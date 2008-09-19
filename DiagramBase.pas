unit DiagramBase;

interface

uses Monitor, Windows, SysUtils, StreamUtils, Contnrs, MathUtils, Graphics, Math,
  DynamicLists, Streams, Deflate, MemUtils, Classes, FastBitmap;

resourcestring
  rsDiagramFileFilter     = 'Diagram (*.ddd)|*.ddd';
  rsTemplatePaletteFilter = 'Diagram template palette (*.ddt)|*.ddt';

const
  DesignerDPI     = 64008;
  DesignerDPmm    = DesignerDPI*10 div 254;
  DesignerDPpoint = DesignerDPI div 72;

  cmPerInch = 2.54;
  mmPerInch = 25.4;

  MarkerBoxSize  = 4;
  LinkMarkerSize = 2;

  CurrentFileVersion = 18; // Supported from program version 1.20

  otTextObject             = 1;
  otRectangleObject        = 2;
  otEllipseObject          = 3;
  otStraightLine           = 4;
  otConnectorLine          = 5;
  otBitmapObject           = 6;
  otMetafileObject         = 7;
  otGroupObject            = 8;
  otPolygonObject          = 9;
  otFlowchartObject        = 10;
  otCurveLine              = 11;
  otInheritedLayer         = 12;

  NoGrid : TPoint = (x:1; y:1);

type
  TDiagramContainer = class; // Forward

  TCanvasInfo = object
		// Set by caller
		Offset               : TPoint;
		Scale                : TFloatPoint;
		DrawMode             : (dmEditing,dmPreview,dmRender);
		ZBuffer              : TBitmap;
		DefaultFont          : TFont;
		DisableFontSmoothing : Boolean; // Not fully implemented
		PageIndex            : Integer;
		Container            : TDiagramContainer;
		function CanvasPoint(const Point: TPoint): TPoint; overload;
		function CanvasPoint(const X, Y: Double):  TPoint; overload;
		function ObjectPoint(const Point: TPoint): TPoint;
		function CanvasRect (const Rect: TRect): TRect;
		function CanvasRect1(const Rect: TRect): TRect;
		function ObjectRect (const Rect: TRect): TRect;
	end;

	TObjectProperty = (
		opName,
		opPosition,
		opAnchors,
		opScalingAnchorsOnly,
		opLineWidth,
		opLineColor,
		opFillColor,
		opLineStart,
		opLineEnd,
		opLineStyle,
		opCornerRadius,
		opTextXAlign,
		opTextYAlign,
		opBlockAlignOnly,
		opMargin,
		opText,
		opTextColor,
		opCustomLinks,
		opRectangleType,
		opBoundsOptions,
		opAngle,
		opBitmap,
		opAlphaBitmap,
		opMetafile,
		opHalftoneStretch,
		opAlphaValue,
		opCurveType
	);
	
	TObjectProperties = set of TObjectProperty;

	TObjectAnchors = set of (oaLeft,oaRight,oaTop,oaBottom,oaHorzScale,oaVertScale);
	PObjectAnchors = ^TObjectAnchors;

	PFloatPointArray = ^TFloatPointArray;

	TBaseObjectList = class; // Forward

	TBaseObjectClass = class of TBaseObject;
	
	TBaseObject = class(TStreamClass)
	protected
		FPosition : TRect;
		FSelected : Boolean;
		FNotifyObjects : TObjectList;
		FOwner : TBaseObjectList;
		//procedure SetPosition(const Position: TRect); virtual;
		function GetProperty(Index: TObjectProperty): Integer; virtual;
		procedure SetProperty(Index: TObjectProperty; Value: Integer); virtual;
		// Notification of link object movement
		function ObjectMoved(LinkObject: TBaseObject): Boolean; virtual;
		// Notification of link object deletion
		procedure ObjectDeleted(LinkObject: TBaseObject); virtual;
		// Notification of link point deletion
		procedure LinkPointDeleted(LinkObject: TBaseObject; LinkIndex: Integer); virtual;
		// Notify all FNotifyObjects of deleted link point
		procedure NotifyLinkPointDeleted(LinkIndex: Integer);
		// Recalculate links to other objects
		procedure ResetLinkIndices; virtual;
		procedure ResetLinkObjects; virtual;
	public
		Links : TFloatPointArray;
		Name : string;
		Anchors : TObjectAnchors;
		TreeNode : TObject;
		property Owner: TBaseObjectList read FOwner;
		constructor CreateNew(PropertyObject: TBaseObject=nil); virtual; abstract;
		destructor Destroy; override;
		function CreateCopy: TBaseObject; virtual; abstract;
		procedure Assign(Other: TObject); override;

		function GetBounds: TRect; virtual;
		property Position: TRect read FPosition write FPosition;
		property Top: Integer read FPosition.Top;
		property Left: Integer read FPosition.Left;
		function Width: Integer;
		function Height: Integer;

		property Selected: Boolean read FSelected write FSelected;

		procedure Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer); virtual;
		procedure DrawSelected(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer); virtual;

		function ValidProperties: TObjectProperties; virtual;
		property Properties[PropertyIndex: TObjectProperty]: Integer read GetProperty write SetProperty; default;
		function Hint: string; virtual;

		function Move(DX,DY: Integer; Handle: Integer; const Grid: TPoint; Shift: TShiftState): TPoint; virtual;
		procedure Scale(const ScaleX,ScaleY: Double; const Center: TPoint); virtual;
		procedure Rotate(const Angle: Double; FlipLR,FlipUD: Boolean; const Center: TPoint); virtual;
		procedure NotifyMovementDone; virtual;

		procedure AddNotifyObject(Obj: TBaseObject);
		procedure RemoveNotifyObject(Obj: TBaseObject);
		function GetLinkPosition(Index: Integer): TPoint;
		// Notify all FNotifyObjects of movement
		procedure NotifyMovement;

		class function Identifier: Integer; virtual; abstract;
		procedure SaveToStream(Stream: TBaseStream); override;
		procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); reintroduce; virtual;
	end;

	TBaseObjectArray = array[0..255] of TBaseObject;
	PBaseObjectArray = ^TBaseObjectArray;

	TBaseObjectList = class(TDynamicObjectList)
	private
		FObjects : PBaseObjectArray;
	public
		constructor Create;
		property Objects: PBaseObjectArray read FObjects;
		function Add(NewObject: TBaseObject): Integer;

		procedure Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo); virtual;
		procedure DrawSelected(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);

		function GetObjectAt(X,Y: Integer; var CanvasInfo: TCanvasInfo): TBaseObject;
		function Select(const Rect: TRect; ZBuffer: TBitmap): TBaseObject;
		procedure SelectAll;
		procedure DeselectAll;
		function IndexInSelection(Obj: TBaseObject): Integer;
		procedure DeleteSelected;
		procedure MoveSelectedToFront;
		procedure MoveSelectedToBack;
		procedure MoveObjectToFront(Obj: TBaseObject);
		procedure MoveObjectToBack(Obj: TBaseObject);
		// Recalculate links to other objects
		procedure ResetLinkIndices;
		procedure ResetLinkObjects;
		function SelectCount: Integer;
		function LastSelected: TBaseObject;
		// Get rectangle around all objects, including line width
		function GetBounds: TRect;
		function GetSelectedBounds: TRect;
		// Get rectangle around all objects, excluding line width
		function GetInnerBounds: TRect;
		// Set property of all selected objects
		procedure SetMemberProperty(Index: TObjectProperty; Value: Integer; SetAlways: Boolean);
		function MoveSelected(DX,DY: Integer; Handle: Integer; const Grid: TPoint; Shift: TShiftState): TPoint;
		procedure RotateSelected(const Angle: Double; FlipLR,FlipUD: Boolean; const Center: TPoint);
		procedure NotifyMovementDone;

		procedure SaveToStream(Stream: TBaseStream); override;
		procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); reintroduce; virtual;
	end;

	TDiagramLayer = class(TBaseObjectList)
	public
		DrawColor : TColor; // Unused, probably with value -1
		procedure SaveToStream(Stream: TBaseStream); override;
		procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); override;
		procedure SaveSelected(Stream: TBaseStream);
		procedure LoadSelected(Stream: TBaseStream);
	end;
	
	TDiagramLayerArray = array[0..255] of TDiagramLayer;
	PDiagramLayerArray = ^TDiagramLayerArray;





	TDiagramPage = class(TDynamicObjectList)
	private
		FLayers : PDiagramLayerArray;
		FName : string;
	public
		Width, Height : Integer;
		property RawName: string read FName write FName;
		function GetName(PageIndex: Integer): string;
		constructor Create;
		property Layers: PDiagramLayerArray read FLayers;
		procedure New(Template: TDiagramPage=nil);
		procedure DrawPaper(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);
		procedure Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);
		procedure SaveToStream(Stream: TBaseStream); override;
		procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); reintroduce; virtual;
	end;
  TPageArray = array[0..255] of TDiagramPage;
  PPageArray = ^TPageArray;





	TDiagramHeader = packed record
		DDd         : string[3];
		FileVersion : Word;
	end;




									 
  TDiagramContainer = class(TDynamicObjectList)
    private
      FPages : PPageArray;
    public
      DefaultFontName  : string;
      DefaultFontSize  : Integer;
      DefaultFontStyle : Integer;
      Stencil : TDiagramLayer;

      constructor Create;
      destructor Destroy; override;
      procedure New;
      property Pages: PPageArray read FPages;

      procedure SaveToStream(Stream: TBaseStream); override;
      procedure LoadFromStream(Stream: TBaseStream); override;
    end;




		
	TPropertyObject = class(TBaseObject)
		public
			Valid : TObjectProperties;
			Values : array[TObjectProperty] of Integer;
			List : TBaseObjectList;
			constructor CreateNew(PropertyObject: TBaseObject); override;
			function GetProperty(Index: TObjectProperty): Integer; override;
			procedure SetProperty(Index: TObjectProperty; Value: Integer); override;
			function ValidProperties: TObjectProperties; override;
			class function Identifier: Integer; override;
			function CreateCopy: TBaseObject; override;
		end;





function ExtractObjectName(const ClassName: string): string;

procedure PrepareSelectMarkerCanvas(Canvas: TCanvas);
procedure DrawSelectMarker(Canvas: TCanvas; X,Y: Integer);

// Scale bitmap by 1/Antialising
procedure ScaleForAntialiasing(var Bitmap: TFastBitmap; Antialiasing: Integer);

procedure RegisterDesignerClipboardFormat();





var
	DesignerClipboardFormat : Integer = 0;





resourcestring
  rsInvalidDiagram = 'Invalid diagram';
  rsPageD = 'Page %d';
  rsFileFromLaterProgramVersion = 'File from later program version';




























implementation

uses Types, ShapeObject, LineObject, PictureObject, GroupObject, FlowchartObject,
  BitmapAntialiasingScaling;

procedure UnionRect(var Rect: TRect; const R2: TRect);
begin
  if R2.Left<Rect.Left then Rect.Left:=R2.Left;
  if R2.Top<Rect.Top then Rect.Top:=R2.Top;
  if R2.Right>Rect.Right then Rect.Right:=R2.Right;
  if R2.Bottom>Rect.Bottom then Rect.Bottom:=R2.Bottom;
end;

procedure RegisterDesignerClipboardFormat;
begin
  DesignerClipboardFormat:=RegisterClipboardFormat('Diagram Designer diagram');
end;

function ExtractObjectName(const ClassName: string): string;
begin
  Result:=Copy(ClassName,2,Length(ClassName)-7);
end;

// Do antialiasing scaling
procedure ScaleForAntialiasing(var Bitmap: TFastBitmap; Antialiasing: Integer);
var
  AntialiasBitmap : TFastBitmap;
begin
  if Antialiasing>1 then
  begin
    AntialiasBitmap:=TFastBitmap.Create;
    try
      AntialiasBitmap.New(Bitmap.Width div Antialiasing,Bitmap.Height div Antialiasing,Bitmap.PixelFormat);
      if (Antialiasing=2) and (Bitmap.PixelFormat=pf24bit) then
        BitmapAntialiasingScaleHalf(Bitmap,AntialiasBitmap)
      else
        HalftoneStretchDraw(Bitmap,AntialiasBitmap.Canvas,Rect(0,0,AntialiasBitmap.Width,AntialiasBitmap.Height));
      SwapDWords(Bitmap,AntialiasBitmap);
    finally
      AntialiasBitmap.Free;
    end;
  end;
end;

//==============================================================================================================================
// TCanvasInfo
//==============================================================================================================================
function TCanvasInfo.CanvasPoint(const Point: TPoint): TPoint;
begin
  Result.X:=Round(Point.X*Scale.X)+Offset.X;
  Result.Y:=Round(Point.Y*Scale.Y)+Offset.Y;
end;

function TCanvasInfo.CanvasPoint(const X,Y: Double): TPoint;
begin
  Result.X:=Round(X*Scale.X)+Offset.X;
  Result.Y:=Round(Y*Scale.Y)+Offset.Y;
end;

function TCanvasInfo.ObjectPoint(const Point: TPoint): TPoint;
begin
  Result.X:=Round((Point.X-Offset.X)/Scale.X);
  Result.Y:=Round((Point.Y-Offset.Y)/Scale.Y);
end;

function TCanvasInfo.CanvasRect(const Rect: TRect): TRect;
begin
  Result.TopLeft:=CanvasPoint(Rect.TopLeft);
  Result.BottomRight:=CanvasPoint(Rect.BottomRight);
end;

function TCanvasInfo.CanvasRect1(const Rect: TRect): TRect;
begin
  Result.TopLeft:=CanvasPoint(Rect.TopLeft);
  Result.BottomRight:=CanvasPoint(Rect.BottomRight);
  Inc(Result.Right);
  Inc(Result.Bottom);
end;

function TCanvasInfo.ObjectRect(const Rect: TRect): TRect;
begin
  Result.TopLeft:=ObjectPoint(Rect.TopLeft);
  Result.BottomRight:=ObjectPoint(Rect.BottomRight);
end;

//=====================================================================================================
// TBaseObject
//=====================================================================================================
destructor TBaseObject.Destroy;
var
  I : Integer;
begin
  inherited;
  if Assigned(FNotifyObjects) then
  begin
    for I:=0 to FNotifyObjects.Count-1 do TBaseObject(FNotifyObjects.Items[I]).ObjectDeleted(Self);
    FNotifyObjects.Free;
  end;
end;

procedure TBaseObject.Assign(Other: TObject);
var
  I : TObjectProperty;
  ValidProperties : TObjectProperties;
begin
  if Other is TBaseObject then
  begin
    ValidProperties:=TBaseObject(Other).ValidProperties;
    for I:=Low(TObjectProperty) to High(TObjectProperty) do
      if I in ValidProperties then Properties[I]:=TBaseObject(Other).Properties[I];
    FPosition:=TBaseObject(Other).FPosition;
  end
  else inherited;
end;

procedure TBaseObject.Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer);

  procedure DrawLink(X,Y: Integer);
  begin
    with Canvas do
    begin
      MoveTo(X-LinkMarkerSize,Y-LinkMarkerSize);
      LineTo(X+LinkMarkerSize+1,Y+LinkMarkerSize+1);
      MoveTo(X+LinkMarkerSize,Y-LinkMarkerSize);
      LineTo(X-LinkMarkerSize-1,Y+LinkMarkerSize+1);
    end;
  end;

var
  CanvasRect : TRect;
  I, ObjWidth, ObjHeight : Integer;
begin
  if CanvasInfo.DrawMode=dmEditing then
  begin
    if Length(Links)>0 then
    begin
      CanvasRect:=CanvasInfo.CanvasRect(Position);
      ObjWidth:=CanvasRect.Right-CanvasRect.Left;
      ObjHeight:=CanvasRect.Bottom-CanvasRect.Top;
      with Canvas.Pen do
      begin
        Style:=psSolid;
        Width:=1;
        Color:=clRed;
      end;
      for I:=0 to High(Links) do with Links[I] do
        DrawLink(CanvasRect.Left+Round(X*ObjWidth),CanvasRect.Top+Round(Y*ObjHeight));
    end;
  end;
end;

var
  BrushBitmap : TBitmap;

procedure PrepareSelectMarkerCanvas(Canvas: TCanvas);
begin
  if Win32Platform>=VER_PLATFORM_WIN32_NT then Canvas.Brush.Bitmap:=BrushBitmap
  else
  begin
    Canvas.Brush.Style:=bsSolid;
    Canvas.Brush.Color:=TColor($A0A0A0);;
  end;
end;

procedure DrawSelectMarker(Canvas: TCanvas; X,Y: Integer);
begin
  Canvas.FrameRect(Bounds(X-MarkerBoxSize,Y-MarkerBoxSize,MarkerBoxSize*2+1,MarkerBoxSize*2+1));
end;

procedure TBaseObject.DrawSelected(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer);

  procedure DrawFocusRect(X,Y,Marker: Integer);
  var
    BoxRect : TRect;
  begin
    BoxRect:=Rect(X-MarkerBoxSize,Y-MarkerBoxSize,X+(MarkerBoxSize+1),Y+(MarkerBoxSize+1));
    Canvas.FrameRect(BoxRect);
    with CanvasInfo, ZBuffer.Canvas do
    begin
      Brush.Color:=Index or (Marker shl 16);
      FillRect(BoxRect);
    end;
  end;

//  1 5 2
//  7 0 8
//  3 6 4
var
  CanvasRect : TRect;
begin
  if Selected then
  begin
    PrepareSelectMarkerCanvas(Canvas);
    CanvasRect:=CanvasInfo.CanvasRect(Position);
    with CanvasRect do
    begin
      DrawFocusRect((Left+Right) div 2,Top,5);
      DrawFocusRect((Left+Right) div 2,Bottom,6);
      DrawFocusRect(Left,(Top+Bottom) div 2,7);
      DrawFocusRect(Right,(Top+Bottom) div 2,8);

      DrawFocusRect(Left,Top,1);
      DrawFocusRect(Right,Top,2);
      DrawFocusRect(Left,Bottom,3);
      DrawFocusRect(Right,Bottom,4);
    end;
  end;
end;

{procedure TBaseObject.SetPosition(const Position: TRect);
begin
  FPosition:=Position;
end;}

function TBaseObject.GetBounds: TRect;
begin
  Result:=FPosition;
end;

function TBaseObject.GetLinkPosition(Index: Integer): TPoint;
begin
  Assert(Index<Length(Links));
  Result.X:=FPosition.Left+Round(Links[Index].X*(FPosition.Right-FPosition.Left));
  Result.Y:=FPosition.Top+Round(Links[Index].Y*(FPosition.Bottom-FPosition.Top));
end;

function TBaseObject.ValidProperties: TObjectProperties;
begin
  Result:=[opName,opAnchors];
end;

function TBaseObject.GetProperty(Index: TObjectProperty): Integer;
begin
  case Index of
    opName    : Result:=Integer(@Name);
    opAnchors : Result:=Integer(@Anchors);
    else raise Exception.Create('Invalid property for '+ClassName+': '+IntToStr(Integer(Index)));
  end;
end;

procedure TBaseObject.SetProperty(Index: TObjectProperty; Value: Integer);
begin
  case Index of
    opName    : Name:=PString(Value)^;
    opAnchors : Anchors:=PObjectAnchors(Value)^;
  end;
end;

function TBaseObject.Hint: string;
begin
  Result:='';
end;

function TBaseObject.Width: Integer;
begin
  with FPosition do Result:=Right-Left;
end;

function TBaseObject.Height: Integer;
begin
  with FPosition do Result:=Bottom-Top;
end;

procedure TBaseObject.AddNotifyObject(Obj: TBaseObject);
begin
  if FNotifyObjects=nil then
  begin
    FNotifyObjects:=TObjectList.Create;
    FNotifyObjects.OwnsObjects:=False;
  end;
  FNotifyObjects.Add(Obj);
end;

procedure TBaseObject.RemoveNotifyObject(Obj: TBaseObject);
begin
  FNotifyObjects.Delete(FNotifyObjects.IndexOf(Obj));
end;

function TBaseObject.ObjectMoved(LinkObject: TBaseObject): Boolean;
begin
  Assert(False);
  Result:=False;
end;

procedure TBaseObject.ObjectDeleted(LinkObject: TBaseObject);
begin
  Assert(False);
end;

procedure TBaseObject.LinkPointDeleted(LinkObject: TBaseObject; LinkIndex: Integer);
begin
  Assert(False);
end;

procedure TBaseObject.ResetLinkIndices;
begin
end;

procedure TBaseObject.ResetLinkObjects;
begin
end;

function TBaseObject.Move(DX,DY,Handle: Integer; const Grid: TPoint; Shift: TShiftState): TPoint;

  function OffsetX(X: Integer): Integer;
  begin
    Result:=RoundInt(X+DX,Grid.X);
  end;

  function OffsetY(Y: Integer): Integer;
  begin
    Result:=RoundInt(Y+DY,Grid.Y);
  end;

var
  BestOffset : TPoint;
  Dist, BestDist, I, ObjWidth, ObjHeight, LX, LY, NewLX, NewLY : Integer;

begin
  //  1 5 2
  //  7 0 8
  //  3 6 4
  case Handle of
    0 : begin
          if Links=nil then Result:=Point(OffsetX(0),OffsetY(0))
          else
          begin
            ObjWidth:=Width;
            ObjHeight:=Height;
            BestDist:=MaxInt;
            for I:=0 to High(Links) do with Links[I] do
            begin
              LX:=FPosition.Left+Round(X*ObjWidth);
              NewLX:=OffsetX(LX);
              LY:=FPosition.Top+Round(Y*ObjHeight);
              NewLY:=OffsetY(LY);
              Dist:=Sqr(LX+DX-OffsetX(LX))+Sqr(LY+DY-OffsetY(LY));
              if Dist<BestDist then
              begin
                BestDist:=Dist;
                BestOffset.X:=NewLX-LX;
                BestOffset.Y:=NewLY-LY;
              end;
            end;
            Result:=BestOffset;
          end;
          OffsetRect(FPosition,Result.X,Result.Y);      
        end;
    1 : begin
          Result.X:=Min(OffsetX(FPosition.Left),FPosition.Right)-FPosition.Left;
          Inc(FPosition.Left,Result.X);
          Result.Y:=Min(OffsetY(FPosition.Top),FPosition.Bottom)-FPosition.Top;
          Inc(FPosition.Top,Result.Y);
          if ssShift in Shift then
          begin
            Dec(FPosition.Right,Result.X);
            Dec(FPosition.Bottom,Result.Y);
          end;
        end;
    2 : begin
          Result.X:=Max(OffsetX(FPosition.Right),FPosition.Left)-FPosition.Right;
          Inc(FPosition.Right,Result.X);
          Result.Y:=Min(OffsetY(FPosition.Top),FPosition.Bottom)-FPosition.Top;
          Inc(FPosition.Top,Result.Y);
          if ssShift in Shift then
          begin
            Dec(FPosition.Left,Result.X);
            Dec(FPosition.Bottom,Result.Y);
          end;
        end;
    3 : begin
          Result.X:=Min(OffsetX(FPosition.Left),FPosition.Right)-FPosition.Left;
          Inc(FPosition.Left,Result.X);
          Result.Y:=Max(OffsetY(FPosition.Bottom),FPosition.Top)-FPosition.Bottom;
          Inc(FPosition.Bottom,Result.Y);
          if ssShift in Shift then
          begin
            Dec(FPosition.Right,Result.X);
            Dec(FPosition.Top,Result.Y);
          end;
        end;
    4 : begin
          Result.X:=Max(OffsetX(FPosition.Right),FPosition.Left)-FPosition.Right;
          Inc(FPosition.Right,Result.X);
          Result.Y:=Max(OffsetY(FPosition.Bottom),FPosition.Top)-FPosition.Bottom;
          Inc(FPosition.Bottom,Result.Y);
          if ssShift in Shift then
          begin
            Dec(FPosition.Left,Result.X);
            Dec(FPosition.Top,Result.Y);
          end;
        end;
    5 : begin
          Result.X:=0;
          Result.Y:=Min(OffsetY(FPosition.Top),FPosition.Bottom)-FPosition.Top;
          Inc(FPosition.Top,Result.Y);
          if ssShift in Shift then Dec(FPosition.Bottom,Result.Y);
        end;
    6 : begin
          Result.X:=0;
          Result.Y:=Max(OffsetY(FPosition.Bottom),FPosition.Top)-FPosition.Bottom;
          Inc(FPosition.Bottom,Result.Y);
          if ssShift in Shift then Dec(FPosition.Top,Result.Y);
        end;
    7 : begin
          Result.X:=Min(OffsetX(FPosition.Left),FPosition.Right)-FPosition.Left;
          Inc(FPosition.Left,Result.X);
          Result.Y:=0;
          if ssShift in Shift then Dec(FPosition.Right,Result.X);
        end;
    8 : begin
          Result.X:=Max(OffsetX(FPosition.Right),FPosition.Left)-FPosition.Right;
          Inc(FPosition.Right,Result.X);
          Result.Y:=0;
          if ssShift in Shift then Dec(FPosition.Left,Result.X);
        end;
    else
      begin
        OffsetRect(FPosition,DX,DY); // Handle=-1, move all and ignore grid
        Result.X:=DX;
        Result.Y:=DY;
      end;
  end;
  NotifyMovement;
end;

procedure TBaseObject.Scale(const ScaleX, ScaleY: Double; const Center: TPoint);
begin
  with FPosition.TopLeft do
  begin
    X:=Round((X-Center.X)*ScaleX+Center.X);
    Y:=Round((Y-Center.Y)*ScaleY+Center.Y);
  end;
  with FPosition.BottomRight do
  begin
    X:=Round((X-Center.X)*ScaleX+Center.X);
    Y:=Round((Y-Center.Y)*ScaleY+Center.Y);
  end;
end;

procedure TBaseObject.Rotate(const Angle: Double; FlipLR,FlipUD: Boolean; const Center: TPoint);
var
  I : Integer;
begin
  if Angle<>0 then
  begin
    with RotatePoint(FloatPoint(FPosition.TopLeft),FloatPoint(Center),Angle) do
    begin
      FPosition.TopLeft.X:=Round(X);
      FPosition.TopLeft.Y:=Round(Y);
    end;
    with RotatePoint(FloatPoint(FPosition.BottomRight),FloatPoint(Center),Angle) do
    begin
      FPosition.BottomRight.X:=Round(X);
      FPosition.BottomRight.Y:=Round(Y);
    end;
  end;

  if FlipLR then
  begin
    FPosition.Left:=2*Center.X-FPosition.Left;
    FPosition.Right:=2*Center.X-FPosition.Right;
    if opCustomLinks in ValidProperties then
      for I:=0 to High(Links) do Links[I].X:=1-Links[I].X;
  end;

  if FlipUD then
  begin
    FPosition.Top:=2*Center.Y-FPosition.Top;
    FPosition.Bottom:=2*Center.Y-FPosition.Bottom;
    if opCustomLinks in ValidProperties then
      for I:=0 to High(Links) do Links[I].Y:=1-Links[I].Y;
  end;

  if FPosition.Right<FPosition.Left then SwapDWords(FPosition.Right,FPosition.Left);
  if FPosition.Bottom<FPosition.Top then SwapDWords(FPosition.Bottom,FPosition.Top);

  NotifyMovement;
end;

procedure TBaseObject.NotifyMovementDone;
begin
end;

procedure TBaseObject.NotifyMovement;
var
  I : Integer;
begin
  if Assigned(FNotifyObjects) then
    for I:=FNotifyObjects.Count-1 downto 0 do
      if not TBaseObject(FNotifyObjects.Items[I]).Selected then
      begin
        if not TBaseObject(FNotifyObjects.Items[I]).ObjectMoved(Self) then
          FNotifyObjects.Delete(I);
      end;
end;

procedure TBaseObject.NotifyLinkPointDeleted(LinkIndex: Integer);
var
  I : Integer;
begin
  if Assigned(FNotifyObjects) then
    for I:=FNotifyObjects.Count-1 downto 0 do
      TBaseObject(FNotifyObjects.Items[I]).LinkPointDeleted(Self,LinkIndex);
end;

procedure TBaseObject.SaveToStream(Stream: TBaseStream);
begin
  SaveString16(Name,Stream);
  Stream.Write(FPosition,SizeOf(FPosition));
  Stream.Write(Anchors,SizeOf(Anchors));
end;

procedure TBaseObject.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
begin
  LoadString16(Name,Stream);
  Stream.Read(FPosition,SizeOf(FPosition));
  if FileVersion>=13 then Stream.Read(Anchors,SizeOf(Anchors));
end;

//=====================================================================================================
// TBaseObjectList
//=====================================================================================================

constructor TBaseObjectList.Create;
begin
  inherited Create(FObjects);
end;

function TBaseObjectList.Add(NewObject: TBaseObject): Integer;
begin
  Assert(Count<65535);
  Result:=Count;
  IncCount;
  PObjectArray(FData)^[Result]:=NewObject;
  NewObject.FOwner:=Self;
end;

function TBaseObjectList.GetObjectAt(X,Y: Integer; var CanvasInfo: TCanvasInfo): TBaseObject;
var
  CanvasPoint : TPoint;
  I : Integer;
begin
  CanvasPoint:=CanvasInfo.ObjectPoint(Point(X,Y));
  for I:=Count-1 downto 0 do if PtInRect(Objects[I].Position,CanvasPoint) then
  begin
    Result:=Objects[I];
    Exit;
  end;
  Result:=nil;
end;

procedure TBaseObjectList.Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);
var
  I : Integer;
begin
  for I:=0 to Count-1 do Objects[I].Draw(Canvas,CanvasInfo,I);
end;

procedure TBaseObjectList.DrawSelected(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);
var
  I : Integer;
begin
  for I:=0 to Count-1 do Objects[I].DrawSelected(Canvas,CanvasInfo,I);
end;

function TBaseObjectList.Select(const Rect: TRect; ZBuffer: TBitmap): TBaseObject;
var
  X, Y, X1, X2 : Integer;
  Value : PInteger;
  LastValue : Integer;
begin
  Result:=nil;
  X1:=Rect.Left;
  X2:=Rect.Right;
  if X1<0 then X1:=0
  else if X2>=ZBuffer.Width then X2:=ZBuffer.Width-1;
  LastValue:=-1;
  for Y:=Max(0,Rect.Top) to Min(ZBuffer.Height-1,Rect.Bottom) do
  begin
    Value:=@PIntegerArray(ZBuffer.ScanLine[Y])^[X1];
    for X:=X1 to X2 do
    begin
      if Value^<>LastValue then
      begin
        LastValue:=Value^;
        if LastValue<>$ffffff then
        begin
          Result:=Objects[Swap(LastValue shr 8)];
          Result.Selected:=True;
        end;
      end;
      Inc(Value);
    end;
  end;
end;

procedure TBaseObjectList.SelectAll;
var
  I : Integer;
begin
  for I:=0 to Count-1 do Objects[I].Selected:=True;
end;

procedure TBaseObjectList.DeselectAll;
var
  I : Integer;
begin
  for I:=0 to Count-1 do Objects[I].Selected:=False;
end;

function TBaseObjectList.IndexInSelection(Obj: TBaseObject): Integer;
var
  I : Integer;
begin
  if Obj.Selected then
  begin
    Result:=0;
    for I:=0 to Count-1 do
    begin
      if Objects[I]=Obj then Exit;
      if Objects[I].Selected then Inc(Result);
    end;
  end;
  Result:=-1;
end;

procedure TBaseObjectList.DeleteSelected;
var
  I : Integer;
begin
  for I:=Count-1 downto 0 do if Objects[I].Selected then Delete(I);
  ResetLinkIndices;
end;

procedure TBaseObjectList.MoveSelectedToFront;
var
  Index, I : Integer;
begin
  Index:=0;
  for I:=1 to Count do
  begin
    if Objects[Index].Selected then Move(Index,Count-1)
    else Inc(Index);
  end;
  ResetLinkIndices;
end;

procedure TBaseObjectList.MoveSelectedToBack;
var
  Index, I : Integer;
begin
  Index:=Count-1;
  for I:=1 to Count do
  begin
    if Objects[Index].Selected then Move(Index,0)
    else Dec(Index);
  end;
  ResetLinkIndices;
end;

procedure TBaseObjectList.MoveObjectToFront(Obj: TBaseObject);
begin
  Move(IndexOf(Obj),Count-1);
  ResetLinkIndices;
end;

procedure TBaseObjectList.MoveObjectToBack(Obj: TBaseObject);
begin
  Move(IndexOf(Obj),0);
  ResetLinkIndices;
end;

procedure TBaseObjectList.ResetLinkIndices;
var
  I : Integer;
begin
  for I:=0 to Count-1 do Objects[I].ResetLinkIndices;
end;

procedure TBaseObjectList.ResetLinkObjects;
var
  I : Integer;
begin
  for I:=0 to Count-1 do Objects[I].ResetLinkObjects;
end;

function TBaseObjectList.SelectCount: Integer;
var
  I : Integer;
begin
  Result:=0;
  for I:=0 to Count-1 do if Objects[I].Selected then Inc(Result);
end;

function TBaseObjectList.LastSelected: TBaseObject;
var
  I : Integer;
begin
  for I:=Count-1 downto 0 do if Objects[I].Selected then
  begin
    Result:=Objects[I];
    Exit;
  end;
  Result:=nil;
end;

function TBaseObjectList.GetBounds: TRect;
var
  I : Integer;
begin
  if Count=0 then ZeroMem(Result,SizeOf(Result))
  else
  begin
    Result:=Objects[0].GetBounds;
    for I:=1 to Count-1 do UnionRect(Result,Objects[I].GetBounds);
  end;
end;

function TBaseObjectList.GetSelectedBounds: TRect;
var
  I : Integer;
  First : Boolean;
begin
  First:=True;
  for I:=0 to Count-1 do if Objects[I].Selected then
    if First then
    begin
      Result:=Objects[I].GetBounds;
      First:=False;
    end
    else UnionRect(Result,Objects[I].GetBounds);
  if First then ZeroMem(Result,SizeOf(Result))
end;

function TBaseObjectList.GetInnerBounds: TRect;
var
  I : Integer;
begin
  if Count=0 then ZeroMem(Result,SizeOf(Result))
  else
  begin
    Result:=NormalizeRect(Objects[0].Position);
    for I:=1 to Count-1 do UnionRect(Result,NormalizeRect(Objects[I].Position));
  end;
end;

function TBaseObjectList.MoveSelected(DX,DY: Integer; Handle: Integer; const Grid: TPoint; Shift: TShiftState): TPoint;
var
  I : Integer;
  Obj, Active : TBaseObject;
  MultiSelect : Boolean;
begin
  Active:=nil;
  MultiSelect:=False;
  for I:=0 to Count-1 do
  begin
    Obj:=Objects[I];
    if Obj.Selected then
    begin
      if Active=nil then Active:=Obj
      else
      begin
        if not MultiSelect then
        begin
          MultiSelect:=True;
          Result.X:=RoundInt(DX,Grid.X);
          Result.Y:=RoundInt(DY,Grid.Y);
          Active.Move(Result.X,Result.Y,-1,Grid,[]);
        end;
        Obj.Move(Result.X,Result.Y,-1,Grid,[]); // Multiple objects selected
      end;
    end;
  end;
  if Assigned(Active) and not MultiSelect then Result:=Active.Move(DX,DY,Handle,Grid,Shift); // Single object selected
end;

procedure TBaseObjectList.RotateSelected(const Angle: Double; FlipLR,FlipUD: Boolean; const Center: TPoint);
var
  I : Integer;
begin
  for I:=0 to Count-1 do with Objects[I] do if Selected then Rotate(Angle,FlipLR,FlipUD,Center);
end;

procedure TBaseObjectList.NotifyMovementDone;
var
  I : Integer;
begin
  for I:=0 to Count-1 do with Objects[I] do if Selected then NotifyMovementDone;
end;

procedure TBaseObjectList.SetMemberProperty(Index: TObjectProperty; Value: Integer; SetAlways: Boolean);
var
  I : Integer;
begin
  for I:=0 to Count-1 do if Objects[I].Selected then
  begin
    if Objects[I] is TGroupObject then TGroupObject(Objects[I]).Group.SetMemberProperty(Index,Value,SetAlways)
    else if SetAlways or (Index in Objects[I].ValidProperties) then Objects[I].Properties[Index]:=Value;
  end;
end;

procedure TBaseObjectList.SaveToStream(Stream: TBaseStream);
var
  ObjectCount : Word;
  I, ObjectType : Integer;
begin
  ObjectCount:=Count;
  Stream.Write(ObjectCount,2);
  for I:=0 to Count-1 do with Objects[I] do
  begin
    ObjectType:=Identifier;
    Stream.Write(ObjectType,1);
    SaveToStream(Stream);
  end;
end;

type TOpenBaseConnectorObject = class(TBaseConnectorObject);

procedure TBaseObjectList.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
var
  ObjectType : Byte;
  ObjectCount : Word;
  I, LinkOffset, Link : Integer;
  NewObject : TBaseObject;
begin
  LinkOffset:=Count;
  Stream.Read(ObjectCount,2);
  for I:=1 to ObjectCount do
  begin
    Stream.Read(ObjectType,1);
    case ObjectType of
      otTextObject      : NewObject:=TTextObject.Create;
      otRectangleObject : NewObject:=TRectangleObject.Create;
      otEllipseObject   : NewObject:=TEllipseObject.Create;
      otStraightLine    : NewObject:=TStraightLineObject.Create;
      otConnectorLine   : NewObject:=TAxisLineObject.Create;
      otBitmapObject    : NewObject:=TBitmapObject.Create;
      otMetafileObject  : NewObject:=TMetafileObject.Create;
      otGroupObject     : NewObject:=TGroupObject.Create;
      otPolygonObject   : NewObject:=TPolygonObject.Create;
      otFlowchartObject : NewObject:=TFlowchartObject.Create;
      otCurveLine       : NewObject:=TCurveLineObject.Create;
      otInheritedLayer  : NewObject:=TInheritedLayerObject.Create;
    else
      raise Exception.Create(rsInvalidDiagram);
    end;
    NewObject.LoadFromStream(Stream,FileVersion);
    if NewObject is TBaseConnectorObject then // Update link indices when loading to a non-empty list
      with TOpenBaseConnectorObject(NewObject) do
        for Link:=1 to 2 do
          with FLinkObjects[Link] do if ObjectIndex>=0 then Inc(ObjectIndex,LinkOffset);
    Add(NewObject);
  end;
  ResetLinkObjects;
end;

//=====================================================================================================
// TDiagramLayer
//=====================================================================================================
procedure TDiagramLayer.SaveToStream(Stream: TBaseStream);
begin
  Stream.Write(DrawColor,4);
  inherited;
end;

procedure TDiagramLayer.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
begin
  Stream.Read(DrawColor,4);
  inherited;
end;

procedure TDiagramLayer.SaveSelected(Stream: TBaseStream);
var
  ObjectCount : Word;
  I, ObjectType : Integer;
  Obj : TBaseObject;
begin
  Stream.Write(DrawColor,4);

  ObjectCount:=SelectCount;
  Stream.Write(ObjectCount,2);
  for I:=0 to Count-1 do
  begin
    Obj:=Objects[I];
    with Obj do if Selected then
    begin
      ObjectType:=Identifier;
      Stream.Write(ObjectType,1);
      if Obj is TBaseConnectorObject then TBaseConnectorObject(Obj).SaveSelected(Stream)
      else SaveToStream(Stream);
    end;
  end;
end;

procedure TDiagramLayer.LoadSelected(Stream: TBaseStream);
var
  I : Integer;
begin
  Stream.Read(I,4); // Ignore DrawColor

  I:=Count;
  inherited LoadFromStream(Stream,CurrentFileVersion);
  for I:=I to Count-1 do Objects[I].Selected:=True;
end;

//=====================================================================================================
// TDiagramPage
//=====================================================================================================
constructor TDiagramPage.Create;
begin
  inherited Create(FLayers);
end;

procedure TDiagramPage.New(Template: TDiagramPage);
begin
  Clear;
  Add(TDiagramLayer.Create);
  Layers[0].DrawColor:=-1;
  if Assigned(Template) then
  begin
    Width:=Template.Width;
    Height:=Template.Height;
  end
  else // A4
  begin
    Width:=DesignerDPmm*210;
    Height:=DesignerDPmm*297;
  end;
end;

procedure TDiagramPage.DrawPaper(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);
const
  ShadowSize = DesignerDPmm*1;
var
  Shadow : Integer;
  Paper : TRect;
begin
  with Canvas do
  begin
    Brush.Style:=bsSolid;
    if CanvasInfo.DrawMode=dmEditing then Brush.Color:=$f0f7f9
    else Brush.Color:=clWhite;
    Pen.Color:=clBlack;
    Pen.Style:=psSolid;
    Pen.Width:=0;

    Paper.TopLeft:=CanvasInfo.CanvasPoint(Point(0,0));
    Paper.BottomRight:=CanvasInfo.CanvasPoint(Point(Width,Height));
    Rectangle(Paper);

    Shadow:=Round(ShadowSize*CanvasInfo.Scale.X);
    Brush.Color:=clDkGray;
    FillRect(Rect(Paper.Right,Paper.Top+Shadow,Paper.Right+Shadow,Paper.Bottom));
    FillRect(Rect(Paper.Left+Shadow,Paper.Bottom,Paper.Right+Shadow,Paper.Bottom+Shadow));
  end;
end;

procedure TDiagramPage.Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);
var
  I : Integer;
begin
  if Assigned(CanvasInfo.Container) then CanvasInfo.Container.Stencil.Draw(Canvas,CanvasInfo);
  for I:=0 to Count-1 do Layers[I].Draw(Canvas,CanvasInfo);
end;

procedure TDiagramPage.SaveToStream(Stream: TBaseStream);
var
  LayerCount : Word;
  I : Integer;
begin
  Stream.Write(Width,4);
  Stream.Write(Height,4);
  SaveString16(FName,Stream);

  LayerCount:=Count;
  Stream.Write(LayerCount,2);
  for I:=0 to Count-1 do Layers[I].SaveToStream(Stream);
end;

procedure TDiagramPage.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
var
  LayerCount : Word;
  I : Integer;              
begin
  Stream.Read(Width,4);
  Stream.Read(Height,4);
  LoadString16(FName,Stream); 

  Stream.Read(LayerCount,2);
  for I:=1 to LayerCount do Layers[Add(TDiagramLayer.Create)].LoadFromStream(Stream,FileVersion);
end;

function TDiagramPage.GetName(PageIndex: Integer): string;
begin
  if FName='' then Result:=Format(rsPageD,[PageIndex+1])
  else Result:=FName;
end;

//=====================================================================================================
// TDiagramContainer
//=====================================================================================================
constructor TDiagramContainer.Create;
begin
  inherited Create(FPages);
  OwnsObjects:=True;
  Stencil:=TDiagramLayer.Create;
end;

destructor TDiagramContainer.Destroy;
begin
  inherited;
  Stencil.Free;
end;

procedure TDiagramContainer.New;
begin
  Clear;
  Add(TDiagramPage.Create);
  Pages[0].New;
  Stencil.Clear;
end;

procedure TDiagramContainer.SaveToStream(Stream: TBaseStream);
var
  Header : TDiagramHeader;
  Deflate : TDeflateStream;
  I : LongInt;
  PageCount : Word;
begin
  Header.DDd:='DDd';
  Header.FileVersion:=CurrentFileVersion;
  Stream.Write(Header,SizeOf(Header));
  Deflate:=TDeflateStream.Create(Stream,fmWrite);
  try
    SaveString16(DefaultFontName,Deflate);
    Deflate.Write(DefaultFontSize,4);
    Deflate.Write(DefaultFontStyle,4);

    PageCount:=Count;
    Deflate.Write(PageCount,2);
    for I:=0 to Count-1 do Pages[I].SaveToStream(Deflate);
    Stencil.SaveToStream(Deflate);
  finally
    Deflate.Free;
  end;
end;

procedure TDiagramContainer.LoadFromStream(Stream: TBaseStream);
var
  Header : TDiagramHeader;
  Deflate : TDeflateStream;
  I : LongInt;
  PageCount : Word;
begin
  Stream.Read(Header,SizeOf(Header));
  if Header.DDd<>'DDd' then raise Exception.Create(rsInvalidDiagram);
  if Header.FileVersion>CurrentFileVersion then raise Exception.Create(rsFileFromLaterProgramVersion);
  Clear;
  Stencil.Clear;
  Deflate:=TDeflateStream.Create(Stream,fmRead);
  try
    LoadString16(DefaultFontName,Deflate);
    Deflate.Read(DefaultFontSize,4);
    Deflate.Read(DefaultFontStyle,4);

    Deflate.Read(PageCount,2);
    for I:=1 to PageCount do Pages[Add(TDiagramPage.Create)].LoadFromStream(Deflate,Header.FileVersion);
    if Header.FileVersion>=5 then Stencil.LoadFromStream(Deflate,Header.FileVersion);
  finally
    Deflate.Free;
  end;
end;

//==============================================================================================================================
// TPropertyObject
//==============================================================================================================================
constructor TPropertyObject.CreateNew(PropertyObject: TBaseObject);
begin
  Assert(False);
  inherited;
end;

function TPropertyObject.ValidProperties: TObjectProperties;
begin
  Result:=Valid;
end;

function TPropertyObject.GetProperty(Index: TObjectProperty): Integer;
begin
  if Index in Valid then Result:=Values[Index]
  else Result:=inherited GetProperty(Index);
end;

procedure TPropertyObject.SetProperty(Index: TObjectProperty; Value: Integer);
begin
  Include(Valid,Index);
  Values[Index]:=Value;
end;

class function TPropertyObject.Identifier: Integer;
begin
  Result:=-1;
  Assert(False);
end;

function TPropertyObject.CreateCopy: TBaseObject;
begin
  Result:=nil;
  Assert(False);
end;

//==============================================================================================================================

initialization
  BrushBitmap:=TBitmap.Create;
  BrushBitmap.Width:=2;
  BrushBitmap.Height:=2;
  BrushBitmap.Canvas.Pixels[0,0]:=0;
  BrushBitmap.Canvas.Pixels[1,1]:=0;
finalization
  BrushBitmap.Free;
end.

