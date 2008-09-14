unit DesignerSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  DiagramBase, StdCtrls, ValueEdits, Math, StyleForm, Settings, StringUtils,
  ExtCtrls, Buttons;

type
  TDisplayUnits = (duMM,duCM,duInch,duPoints,du300,du600);

const
  DisplayUnitSize   : array[TDisplayUnits] of Double = (DesignerDPmm,DesignerDPmm*10,DesignerDPI,
                                                        DesignerDPpoint,DesignerDPI/300,DesignerDPI/600);
  DisplayUnitName   : array[TDisplayUnits] of string = (' mm',' cm','"',' points',' dots',' dots');
  DisplayUnitFormat : array[TDisplayUnits] of string = ('0.0','0.00','0.00','0','0','0');

type
  TDesignerSetup = object
                     DisplayUnits           : TDisplayUnits;
                     Grid                   : TPoint;
                     ShowGrid               : Boolean;
                     ReversePrint           : Boolean;
                     UndoHistory            : Integer;
                     ClipboardMetafileScale : Integer;
                     Antialiasing           : Integer;
                     DictionaryPath         : string;
                     procedure LoadSettings(Setup: TProgramSetup);
                     procedure SaveSettings(Setup: TProgramSetup);
                   end;

  TDesignerSetupForm = class(TStyleForm)
    GridBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GridXEdit: TFloatEdit;
    GridYEdit: TFloatEdit;
    Button1: TButton;
    Button2: TButton;
    ShowGridBox: TCheckBox;
    Label3: TLabel;
    UndoHistoryEdit: TIntegerEdit;
    Label4: TLabel;
    ClipboardScaleEdit: TIntegerEdit;
    Label5: TLabel;
    UnitsBox: TComboBox;
    LanguageButton: TBitBtn;
    DictionaryPathButton: TButton;
    Bevel1: TBevel;
    FileFormatAssociationsButton: TButton;
    Label6: TLabel;
    AntialiasingEdit: TIntegerEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure UnitsBoxChange(Sender: TObject);
    procedure LanguageButtonClick(Sender: TObject);
    procedure DictionaryPathButtonClick(Sender: TObject);
    procedure FileFormatAssociationsButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Options : TDesignerSetup;

    class function Execute(var AOptions : TDesignerSetup): Boolean;
  end;

resourcestring
  rsGridS = 'Grid (%s)';
  rsDictionariesDicDic = 'Dictionaries (*.dic)|*.dic';

implementation

uses LanguageSelector, FileUtils, SpellChecker, Main, FormatAssociation,
  FormatAssociationRegister, WinAPIUtils;

{$R *.dfm}

//==============================================================================================================================
// TDesignerSetup
//==============================================================================================================================
procedure TDesignerSetup.LoadSettings(Setup : TProgramSetup);
begin
  Grid:=Point(Max(1,Setup.GetInteger('GridX',DesignerDPmm)),
              Max(1,Setup.GetInteger('GridY',DesignerDPmm)));
  ShowGrid:=Setup.GetBoolean('ShowGrid',False);
  ReversePrint:=Setup.GetBoolean('ReversePrint',False);
  UndoHistory:=Setup.GetInteger('UndoHistory',5);
  ClipboardMetafileScale:=Setup.GetInteger('ClipboardScale',1);
  Antialiasing:=Setup.GetInteger('Antialiasing',2);
  DisplayUnits:=TDisplayUnits(Setup.GetInteger('DisplayUnits',Integer(duMM)));
  DictionaryPath:=Setup.GetString('DictionaryPath',ProgramPath);
end;

procedure TDesignerSetup.SaveSettings(Setup : TProgramSetup);
begin
  Setup.WriteInteger('GridX',Grid.X);
  Setup.WriteInteger('GridY',Grid.Y);
  Setup.WriteBoolean('ShowGrid',ShowGrid);
  Setup.WriteBoolean('ReversePrint',ReversePrint);
  Setup.WriteInteger('UndoHistory',UndoHistory);
  Setup.WriteInteger('ClipboardScale',ClipboardMetafileScale);
  Setup.WriteInteger('Antialiasing',Antialiasing);
  Setup.WriteInteger('DisplayUnits',Integer(DisplayUnits));
  Setup.WriteString('DictionaryPath',DictionaryPath);
end;

//==============================================================================================================================
// TDesignerSetupForm
//==============================================================================================================================
class function TDesignerSetupForm.Execute(var AOptions: TDesignerSetup): Boolean;
begin
  with Create(nil,GetActiveFormHandle) do
  try
    Options:=AOptions;

    ShowGridBox.Checked:=Options.ShowGrid;
    UndoHistoryEdit.Value:=Options.UndoHistory;
    ClipboardScaleEdit.Value:=Options.ClipboardMetafileScale;
    AntialiasingEdit.Value:=Options.Antialiasing;
    UnitsBox.ItemIndex:=Integer(Options.DisplayUnits);

    Result:=ShowModal=mrOk;
    if Result then AOptions:=Options;
  finally
    Free;
  end;
end;

procedure TDesignerSetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult=mrOk then
  begin
    Options.Grid.X:=Max(1,Round(GridXEdit.Value*DisplayUnitSize[Options.DisplayUnits]));
    Options.Grid.Y:=Max(1,Round(GridYEdit.Value*DisplayUnitSize[Options.DisplayUnits]));
    Options.ShowGrid:=ShowGridBox.Checked;
    Options.UndoHistory:=UndoHistoryEdit.Value;
    Options.ClipboardMetafileScale:=ClipboardScaleEdit.Value;
    Options.Antialiasing:=AntialiasingEdit.Value;
  end;
end;

procedure TDesignerSetupForm.FormShow(Sender: TObject);
begin
  GridBox.Caption:=Format(rsGridS,[RemLeadSpace(DisplayUnitName[Options.DisplayUnits])]);
  GridXEdit.FormatString:=DisplayUnitFormat[Options.DisplayUnits];
  GridXEdit.Max:=1001/DisplayUnitSize[Options.DisplayUnits]*DesignerDPmm;
  GridXEdit.Value:=Options.Grid.X/DisplayUnitSize[Options.DisplayUnits];
  GridYEdit.FormatString:=GridXEdit.FormatString;
  GridYEdit.Max:=GridXEdit.Max;
  GridYEdit.Value:=Options.Grid.Y/DisplayUnitSize[Options.DisplayUnits];
  GridXEdit.SelectAll;
  SetElevationRequiredState(FileFormatAssociationsButton);
end;

procedure TDesignerSetupForm.UnitsBoxChange(Sender: TObject);
begin
  Options.Grid.X:=Round(GridXEdit.Value*DisplayUnitSize[Options.DisplayUnits]);
  Options.Grid.Y:=Round(GridYEdit.Value*DisplayUnitSize[Options.DisplayUnits]);
  Options.DisplayUnits:=TDisplayUnits(UnitsBox.ItemIndex);
  FormShow(nil);
end;

procedure TDesignerSetupForm.LanguageButtonClick(Sender: TObject);
begin
  TLanguageSelectorForm.Execute(True);
end;

procedure TDesignerSetupForm.DictionaryPathButtonClick(Sender: TObject);
var
  Dictionary : string;
begin
  Dictionary:=Options.DictionaryPath;
  if OpenFileDialog(Dictionary,rsDictionariesDicDic) then
  begin
    Options.DictionaryPath:=ExtractFilePath(Dictionary);
    FreeAndNil(SpellCheckForm);
  end;
end;

procedure TDesignerSetupForm.FileFormatAssociationsButtonClick(Sender: TObject);
begin
  if WindowsIsVistaOrLater and not ProcessHasAdministratorPrivileges then
  try
    Enabled:=False;
    RunAsAdministrator(ParamStr(0),'**',True) // In Vista, run admin process
  finally
    Enabled:=True;
  end
  else
  begin
    Application.Title:=MainForm.ApplicationTitle;
    TFormatAssociateRegisterForm.Execute(rsDiagramFileFilter+'|'+rsTemplatePaletteFilter+'|',[0]);
    Application.Title:=MainForm.Caption;
  end;
end;

end.

