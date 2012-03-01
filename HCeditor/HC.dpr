program HC;

uses
  Forms,
  unHCMain in 'src\unHCMain.pas' {HCMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THCMain, HCMain);
  Application.Run;
end.
