program IVK_dataconverter;

uses
  Forms,
  unDCMain in 'src\unDCMain.pas' {fmDCMain},
  unStruct in 'src\unStruct.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmDCMain, fmDCMain);
  Application.Run;
end.
