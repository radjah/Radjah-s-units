program tarprog;

uses
  Forms,
  uMain in 'uMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Подготовка таблицы для проведения тарировки';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
