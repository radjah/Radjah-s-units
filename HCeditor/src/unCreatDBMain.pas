unit unCreatDBMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SQLiteTable3, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    odOpenDB: TOpenDialog;
    btCreateDB: TButton;
    btOptim: TButton;
    btOpenDB: TButton;
    mmSQL: TMemo;
    Label1: TLabel;
    dbgResult: TDBGrid;
    Label2: TLabel;
    zConn: TZConnection;
    zqCommon: TZQuery;
    dsCommon: TDataSource;
    btOpenDS: TButton;
    btExec: TButton;
    sdSaveDB: TSaveDialog;
    btCloseDB: TButton;
    btAbout: TButton;
    procedure btCreateDBClick(Sender: TObject);
    procedure btOptimClick(Sender: TObject);
    procedure btOpenDBClick(Sender: TObject);
    procedure btOpenDSClick(Sender: TObject);
    procedure btExecClick(Sender: TObject);
    procedure btCloseDBClick(Sender: TObject);
    procedure btAboutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  unCommonFunc, unAbout;

{$R *.dfm}

procedure TForm1.btAboutClick(Sender: TObject);
begin
  fmAbout.lProgrammName.Caption := 'Обслуживание базы';
  fmAbout.ShowModal;
end;

procedure TForm1.btCloseDBClick(Sender: TObject);
begin
  zConn.Disconnect;
  btExec.Enabled := False;
  btOpenDS.Enabled := False;
  btOpenDB.Enabled := True;
  btCloseDB.Enabled := False;
  ShowMessage('База закрыта.');
end;

procedure TForm1.btCreateDBClick(Sender: TObject);

var
  DB: TSQLiteDatabase; // База данных
  MBResult: integer; // Ответ пользователя
  DBFilename: TFileName; // Имя новой базы
  IsNameSet: boolean; // Указаны ли данные?
begin
  MBResult := MessageBox(Self.Handle, 'Создать новую базу в папке программы?' +
    #10#13 + ' (Нет - указать путь и имя вручную)' + #10#13, 'Создание базы',
    MB_YESNOCANCEL or MB_ICONQUESTION);
  if MBResult = IDYES then
  begin
    DBFilename := ExtractFilePath(Application.ExeName) + 'stages.sqlite';
    IsNameSet := True;
  end
  else if MBResult = IDNO then
  begin
    if sdSaveDB.Execute then
    begin
      DBFilename := sdSaveDB.FileName;
      IsNameSet := True
    end
    else
      IsNameSet := False;
  end
  else
    IsNameSet := False;
  if IsNameSet then
  begin
    DB := TSQLiteDatabase.Create(DBFilename);
    // Удаление таблиц
    if DB.TableExists('cstruct') then
      DB.ExecSQL('DROP TABLE cstruct');
    if DB.TableExists('cycle') then
      DB.ExecSQL('DROP TABLE cycle');
    if DB.TableExists('sstruct') then
      DB.ExecSQL('DROP TABLE sstruct');
    if DB.TableExists('stages') then
      DB.ExecSQL('DROP TABLE stages');
    // Создание таблиц
    DB.ExecSQL('CREATE TABLE cstruct (id integer PRIMARY KEY AUTOINCREMENT' +
      ' NOT NULL UNIQUE, cid integer NOT NULL, corder integer NOT NULL,' +
      ' sid integer NOT NULL);');
    DB.ExecSQL('CREATE TABLE cycle (cid integer PRIMARY KEY AUTOINCREMENT' +
      ' NOT NULL UNIQUE, cname varchar(128) NOT NULL);');
    DB.ExecSQL('CREATE TABLE sstruct (pid integer PRIMARY KEY AUTOINCREMENT' +
      ' NOT NULL UNIQUE, sid integer NOT NULL, clevel integer NOT NULL,' +
      ' ptime integer NOT NULL, porder integer NOT NULL);');
    DB.ExecSQL('CREATE TABLE stages (sid integer PRIMARY KEY AUTOINCREMENT' +
      ' NOT NULL UNIQUE, sname varchar(128) NOT NULL);');
    // Создание индексов
    DB.ExecSQL('CREATE INDEX sindex ON cstruct (sid, corder);');
    DB.ExecSQL('CREATE INDEX cname_idx ON cycle (cname);');
    DB.ExecSQL('CREATE INDEX cindex ON sstruct (sid, porder);');
    DB.ExecSQL('CREATE INDEX sname_idx ON stages (sname);');
    DB.Free;
    ShowMessage('Если вы видите это сообщение, то база успешно создана.');
  end;
end;

procedure TForm1.btExecClick(Sender: TObject);
begin
  zqCommon.Close;
  zqCommon.SQL := mmSQL.Lines;
  zqCommon.ExecSQL;
  ShowMessage('Запрос выполнен.');
end;

procedure TForm1.btOpenDBClick(Sender: TObject);
begin
  if odOpenDB.Execute then
  begin
    zConn.Database := odOpenDB.FileName;
    zConn.Connect;
    btExec.Enabled := True;
    btOpenDS.Enabled := True;
    btOpenDB.Enabled := False;
    btCloseDB.Enabled := True;
    ShowMessage('База открыта. Можно выполнять запросы.');
  end;
end;

procedure TForm1.btOpenDSClick(Sender: TObject);
begin
  zqCommon.Close;
  zqCommon.SQL := mmSQL.Lines;
  zqCommon.Open;
end;

procedure TForm1.btOptimClick(Sender: TObject);
var
  DB: TSQLiteDatabase; // База данных
begin
  if odOpenDB.Execute then
  begin
    DB := TSQLiteDatabase.Create(odOpenDB.FileName);
    DB.ExecSQL('REINDEX;');
    DB.ExecSQL('VACUUM;');
    DB.Free;
    ShowMessage('База данных оптимизирована.');
  end;
end;

end.
