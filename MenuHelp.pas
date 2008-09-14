unit MenuHelp;

interface

uses Monitor, Windows, Classes, Forms, StyleForm, Menus, StringUtils, comctrls, Controls,
  Messages, Graphics, StdCtrls;

procedure ShowMenuHelp(MenuItems: TMenuItem);


implementation

type
  TEscapeEventClass = class(TMonitorObject)
      procedure HelpFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    end;

procedure TEscapeEventClass.HelpFormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_ESCAPE then TForm(TRichEdit(Sender).Parent).Close;
end;

procedure ShowMenuHelp(MenuItems: TMenuItem);

  procedure ExploreMenu(Item: TMenuItem; Help: TStrings; const Root: string='');
  var
    I : Integer;
    Str : string;
  begin
    Str:=StripTrailing3Dots(StripHotkey(Item.Caption));
    if Item.Count=0 then
    begin
      if (Item.Hint<>'') and Item.Visible then
      begin
        Help.Add('§'+Root+Str);
        Str:=Item.Hint;
        I:=Pos('|',Str);
        if I>0 then Delete(Str,1,I);
        Str:=RemTailSpace(Str);
        if Str[Length(Str)]<>'.' then Str:=Str+'.';
        Help.Add(Str);
      end;
    end
    else for I:=0 to Item.Count-1 do ExploreMenu(Item.Items[I],Help,Root+Str+' | ');
  end;

var
  I : Integer;
  HelpForm : TForm;
  EscapeEvent : TEscapeEventClass;
begin
  EscapeEvent:=TEscapeEventClass.Create;
  HelpForm:=TStyleForm.CreateNew(Application,GetActiveFormHandle);
  with HelpForm do
  try
    Caption:='Feature description';
    Width:=500;
    Height:=400;
    BorderIcons:=[biSystemMenu,biMaximize];
    Position:=poScreenCenter;
    with TRichEdit.Create(HelpForm) do
    begin
      Align:=alClient;
      ReadOnly:=True;
      Parent:=HelpForm;
      PlainText:=False;
      Font.Name:='Arial';
      Font.Size:=10;
      Font.Charset:=Application.MainForm.Font.Charset;
      for I:=0 to MenuItems.Count-1 do ExploreMenu(MenuItems[I],Lines);
      for I:=0 to Lines.Count-1 do
      begin
        if (Lines[I]<>'') and (Lines[I][1]='§') then
        begin
          Lines[I]:=Copy(Lines[I],2,MaxInt);
          SelStart:=SendMessage(Handle,EM_LINEINDEX,I,0);
          SelLength:=Length(Lines[I]);
          SelAttributes.Style:=[fsBold];
        end;
        SelStart:=SelStart+Length(Lines[I])+2;
      end;
      ScrollBars:=ssBoth;
      WordWrap:=True;
      OnKeyDown:=EscapeEvent.HelpFormKeyDown;
    end;
    ShowModal;
  finally
    Free;
    EscapeEvent.Free;
  end;
end;

end.

