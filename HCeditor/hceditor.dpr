program hceditor;

uses
  Forms,
  unHCEditorMain in 'src\unHCEditorMain.pas' {fmHCEditorMain},
  unStageEditor in 'src\unStageEditor.pas' {fmStageEditor},
  unCommonFunc in 'src\unCommonFunc.pas',
  unNewStage in 'src\unNewStage.pas' {fmNewStage},
  unCycleEditor in 'src\unCycleEditor.pas' {fmCycleEditor},
  unPreview in 'src\unPreview.pas' {fmPreview},
  unAbout in 'src\unAbout.pas' {fmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmHCEditorMain, fmHCEditorMain);
  Application.CreateForm(TfmStageEditor, fmStageEditor);
  Application.CreateForm(TfmNewStage, fmNewStage);
  Application.CreateForm(TfmCycleEditor, fmCycleEditor);
  Application.CreateForm(TfmPreview, fmPreview);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.Run;
end.
