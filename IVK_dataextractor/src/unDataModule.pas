unit unDataModule;

interface

uses
  SysUtils, Classes, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ADODB;

type
  TIVK_DM = class(TDataModule)
    connIVK_DB: TADOConnection;
    tbTags: TADOTable;
    tbTWX_GLOBAL: TADOTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IVK_DM: TIVK_DM;

implementation

{$R *.dfm}

end.
