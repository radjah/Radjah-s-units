unit unMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  StdCtrls, ShellAPI, Dialogs, XPMan;

type
  TTBupdApp = class(TForm)
    eTBPath: TEdit;
    btTBBrowse: TButton;
    Label1: TLabel;
    eUpdateFile: TEdit;
    Label2: TLabel;
    btUpdateFileBrowse: TButton;
    btUpdate: TButton;
    odff: TOpenDialog;
    odmar: TOpenDialog;
    XPManifest1: TXPManifest;
    btCleanup: TButton;
    btCheck: TButton;
    procedure btTBBrowseClick(Sender: TObject);
    procedure btUpdateFileBrowseClick(Sender: TObject);
    procedure btUpdateClick(Sender: TObject);
    procedure btCleanupClick(Sender: TObject);
    procedure btCheckClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TBupdApp: TTBupdApp;

implementation

{$R *.dfm}

procedure TTBupdApp.btTBBrowseClick(Sender: TObject);
begin
  if odff.Execute then eTBPath.Text:=ExtractFilePath(odff.FileName);
end;

procedure TTBupdApp.btUpdateFileBrowseClick(Sender: TObject);
begin
  if odmar.Execute then eUpdateFile.Text:=odmar.FileName;
end;

procedure TTBupdApp.btUpdateClick(Sender: TObject);
begin
  if (eTBPath.Text<>'') and (eUpdateFile.Text<>'') then
  begin
    if FileExists(eTBPath.Text+'thunderbir-update\updater.exe') then DeleteFile(eTBPath.Text+'thunderbir-update\updater.exe');
    if FileExists(eTBPath.Text+'thunderbir-update\updater.ini') then DeleteFile(eTBPath.Text+'thunderbir-update\updater.ini');
    if FileExists(eTBPath.Text+'thunderbir-update\update.log') then DeleteFile(eTBPath.Text+'thunderbir-update\update.log');
    if FileExists(eTBPath.Text+'thunderbir-update\update.mar') then DeleteFile(eTBPath.Text+'thunderbir-update\update.mar');
    if FileExists(eTBPath.Text+'thunderbir-update\update.manifest') then DeleteFile(eTBPath.Text+'thunderbir-update\update.manifest');
    if FileExists(eTBPath.Text+'thunderbir-update\update.status') then DeleteFile(eTBPath.Text+'thunderbir-update\update.status');
    if DirectoryExists(eTBPath.Text+'thunderbir-update') then RemoveDir(eTBPath.Text+'thunderbir-update');
    if CreateDirectory(pchar(eTBPath.Text+'thunderbir-update'),nil) and
      CopyFile(pchar(eUpdateFile.Text),pchar(eTBPath.Text+'thunderbir-update\update.mar'),FALSE) and
      CopyFile(pchar(eTBPath.Text+'updater.exe'),pchar(eTBPath.Text+'thunderbir-update\updater.exe'),FALSE) and
      CopyFile(pchar(eTBPath.Text+'updater.ini'),pchar(eTBPath.Text+'thunderbir-update\updater.ini'),FALSE)
      then
      begin
        SetCurrentDirectory(pchar(eTBPath.Text));
        WinExec('thunderbir-update\updater.exe .\thunderbir-update 0',SW_SHOWDEFAULT);
        btCheck.Enabled:=True;
      end
    else showmessage('Не удалось скопировать файлы!'+#13+'Удалите папку '+eTBPath.Text+'thunderbir-update');
  end else showmessage('Не все данные указаны!');
end;

procedure TTBupdApp.btCleanupClick(Sender: TObject);
begin
if (eTBPath.Text<>'') then
  begin
    if FileExists(eTBPath.Text+'thunderbir-update\updater.exe') then DeleteFile(eTBPath.Text+'thunderbir-update\updater.exe');
    if FileExists(eTBPath.Text+'thunderbir-update\updater.ini') then DeleteFile(eTBPath.Text+'thunderbir-update\updater.ini');
    if FileExists(eTBPath.Text+'thunderbir-update\update.log') then DeleteFile(eTBPath.Text+'thunderbir-update\update.log');
    if FileExists(eTBPath.Text+'thunderbir-update\update.mar') then DeleteFile(eTBPath.Text+'thunderbir-update\update.mar');
    if FileExists(eTBPath.Text+'thunderbir-update\update.manifest') then DeleteFile(eTBPath.Text+'thunderbir-update\update.manifest');
    if FileExists(eTBPath.Text+'thunderbir-update\update.status') then DeleteFile(eTBPath.Text+'thunderbir-update\update.status');
    if DirectoryExists(eTBPath.Text+'thunderbir-update') then RemoveDir(eTBPath.Text+'thunderbir-update');
  end else showmessage('Не все данные указаны!');
end;

procedure TTBupdApp.btCheckClick(Sender: TObject);
var
  fin:ANSIstring;
  res:textfile;
begin
        AssignFile(res,eTBPath.Text+'thunderbir-update\update.status');
        Reset(res);
        Readln(res,fin);
        ShowMessage(fin);
        CloseFile(res);
        btCheck.Enabled:=False;
end;

end.

