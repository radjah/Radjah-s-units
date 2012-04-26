program tarconv;

uses
  Forms,
  unMain in 'src\unMain.pas' {fmMain},
  unAdvSettings in 'src\unAdvSettings.pas' {fmAdvSettings},
  MyFunctions in '..\libs\MyFunctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title:='Конвертор тарировочных таблиц';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmAdvSettings, fmAdvSettings);
  Application.Run;
end.
