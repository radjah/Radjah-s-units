program ControlScales;

uses
  Forms,
  ControlForm in 'ControlForm.pas' {ControlScalesForm} ,
  mdMailSlot in 'mdMailSlot.pas',
  RollBuf in 'RollBuf.pas',
  RollIntf in 'RollIntf.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Контроль весов';
  Application.CreateForm(TControlScalesForm, ControlScalesForm);
  Application.Run;

end.
