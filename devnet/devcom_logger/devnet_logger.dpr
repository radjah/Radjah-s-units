program devnet_logger;

uses
  Forms,
  unDevNetLogger in 'unDevNetLogger.pas' {fmDevNetLogger},
  unArchive in 'unArchive.pas' {fmArchive};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmDevNetLogger, fmDevNetLogger);
  Application.CreateForm(TfmArchive, fmArchive);
  Application.Run;
end.
