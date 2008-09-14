unit WinAPIUtils;

interface

uses Windows, Controls, Classes, SysUtils, Graphics, ComCtrls;

// Show shield on button requiring administrator rights
procedure SetElevationRequiredState(Control: TWinControl; Required: LongBool=True);

// Process paint messages waiting for the application
procedure ProcessPaintMessages;
// Enable/disable redrawing of a control
procedure SetRedrawState(Control: TWinControl; Enabled: Boolean);

// Turn off font antialiasing
procedure DisableFontSmoothing(Font: TFont);
// Change to Vista style tree or list view
procedure EnableVistaViewStyle(ViewControl: TWinControl);

// Set caller thread priority
procedure SetPriority(Priority: TThreadPriority);

// Start new process with administrator privileges
procedure RunAsAdministrator(const FileName: string; const Parameters: string=''; WaitForProcess: Boolean=False);
// Return true if the calling process has administrator privileges
function ProcessHasAdministratorPrivileges: Boolean;
// True if Vista or later OS
function WindowsIsVistaOrLater: Boolean;

implementation

uses ShellAPI, Forms, Registry, Messages, UxTheme;

procedure SetElevationRequiredState(Control: TWinControl; Required: LongBool=True);
const
  BCM_FIRST = $1600;
  BCM_SETSHIELD = BCM_FIRST+$000c;
begin
  SendMessage(Control.Handle,BCM_SETSHIELD,0,Integer(Required));
end;

// Set priority of the calling thread
procedure SetPriority(Priority: TThreadPriority);
const
  Priorities: array [TThreadPriority] of Integer =
   (THREAD_PRIORITY_IDLE, THREAD_PRIORITY_LOWEST, THREAD_PRIORITY_BELOW_NORMAL,
    THREAD_PRIORITY_NORMAL, THREAD_PRIORITY_ABOVE_NORMAL,
    THREAD_PRIORITY_HIGHEST, THREAD_PRIORITY_TIME_CRITICAL);
begin
  SetThreadPriority(GetCurrentThread,Priorities[Priority]);
end;

// Process paint messages waiting for the application
procedure ProcessPaintMessages;
var
  Msg : TMsg;
begin
  while PeekMessage(Msg,0,WM_PAINT,WM_PAINT,PM_REMOVE) do
    DispatchMessage(Msg);
end;

// Enable/disable redrawing of a control
procedure SetRedrawState(Control: TWinControl; Enabled: Boolean);
begin
  SendMessage(Control.Handle,WM_SETREDRAW,Integer(Enabled),0);
end;

procedure RunAsAdministrator(const FileName,Parameters: string; WaitForProcess: Boolean);
var
  SEI : SHELLEXECUTEINFO;
begin
  FillChar(SEI,SizeOf(SEI),0);
  with SEI do
  begin
    cbSize:=SizeOf(SEI);
    fMask:=SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
    if WaitForProcess then fMask:=fMask or SEE_MASK_NOCLOSEPROCESS;
    if Screen.ActiveForm=nil then Wnd:=Application.Handle
    else Wnd:=Screen.ActiveForm.Handle;
    lpVerb:='runas';
    lpFile:=PChar(FileName);
    lpParameters:=PChar(Parameters);
    nShow:=SW_SHOWNORMAL;
  end;
  if not ShellExecuteEx(@SEI) then RaiseLastOSError;
  // Wait for process but keep screen updated
  if WaitForProcess then
    while WaitForSingleObject(SEI.hProcess,50)=WAIT_TIMEOUT do
      ProcessPaintMessages;
end;

var
  IsUserAnAdmin: function(): LongBool; stdcall;

function ProcessHasAdministratorPrivileges: Boolean;
begin
  if Assigned(IsUserAnAdmin) then
    Result:=IsUserAnAdmin
  else
  begin
    IsUserAnAdmin:=GetProcAddress(LoadLibrary('shell32.dll'),'IsUserAnAdmin');
    if Assigned(IsUserAnAdmin) then
      Result:=IsUserAnAdmin
    else
    with TRegistry.Create do
    try
      RootKey:=HKEY_LOCAL_MACHINE;
      Result:=OpenKey('\SOFTWARE',False);
    finally
      Free;
    end;
  end;
end;

function WindowsIsVistaOrLater: Boolean;
begin
  Result:=Win32MajorVersion>=6;
end;

// Turn off font antialiasing
procedure DisableFontSmoothing(Font: TFont);
var
  tagLOGFONT: TLogFont;
begin
  GetObject(Font.Handle, SizeOf(TLogFont), @tagLOGFONT);
  tagLOGFONT.lfQuality  := NONANTIALIASED_QUALITY;
  Font.Handle := CreateFontIndirect(tagLOGFONT);
end;

// Change to Vista style tree or list view
procedure EnableVistaViewStyle(ViewControl: TWinControl);
begin
  Assert((ViewControl is TCustomTreeView) or (ViewControl is TCustomListView));
  if WindowsIsVistaOrLater then
    SetWindowTheme(ViewControl.Handle, 'explorer', nil);
end;

end.

