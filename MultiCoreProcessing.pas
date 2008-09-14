unit MultiCoreProcessing;

interface

uses Windows, Classes, SysUtils, Math;

type
  TSimpleThread = class; // Forward

  TSimpleThreadProc = procedure(Thread: TSimpleThread; Data: Pointer);
  TSimpleThreadMethod = procedure(Thread: TSimpleThread; Data: Pointer) of object;

  // A thread class ment for executing a simple process that requires no synchronization.
  // Exceptions are passed on to the calling thread.
  TSimpleThread = class(TThread)
  private
    ThreadProc : TSimpleThreadProc;
    ThreadMethod : TSimpleThreadMethod;
    Data : Pointer;
    Started : Boolean;
    ExceptionMessage : string;
  public
    constructor Create(ThreadProc: TSimpleThreadProc; Data: Pointer); overload;
    constructor Create(const ThreadMethod: TSimpleThreadMethod; Data: Pointer); overload;
    destructor Destroy; override;
    procedure WaitFor;
    procedure Execute; override;
  end;

  TMultiCoreProcessThread = class; // Forward
  TMultiCoreProcess = class; // Forward

  TMultiCoreProcessMethod = procedure(Thread: TMultiCoreProcessThread; Data: Pointer) of object;

  TMultiCoreProcessThread = class(TThread)
  private
    ProcessMethod : TMultiCoreProcessMethod;
    Data : Pointer;
    Process : TMultiCoreProcess;
  public
    constructor Create(Process: TMultiCoreProcess; const ProcessMethod: TMultiCoreProcessMethod; Data: Pointer);
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TThreadDataArray = array of Pointer;

  // Class for dividing a process in multiple threads. Inherit from this class and implement ProcessMethod.
  TMultiCoreProcess = class
  private
    Exceptions : Integer;
    ExceptionMessage : string;
  protected
    // Returns True when one of the parallel threads has been aborted or has raised an exception
    function ProcessAborted: Boolean;
    // The thread process. Exceptions are passed on to the calling thread.
    procedure ProcessMethod(Thread: TMultiCoreProcessThread; Data: Pointer); virtual; abstract;
  public
    // Return number of CPU cores available
    class function NumberOfCores: Integer;
    class function OptimalNumberOfThreads(ThreadsPerCore: Integer=1; MaxThreads: Integer=16): Integer;
    // Execute a number of threads corresponding to the number of elements in the ThreadData array
    procedure ExecuteProcess(ThreadData: TThreadDataArray);
    // Divide the interval [Start,Stop] in parts and execute a thread for each part passing a PThreadDataStartStop
    procedure ExecuteStartStop(Start,Stop,MinSegmentSize: Integer; MaxNumberOfThreads: Integer=0);
  end;

  TThreadDataStartStop = record
                           Start, Stop : Integer;
                           ThreadIndex : Integer;
                         end;
  PThreadDataStartStop = ^TThreadDataStartStop;

implementation

//==============================================================================================================================
// TSimpleThread
//==============================================================================================================================

constructor TSimpleThread.Create(ThreadProc: TSimpleThreadProc; Data: Pointer);
begin
  Self.ThreadProc:=ThreadProc;
  Self.Data:=Data;
  inherited Create(False);
end;

constructor TSimpleThread.Create(const ThreadMethod: TSimpleThreadMethod; Data: Pointer);
begin
  Self.ThreadMethod:=ThreadMethod;
  Self.Data:=Data;
  inherited Create(False);
end;

destructor TSimpleThread.Destroy;
begin
  while not Started do Sleep(0); // Make sure that thread is actually started
  inherited;
  if ExceptionMessage<>'' then
    raise Exception.Create(ExceptionMessage); // This may be a memory leak...
end;

procedure TSimpleThread.WaitFor;
var
  Msg : string;
begin
  while not Started do Sleep(0); // Make sure that thread is actually started
  inherited WaitFor;
  if ExceptionMessage<>'' then
  begin
    Msg:=ExceptionMessage;
    ExceptionMessage:='';
    raise Exception.Create(Msg);
  end;
end;

procedure TSimpleThread.Execute;
begin
  Started:=True;
  try
    if Assigned(ThreadProc) then ThreadProc(Self,Data)
    else ThreadMethod(Self,Data);
  except
    on E: Exception do
      ExceptionMessage:=E.Message;
  end;
end;

//==============================================================================================================================
// TMultiCoreProcessThread
//==============================================================================================================================

constructor TMultiCoreProcessThread.Create(Process: TMultiCoreProcess; const ProcessMethod: TMultiCoreProcessMethod; Data: Pointer);
begin
  Self.Process:=Process;
  Self.ProcessMethod:=ProcessMethod;
  Self.Data:=Data;
  inherited Create(False);
end;

destructor TMultiCoreProcessThread.Destroy;
begin
  WaitFor;
  while Assigned(Process) do Sleep(0); // Make sure that thread was actually started
  inherited Destroy;
end;

procedure TMultiCoreProcessThread.Execute;
begin
  try
    ProcessMethod(Self,Data);
  except
    on E: EAbort do
      if InterlockedExchange(Process.Exceptions,2)=1 then
        Process.Exceptions:=1;
    on E: Exception do
      if InterlockedExchange(Process.Exceptions,1)=0 then
        Process.ExceptionMessage:=E.Message;
  end;
  Process:=nil;
end;

//==============================================================================================================================
// TMultiCoreProcess
//==============================================================================================================================

class function TMultiCoreProcess.NumberOfCores: Integer;
var
  SystemInfo : TSystemInfo;
begin
  GetSystemInfo(SystemInfo);
  Result:=SystemInfo.dwNumberOfProcessors;
  {$IFOPT D+}
  //Result:=1;
  {$ENDIF}
end;

var
  AllowThreads : Boolean = False; // Set in initialization

class function TMultiCoreProcess.OptimalNumberOfThreads(ThreadsPerCore,MaxThreads: Integer): Integer;
begin
  Assert(ThreadsPerCore>=1);
  if AllowThreads then Result:=NumberOfCores
  else Result:=1;
  if Result>1 then Result:=Min(Result*ThreadsPerCore,MaxThreads);
end;

function TMultiCoreProcess.ProcessAborted: Boolean;
begin
  Result:=Exceptions<>0;
end;

procedure TMultiCoreProcess.ExecuteProcess(ThreadData: TThreadDataArray);
var
  Threads : array of TMultiCoreProcessThread;
  I : Integer;
begin
  Assert(Length(ThreadData)>=1,'No thread data');
  Exceptions:=0;
  SetLength(Threads,Length(ThreadData)-1);
  try
    for I:=0 to High(Threads) do
      Threads[I]:=TMultiCoreProcessThread.Create(Self,ProcessMethod,ThreadData[I+1]);
    try
      ProcessMethod(nil,ThreadData[0]);
    except
      Exceptions:=1;
      raise;
    end;
  finally
    for I:=0 to High(Threads) do
      Threads[I].Free;
  end;
  if Exceptions=1 then raise Exception.Create(ExceptionMessage)
  else if Exceptions=2 then Abort;
end;

procedure TMultiCoreProcess.ExecuteStartStop(Start,Stop,MinSegmentSize,MaxNumberOfThreads: Integer);
var
  I, SegmentSize : Integer;
  StartStopData : array of TThreadDataStartStop;
  ThreadData : TThreadDataArray;
begin
  Assert(Start<=Stop);
  if MaxNumberOfThreads=0 then MaxNumberOfThreads:=OptimalNumberOfThreads;
  Assert(MaxNumberOfThreads>=1);
  SegmentSize:=Max(MinSegmentSize,(Stop-Start+1) div MaxNumberOfThreads);
  SetLength(StartStopData,Max(1,(Stop-Start+1) div SegmentSize));
  SetLength(ThreadData,Length(StartStopData));
  for I:=0 to High(StartStopData) do
  begin
    StartStopData[I].Start:=Start+SegmentSize*I;
    StartStopData[I].Stop:=Start+SegmentSize*(I+1)-1;
    StartStopData[I].ThreadIndex:=I;
    ThreadData[I]:=@StartStopData[I];
  end;
  StartStopData[High(StartStopData)].Stop:=Stop;
  ExecuteProcess(ThreadData);
end;

var
  OldDllProc : TDLLProc;

procedure DLLEntryPointFunc(Reason:integer);
begin
  DLLProc:=OldDllProc;
  if Assigned(DLLProc) then DllProc(Reason);
  AllowThreads:=True;
end;

initialization
  if IsLibrary then // Threads are not allowed until DLL initialization completed
  begin
    OldDllProc:=DLLProc;
    DLLProc:=@DLLEntryPointFunc;
  end
  else AllowThreads:=True;
end.

