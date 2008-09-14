unit Fourier;

interface

uses SysUtils, Complex;

resourcestring
  rsMustBeIntegerPowerOf2 = 'Number of samples for FFT is not a positive integer power of 2';

const
  FFT  = 2*Pi;
  IFFT = -2*Pi;

procedure PerformFFT(var InVal,OutVal: TComplexArray; NumSamples: Integer; Domain: Double = FFT); overload;

// Note that coefficeints are moved around
procedure PerformFFT(var OutVal: TComplexArray; NumSamples: Integer; Domain: Double = FFT); overload;

function NumberOfBitsNeeded(PowerOfTwo: Cardinal): Integer;
function ReverseBits(Index,NumBits: Integer): Integer;

function CeilToPowerOfTwo(Value: Cardinal): Cardinal;

implementation

function CeilToPowerOfTwo(Value: Cardinal): Cardinal;
var
  I : Integer;
begin
  for I:=31 downto 0 do if Value and (1 shl I)<>0 then
  begin
    if 1 shl I=Value then CeilToPowerOfTwo:=Value
    else CeilToPowerOfTwo:=2 shl I;
    Exit;
  end;
  CeilToPowerOfTwo:=1;
end;

function NumberOfBitsNeeded(PowerOfTwo: Cardinal): Integer;
var
  I : Integer;
begin
  for I:=0 to 31 do if 1 shl I=PowerOfTwo then
  begin
    NumberOfBitsNeeded:=I;
    Exit;
  end;
  Assert(False,'Not a power of 2');
  NumberOfBitsNeeded:=-1;
end;

function ReverseBits(Index,NumBits: Integer): Integer;
var
  I : Integer;
begin
  Result:=0;
  for I:=0 to NumBits-1 do
  begin
    Result:=(Result shl 1) or (Index and 1);
    Index:=Index shr 1;
  end;
end;

procedure PerformFFT(var InVal,OutVal: TComplexArray; NumSamples: Integer; Domain: Double);
var
  NumBits, i : Integer;
begin
  NumBits:=NumberOfBitsNeeded(NumSamples);

  if NumBits<1 then raise Exception.Create(rsMustBeIntegerPowerOf2);

  for i:=0 to NumSamples-1 do OutVal[ReverseBits(i,NumBits)]:=InVal[i];

  PerformFFT(OutVal,NumSamples,Domain);
end;

procedure PerformFFT(var OutVal: TComplexArray; NumSamples: Integer; Domain: Double);
var
  i, j, k, n, BlockSize, BlockEnd : Integer;
  delta_angle, delta_ar : Double;
  alpha, beta : Double;
  tr, ti, ar, ai : Double;
begin
  BlockEnd:=1;
  BlockSize:=2;
  while BlockSize <= NumSamples do
  begin
    delta_angle := Domain / BlockSize;
    alpha := sin ( 0.5 * delta_angle );
    alpha := 2.0 * Sqr(alpha);
    beta := sin ( delta_angle );

    i := 0;
    while i < NumSamples do
    begin
      ar := 1;    // cos(0)
      ai := 0;    // sin(0)

      j := i;
      for n := 0 to BlockEnd-1 do
      begin
        k := j + BlockEnd;
        tr := ar*OutVal[k].Re - ai*OutVal[k].Im;
        ti := ar*OutVal[k].Im + ai*OutVal[k].Re;
        OutVal[k].Re := OutVal[j].Re - tr;
        OutVal[k].Im := OutVal[j].Im - ti;
        OutVal[j].Re := OutVal[j].Re + tr;
        OutVal[j].Im := OutVal[j].Im + ti;
        delta_ar := alpha*ar + beta*ai;
        ai := ai - (alpha*ai - beta*ar);
        ar := ar - delta_ar;
        Inc(j);
      end;

      Inc(i,BlockSize);
    end;
    BlockEnd:=BlockSize;
    BlockSize:=BlockSize shl 1;
  end;
end;

// Frequency peak interpolation
{
Jain's Method :
y1 = |X[k-1]| 
y2 = |X[k]| 
y3 = |X[k+1]| 
if y1 > y3 then 
   a = y2  /  y1
   d = a  /  (1 + a)
   k' = k - 1 + d 
else
   a = y3  /  y2
   d = a  /  (1 + a)
   k' = k + d
end 
}

end.
