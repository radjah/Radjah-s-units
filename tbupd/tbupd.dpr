program tbupd;

uses
  Forms,
  unMain in 'src\unMain.pas' {TBupdApp};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTBupdApp, TBupdApp);
  Application.Title:='Обновление Mozilla Thunderbird';
  Application.Run;
end.
