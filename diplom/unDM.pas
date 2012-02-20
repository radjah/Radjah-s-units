unit unDM;

interface

uses
  SysUtils, Classes, DB, ADODB, Dialogs;

type
  TfmDM = class(TDataModule)
    ADOConn: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDM: TfmDM;

implementation

{$R *.dfm}

procedure TfmDM.DataModuleCreate(Sender: TObject);
begin
  ADOConn.Close;
  ADOConn.ConnectionString:='FILE NAME='+GetCurrentDir+'\conn.udl';
  ADOConn.Open;
end;

end.
