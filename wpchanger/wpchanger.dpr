program wpchanger;

uses
  Forms,
  unMain in 'unMain.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  application.Title:='Менялка обоев';
  Application.Run;
end.
