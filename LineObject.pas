unit LineObject;

interface

uses
	Windows, 
	SysUtils, 
	MathUtils, 
	Graphics, 
	DiagramBase, 
	Math, 
	Types, 
	Streams, 
	ShapeObject, 
	Classes, 
	MemUtils, 
	GroupObject;





resourcestring
	rsNone         = 'None';
	rsArrow1       = 'Arrow 1';
	rsArrow2       = 'Arrow 2';
	rsArrow3       = 'Arrow 3';
	rsDoubleArrow3 = 'Double arrow';
	rsStop         = 'Stop';
	rsCircle       = 'Circle';
	rsBall         = 'Ball';
	rsDiamond      = 'Diamond';





const
	leNone         = 0;
	leStop         = $11;
	leCircle       = $21;
	leBall         = $22;
	leDiamond      = $23;
	leArrow1       = $31;
	leArrow2       = $32;
	leArrow3       = $33;
	leDoubleArrow1 = $41;

	LineEnds : array[0..8] of Integer = (
		leNone, 
		leArrow1, 
		leArrow2, 
		leArrow3, 
		leDoubleArrow1, 
		leStop, 
		leCircle, 
		leBall, 
		leDiamond
	);

	LineEndNames : array[0..High(LineEnds)] of Pointer =
	(
		@rsNone, 
		@rsArrow1, 
		@rsArrow2, 
		@rsArrow3, 
		@rsDoubleArrow3, 
		@rsStop, 
		@rsCircle, 
		@rsBall, 
		@rsDiamond
	);

  lsSolid    = 0;
  lsDotted1  = $11;
  lsDotted2  = $12;
  lsShort1   = $21;
  lsShort2   = $22;
  lsLong1    = $31;
  lsLong2    = $32;
  lsDashDot1 = $41;
  lsDashDot2 = $42;
  lsDashDash = $51;
  lsOutline  = $61;

	LineStyles : array[0..10] of Integer =
	(
		lsSolid, 
		lsDotted1, 
		lsDotted2, 
		lsShort1, 
		lsShort2, 
		lsLong1, 
		lsLong2, 
		lsDashDot1, 
		lsDashDot2, 
		lsDashDash, 
		lsOutline
	);





type
	RLinkObject = record
		Obj:         TBaseObject;
		ObjectIndex: Integer;
		LinkIndex:   Integer;
	end;


	TBaseConnectorObject = class(TBaseLineObject)
	protected
		FStartMarker, FEndMarker: Integer;
		FLineStyle: Integer;
		FFillColor: TColor;
		FObjectMovedRunning: Boolean;
		FLinkObjects: array[1..2] of RLinkObject;
		function GetProperty(Index: TObjectProperty): Integer; override;
		procedure SetProperty(Index: TObjectProperty; Value: Integer); override;
		//procedure SetPosition(const Position: TRect); override;
		function ObjectMoved(LinkObject: TBaseObject): Boolean; override;
		procedure ObjectDeleted(LinkObject: TBaseObject); override;
		procedure LinkPointDeleted(LinkObject: TBaseObject; LinkIndex: Integer); override;
		procedure ResetLinkIndices; override;
		procedure ResetLinkObjects; override;
		procedure DrawLineStyle(Canvas: TCanvas; const P1, P2: TPoint; const CanvasInfo: TCanvasInfo);
		procedure DrawLineEnd(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Pos: TPoint; const Direction: TPoint; Kind: Integer);
	public
		constructor CreateNew(PropertyObject: TBaseObject=nil); override;
		constructor Create;
		destructor Destroy; override;
		property P1: TPoint read FPosition.TopLeft write FPosition.TopLeft;
		property P2: TPoint read FPosition.BottomRight write FPosition.BottomRight;
		function GetBounds: TRect; override;
		function ValidProperties: TObjectProperties; override;
		procedure DrawSelected(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer); override;

		procedure Rotate(const Angle: Double; FlipLR, FlipUD: Boolean; const Center: TPoint); override;
		function Move(DX, DY: Integer; Handle: Integer; const Grid: TPoint; Shift: TShiftState): TPoint; override;

		procedure MakeLink(Point: Integer; LinkObject: TBaseObject; ALinkIndex: Integer); virtual;
		procedure DisconnectLink(Point: Integer);
		function HasLinkObject(Point: Integer): Boolean;

		procedure SaveToStream(Stream: TBaseStream); override;
		procedure SaveSelected(Stream: TBaseStream); virtual;
		procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); override;
	end;


	TStraightLineObject = class(TBaseConnectorObject)
	public
		function CreateCopy(): TBaseObject; override;
		class function Identifier(): Integer; override;
		procedure Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer); override;
	end;

	
	TArrowObject = class(TStraightLineObject)
	public
		constructor CreateNew(PropertyObject: TBaseObject=nil); override;
	end;


  TAxisLineObject = class(TBaseConnectorObject)
	protected
		EndDirection : array[1..2] of (ldVertical, ldHorizontal);
		FCornerRadius : Integer;
		procedure ResetLinkObjects; override;
		procedure FindEndDirection(Point: Integer);
		function GetProperty(Index: TObjectProperty): Integer; override;
		procedure SetProperty(Index: TObjectProperty; Value: Integer); override;
	public
		function CreateCopy(): TBaseObject; override;
		class function Identifier(): Integer; override;
		function ValidProperties(): TObjectProperties; override;
		procedure MakeLink(Point: Integer; LinkObject: TBaseObject; ALinkIndex: Integer); override;
		procedure Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer); override;

		procedure SaveToStream(Stream: TBaseStream); override;
		procedure SaveSelected(Stream: TBaseStream); override;
		procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); override;
	end;


	TConnectorObject = class(TAxisLineObject)
	public
		constructor CreateNew(PropertyObject: TBaseObject = nil); override;
	end;


	TCurveLineType = (ctCatmullRom, ctLegacy, ctBezier, ctLineSegments);


	TCurveLineObject = class(TBaseLineObject)
	protected
		Points : array of TPoint;
		FCurveLineType : TCurveLineType;
		procedure UpdatePosition;
		procedure DrawAsLegacySpline(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);
		procedure DrawAsCatmullRomSpline(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);
		procedure DrawAsPolyX(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);
		function GetProperty(Index: TObjectProperty): Integer; override;
		procedure SetProperty(Index: TObjectProperty; Value: Integer); override;
	public
		constructor Create;
		constructor CreateNew(PropertyObject: TBaseObject); override;
		function CreateCopy: TBaseObject; override;
		procedure Assign(Other: TObject); override;

		function Move(DX, DY: Integer; Handle: Integer; const Grid: TPoint; Shift: TShiftState): TPoint; override;
		procedure Scale(const ScaleX, ScaleY: Double; const Center: TPoint); override;
		procedure Rotate(const Angle: Double; FlipLR, FlipUD: Boolean; const Center: TPoint); override;

		class function Identifier: Integer; override;
		function ValidProperties: TObjectProperties; override;
		procedure Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer); override;
		procedure DrawSelected(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer); override;

		procedure SaveToStream(Stream: TBaseStream); override;
		procedure LoadFromStream(Stream: TBaseStream; FileVersion: Integer); override;

		function AddPoint(Where: Integer): Integer;
		function CreatePolygon: TPolygonObject;
	end;





function ExtendLineBy1(const P1, P2: TPoint): TPoint;





resourcestring
	rsNoMorePointsAllowed = 'No more points allowed';
	rsCurveMustBeClosedCatmullRomSpline = 'Curve must be closed Catmull-Rom spline or line segments';


































implementation





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TBaseConnectorObject:

constructor TBaseConnectorObject.Create();
begin
  if not(Assigned(Links)) then
  begin
		SetLength(Links, 2);
		Links[0] := FloatPoint(0, 0);
		Links[1] := FloatPoint(1, 1);
  end;
	inherited Create();
	FLinkObjects[1]. ObjectIndex := -1;
	FLinkObjects[2]. ObjectIndex := -1;
end;





constructor TBaseConnectorObject.CreateNew(PropertyObject: TBaseObject);
begin
  Create();
	FLineWidth := DefaultLineWidth;
	FFillColor := clWhite;
	Name := ExtractObjectName(ClassName);
	if Assigned(PropertyObject) then Assign(PropertyObject);
end;





destructor TBaseConnectorObject.Destroy();
begin
	inherited Destroy();		// TODO: check this, usually inherited Destroy() should be called at the end of Destroy()
	with FLinkObjects[1] do if Assigned(Obj) then Obj.RemoveNotifyObject(Self);
	with FLinkObjects[2] do if Assigned(Obj) then Obj.RemoveNotifyObject(Self);
end;





function TBaseConnectorObject.ValidProperties(): TObjectProperties;
begin
  Result := (inherited ValidProperties()) - [opPosition, opTextYAlign, opMargin] + [opLineStart, opLineEnd, opLineStyle, opBlockAlignOnly, opFillColor];
end;





function TBaseConnectorObject.GetProperty(Index: TObjectProperty): Integer;
begin
	case Index of
		opLineStart : Result := FStartMarker;
		opLineEnd   : Result := FEndMarker;
		opLineStyle : Result := FLineStyle;
		opFillColor : Result := FFillColor;
    else Result := inherited GetProperty(Index);
  end;
end;





procedure TBaseConnectorObject.SetProperty(Index: TObjectProperty; Value: Integer);
begin
  case Index of
		opLineStart: FStartMarker := Value;
		opLineEnd  : FEndMarker   := Value;
		opLineStyle: FLineStyle   := Value;
		opFillColor: FFillColor   := Value;
    else inherited SetProperty(Index, Value);
  end;
end;





function TBaseConnectorObject.GetBounds(): TRect;
var
	HalfLineWidth : Integer;
begin
	if (FLineColor = clNone) then
	begin
		HalfLineWidth := 0;
	end
	else
	begin
		HalfLineWidth := (FLineWidth + 1) div 2;
	end;
	Result.Left   := Min(P1.X, P2.X) - HalfLineWidth;
	Result.Top    := Min(P1.Y, P2.Y) - HalfLineWidth;
	Result.Right  := Max(P1.X, P2.X) + HalfLineWidth;
	Result.Bottom := Max(P1.Y, P2.Y) + HalfLineWidth;
end;





procedure TBaseConnectorObject.DrawLineStyle(Canvas: TCanvas; const P1, P2: TPoint; const CanvasInfo: TCanvasInfo);
var
	X, Y, DX, DY, Dist, P, L1, L2, S: Double;
	I: Integer;
begin
	case FLineStyle of
		lsDotted1:
		begin
			L1 := DesignerDPpoint;
			L2 := DesignerDPpoint;
			S  := DesignerDPpoint;
		end;

		lsDotted2:
		begin
			L1 := DesignerDPpoint;
			L2 := DesignerDPpoint;
			S  := DesignerDPpoint * 2;
		end;

		lsShort1:
		begin
			L1 := DesignerDPpoint * 4;
			L2 := DesignerDPpoint * 4;
			S  := DesignerDPpoint * 2;
		end;

		lsShort2:
		begin
			L1 := DesignerDPpoint * 4;
			L2 := DesignerDPpoint * 4;
			S  := DesignerDPpoint * 8;
		end;

		lsLong1:
		begin
			L1 := DesignerDPpoint * 8;
			L2 := DesignerDPpoint * 8;
			S  := DesignerDPpoint * 4;
		end;

		lsLong2:
		begin
			L1 := DesignerDPpoint * 8;
			L2 := DesignerDPpoint * 8;
			S  := DesignerDPpoint * 8;
		end;

		lsDashDot1:
		begin
			L1 := DesignerDPpoint;
			L2 := DesignerDPpoint * 4;
			S  := DesignerDPpoint * 2;
		end;

		lsDashDot2:
		begin
			L1 := DesignerDPpoint;
			L2 := DesignerDPpoint * 8;
			S  := DesignerDPpoint * 2;
		end;

		lsDashDash :
		begin
			L1 := DesignerDPpoint * 4;
			L2 := DesignerDPpoint * 8;
			S  := DesignerDPpoint * 2;
		end;

		lsOutline:
		begin
			with Canvas do
			begin
				I := Pen.Width;
				with CanvasInfo.CanvasPoint(P1) do MoveTo(X, Y);
				with CanvasInfo.CanvasPoint(P2) do LineTo(X, Y);
				Pen.Color := FFillColor;
				Pen.Width := I div 2;
				with CanvasInfo.CanvasPoint(P1) do LineTo(X, Y);
				Pen.Width := I;
				Pen.Color := FLineColor;
				Exit;
			end;
		end;
		
		else
		begin
			with Canvas do
			begin
				with CanvasInfo.CanvasPoint(P1) do MoveTo(X, Y);
				with CanvasInfo.CanvasPoint(P2) do LineTo(X, Y);
				Exit;
			end;
    end;
	end;
	
  Dist := Sqr(P2.X - P1.X + 0.0) + Sqr(P2.Y - P1.Y + 0.0);
	if (Dist = 0) then
	begin
		Exit;
	end;
	
  Dist := Sqrt(Dist);
  X := P1.X;
  Y := P1.Y;
	DX := (P2.X - P1.X) / Dist;
  DY := (P2.Y - P1.Y) / Dist;
  with Canvas do
  begin
    P := 0;
    repeat
      // Line 1
      with CanvasInfo.CanvasPoint(X, Y) do MoveTo(X, Y);
      P := P + L1;
			if (P >= Dist) then
			begin
				P := Dist - (P - L1);
				with CanvasInfo.CanvasPoint(X + DX * P, Y + DY * P) do LineTo(X, Y);
        break;
      end;
			X := X + DX * L1;
			Y := Y + DY * L1;
      with CanvasInfo.CanvasPoint(X, Y) do LineTo(X, Y);

      // Space 1
      P := P + S;
			if (P >= Dist) then
			begin
				break;
			end;
			X := X + DX * S;
			Y := Y + DY * S;

			// Line 2
			with CanvasInfo.CanvasPoint(X, Y) do MoveTo(X, Y);
			P := P + L2;
			if (P >= Dist) then
			begin
				P := Dist - (P - L2);
				with CanvasInfo.CanvasPoint(X + DX * P, Y + DY * P) do LineTo(X, Y);
				break;
			end;
			X := X + DX * L2;
			Y := Y + DY * L2;
      with CanvasInfo.CanvasPoint(X, Y) do LineTo(X, Y);

      // Space 2
      P := P + S;
			if (P >= Dist) then
			begin
				break;
			end;
      X := X + DX*S;
      Y := Y + DY*S;
    until false;
  end;
end;





procedure TBaseConnectorObject.DrawLineEnd(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Pos: TPoint; const Direction: TPoint; Kind: Integer);
var
	Dir: TFloatPoint;
	Scale, Length: Double;
	R, PenWidth: Integer;
	Poly3: array[1..3] of TPoint;
	Poly4: array[1..4] of TPoint;
	FillColor: TColor;
begin
	Length := Hi(Kind) * DesignerDPpoint * CanvasInfo.Scale.X;
  if ((Pos.X <> Direction.X) or (Pos.Y <> Direction.Y)) then
  begin
    Dir.X := Pos.X - Direction.X;
    Dir.Y := Pos.Y - Direction.Y;
    Scale := Length/Sqrt(Sqr(Dir.X) + Sqr(Dir.Y));
		Dir.X := Dir.X * Scale;
		Dir.Y := Dir.Y * Scale;
  end
	else
	begin
		Dir.Y := 0;
		Dir.X := Length;
	end;
	
  if (FLineStyle = lsOutline) then
  begin
    FillColor := FFillColor;
    PenWidth := Canvas.Pen.Width;
		if Lo(Kind) in [leBall, leDiamond, leArrow2, leArrow3, leDoubleArrow1] then
		begin
			Canvas.Pen.Width := (PenWidth + 2) div 4;
		end;
		if Lo(Kind) in [leArrow2, leArrow3, leDoubleArrow1] then
		begin
			Pos := VectorAdd(Pos, RoundPoint(VectorMult(Dir, PenWidth * 0.9 / Length)));
		end;
  end
  else
  begin
    FillColor := FLineColor;
    PenWidth := 0;
  end;
  with Canvas, Pos do
	case Lo(Kind) of
		leStop:
		begin
			MoveTo(X - Round(Dir.Y), Y + Round(Dir.X));
			LineTo(X + Round(Dir.Y), Y - Round(Dir.X));
		end;

		leCircle:
		begin
			R := Round(Hi(Kind)*FLineWidth*CanvasInfo.Scale.X);
			Brush.Style := bsClear;
			Ellipse(X - R, Y - R, X + R, Y + R);
		end;

		leBall:
		begin
			R := Round(Hi(Kind) * FLineWidth*CanvasInfo.Scale.X);
			Brush.Style := bsSolid;
			Brush.Color := FillColor;
			Ellipse(X - R, Y - R, X + R, Y + R);
		end;

		leDiamond:
		begin
			Brush.Style := bsSolid;
			Brush.Color := FillColor;
			Poly4[1] := Point(X + Round(Dir.X), Y + Round(Dir.Y));
			Poly4[2] := Point(X - Round(Dir.Y), Y + Round(Dir.X));
			Poly4[3] := Point(X - Round(Dir.X), Y - Round(Dir.Y));
			Poly4[4] := Point(X + Round(Dir.Y), Y - Round(Dir.X));
			Polygon(Poly4);
		end;

		leArrow1 :
		begin
			MoveTo(X + Round( - 2*Dir.X - Dir.Y), Y + Round(-2*Dir.Y + Dir.X));
			LineTo(X, Y);
			MoveTo(X + Round(-2*Dir.X + Dir.Y), Y + Round(-2*Dir.Y-Dir.X));
			LineTo(X, Y);
		end;

		leArrow2 :
		begin
			Brush.Style := bsSolid;
			Brush.Color := FillColor;
			Poly3[1] := Pos;
			Poly3[2] := Point(X + Round(-2*Dir.X - Dir.Y), Y + Round(-2*Dir.Y + Dir.X));
			Poly3[3] := Point(X + Round(-2*Dir.X + Dir.Y), Y + Round(-2*Dir.Y - Dir.X));
			Polygon(Poly3);
		end;

		leArrow3 :
		begin
			Brush.Style := bsSolid;
			Brush.Color := FillColor;
			Poly4[1] := Pos;
			Poly4[2] := Point(X + Round(-2*Dir.X - Dir.Y), Y + Round(-2*Dir.Y + Dir.X));
			Poly4[3] := Point(X - Round(Dir.X), Y - Round(Dir.Y));
			Poly4[4] := Point(X + Round(-2*Dir.X + Dir.Y), Y + Round(-2*Dir.Y - Dir.X));
			Polygon(Poly4);
		end;

		leDoubleArrow1:
		begin
			Brush.Style := bsSolid;
			Brush.Color := FillColor;
			Poly3[1] := Pos;
			Poly3[2] := Point(X + Round(-2 * Dir.X - Dir.Y), Y + Round(-2 * Dir.Y + Dir.X));
			Poly3[3] := Point(X + Round(-2 * Dir.X + Dir.Y), Y + Round(-2 * Dir.Y - Dir.X));
			Polygon(Poly3);
			Poly3[1] := Point(X - Round(2 * Dir.X), Y - Round(2 * Dir.Y));
			Poly3[2] := Point(X + Round(-4 * Dir.X - Dir.Y), Y + Round(-4 * Dir.Y + Dir.X));
			Poly3[3] := Point(X + Round(-4 * Dir.X + Dir.Y), Y + Round(-4 * Dir.Y - Dir.X));
			Polygon(Poly3);
		end;
	end;
	if FLineStyle=lsOutline then Canvas.Pen.Width := PenWidth;
end;





procedure TBaseConnectorObject.DrawSelected(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer);

	procedure DrawFocusRect(X, Y, Marker: Integer);
	var
		BoxRect : TRect;
	begin
		BoxRect := Rect(X - MarkerBoxSize, Y - MarkerBoxSize, X + (MarkerBoxSize + 1), Y + (MarkerBoxSize + 1));
    Canvas.FrameRect(BoxRect);
    with CanvasInfo, ZBuffer.Canvas do
    begin
      Brush.Color := Index or (Marker shl 16);
      FillRect(BoxRect);
    end;
  end;

  procedure DrawLink(X, Y: Integer);
  begin
    with Canvas do
    begin
      MoveTo(X - LinkMarkerSize, Y - LinkMarkerSize);
      LineTo(X + LinkMarkerSize + 1, Y + LinkMarkerSize + 1);
      MoveTo(X + LinkMarkerSize, Y - LinkMarkerSize);
      LineTo(X - LinkMarkerSize - 1, Y + LinkMarkerSize + 1);
    end;
  end;

var
  CanvasRect: TRect;
begin
	if not(Selected) then
	begin
		Exit;
	end;
	
	CanvasRect := CanvasInfo.CanvasRect(Position);
	with Canvas do
	begin
		if Assigned(FLinkObjects[1].Obj) then
		begin
			Brush.Style := bsSolid;
			Brush.Color := $00bb00;
			with CanvasRect.TopLeft do
			begin
				FrameRect(Rect(X - (MarkerBoxSize + 1), Y - (MarkerBoxSize + 1), X + (MarkerBoxSize + 1 + 1), Y + (MarkerBoxSize + 1 + 1)));
			end;
			if Assigned(FLinkObjects[2].Obj) then with CanvasRect.BottomRight do
			begin
				FrameRect(Rect(X - (MarkerBoxSize + 1), Y - (MarkerBoxSize + 1), X + (MarkerBoxSize + 1 + 1), Y + (MarkerBoxSize + 1 + 1)));
			end;
		end
		else if Assigned(FLinkObjects[2].Obj) then
		begin
			Brush.Style := bsSolid;
			Brush.Color := $00bb00;
			with CanvasRect.BottomRight do
			begin
				FrameRect(Rect(X - (MarkerBoxSize + 1), Y - (MarkerBoxSize + 1), X + (MarkerBoxSize + 1 + 1), Y + (MarkerBoxSize + 1 + 1)));
			end;
		end;
	end;

	PrepareSelectMarkerCanvas(Canvas);
	with CanvasRect do
	begin
		DrawFocusRect(Left, Top, 1);
		DrawFocusRect(Right, Bottom, 2);
	end;
end;





function TBaseConnectorObject.Move(DX, DY: Integer; Handle: Integer; const Grid: TPoint; Shift: TShiftState): TPoint;
var
	ActivePoint, Other: PPoint;
begin
	case Handle of
		1: ActivePoint := @P1;
    2: ActivePoint := @P2;
    else
		begin
			Result := inherited Move(DX, DY, Handle, Grid, []);
			if (Handle=0) and ((Result.X<>0) or (Result.Y<>0)) then
			begin
				with FLinkObjects[1] do
					if not ((Obj is TBaseConnectorObject) and (TBaseConnectorObject(Obj).FLinkObjects[LinkIndex + 1].Obj=Self)) then
						DisconnectLink(1);
				with FLinkObjects[2] do
					if not ((Obj is TBaseConnectorObject) and (TBaseConnectorObject(Obj).FLinkObjects[LinkIndex + 1].Obj=Self)) then
						DisconnectLink(2);
			end;
			Exit;
		end
	end;
	
	if (ssCtrl in Shift) then // Ctrl pressed, force vertical or horizontal
  begin
    if (Handle = 1) then Other := @P2
    else Other := @P1;
    if (Abs(ActivePoint^.X + DX - Other^.X) > Abs(ActivePoint^.Y + DY - Other^.Y)) then // Horizontal line
    begin
      Result.X := RoundInt(ActivePoint^.X + DX, Grid.X) - ActivePoint^.X;
      Result.Y := Other^.Y - ActivePoint^.Y;
    end
    else // Vertical line
    begin
      Result.X := Other^.X - ActivePoint^.X;
      Result.Y := RoundInt(ActivePoint^.Y + DY, Grid.Y) - ActivePoint^.Y;
    end;
  end
  else // Free move
  begin
    Result.X := RoundInt(ActivePoint^.X + DX, Grid.X) - ActivePoint^.X;
    Result.Y := RoundInt(ActivePoint^.Y + DY, Grid.Y) - ActivePoint^.Y;
  end;
  if ((Result.X <> 0) or (Result.Y <> 0)) then DisconnectLink(Handle);
  Inc(ActivePoint^.X, Result.X);
  Inc(ActivePoint^.Y, Result.Y);
end;





procedure TBaseConnectorObject.Rotate(const Angle: Double; FlipLR, FlipUD: Boolean; const Center: TPoint);
begin
  if (Angle <> 0) then
  begin
    with RotatePoint(FloatPoint(FPosition.TopLeft), FloatPoint(Center), Angle) do
    begin
      FPosition.TopLeft.X := Round(X);
      FPosition.TopLeft.Y := Round(Y);
    end;
    with RotatePoint(FloatPoint(FPosition.BottomRight), FloatPoint(Center), Angle) do
    begin
      FPosition.BottomRight.X := Round(X);
      FPosition.BottomRight.Y := Round(Y);
    end;
  end;

  if FlipLR then
  begin
		FPosition.Left := 2 * Center.X - FPosition.Left;
		FPosition.Right := 2 * Center.X - FPosition.Right;
  end;

  if FlipUD then
  begin
		FPosition.Top := 2 * Center.Y - FPosition.Top;
    FPosition.Bottom := 2 * Center.Y - FPosition.Bottom;
  end;

  NotifyMovement();
end;





function TBaseConnectorObject.ObjectMoved(LinkObject: TBaseObject): Boolean;
begin
  Result := True;
	if (FObjectMovedRunning) then
	begin
		Exit;
	end;
	
	FObjectMovedRunning := True;
	try
		if FLinkObjects[1].Obj=LinkObject then
			P1 := LinkObject.GetLinkPosition(FLinkObjects[1].LinkIndex)
		else if FLinkObjects[2].Obj=LinkObject then
			P2 := LinkObject.GetLinkPosition(FLinkObjects[2].LinkIndex)
		else
			Result := False;
		NotifyMovement();
	finally
		FObjectMovedRunning := False;
	end;
end;





procedure TBaseConnectorObject.ObjectDeleted(LinkObject: TBaseObject);
begin
	with FLinkObjects[1] do
	begin
		if (Obj = LinkObject) then
		begin
			Obj := nil;
			ObjectIndex := -1;
		end;
	end;

	with FLinkObjects[2] do
	begin
		if (Obj = LinkObject) then
		begin
			Obj := nil;
			ObjectIndex := -1;
		end;
	end;
end;





procedure TBaseConnectorObject.LinkPointDeleted(LinkObject: TBaseObject; LinkIndex: Integer);
begin
	if ((FLinkObjects[1].Obj = LinkObject) and (FLinkObjects[1].LinkIndex = LinkIndex)) then DisconnectLink(1);
	if ((FLinkObjects[2].Obj = LinkObject) and (FLinkObjects[2].LinkIndex = LinkIndex)) then DisconnectLink(2);
end;





procedure TBaseConnectorObject.MakeLink(Point: Integer; LinkObject: TBaseObject; ALinkIndex: Integer);
begin
  with FLinkObjects[Point] do
  begin
    ObjectIndex := Owner.IndexOf(LinkObject);
    Assert(ObjectIndex<>-1);
    if Assigned(Obj) then Obj.RemoveNotifyObject(Self);
    Obj := LinkObject;
    LinkIndex := ALinkIndex;
    LinkObject.AddNotifyObject(Self);
    ObjectMoved(LinkObject);
  end;
	if (
		(LinkObject is TBaseConnectorObject) and
		not(Assigned(TBaseConnectorObject(LinkObject).FLinkObjects[ALinkIndex + 1].Obj))
	) then
	begin
		TBaseConnectorObject(LinkObject).MakeLink(ALinkIndex + 1, Self, Point - 1);
	end;
end;





procedure TBaseConnectorObject.DisconnectLink(Point: Integer);
begin
	with FLinkObjects[Point] do
	begin
		ObjectIndex := -1;
		if Assigned(Obj) then
		begin
			Obj.RemoveNotifyObject(Self);
      if (Obj is TBaseConnectorObject) then with TBaseConnectorObject(Obj) do
      begin
        Obj := nil;
				if (FLinkObjects[1].Obj = Self) then DisconnectLink(1);
				if (FLinkObjects[2].Obj = Self) then DisconnectLink(2);
			end;
			Obj := nil;
		end;
	end;
end;





function TBaseConnectorObject.HasLinkObject(Point: Integer): Boolean;
begin
	Result := Assigned(FLinkObjects[Point].Obj);
end;





procedure TBaseConnectorObject.ResetLinkIndices();
begin
	with FLinkObjects[1] do if Assigned(Obj) then ObjectIndex := Owner.IndexOf(Obj);
	with FLinkObjects[2] do if Assigned(Obj) then ObjectIndex := Owner.IndexOf(Obj);
end;





procedure TBaseConnectorObject.ResetLinkObjects();
var
  Link : Integer;
begin
	for Link := 1 to 2 do with FLinkObjects[Link] do
	begin
    if (ObjectIndex >= 0) then
    begin
      if Assigned(Obj) then
      begin
        Obj.RemoveNotifyObject(Self);
        Obj := nil;
      end;
			if (ObjectIndex >= Owner.Count) then
			begin
				ObjectIndex := -1;
			end
			else
			begin
				Obj := Owner.Objects[ObjectIndex];
				Obj.AddNotifyObject(Self);
			end;
		end;
	end;		// for Link
end;





procedure TBaseConnectorObject.SaveToStream(Stream: TBaseStream);
begin
  inherited;
  Stream.Write(FStartMarker, 2);
  Stream.Write(FEndMarker, 2);
  Stream.Write(FLineStyle, 2);
  Stream.Write(FFillColor, 4);

  Stream.Write(FLinkObjects[1].ObjectIndex, 4);
  if (FLinkObjects[1].ObjectIndex <> -1) then Stream.Write(FLinkObjects[1].LinkIndex, 2);
  Stream.Write(FLinkObjects[2].ObjectIndex, 4);
  if (FLinkObjects[2].ObjectIndex <> -1) then Stream.Write(FLinkObjects[2].LinkIndex, 2);
end;





var
	NullLink : Integer = -1;




	
procedure TBaseConnectorObject.SaveSelected(Stream: TBaseStream);
var
  Link, I : Integer;
begin
  inherited SaveToStream(Stream);
  Stream.Write(FStartMarker, 2);
  Stream.Write(FEndMarker, 2);
  Stream.Write(FLineStyle, 2);
  Stream.Write(FFillColor, 4);

  for Link := 1 to 2 do with FLinkObjects[Link] do
  begin
    if (Assigned(Obj) and Obj.Selected) then
    begin
      I := Owner.IndexInSelection(Obj);
      Assert(I <> -1);
      Stream.Write(I, 4);
      Stream.Write(LinkIndex, 2);
    end
    else Stream.Write(NullLink, 4);
  end;
end;





procedure TBaseConnectorObject.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
begin
  inherited LoadFromStream(Stream, FileVersion);
  Stream.Read(FStartMarker, 2);
  Stream.Read(FEndMarker, 2);
	if (FileVersion >= 9)  then Stream.Read(FLineStyle, 2);
	if (FileVersion >= 18) then Stream.Read(FFillColor, 4)
  else FFillColor := FLineColor;

  Stream.Read(FLinkObjects[1].ObjectIndex, 4);
	if (FLinkObjects[1].ObjectIndex <> -1) then Stream.Read(FLinkObjects[1].LinkIndex, 2);
	Stream.Read(FLinkObjects[2].ObjectIndex, 4);
  if (FLinkObjects[2].ObjectIndex <> -1) then Stream.Read(FLinkObjects[2].LinkIndex, 2);
end;





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TArrowObject:

constructor TArrowObject.CreateNew(PropertyObject: TBaseObject);
begin
  Create();
	FLineWidth := DefaultLineWidth;
	FEndMarker := leArrow3 or $200;
	Name := ExtractObjectName(ClassName);
	if Assigned(PropertyObject) then Assign(PropertyObject);
end;





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TStraightLineObject:

function TStraightLineObject.CreateCopy: TBaseObject;
begin
  Result := TStraightLineObject.Create();
  Result.Assign(Self);
end;





function ExtendLineBy1(const P1, P2: TPoint): TPoint;
var
  L : Double;
begin
  Result.X := P2.X - P1.X;
  Result.Y := P2.Y - P1.Y;
  if ((Result.X <> 0) or (Result.Y <> 0)) then
  begin
    L := 1 / Sqrt(Sqr(Int64(Result.X)) + Sqr(Int64(Result.Y)));
    Result.X := P2.X + Round(Result.X*L);
    Result.Y := P2.Y + Round(Result.Y*L);
  end
  else
  begin
    Result.X := P2.X + 1;
    Result.Y := P2.Y;
  end;
end;





procedure TStraightLineObject.Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer);
var
  CanvasRect : TRect;
  PenWidth : Integer;
begin
  inherited;
  CanvasRect := CanvasInfo.CanvasRect(Position);
  with Canvas do
  begin
		if (FLineColor = clNone) then
		begin
			Pen.Style := psClear;
			PenWidth := 2;
		end
		else
		begin
			Pen.Style := psSolid;
			Pen.Color := FLineColor;
      PenWidth := Round(FLineWidth * CanvasInfo.Scale.X);
      Pen.Width := PenWidth;
    end;
    //if FText<>'' then ExcludeClipRect(Handle, CurrentTextRect.Left, CurrentTextRect.Top, CurrentTextRect.Right, CurrentTextRect.Bottom);

    if (FLineStyle = lsSolid) then
    begin
      with CanvasRect.TopLeft do MoveTo(X, Y);
      with CanvasRect.BottomRight do LineTo(X, Y);
      if (PenWidth < 2) then with CanvasRect.BottomRight do Pixels[X, Y] := FLineColor;
      //with ExtendLineBy1(CanvasRect.TopLeft, CanvasRect.BottomRight) do LineTo(X, Y);
      //if CanvasInfo.DrawMode<>dmEditing then with CanvasRect.TopLeft do LineTo(X, Y);
    end
		else
		begin
			DrawLineStyle(Canvas, Position.TopLeft, Position.BottomRight, CanvasInfo);
		end;
		
		if (FStartMarker <> 0) then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.TopLeft,     CanvasRect.BottomRight, FStartMarker);
		if (FEndMarker   <> 0) then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.BottomRight, CanvasRect.TopLeft,     FEndMarker);

    if (FText <> '') then
    begin
      Brush.Style := bsSolid;
      Brush.Color := clWhite;
      FillRect(CurrentTextRect);
      inherited Draw(Canvas, CanvasInfo, Index); // TODO: Use clipping regions
      //IntersectClipRect(Handle, CurrentTextRect.Left, CurrentTextRect.Top, CurrentTextRect.Right, CurrentTextRect.Bottom);
    end;
	end;
	
  if Assigned(CanvasInfo.ZBuffer) then with CanvasInfo.ZBuffer.Canvas do
  begin
		if (FLineColor = clNone) then Pen.Width := 0
    else Pen.Width := Max(Canvas.Pen.Width, 3);
    Pen.Style := psSolid;
    Pen.Color := Index;
    with CanvasRect.TopLeft do MoveTo(X, Y);
    with CanvasRect.BottomRight do LineTo(X, Y);
  end;
end;





class function TStraightLineObject.Identifier: Integer;
begin
  Result := otStraightLine;
end;





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TAxisLineObject:

function TAxisLineObject.CreateCopy(): TBaseObject;
begin
	Result := TAxisLineObject.Create();
	Result.Assign(Self);
end;





class function TAxisLineObject.Identifier(): Integer;
begin
  Result := otConnectorLine;
end;





function TAxisLineObject.ValidProperties: TObjectProperties;
begin
	Result := (inherited ValidProperties) + [opCornerRadius];
end;





function TAxisLineObject.GetProperty(Index: TObjectProperty): Integer;
begin
  case Index of
    opCornerRadius: Result := FCornerRadius;
		else Result := inherited GetProperty(Index);
	end;
end;





procedure TAxisLineObject.SetProperty(Index: TObjectProperty; Value: Integer);
begin
	case Index of
		opCornerRadius: FCornerRadius := Value;
    else inherited SetProperty(Index, Value);
  end;
end;





procedure TAxisLineObject.Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer);

var
  Radius, Diameter: TPoint;

  procedure DrawCorner(const P1: TPoint; P2X, P2Y: Integer; const P3: TPoint; MoveToStart: Boolean);
  var
    ArcRect : TRect;
    PC : TPoint;
  begin
    if (P1.X=P3.X) or (P1.Y=P3.Y) then // Straight line
    begin
      if MoveToStart then with P1 do Canvas.MoveTo(X, Y);
      with P3 do Canvas.LineTo(X, Y);
    end
    else // Corner with arc
    begin
      if MoveToStart then with P1 do Canvas.MoveTo(X, Y);
      if P1.X=P2X then
      begin
        Canvas.LineTo(P2X, P2Y - Radius.Y);
        if FCornerRadius<>0 then
        begin
          ArcRect.Left := P1.X;
          ArcRect.Top := P2Y - Diameter.Y;
          ArcRect.Right := P2X + Diameter.X;
          ArcRect.Bottom := P3.Y;
          if ArcRect.Left>ArcRect.Right then
            SwapDWords(ArcRect.Left, ArcRect.Right);
          if ArcRect.Top>ArcRect.Bottom then
            SwapDWords(ArcRect.Bottom, ArcRect.Top);
          PC := CenterPoint(ArcRect);
          if (Diameter.X xor Diameter.Y) and $80000000=0 then // If same sign
            Canvas.Arc(ArcRect.Left, ArcRect.Top, ArcRect.Right + 1, ArcRect.Bottom + 1, 
                       PC.X - Diameter.X, PC.Y + 1, PC.X + 1, PC.Y + Diameter.Y)
          else
            Canvas.Arc(ArcRect.Left, ArcRect.Top, ArcRect.Right + 1, ArcRect.Bottom + 1, 
                       PC.X, PC.Y + Diameter.Y, PC.X - Diameter.X, PC.Y);
          Canvas.MoveTo(P1.X + Radius.X, P2Y);
        end;
      end
      else
      begin 
        Assert(P1.Y=P2Y);
        Canvas.LineTo(P2X - Radius.X, P2Y);
        if FCornerRadius<>0 then
        begin
          ArcRect.Left := P2X - Diameter.X;
          ArcRect.Top := P1.Y;
          ArcRect.Right := P3.X;
          ArcRect.Bottom := P2Y + Diameter.Y;
          if ArcRect.Left>ArcRect.Right then 
            SwapDWords(ArcRect.Left, ArcRect.Right);
          if ArcRect.Top>ArcRect.Bottom then
            SwapDWords(ArcRect.Bottom, ArcRect.Top);
          PC := CenterPoint(ArcRect);
          if (Diameter.X xor Diameter.Y) and $80000000=0 then // If same sign
            Canvas.Arc(ArcRect.Left, ArcRect.Top, ArcRect.Right + 1, ArcRect.Bottom + 1, 
                       PC.X + Diameter.X, PC.Y, PC.X, PC.Y - Diameter.Y)
          else
            Canvas.Arc(ArcRect.Left, ArcRect.Top, ArcRect.Right + 1, ArcRect.Bottom + 1, 
                       PC.X, PC.Y - Diameter.Y, PC.X + Diameter.X, PC.Y);
          Canvas.MoveTo(P2X, P1.Y + Radius.Y);
        end;
      end;
      with P3 do Canvas.LineTo(X, Y);
    end;
  end;

var
  CanvasRect : TRect;
  P1, P2, PCenter : TPoint;
  Mid, PenWidth : Integer;
begin
  inherited Draw(Canvas, CanvasInfo, Index);

  CanvasRect := CanvasInfo.CanvasRect(Position);
  with Canvas do
  begin
    //if FText<>'' then ExcludeClipRect(Handle, CurrectTextRect.Left, CurrectTextRect.Top, CurrectTextRect.Right, CurrectTextRect.Bottom);
    if FLineColor=clNone then Pen.Style := psClear
    else
    begin
      Pen.Style := psSolid;
      Pen.Color := FLineColor;
      Pen.Width := Round(FLineWidth*CanvasInfo.Scale.X);
    end;

    if FLineStyle in [lsSolid, lsOutline] then // Draw solid line
    begin
      // Setup parameters
      if FCornerRadius=0 then
      begin
        Radius := Origo;
        Diameter := Origo;
      end
      else
      begin
        Diameter.X := Min(Round(FCornerRadius*CanvasInfo.Scale.X*2), Abs(CanvasRect.Right - CanvasRect.Left));
        Diameter.Y := Min(Round(FCornerRadius*CanvasInfo.Scale.Y*2), Abs(CanvasRect.Bottom - CanvasRect.Top));
        with CanvasRect do
        begin
          if Left>Right then
          begin
            Diameter.X :=  - Diameter.X;
            Radius.X := Diameter.X div 2 + 1;
          end
          else Radius.X := Diameter.X div 2 - 1;
          if Top>Bottom then
          begin
            Diameter.Y := -Diameter.Y;
            Radius.Y := Diameter.Y div 2 + 1;
          end
          else Radius.Y := Diameter.Y div 2 - 1;
        end;
      end;
      // Draw solid/outer line
      if EndDirection[1]=ldVertical then
      begin
        if EndDirection[2]=ldVertical then
        begin
          PCenter := CenterPoint(CanvasRect);
          DrawCorner(CanvasRect.TopLeft, CanvasRect.Left, PCenter.Y, PCenter, True);
          DrawCorner(PCenter, CanvasRect.Right, PCenter.Y, CanvasRect.BottomRight, False);
        end
        else DrawCorner(CanvasRect.TopLeft, CanvasRect.Left, CanvasRect.Bottom, CanvasRect.BottomRight, True);
      end
      else
      begin
        if EndDirection[2]=ldVertical then DrawCorner(CanvasRect.TopLeft, CanvasRect.Right, CanvasRect.Top, CanvasRect.BottomRight, True)
        else
        begin
          PCenter := CenterPoint(CanvasRect);
          DrawCorner(CanvasRect.TopLeft, PCenter.X, CanvasRect.Top, PCenter, True);
          DrawCorner(PCenter, PCenter.X, CanvasRect.Bottom, CanvasRect.BottomRight, False);
        end;
      end;
      if FLineStyle=lsOutline then
      begin
        PenWidth := Pen.Width;
        Pen.Width := PenWidth div 2;
        Pen.Color := FFillColor;
        // Draw inner line
        if EndDirection[1]=ldVertical then
        begin
          if EndDirection[2]=ldVertical then
          begin
            PCenter := CenterPoint(CanvasRect);
            DrawCorner(CanvasRect.TopLeft, CanvasRect.Left, PCenter.Y, PCenter, True);
            DrawCorner(PCenter, CanvasRect.Right, PCenter.Y, CanvasRect.BottomRight, False);
          end
          else DrawCorner(CanvasRect.TopLeft, CanvasRect.Left, CanvasRect.Bottom, CanvasRect.BottomRight, True);
        end
        else
        begin
          if EndDirection[2]=ldVertical then DrawCorner(CanvasRect.TopLeft, CanvasRect.Right, CanvasRect.Top, CanvasRect.BottomRight, True)
          else
          begin
            PCenter := CenterPoint(CanvasRect);
            DrawCorner(CanvasRect.TopLeft, PCenter.X, CanvasRect.Top, PCenter, True);
            DrawCorner(PCenter, PCenter.X, CanvasRect.Bottom, CanvasRect.BottomRight, False);
          end;
        end;
        Pen.Width := PenWidth;
        Pen.Color := FLineColor;
      end;
      // Line ends
      if EndDirection[1]=ldVertical then
      begin
        if FEndMarker<>0 then
          if EndDirection[2]=ldVertical then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.BottomRight, Point(CanvasRect.BottomRight.X, CanvasRect.TopLeft.Y), FEndMarker)
          else DrawLineEnd(Canvas, CanvasInfo, CanvasRect.BottomRight, Point(CanvasRect.TopLeft.X, CanvasRect.BottomRight.Y), FEndMarker);
        if FStartMarker<>0 then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.TopLeft, Point(CanvasRect.TopLeft.X, CanvasRect.BottomRight.Y), FStartMarker);
      end
      else
      begin
        if FEndMarker<>0 then
          if EndDirection[2]=ldVertical then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.BottomRight, Point(CanvasRect.BottomRight.X, CanvasRect.TopLeft.Y), FEndMarker)
          else DrawLineEnd(Canvas, CanvasInfo, CanvasRect.BottomRight, Point(CanvasRect.TopLeft.X, CanvasRect.BottomRight.Y), FEndMarker);
        if FStartMarker<>0 then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.TopLeft, Point(CanvasRect.BottomRight.X, CanvasRect.TopLeft.Y), FStartMarker);
      end;
    end
    else // Draw line with style
    begin
      if EndDirection[1]=ldVertical then
      begin
        if EndDirection[2]=ldVertical then
        begin
          with Position do Mid := Top + (Bottom - Top) div 2;
          P1 := Point(Position.TopLeft.X, Mid);
          P2 := Point(Position.BottomRight.X, Mid);
          DrawLineStyle(Canvas, Position.TopLeft, P1, CanvasInfo);
          DrawLineStyle(Canvas, P1, P2, CanvasInfo);
          DrawLineStyle(Canvas, P2, Position.BottomRight, CanvasInfo);
          if FEndMarker<>0 then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.BottomRight, Point(CanvasRect.BottomRight.X, CanvasRect.TopLeft.Y), FEndMarker);
        end
        else // EndDirection[2]=ldHorizontal
        begin
          P1 := Point(Position.TopLeft.X, Position.BottomRight.Y);
          DrawLineStyle(Canvas, Position.TopLeft, P1, CanvasInfo);
          DrawLineStyle(Canvas, P1, Position.BottomRight, CanvasInfo);
          if FEndMarker<>0 then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.BottomRight, Point(CanvasRect.TopLeft.X, CanvasRect.BottomRight.Y), FEndMarker);
        end;
        if FStartMarker<>0 then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.TopLeft, Point(CanvasRect.TopLeft.X, CanvasRect.BottomRight.Y), FStartMarker);
      end
      else // EndDirection[1]=ldHorizontal
      begin
        if EndDirection[2]=ldVertical then
        begin
          P1 := Point(Position.BottomRight.X, Position.TopLeft.Y);
          DrawLineStyle(Canvas, Position.TopLeft, P1, CanvasInfo);
          DrawLineStyle(Canvas, P1, Position.BottomRight, CanvasInfo);
          if FEndMarker<>0 then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.BottomRight, Point(CanvasRect.BottomRight.X, CanvasRect.TopLeft.Y), FEndMarker);
        end
        else // EndDirection[2]=ldHorizontal
        begin
          with Position do Mid := Left + (Right - Left) div 2;
          P1 := Point(Mid, Position.TopLeft.Y);
          P2 := Point(Mid, Position.BottomRight.Y);
          DrawLineStyle(Canvas, Position.TopLeft, P1, CanvasInfo);
          DrawLineStyle(Canvas, P1, P2, CanvasInfo);
          DrawLineStyle(Canvas, P2, Position.BottomRight, CanvasInfo);
          if FEndMarker<>0 then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.BottomRight, Point(CanvasRect.TopLeft.X, CanvasRect.BottomRight.Y), FEndMarker);
        end;
        if FStartMarker<>0 then DrawLineEnd(Canvas, CanvasInfo, CanvasRect.TopLeft, Point(CanvasRect.BottomRight.X, CanvasRect.TopLeft.Y), FStartMarker);
      end;
    end;

    if FText<>'' then
    begin
      Brush.Style := bsSolid;
      Brush.Color := clWhite;
      FillRect(CurrentTextRect);
      inherited; // TODO: Use clipping regions
      //IntersectClipRect(Handle, CurrectTextRect.Left, CurrectTextRect.Top, CurrectTextRect.Right, CurrectTextRect.Bottom);
    end;
  end;
  if Assigned(CanvasInfo.ZBuffer) then with CanvasInfo.ZBuffer.Canvas do // Z-buffer
  begin
    if FLineColor=clNone then Pen.Width := 0
    else Pen.Width := Max(Canvas.Pen.Width, 3);
    Pen.Style := psSolid;
    Pen.Color := Index;
    if EndDirection[1]=ldVertical then
    begin
      if EndDirection[2]=ldVertical then
      begin
        with CanvasRect do Mid := Top + (Bottom - Top) div 2;
        with CanvasRect.TopLeft do
        begin
          MoveTo(X, Y);
          LineTo(X, Mid);
        end;
        with CanvasRect.BottomRight do
        begin
          LineTo(X, Mid);
          LineTo(X, Y);
        end;
      end
      else
      begin
        with CanvasRect.TopLeft do
        begin
          MoveTo(X, Y);
          LineTo(X, CanvasRect.BottomRight.Y);
        end;
        with CanvasRect.BottomRight do LineTo(X, Y);
      end;
    end
    else
    begin
      if EndDirection[2]=ldVertical then
      begin
        with CanvasRect.TopLeft do
        begin
          MoveTo(X, Y);
          LineTo(CanvasRect.BottomRight.X, Y);
        end;
        with CanvasRect.BottomRight do LineTo(X, Y);
      end
      else
      begin
        with CanvasRect do Mid := Left + (Right - Left) div 2;
        with CanvasRect.TopLeft do
        begin
          MoveTo(X, Y);
          LineTo(Mid, Y);
        end;
        with CanvasRect.BottomRight do
        begin
          LineTo(Mid, Y);
          LineTo(X, Y);
        end;
      end;
    end;
  end;
end;





procedure TAxisLineObject.FindEndDirection(Point: Integer);
var
  Center : TPoint;
begin
  with FLinkObjects[Point] do
  begin
    if LinkIndex>=Length(Obj.Links) then
    begin
      Obj := nil;
      ObjectIndex := -1;
    end
    else
    begin
      Center := CenterPoint(Obj.Position);
      if (Obj.Links[LinkIndex].X<0.05) or (Obj.Links[LinkIndex].X>0.95) then EndDirection[Point] := ldHorizontal
      else if (Obj.Links[LinkIndex].Y<0.05) or (Obj.Links[LinkIndex].Y>0.95) then EndDirection[Point] := ldVertical
      else with Obj.GetLinkPosition(LinkIndex) do
      begin
        if Abs(X - Center.X)>Abs(Y - Center.Y) then EndDirection[Point] := ldHorizontal
        else EndDirection[Point] := ldVertical;
      end;
    end;
  end;
end;

procedure TAxisLineObject.ResetLinkObjects;
begin
  inherited;
  if Assigned(FLinkObjects[1].Obj) then FindEndDirection(1);
  if Assigned(FLinkObjects[2].Obj) then FindEndDirection(2);
end;

procedure TAxisLineObject.MakeLink(Point: Integer; LinkObject: TBaseObject; ALinkIndex: Integer);
begin
  inherited;
  FindEndDirection(Point);
end;

procedure TAxisLineObject.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
begin
  inherited;
  if FileVersion>=14 then Stream.Read(FCornerRadius, 4);
end;

procedure TAxisLineObject.SaveToStream(Stream: TBaseStream);
begin
  inherited;
  Stream.Write(FCornerRadius, 4);
end;

procedure TAxisLineObject.SaveSelected(Stream: TBaseStream);
begin
  inherited;
  Stream.Write(FCornerRadius, 4);
end;

//==============================================================================================================================
// TConnectorObject
//==============================================================================================================================
constructor TConnectorObject.CreateNew(PropertyObject: TBaseObject);
begin
  Create;
  FLineWidth := DefaultLineWidth;
  FEndMarker := leArrow3 or $200;
  Name := ExtractObjectName(ClassName);
  if Assigned(PropertyObject) then Assign(PropertyObject);
end;

//==============================================================================================================================
// TCurveLineObject
//==============================================================================================================================
const
  LineSegs = 32;

type
  TBlend = array[0..3, 1..LineSegs] of Double;

var
  FirstBlend, CenterBlend, LastBlend : TBlend;

procedure InitBlend;
var
  U, V, W : Double;
  I : Integer;
begin
  for I := 1 to LineSegs do
  begin
    U := I/LineSegs; V := U - 1; W := U + 1;

    FirstBlend[0, I] := -V*(V - 1)*(V - 2)/6;
    FirstBlend[1, I] :=  U*(V - 1)*(V - 2)/2;
    FirstBlend[2, I] := -U*V*(V - 2)/2;
    FirstBlend[3, I] :=  U*V*(V - 1)/6;

    CenterBlend[0, I] := -U*V*(U - 2)/6;
    CenterBlend[1, I] :=  W*V*(U - 2)/2;
    CenterBlend[2, I] := -W*U*(U - 2)/2;
    CenterBlend[3, I] :=  W*U*V/6;

    LastBlend[0, I] := -W*U*(W - 2)/6;
    LastBlend[1, I] :=  (W + 1)*U*(W - 2)/2;
    LastBlend[2, I] := -(W + 1)*W*(W - 2)/2;
    LastBlend[3, I] :=  (W + 1)*W*U/6;
  end;
end;

constructor TCurveLineObject.Create;
begin
  inherited;
  Links := nil;
  if FirstBlend[0, 1]=0 then InitBlend;
end;

constructor TCurveLineObject.CreateNew(PropertyObject: TBaseObject);
begin
  Create;
  FLineWidth := DefaultLineWidth;
  Name := ExtractObjectName(ClassName);
  if Assigned(PropertyObject) then Assign(PropertyObject);
end;

function TCurveLineObject.CreateCopy: TBaseObject;
begin
  Result := TCurveLineObject.Create;
  Result.Assign(Self);
end;

function TCurveLineObject.ValidProperties: TObjectProperties;
begin
  Result := (inherited ValidProperties) - [opPosition, opTextYAlign, opMargin] + [opScalingAnchorsOnly, opBlockAlignOnly, opCurveType];
end;

class function TCurveLineObject.Identifier: Integer;
begin
  Result := otCurveLine;
end;

procedure TCurveLineObject.SaveToStream(Stream: TBaseStream);
var
  Count : Integer;
begin
  inherited;
  Stream.Write(FCurveLineType, 1);
  Count := Length(Points);
  Stream.Write(Count, 2);
  Stream.Write(Points[0], Count*SizeOf(TPoint));
end;

procedure TCurveLineObject.LoadFromStream(Stream: TBaseStream; FileVersion: Integer);
var
  Count : Word;
begin
  inherited;
  FCurveLineType := ctLegacy;
  if FileVersion>=16 then Stream.Read(FCurveLineType, 1);
  Stream.Read(Count, 2);
  SetLength(Points, Count);
  Stream.Read(Points[0], Integer(Count)*SizeOf(TPoint));
end;

procedure TCurveLineObject.DrawAsLegacySpline(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);

  procedure MoveTo(X, Y: Integer);
  begin
    Canvas.MoveTo(X, Y);
    if Assigned(CanvasInfo.ZBuffer) then CanvasInfo.ZBuffer.Canvas.MoveTo(X, Y);
  end;

  procedure LineTo(X, Y: Integer);
  begin
    Canvas.LineTo(X, Y);
    if Assigned(CanvasInfo.ZBuffer) then CanvasInfo.ZBuffer.Canvas.LineTo(X, Y);
  end;

var
  SM : array[0..3] of TFloatPoint;

  procedure DrawSegs(const B: TBlend);
  var
    I, J : Integer;
    X, Y : Double;
  begin
    for I := 1 to LineSegs do
    begin
      X := 0; Y := 0;
      for J := 0 to 3 do
      begin
       X := X + SM[J].X*B[J, I];
       Y := Y + SM[J].Y*B[J, I];
      end;
      LineTo(Round(X), Round(Y));
    end;
  end;

  procedure NextSection;
  begin
    System.Move(SM[1], SM[0], 3*SizeOf(TFloatPoint));
  end;

  function GetPoint(I: Integer): TFloatPoint;
  begin
    with CanvasInfo do
    case Length(Points) of
      3 : case I of
            1  : begin
                   Result.X := (Points[0].X + Points[1].X)/2*Scale.X + Offset.X;
                   Result.Y := (Points[0].Y + Points[1].Y)/2*Scale.Y + Offset.Y;
                 end;
            3  : begin
                   Result.X := (Points[1].X + Points[2].X)/2*Scale.X + Offset.X;
                   Result.Y := (Points[1].Y + Points[2].Y)/2*Scale.Y + Offset.Y;
                 end;
            else with Points[I div 2] do
                 begin
                   Result.X := X*Scale.X + Offset.X;
                   Result.Y := Y*Scale.Y + Offset.Y;
                 end;
          end;

      4 : if I<2 then with Points[I] do
          begin
            Result.X := X*Scale.X + Offset.X;
            Result.Y := Y*Scale.Y + Offset.Y;
          end
          else if I>2 then with Points[I - 1] do
          begin
            Result.X := X*Scale.X + Offset.X;
            Result.Y := Y*Scale.Y + Offset.Y;
          end
          else
          begin
            Result.X := (Points[1].X + Points[2].X)/2*Scale.X + Offset.X;
            Result.Y := (Points[1].Y + Points[2].Y)/2*Scale.Y + Offset.Y;
          end;

    else  with Points[I] do
          begin
            Result.X := X*Scale.X + Offset.X;
            Result.Y := Y*Scale.Y + Offset.Y;
          end;
    end
  end;

var
  I : Integer;
begin
  if Length(Points)>2 then
  begin
    for I := 0 to 3 do SM[I] := GetPoint(I);
    MoveTo(Round(SM[0].X), Round(SM[0].Y));
    DrawSegs(FirstBlend);
    DrawSegs(CenterBlend);
    NextSection;
    for I := 4 to Length(Points) - 2 do
    begin
      SM[3] := GetPoint(I);
      DrawSegs(CenterBlend);
      NextSection;
    end;
    SM[3] := GetPoint(Max(4, High(Points)));
    DrawSegs(CenterBlend);
    DrawSegs(LastBlend);
  end
  else // Only two points, make straight line
  begin
    with CanvasInfo.CanvasPoint(Points[0]) do MoveTo(X, Y);
    with CanvasInfo.CanvasPoint(Points[1]) do LineTo(X, Y);
  end;
end;

procedure TCurveLineObject.DrawAsPolyX(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);
var
  CanvasPoints : array of TPoint;
  I : Integer;
begin
  SetLength(CanvasPoints, CeilInt(Length(Points) - 1, 3) + 1);
  for I := 0 to High(Points) do
    CanvasPoints[I] := CanvasInfo.CanvasPoint(Points[I]);
  for I := Length(Points) to High(CanvasPoints) do
    CanvasPoints[I] := CanvasPoints[High(Points)];
  case FCurveLineType of
    ctBezier : Canvas.PolyBezier(CanvasPoints);
  else Canvas.Polyline(CanvasPoints);
  end;
  if Assigned(CanvasInfo.ZBuffer) then
    CanvasInfo.ZBuffer.Canvas.PolyBezier(CanvasPoints);
end;

procedure TCurveLineObject.DrawAsCatmullRomSpline(Canvas: TCanvas; const CanvasInfo: TCanvasInfo);

  procedure MoveTo(X, Y: Integer);
  begin
    Canvas.MoveTo(X, Y);
    if Assigned(CanvasInfo.ZBuffer) then CanvasInfo.ZBuffer.Canvas.MoveTo(X, Y);
  end;

  procedure LineTo(X, Y: Integer);
  begin
    Canvas.LineTo(X, Y);
    if Assigned(CanvasInfo.ZBuffer) then CanvasInfo.ZBuffer.Canvas.LineTo(X, Y);
  end;

var
  P : array[0..3] of TPoint;

  procedure DrawSegments;
  var
    I, LastSegment : Integer;
    t : Double;
  begin
    LastSegment := Floor(PointDist(P[1], P[2])/DesignerDPI*50);
    for I := 1 to LastSegment - 1 do
    begin
      t := I/LastSegment;
      with CanvasInfo.CanvasPoint(CatmullRomPoly(P[0].X, P[1].X, P[2].X, P[3].X, t), 
                                  CatmullRomPoly(P[0].Y, P[1].Y, P[2].Y, P[3].Y, t)) do LineTo(X, Y);
    end;
    with CanvasInfo.CanvasPoint(P[2]) do LineTo(X, Y);
  end;

var
  I : Integer;
begin
  with CanvasInfo.CanvasPoint(Points[0]) do MoveTo(X, Y);
  if Length(Points)>2 then
  begin
    for I := 0 to 2 do P[I + 1] := Points[I];
    if CompareMem(@Points[0], @Points[High(Points)], SizeOf(TPoint)) then // Closed spline
    begin
      P[0] := Points[Length(Points) - 2];
      for I := 0 to Length(Points) - 2 do
      begin
        DrawSegments;
        System.Move(P[1], P[0], 3*SizeOf(TPoint));
        P[3] := Points[(I + 3) mod High(Points)];
      end;
    end
    else // Open spline
    begin
      P[0] := P[1];
      for I := 0 to Length(Points) - 2 do
      begin
        DrawSegments;
        System.Move(P[1], P[0], 3*SizeOf(TPoint));
        if I<Length(Points) - 3 then P[3] := Points[I + 3];
      end;
    end;
  end
  else with CanvasInfo.CanvasPoint(Points[1]) do LineTo(X, Y); // Only two points, make straight line
end;

procedure TCurveLineObject.Draw(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer);
begin
  inherited;
  with Canvas do
  begin
    if FLineColor=clNone then Pen.Style := psClear
    else
    begin
      Pen.Style := psSolid;
      Pen.Color := FLineColor;
      Pen.Width := Round(FLineWidth*CanvasInfo.Scale.X);
    end;
    //if FText<>'' then ExcludeClipRect(Handle, CurrentTextRect.Left, CurrentTextRect.Top, CurrentTextRect.Right, CurrentTextRect.Bottom);
  end;
  if Assigned(CanvasInfo.ZBuffer) then with CanvasInfo.ZBuffer.Canvas do
  begin
    if FLineColor=clNone then Pen.Width := 0
    else Pen.Width := Max(Canvas.Pen.Width, 3);
    Pen.Style := psSolid;
    Pen.Color := Index;
  end;

  if Length(Points)>1 then
    case FCurveLineType of
      ctLegacy       : DrawAsLegacySpline(Canvas, CanvasInfo);
      ctCatmullRom   : DrawAsCatmullRomSpline(Canvas, CanvasInfo);
    else DrawAsPolyX(Canvas, CanvasInfo);
    end;

  if FText<>'' then with Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := clWhite;
    FillRect(CurrentTextRect);
    inherited; // TODO: Use clipping regions
    //IntersectClipRect(Handle, CurrentTextRect.Left, CurrentTextRect.Top, CurrentTextRect.Right, CurrentTextRect.Bottom);
  end;
end;

procedure TCurveLineObject.DrawSelected(Canvas: TCanvas; const CanvasInfo: TCanvasInfo; Index: Integer);

  procedure DrawFocusRect(X, Y, Marker: Integer);
  var
    BoxRect : TRect;
  begin
    BoxRect := Rect(X - MarkerBoxSize, Y - MarkerBoxSize, X + (MarkerBoxSize + 1), Y + (MarkerBoxSize + 1));
    Canvas.FrameRect(BoxRect);
    with CanvasInfo, ZBuffer.Canvas do
    begin
      Brush.Color := Index or (Marker shl 16);
      FillRect(BoxRect);
    end;
  end;

var
  I : Integer;
begin
  if Selected then
  begin
    PrepareSelectMarkerCanvas(Canvas);
    for I := 0 to High(Points) do with CanvasInfo.CanvasPoint(Points[I]) do DrawFocusRect(X, Y, I + 1);
  end;
end;

function TCurveLineObject.AddPoint(Where: Integer): Integer;
begin
  // Point indices above 254 will result in invalid entries in the Z-buffer, see DrawSelected
  if Length(Points)<255 then
  begin
    SetLength(Points, Length(Points) + 1);
    if Where=1 then Result := 1 else Result := Where + 1;
    System.Move(Points[Result - 1], Points[Result], (Length(Points) - Result)*SizeOf(TPoint));
    if Result>1 then Points[Result - 1] := Points[Result - 2];
  end
  else raise Exception.Create(rsNoMorePointsAllowed);
end;

procedure TCurveLineObject.UpdatePosition;
var
  I : Integer;
begin
  with Position do
  begin
    Left := High(Integer);
    Right := Low(Integer);
    Top := High(Integer);
    Bottom := Low(Integer);
    for I := 0 to High(Points) do with Points[I] do
    begin
      if X<Left then Left := X;
      if X>Right then Right := X;
      if Y<Top then Top := Y;
      if Y>Bottom then Bottom := Y;
    end;
  end;
end;

function TCurveLineObject.Move(DX, DY, Handle: Integer; const Grid: TPoint; Shift: TShiftState): TPoint;
var
  I : Integer;
begin
  if Length(Points)<2 then
  begin
    SetLength(Points, 2);
    Points[0] := Position.TopLeft;
    Points[1] := Position.BottomRight;
  end;

  if Handle=0 then
  begin
    Result := Point(RoundInt(DX, Grid.X), RoundInt(DY, Grid.Y));
    OffsetRect(FPosition, Result.X, Result.Y);
    for I := 0 to High(Points) do Points[I] := OffsetPoint(Points[I], Result);
  end
  else if Handle=-1 then
  begin
    Result := Point(DX, DY);
    OffsetRect(FPosition, Result.X, Result.Y);
    for I := 0 to High(Points) do Points[I] := OffsetPoint(Points[I], Result);
  end
  else if Handle<=Length(Points) then
  begin
    Dec(Handle);
    with Points[Handle] do Result := Point(RoundInt(DX + X, Grid.X) - X, RoundInt(DY + Y, Grid.Y) - Y);
    Points[Handle] := OffsetPoint(Points[Handle], Result);
    UpdatePosition;
  end;
end;

procedure TCurveLineObject.Scale(const ScaleX, ScaleY: Double; const Center: TPoint);
var
  I : Integer;
begin
  inherited;
  for I := 0 to High(Points) do
    with Points[I] do         
    begin
      X := Round((X - Center.X)*ScaleX + Center.X);
      Y := Round((Y - Center.Y)*ScaleY + Center.Y);
    end;
end;

procedure TCurveLineObject.Rotate(const Angle: Double; FlipLR, FlipUD: Boolean; const Center: TPoint);
var
  I : Integer;
begin
  if Angle<>0 then
    for I := 0 to High(Points) do
      with RotatePoint(FloatPoint(Points[I]), FloatPoint(Center), Angle) do
      begin
        Points[I].X := Round(X);
        Points[I].Y := Round(Y);
      end;
  if FlipLR then for I := 0 to High(Points) do Points[I].X := 2*Center.X - Points[I].X;
  if FlipUD then for I := 0 to High(Points) do Points[I].Y := 2*Center.Y - Points[I].Y;
  UpdatePosition;
end;

procedure TCurveLineObject.Assign(Other: TObject);
begin
  inherited;
  if Other is TCurveLineObject then
  begin
    Points := Copy(TCurveLineObject(Other).Points);
  end;
end;

function TCurveLineObject.GetProperty(Index: TObjectProperty): Integer;
begin
  case Index of
    opCurveType          : Result := Integer(FCurveLineType);
    opScalingAnchorsOnly : Result := 0;
    else Result := inherited GetProperty(Index);
  end;
end;

procedure TCurveLineObject.SetProperty(Index: TObjectProperty; Value: Integer);
begin
  case Index of
    opCurveType : FCurveLineType := TCurveLineType(Value);
    else inherited SetProperty(Index, Value);
  end;
end;

function TCurveLineObject.CreatePolygon: TPolygonObject;
var
  P : array[0..3] of TPoint;
  LinkPoints : PFloatPointArray;
  Bounds : TFloatRect;

  procedure AddSegments;
  var
    I, PointIndex, LastSegment : Integer;
    t : Double;
  begin
    LastSegment := Floor(PointDist(P[1], P[2])/DesignerDPI*50);
    if LastSegment=0 then Exit; // Points are identical
    PointIndex := Length(LinkPoints^);
    SetLength(LinkPoints^, PointIndex + LastSegment);
    for I := 1 to LastSegment - 1 do
    begin
      t := I/LastSegment;
      LinkPoints^[PointIndex] := FloatPoint(CatmullRomPoly(P[0].X, P[1].X, P[2].X, P[3].X, t), 
                                          CatmullRomPoly(P[0].Y, P[1].Y, P[2].Y, P[3].Y, t));
      Inc(PointIndex);
    end;
    LinkPoints^[PointIndex] := FloatPoint(P[2].X, P[2].Y);
  end;

var
	I, IPrev, INext : Integer;
  Dist : Double;
begin
  if not (FCurveLineType in [ctCatmullRom, ctLineSegments]) or (Length(Points)<4) or not CompareMem(@Points[0], @Points[High(Points)], SizeOf(TPoint)) then
    raise Exception.Create(rsCurveMustBeClosedCatmullRomSpline);
  Result := TPolygonObject.CreateNew;
  try
    // Create new points
    LinkPoints := PFloatPointArray(Result.Properties[opCustomLinks]);
    if FCurveLineType=ctCatmullRom then // Catmull-Rom
    begin
      SetLength(LinkPoints^, 0);
      for I := 0 to 2 do P[I + 1] := Points[I];
      P[0] := Points[Length(Points) - 2];
      for I := 0 to Length(Points) - 2 do
      begin
        AddSegments;
        System.Move(P[1], P[0], 3*SizeOf(TPoint));
        P[3] := Points[(I + 3) mod High(Points)];
      end;
    end
    else // Line segments
    begin
      SetLength(LinkPoints^, Length(Points) - 1);
      for I := 0 to Length(Points) - 2 do
        LinkPoints^[I] := FloatPoint(Points[I]);
    end;
    // Decimate to recduce linear parts
    for I := High(LinkPoints^) downto 0 do
    begin
      IPrev := I - 1;
      if I=0 then IPrev := High(LinkPoints^);
      INext := I + 1;
      if INext=Length(LinkPoints^) then INext := 0;
      Dist := PointToLineSegmentDist(LinkPoints^[I], LinkPoints^[IPrev], LinkPoints^[INext]);
      if Dist<4 then
      begin
        System.Move(LinkPoints^[I + 1], LinkPoints^[I], (Length(LinkPoints^) - I - 1)*SizeOf(TFloatPoint));
        SetLength(LinkPoints^, Length(LinkPoints^) - 1);
      end;
    end;
    // Decimate if list is too long
    while Length(LinkPoints^)>65535 do
    begin
      for I := 1 to Length(LinkPoints^) div 2 - 1 do
        LinkPoints^[I] := LinkPoints^[I*2];
      SetLength(LinkPoints^, Length(LinkPoints^) div 2);
    end;
    // Determine bounding box
    Bounds := FloatRect(Infinity, Infinity, -Infinity, -Infinity);
    for I := 0 to High(LinkPoints^) do
      with LinkPoints^[I] do
      begin
        if X<Bounds.Left then Bounds.Left := X;
        if X>Bounds.Right then Bounds.Right := X;
        if Y<Bounds.Top then Bounds.Top := Y;
        if Y>Bounds.Bottom then Bounds.Bottom := Y;
      end;
    Result.Position := RoundRect(Bounds);
    // Scale link points
    for I := 0 to High(LinkPoints^) do
      with LinkPoints^[I] do
      begin
        X := (X - Bounds.Left)/(Bounds.Right - Bounds.Left);
        Y := (Y - Bounds.Top)/(Bounds.Bottom - Bounds.Top);
      end;
  except
    Result.Free;
    raise;
  end;
end;

end.

