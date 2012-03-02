unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  StdCtrls, ShellAPI, Dialogs, XPMan;

type
  TTBupdApp = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Button3: TButton;
    odff: TOpenDialog;
    odmar: TOpenDialog;
    XPManifest1: TXPManifest;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TBupdApp: TTBupdApp;

implementation

{$R *.dfm}

procedure TTBupdApp.Button1Click(Sender: TObject);
begin
  if odff.Execute then Edit1.Text:=ExtractFilePath(odff.FileName);
end;

procedure TTBupdApp.Button2Click(Sender: TObject);
begin
  if odmar.Execute then Edit2.Text:=odmar.FileName;
end;

procedure TTBupdApp.Button3Click(Sender: TObject);
begin
  if (Edit1.Text<>'') and (Edit2.Text<>'') then
  begin
    if FileExists(Edit1.Text+'thunderbir-update\updater.exe') then DeleteFile(Edit1.Text+'thunderbir-update\updater.exe');
    if FileExists(Edit1.Text+'thunderbir-update\updater.ini') then DeleteFile(Edit1.Text+'thunderbir-update\updater.ini');
    if FileExists(Edit1.Text+'thunderbir-update\update.log') then DeleteFile(Edit1.Text+'thunderbir-update\update.log');
    if FileExists(Edit1.Text+'thunderbir-update\update.mar') then DeleteFile(Edit1.Text+'thunderbir-update\update.mar');
    if FileExists(Edit1.Text+'thunderbir-update\update.manifest') then DeleteFile(Edit1.Text+'thunderbir-update\update.manifest');
    if FileExists(Edit1.Text+'thunderbir-update\update.status') then DeleteFile(Edit1.Text+'thunderbir-update\update.status');
    if DirectoryExists(Edit1.Text+'thunderbir-update') then RemoveDir(Edit1.Text+'thunderbir-update');
    if CreateDirectory(pchar(Edit1.Text+'thunderbir-update'),nil) and
      CopyFile(pchar(Edit2.Text),pchar(Edit1.Text+'thunderbir-update\update.mar'),FALSE) and
      CopyFile(pchar(Edit1.Text+'updater.exe'),pchar(Edit1.Text+'thunderbir-update\updater.exe'),FALSE) and
      CopyFile(pchar(Edit1.Text+'updater.ini'),pchar(Edit1.Text+'thunderbir-update\updater.ini'),FALSE)
      then
      begin
        SetCurrentDirectory(pchar(Edit1.Text));
        WinExec(pchar('thunderbir-update\updater.exe .\thunderbir-update 0'),SW_SHOWDEFAULT);
        Button5.Enabled:=True;
      end
    else showmessage('Не удалось скопировать файлы!'+#13+'Удалите папку '+Edit1.Text+'thunderbir-update');
  end else showmessage('Не все данные указаны!');
end;

procedure TTBupdApp.Button4Click(Sender: TObject);
begin
if (Edit1.Text<>'') then
  begin
    if FileExists(Edit1.Text+'thunderbir-update\updater.exe') then DeleteFile(Edit1.Text+'thunderbir-update\updater.exe');
    if FileExists(Edit1.Text+'thunderbir-update\updater.ini') then DeleteFile(Edit1.Text+'thunderbir-update\updater.ini');
    if FileExists(Edit1.Text+'thunderbir-update\update.log') then DeleteFile(Edit1.Text+'thunderbir-update\update.log');
    if FileExists(Edit1.Text+'thunderbir-update\update.mar') then DeleteFile(Edit1.Text+'thunderbir-update\update.mar');
    if FileExists(Edit1.Text+'thunderbir-update\update.manifest') then DeleteFile(Edit1.Text+'thunderbir-update\update.manifest');
    if FileExists(Edit1.Text+'thunderbir-update\update.status') then DeleteFile(Edit1.Text+'thunderbir-update\update.status');
    if DirectoryExists(Edit1.Text+'thunderbir-update') then RemoveDir(Edit1.Text+'thunderbir-update');
  end else showmessage('Не все данные указаны!');
end;

procedure TTBupdApp.Button5Click(Sender: TObject);
var
  fin:ANSIstring;
  res:textfile;
begin
        assignfile(res,Edit1.Text+'thunderbir-update\update.status');
        reset(res);
        readln(res,fin);
        showmessage(fin);
        closefile(res);
        Button5.Enabled:=False;
end;

end.

