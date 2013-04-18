program labelmaker;

uses
  Forms,
  unMain in 'src\unMain.pas' {fmMain},
  wordaddons in '..\libs\wordaddons.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
