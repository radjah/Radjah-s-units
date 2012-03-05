program HC;

uses
  Forms,
  unHCMain in 'src\unHCMain.pas' {HCMain},
  unAbout in 'src\unAbout.pas' {fmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THCMain, HCMain);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.Run;
end.
