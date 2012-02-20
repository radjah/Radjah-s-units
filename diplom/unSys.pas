unit unSys;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, unDM, DB, Grids, DBGrids, ADODB, StdCtrls,
  unNewDig, unCommonFunc, hh;

type
  TfmSys = class(TForm)
    MainMenu1: TMainMenu;
    dbgSysConf: TDBGrid;
    dsSysConf: TDataSource;
    btAddSig: TButton;
    qSysConf: TADOQuery;
    qAvSigs: TADOQuery;
    ADOQuery: TADOQuery;
    dbgAvSigs: TDBGrid;
    dsAvSigs: TDataSource;
    btDelSig: TButton;
    qAvSigssigtag: TStringField;
    qAvSigssigname: TStringField;
    qAvSigssigid: TAutoIncField;
    qSysConfid: TAutoIncField;
    qSysConfsigtag: TStringField;
    qSysConfsigid: TIntegerField;
    qSysConfsigquant: TIntegerField;
    Label1: TLabel;
    Label2: TLabel;
    btHelp: TButton;
    procedure btAddSigClick(Sender: TObject);
    procedure btDelSigClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSys: TfmSys;

implementation

{$R *.dfm}

procedure TfmSys.btAddSigClick(Sender: TObject);
begin
  if getnewdig then
  begin
    if NewDig>0 then
    begin
      ADOQuery.Close;
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add('insert into sysconf (sigid,sigquant)');
      ADOQuery.SQL.Add('values ('+inttostr(integer(qAvSigs.FieldValues['sigid']))+','+inttostr(NewDig)+')');
      ADOQuery.ExecSQL;
      ReopenDatasets([qSysConf,qAvSigs]);
    end else ShowMessage('Колчество сигналов не может быть нулевым или отрицательным');
  end;
end;

procedure TfmSys.btDelSigClick(Sender: TObject);
begin
  if ConfirmDel(self.Handle,'сигналы с тегом '+string(qSysConf.FieldValues['sigtag']))
  then
  begin
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('delete from sysconf');
    ADOQuery.SQL.Add('where sigid='+inttostr(integer(qSysConf.FieldValues['sigid'])));
    ADOQuery.ExecSQL;
    ReopenDatasets([qSysConf,qAvSigs]);
  end;
end;

procedure TfmSys.btHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unSys.dfm.html',HH_DISPLAY_TOPIC,0);
end;

end.
