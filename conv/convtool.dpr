program convtool;

uses
  Forms,
  unMain in 'src\unMain.pas' {MainForm},
  ExcelAddOns in 'src\ExcelAddOns.pas',
  uSettings in 'src\uSettings.pas' {fmSettings},
  uAbout in 'src\uAbout.pas' {fmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Конвертер базы данных';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfmSettings, fmSettings);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.Run;
end.
