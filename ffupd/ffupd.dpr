program ffupd;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FFupdApp};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFFupdApp, FFupdApp);
  Application.Title:='Обновление Mozilla Firefox';
  Application.Run;
end.
