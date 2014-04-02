program devnet_logger;

uses
  Forms,
  unDevNetLogger in 'unDevNetLogger.pas' {fmDevNetLogger},
  unArchive in 'unArchive.pas' {fmArchive},
  DevNetDec in '..\..\libs\DevNetDec.pas',
  MyFunctions in '..\..\libs\MyFunctions.pas',
  ExcelAddOns in '..\..\libs\ExcelAddOns.pas',
  unChart in 'unChart.pas' {fmChart};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmDevNetLogger, fmDevNetLogger);
  Application.CreateForm(TfmArchive, fmArchive);
  Application.CreateForm(TfmChart, fmChart);
  Application.Run;
end.
