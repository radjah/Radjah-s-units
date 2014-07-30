program comtest;

uses
  Forms,
  unMain in 'src\unMain.pas' {fmMain},
  PortUnit in 'src\PortUnit.pas',
  synafpc in 'src\synafpc.pas',
  synaser in 'src\synaser.pas',
  synautil in 'src\synautil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
