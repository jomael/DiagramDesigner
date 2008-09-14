program DiagramDesigner;

uses
  FastMM4,
  Forms,
  ImageDLLLoader in 'ImageDLLLoader.pas',
  Main in 'Main.pas' {MainForm},
  DiagramBase in 'DiagramBase.pas',
  LinarBitmap in 'LinarBitmap.pas',
  ShapeObject in 'ShapeObject.pas',
  TemplateObjects in 'TemplateObjects.pas',
  ExpressionPlot in 'ExpressionPlot.pas' {ExpressionPlotForm},
  ExpressionHelp in 'ExpressionHelp.pas' {ExpressionEvalForm},
  ExpressionEval in 'ExpressionEval.pas',
  DesignerSetup in 'DesignerSetup.pas' {DesignerSetupForm},
  FormatAssociation in 'FormatAssociation.pas' {FormatAssociateForm},
  PropertyEditor in 'PropertyEditor.pas' {PropertyEditorForm},
  LineObject in 'LineObject.pas',
  PictureObject in 'PictureObject.pas',
  EventUtils in 'EventUtils.pas',
  GroupObject in 'GroupObject.pas',
  RearrangePages in 'RearrangePages.pas' {RearrangePagesForm},
  LinkEditor in 'LinkEditor.pas' {LinkEditorForm},
  ObjectTree in 'ObjectTree.pas',
  PleaseSupport in 'PleaseSupport.pas' {PleaseSupportForm},
  FlowchartObject in 'FlowchartObject.pas',
  PageProperties in 'PageProperties.pas' {PagePropertiesForm},
  LanguageSelector in 'LanguageSelector.pas' {LanguageSelectorForm},
  Settings in 'Settings.pas',
  About in 'About.pas' {AboutBox},
  PasteSpecial in 'PasteSpecial.pas' {PasteSpecialForm},
  ColorDialog in 'ColorDialog.pas',
  StyleForm in 'StyleForm.pas',
  SlideShow in 'SlideShow.pas' {SlideShowForm},
  SynSpellCheck in 'synspellcheck\SynSpellCheck.pas',
  SpellChecker in 'SpellChecker.pas' {SpellCheckForm},
  MathUtils in 'MathUtils.pas',
  ICOLoader in 'ICOLoader.pas' {IconSelectionForm},
  ValueEdits in 'ValueEdits.pas',
  ThemedBackground in 'ThemedBackground.pas',
  PanelFrame in 'PanelFrame.pas',
  TextEditor in 'TextEditor.pas' {TextEditorForm},
  MemUtils in 'MemUtils.pas',
  TranslationTools in 'TranslationTools.pas',
  QuickMenuSearch in 'QuickMenuSearch.pas' {QuickMenuSearchForm},
  QuickActionSearch in 'QuickActionSearch.pas' {QuickActionSearchForm},
  FormatAssociationRegister in 'FormatAssociationRegister.pas' {FormatAssociateRegisterForm},
  WinAPIUtils in 'WinAPIUtils.pas',
  FastBitmap in 'FastBitmap.pas',
  BitmapAntialiasingScaling in 'BitmapAntialiasingScaling.pas',
  BitmapGammaInterpolation in 'BitmapGammaInterpolation.pas';

{$R *.res}
{$R manifest-invoker.res}

begin
  Application.Title := 'Diagram Designer';
  CreateSetup('Software\MeeSoft\DiagramDesigner');
  LoadSelectedLanguage(False);
  if (ParamStr(1) = '**') then
  begin
    TFormatAssociateRegisterForm.Execute(rsDiagramFileFilter+'|'+rsTemplatePaletteFilter+'|',[0]);
    Exit;
  end;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

