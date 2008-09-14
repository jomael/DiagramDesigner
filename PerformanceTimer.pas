////////////////////////////////////////////////////////////////////////////////
//
// PerformanceTimer.pas - Performance timing for code optimization
// ---------------------------------------------------------------
// Version:   2006-04-15
// Maintain:  Michael Vinther    |    mv@logicnet·dk
//
// Last changes:
//   Process priority boost
//
unit PerformanceTimer;

interface

uses
  Windows, SysUtils, StringUtils;

//{$IFOPT D+}
// Tic boosts the program execution priority, so use with care
procedure Tic;
procedure TicNoBoost;
function Toc: DWord;
function TocText: string;
procedure ShowToc;
//{$ENDIF}

// Progress>0 assumed
function ComputeETA(Progress,Total,TimePassed: DWord): DWord;
function TimeStrFromMS(ms: DWord): string;

implementation

//{$IFOPT D+}

uses MMSystem, Forms;

var
  StartTime : DWord = 0;

procedure Tic;
begin
  SetPriorityClass(GetCurrentProcess,HIGH_PRIORITY_CLASS);
  timeBeginPeriod(1);
  Sleep(1); // Ensures more accurate time measurements
  StartTime:=timeGetTime;
end;

procedure TicNoBoost;
begin
  timeBeginPeriod(1);
  Sleep(1); // Ensures more accurate time measurements
  StartTime:=timeGetTime;
end;

function Toc: DWord;
begin
  Result:=timeGetTime-StartTime;
  timeEndPeriod(1);
  SetPriorityClass(GetCurrentProcess,NORMAL_PRIORITY_CLASS);
end;

function TocText: string;
var
  Time : DWord;
begin
  Time:=Toc;
  if Time<10000 then Result:=Format('%d ms',[Time])
  else if Time<100*1000 then Result:=Format('%.2f s',[Time/1000])
  else Result:=TimeStrFromMS(Time);    
end;

procedure ShowToc; // {$MESSAGE WARN 'Test code!'}
var
  Str : string;
begin
  Str:=TocText;
  if Application.MainForm=nil then MessageBox(Application.Handle,PChar(Str),'Toc',MB_OK or MB_ICONINFORMATION or MB_TASKMODAL)
  else MessageBox(Application.MainForm.Handle,PChar(Str),'Toc',MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
end;

//{$ENDIF}

function ComputeETA(Progress,Total,TimePassed: DWord): DWord;
begin
  Assert(Progress>0);
  Result:=Int64(Total-Progress)*TimePassed div Progress;
end;

function TimeStrFromMS(ms: DWord): string;
begin
  Result:=IntToStrLeadZero(ms div (3600*1000),2)+':'+
          IntToStrLeadZero((ms div (60*1000)) mod 60,2)+':'+
          IntToStrLeadZero((ms div 1000) mod 60,2);
end;

end.

