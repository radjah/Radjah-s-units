unit unMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  StdCtrls, ShellAPI, Dialogs, XPMan;

type
  TFFupdApp = class(TForm)
    eFFPath: TEdit;
    btFFPathBrowse: TButton;
    Label1: TLabel;
    eUpdateFile: TEdit;
    Label2: TLabel;
    btUpdateBrowse: TButton;
    btUpdate: TButton;
    odFFPath: TOpenDialog;
    odUpdateFile: TOpenDialog;
    XPManifest1: TXPManifest;
    btCleanUp: TButton;
    btCheck: TButton;
    procedure btFFPathBrowseClick(Sender: TObject);
    procedure btUpdateBrowseClick(Sender: TObject);
    procedure btUpdateClick(Sender: TObject);
    procedure btCleanUpClick(Sender: TObject);
    procedure btCheckClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFupdApp: TFFupdApp;

implementation

{$R *.dfm}

procedure TFFupdApp.btFFPathBrowseClick(Sender: TObject);
begin
  if odFFPath.Execute then
    eFFPath.Text := ExtractFilePath(odFFPath.FileName);
end;

procedure TFFupdApp.btUpdateBrowseClick(Sender: TObject);
begin
  if odUpdateFile.Execute then
    eUpdateFile.Text := odUpdateFile.FileName;
end;

procedure TFFupdApp.btUpdateClick(Sender: TObject);
begin
  if (eFFPath.Text <> '') and (eUpdateFile.Text <> '') then
  begin
    if FileExists(eFFPath.Text + 'firefox-update\updater.exe') then
      DeleteFile(eFFPath.Text + 'firefox-update\updater.exe');
    if FileExists(eFFPath.Text + 'firefox-update\updater.ini') then
      DeleteFile(eFFPath.Text + 'firefox-update\updater.ini');
    if FileExists(eFFPath.Text + 'firefox-update\update.log') then
      DeleteFile(eFFPath.Text + 'firefox-update\update.log');
    if FileExists(eFFPath.Text + 'firefox-update\update.mar') then
      DeleteFile(eFFPath.Text + 'firefox-update\update.mar');
    if FileExists(eFFPath.Text + 'firefox-update\update.manifest') then
      DeleteFile(eFFPath.Text + 'firefox-update\update.manifest');
    if FileExists(eFFPath.Text + 'firefox-update\update.status') then
      DeleteFile(eFFPath.Text + 'firefox-update\update.status');
    if DirectoryExists(eFFPath.Text + 'firefox-update') then
      RemoveDir(eFFPath.Text + 'firefox-update');
    if CreateDirectory(pchar(eFFPath.Text + 'firefox-update'), nil) and
      CopyFile(pchar(eUpdateFile.Text),
      pchar(eFFPath.Text + 'firefox-update\update.mar'), FALSE) and
      CopyFile(pchar(eFFPath.Text + 'updater.exe'),
      pchar(eFFPath.Text + 'firefox-update\updater.exe'), FALSE) and
      CopyFile(pchar(eFFPath.Text + 'updater.ini'),
      pchar(eFFPath.Text + 'firefox-update\updater.ini'), FALSE) then
    begin
      SetCurrentDirectory(pchar(eFFPath.Text));
      WinExec('firefox-update\updater.exe .\firefox-update 0', SW_SHOWDEFAULT);
      btCheck.Enabled := True;
    end
    else
      showmessage('Не удалось скопировать файлы!' + #13 + 'Удалите папку ' +
        eFFPath.Text + 'firefox-update');
  end
  else
    showmessage('Не все данные указаны!');
end;

procedure TFFupdApp.btCleanUpClick(Sender: TObject);
begin
  if (eFFPath.Text <> '') then
  begin
    if FileExists(eFFPath.Text + 'firefox-update\updater.exe') then
      DeleteFile(eFFPath.Text + 'firefox-update\updater.exe');
    if FileExists(eFFPath.Text + 'firefox-update\updater.ini') then
      DeleteFile(eFFPath.Text + 'firefox-update\updater.ini');
    if FileExists(eFFPath.Text + 'firefox-update\update.log') then
      DeleteFile(eFFPath.Text + 'firefox-update\update.log');
    if FileExists(eFFPath.Text + 'firefox-update\update.mar') then
      DeleteFile(eFFPath.Text + 'firefox-update\update.mar');
    if FileExists(eFFPath.Text + 'firefox-update\update.manifest') then
      DeleteFile(eFFPath.Text + 'firefox-update\update.manifest');
    if FileExists(eFFPath.Text + 'firefox-update\update.status') then
      DeleteFile(eFFPath.Text + 'firefox-update\update.status');
    if DirectoryExists(eFFPath.Text + 'firefox-update') then
      RemoveDir(eFFPath.Text + 'firefox-update');
  end
  else
    showmessage('Не все данные указаны!');
end;

procedure TFFupdApp.btCheckClick(Sender: TObject);
var
  fin: ANSIstring;
  res: textfile;
begin
  assignfile(res, eFFPath.Text + 'firefox-update\update.status');
  reset(res);
  readln(res, fin);
  showmessage(fin);
  closefile(res);
  btCheck.Enabled := FALSE;
end;

end.
