program IVK_tar;

uses
  Forms,
  unIVK_tarMain in 'src\unIVK_tarMain.pas' {fmIVK_tarMain},
  MyFunctions in '..\libs\MyFunctions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmIVK_tarMain, fmIVK_tarMain);
  Application.Run;
end.
