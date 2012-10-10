program IVK_dataextractor;

uses
  Forms,
  unDataModule in 'src\unDataModule.pas' {IVK_DM: TDataModule},
  unMain in 'src\unMain.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TIVK_DM, IVK_DM);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
