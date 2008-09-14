unit DiscreteCosine;

interface

uses SysUtils, MathUtils;

procedure PerformDCT(var InVal: TByteArray; var OutVal: TFloatArray; N: Integer); overload;
procedure PerformDCT(var InVal, OutVal: TFloatArray; N: Integer); overload;
procedure PerformIDCT(var InVal, OutVal: TFloatArray; N: Integer); overload;

implementation

procedure PerformDCT(var InVal: TByteArray; var OutVal: TFloatArray; N: Integer);
var
  x, u : Integer;
  Sum, alpha, B, TwoCosW, yn_1, yn_2, W, y, Pi2N : Float;
begin

  // y(n) = Sin(nW+B) = 2·cos(W)·y(n-1) - y(n-2), n>=0

  Pi2N:=Pi/(2*N);
  Alpha:=Sqrt(2/N);
  for u:=0 to N-1 do
    begin
      Sum:=0;
      B:=U*Pi2N;
      W:=2*B;
      B:=B+Pi/2;
      yn_1:=Sin(-W+B); yn_2:=Sin(-2*W+B);
      TwoCosW:=2*Cos(W);
      for x:=0 to N-1 do
      begin
        y:=TwoCosW*yn_1-yn_2;
        yn_2:=yn_1;
        yn_1:=y;
        Sum:=Sum+InVal[X]*y;
      end;

      if u=0 then OutVal[u]:=Sqrt(1/N)*Sum
      else OutVal[u]:=Alpha*Sum;
    end;
end;

procedure PerformDCT(var InVal, OutVal: TFloatArray; N: Integer);
var
  x, u : Integer;
  Sum, Alpha, B, TwoCosW, yn_1, yn_2, W, y, Pi2N : Float;
begin

  // y(n) = Sin(nW+B) = 2·cos(W)·y(n-1) - y(n-2), n>=0

  Pi2N:=Pi/(2*N);
  Alpha:=Sqrt(2/N);
  for u:=0 to N-1 do
    begin
      Sum:=0;
      B:=U*Pi2N;
      W:=2*B;
      B:=B+Pi/2;
      yn_1:=Sin(-W+B); yn_2:=Sin(-2*W+B);
      TwoCosW:=2*Cos(W);
      for x:=0 to N-1 do
      begin
        y:=TwoCosW*yn_1-yn_2;
        yn_2:=yn_1;
        yn_1:=y;
        Sum:=Sum+InVal[X]*y;
      end;

      if u=0 then OutVal[u]:=Sqrt(1/N)*Sum
      else OutVal[u]:=Alpha*Sum;
    end;
end;

procedure PerformIDCT(var InVal, OutVal: TFloatArray; N: Integer);
var
  x, u : Integer;
  Sum, Alpha, Alpha0, TwoCosW, yn_1, yn_2, W, y, Pi2N : Float;
begin

  // y(n) = Sin(nW+B) = 2·cos(W)·y(n-1) - y(n-2), n>=0

  Pi2N:=Pi/(2*N);
  Alpha0:=Sqrt(1/N);
  Alpha:=Sqrt(2/N);
  for x:=0 to N-1 do
    begin
      Sum:=0;
      W:=(2*x+1)*Pi2N;
      yn_1:=Sin(-W-(Pi/2)); yn_2:=Sin(-2*W-(Pi/2));
      TwoCosW:=2*Cos(W);
      for u:=0 to N-1 do
      begin
        y:=TwoCosW*yn_1-yn_2;
        yn_2:=yn_1;
        yn_1:=y;

        if u=0 then y:=InVal[u]*y*Alpha0
        else y:=InVal[u]*y*Alpha;
        Sum:=Sum+y;
      end;
      OutVal[x]:=Sum;
    end;
end;

end.

