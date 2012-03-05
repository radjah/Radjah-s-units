program CreateDB;

uses
  Forms,
  unCreatDBMain in 'src\unCreatDBMain.pas' {Form1},
  unCommonFunc in 'src\unCommonFunc.pas',
  unAbout in 'src\unAbout.pas' {fmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.Run;
end.
