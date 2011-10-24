program stat_3f;

uses
  Forms,
  unMain in 'src\unMain.pas' {fmMain},
  unResult in 'src\unResult.pas' {fmResult},
  unRename in 'src\unRename.pas' {fmRename};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Трехфакторный анализ';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmResult, fmResult);
  Application.CreateForm(TfmRename, fmRename);
  Application.Run;

end.
