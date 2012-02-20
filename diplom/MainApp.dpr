program MainApp;

uses
  Forms,
  unMain in 'unMain.pas' {fmMain},
  unName in 'unName.pas' {fmName},
  unDM in 'unDM.pas' {fmDM: TDataModule},
  unTypes in 'unTypes.pas',
  unConnector in 'unConnector.pas' {fmConnector},
  unSys in 'unSys.pas' {fmSys},
  unCompConf in 'unCompConf.pas' {fmCompConf},
  unCommonFunc in 'unCommonFunc.pas',
  unNewDig in 'unNewDig.pas' {fmNewDig},
  unUnitConf in 'unUnitConf.pas' {fmUnitConf},
  unSigTypes in 'unSigTypes.pas' {fmSigTypes},
  unAddSigGroup in 'unAddSigGroup.pas' {fmAddSigGroup},
  unProbTags in 'unProbTags.pas' {fmProbTags},
  unMap in 'unMap.pas' {fmMap},
  unReport in 'unReport.pas' {fmReport},
  unMapManual in 'unMapManual.pas' {fmMapManual};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmDM, fmDM);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmName, fmName);
  Application.CreateForm(TfmConnector, fmConnector);
  Application.CreateForm(TfmSys, fmSys);
  Application.CreateForm(TfmCompConf, fmCompConf);
  Application.CreateForm(TfmNewDig, fmNewDig);
  Application.CreateForm(TfmUnitConf, fmUnitConf);
  Application.CreateForm(TfmSigTypes, fmSigTypes);
  Application.CreateForm(TfmAddSigGroup, fmAddSigGroup);
  Application.CreateForm(TfmProbTags, fmProbTags);
  Application.CreateForm(TfmMapManual, fmMapManual);
  Application.CreateForm(TfmMap, fmMap);
  Application.CreateForm(TfmReport, fmReport);
  Application.Run;
end.
