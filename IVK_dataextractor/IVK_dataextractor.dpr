program IVK_dataextractor;

uses
  Forms,
  unDataModule in 'src\unDataModule.pas' {IVK_DM: TDataModule},
  unMain in 'src\unMain.pas' {fmMain},
  MyFunctions in '..\libs\MyFunctions.pas',
  ExcelAddOns in '..\libs\ExcelAddOns.pas',
  unView in 'src\unView.pas' {fmView},
  unStruct in 'src\unStruct.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TIVK_DM, IVK_DM);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmView, fmView);
  Application.Run;
end.
