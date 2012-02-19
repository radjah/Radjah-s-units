program ffupd;

uses
  Forms,
  Unit1 in 'Unit1.pas' {TBupdApp};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTBupdApp, TBupdApp);
  Application.Title:='Обновление Mozilla Thunderbird';
  Application.Run;
end.
