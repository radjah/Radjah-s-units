program tarconv;

uses
  Forms,
  unMain in 'unMain.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title:='Конвертор тарировочных таблиц';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
