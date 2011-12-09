program HC;

uses
  Forms,
  uMain in 'src\uMain.pas' {Main},
  uEditor in 'src\uEditor.pas' {Editor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TEditor, Editor);
  Application.Run;

end.
