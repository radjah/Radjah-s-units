program devnet_logger;

uses
  Forms,
  unDevNetLogger in 'unDevNetLogger.pas' {fmDevNetLogger};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmDevNetLogger, fmDevNetLogger);
  Application.Run;
end.
