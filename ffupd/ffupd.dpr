program ffupd;

uses
  Forms,
  unMain in 'src\unMain.pas' {FFupdApp};

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='Обновление Mozilla Firefox';
  Application.CreateForm(TFFupdApp, FFupdApp);
  Application.Run;
end.
