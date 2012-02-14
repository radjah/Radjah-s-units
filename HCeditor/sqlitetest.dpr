program sqlitetest;

uses
  Forms,
  unMain in 'src\unMain.pas' {fmMain},
  unStageEditor in 'src\unStageEditor.pas' {fmStageEditor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmStageEditor, fmStageEditor);
  Application.Run;
end.
