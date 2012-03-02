program tarprog;

{$R *.dres}

uses
  Forms,
  uMain in 'src\uMain.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Подготовка таблицы для проведения тарировки';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
