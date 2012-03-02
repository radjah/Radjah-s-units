program MainApp;

uses
  Forms,
  unMain in 'src\unMain.pas' {fmMain},
  unName in 'src\unName.pas' {fmName},
  unDM in 'src\unDM.pas' {fmDM: TDataModule},
  unTypes in 'src\unTypes.pas',
  unConnector in 'src\unConnector.pas' {fmConnector},
  unSys in 'src\unSys.pas' {fmSys},
  unCompConf in 'src\unCompConf.pas' {fmCompConf},
  unCommonFunc in 'src\unCommonFunc.pas',
  unNewDig in 'src\unNewDig.pas' {fmNewDig},
  unUnitConf in 'src\unUnitConf.pas' {fmUnitConf},
  unSigTypes in 'src\unSigTypes.pas' {fmSigTypes},
  unAddSigGroup in 'src\unAddSigGroup.pas' {fmAddSigGroup},
  unProbTags in 'src\unProbTags.pas' {fmProbTags},
  unMap in 'src\unMap.pas' {fmMap},
  unReport in 'src\unReport.pas' {fmReport},
  unMapManual in 'src\unMapManual.pas' {fmMapManual};

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
