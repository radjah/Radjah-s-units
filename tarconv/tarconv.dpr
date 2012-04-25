program tarconv;

uses
  Forms,
  unMain in 'src\unMain.pas' {fmMain},
  unAdvSettings in 'src\unAdvSettings.pas' {btAdvSettings};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title:='Конвертор тарировочных таблиц';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TbtAdvSettings, btAdvSettings);
  Application.Run;
end.
