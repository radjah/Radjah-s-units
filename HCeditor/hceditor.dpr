program hceditor;

uses
  Forms,
  unMain in 'src\unMain.pas' {fmMain},
  unStageEditor in 'src\unStageEditor.pas' {fmStageEditor},
  unCommonFunc in 'src\unCommonFunc.pas',
  unNewStage in 'src\unNewStage.pas' {fmNewStage},
  unCycleEditor in 'src\unCycleEditor.pas' {fmCycleEditor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmStageEditor, fmStageEditor);
  Application.CreateForm(TfmNewStage, fmNewStage);
  Application.CreateForm(TfmCycleEditor, fmCycleEditor);
  Application.Run;
end.
