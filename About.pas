unit About;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls, ShellAPI,
  SysUtils, VersionInfo, StyleForm, PanelFrame;
                     
type
  TAboutBox = class(TStyleForm)
    Panel1: TPanelFrame;
    OKButton: TButton;
    ProgramIcon: TImage;
    ProductName: TLabel;
    ProductName2: TLabel;
    Version: TLabel;
    WWWLabel: TLabel;
    Label3: TLabel;
    InfoLabel: TLabel;
    Label1: TLabel;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowAboutBox;

var
  InfoLabelText : string = '';

implementation

{$R *.DFM}

procedure ShowAboutBox;
begin
  {$IFDEF UseStyleForm}
  with TAboutBox.Create(Application,GetActiveFormHandle) do
  {$ELSE}
  with TAboutBox.Create(Application) do
  {$ENDIF}
  try
    {$IFOPT D+}
    with TLabel.Create(Panel1) do
    begin
      Top:=Version.Top;
      Width:=Panel1.ClientWidth-16;
      Alignment:=taRightJustify;
      Caption:='DEBUG BUILD';
      Parent:=Panel1;
      Font.Color:=clRed;
      Font.Style:=[fsBold];
      Transparent:=True;
    end;
    {$ENDIF}

    MakeLinkLabel(WWWLabel);

    ShowModal;
  finally
    Free;
  end;
end;

procedure TAboutBox.FormShow(Sender: TObject);

  function LeadingZero(I: Integer): string;
  begin
    if I<10 then Result:='0'+IntToStr(I)
    else Result:=IntToStr(I);
  end;

var
  MinorVer : string;

begin
  {$IFDEF UseStyleForm}
  UseBackgroundTheme:=True;
  {$ENDIF}
  if VersionStr='' then Version.Caption:=''
  else
  begin
    if ThisApp.ProductVersion.Build=0 then MinorVer:=LeadingZero(ThisApp.ProductVersion.Minor)
    else MinorVer:=LeadingZero(ThisApp.ProductVersion.Minor)+'.'+IntToStr(ThisApp.ProductVersion.Build);
    Version.Caption:=Version.Caption+Format(' %d.%s     %d',[ThisApp.ProductVersion.Major,MinorVer,ThisApp.ProductVersion.Rel]);

    //Version.Caption:=Version.Caption+'     BETA'; 
  end;

  ProductName.Caption:=Application.Title;
  ProgramIcon.Picture.Assign(Application.Icon);

  InfoLabel.Width:=Panel1.Width-2*InfoLabel.Left;
  InfoLabel.Caption:=InfoLabelText;
  if InfoLabelText='' then InfoLabel.Height:=0;
  Panel1.Height:=InfoLabel.BoundsRect.Bottom+4;
  OKButton.Top:=Panel1.BoundsRect.Bottom+4;
  ClientHeight:=OKButton.BoundsRect.Bottom+Panel1.Top;
end;

end.

