program CreateDB;

uses
  Forms,
  unCreatDBMain in 'src\unCreatDBMain.pas' {fmDBService},
  unCommonFunc in 'src\unCommonFunc.pas',
  unAbout in 'src\unAbout.pas' {fmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmDBService, fmDBService);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.Run;
end.
