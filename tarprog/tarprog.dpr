program tarprog;

{$R *.dres}

uses
  Forms,
  uMain in 'src\uMain.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���������� ������� ��� ���������� ���������';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
