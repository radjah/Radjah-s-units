program stat_1f;

uses
  Forms,
  unMain in 'src\unMain.pas' {fmMain} ,
  unResult in 'src\unResult.pas' {fmResult};

{$R *.res}

begin
  Application.Initialize;
  // Application.MainFormOnTaskbar := True;
  Application.Title := 'Однофакторный анализ';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmResult, fmResult);
  Application.Run;

end.
