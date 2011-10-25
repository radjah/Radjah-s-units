program tabgen;

uses
  Forms,
  uMain in 'src\uMain.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Генерация таблиц для FTDraw';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;

end.
