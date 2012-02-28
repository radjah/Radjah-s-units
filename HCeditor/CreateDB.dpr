program CreateDB;

uses
  Forms,
  unCreatDBMain in 'src\unCreatDBMain.pas' {Form1},
  unCommonFunc in 'src\unCommonFunc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
