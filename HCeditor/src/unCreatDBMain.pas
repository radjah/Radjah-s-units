unit unCreatDBMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SQLiteTable3, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, Grids, DBGrids, StdCtrls;

type
  TfmDBService = class(TForm)
    odOpenDB: TOpenDialog;
    btCreateDB: TButton;
    btOptim: TButton;
    zConn: TZConnection;
    zqCommon: TZQuery;
    dsCommon: TDataSource;
    sdSaveDB: TSaveDialog;
    btAbout: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    btOpenDB: TButton;
    mmSQL: TMemo;
    dbgResult: TDBGrid;
    btOpenDS: TButton;
    btExec: TButton;
    btCloseDB: TButton;
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
  fmDBService: TfmDBService;

implementation

uses
  unCommonFunc, unAbout;

{$R *.dfm}

// О программе
procedure TfmDBService.btAboutClick(Sender: TObject);
begin
  fmAbout.lProgrammName.Caption := 'Обслуживание базы';
  fmAbout.ShowModal;
end;

// Закрытие базы
procedure TfmDBService.btCloseDBClick(Sender: TObject);
begin
  zConn.Disconnect;
  btExec.Enabled := False;
  btOpenDS.Enabled := False;
  btOpenDB.Enabled := True;
  btCloseDB.Enabled := False;
  MessageBox(Self.Handle, 'База закрыта.', 'Обслуживание базы данных',
    MB_OK or MB_ICONINFORMATION);
end;

// Создание новой базы
procedure TfmDBService.btCreateDBClick(Sender: TObject);

var
  DB: TSQLiteDatabase; // База данных
  MBResult: integer; // Ответ пользователя
  DBFilename: TFileName; // Имя новой базы
  IsNameSet: boolean; // Указаны ли данные?
begin
  // Запрос
  MBResult := MessageBox(Self.Handle, 'Создать новую базу в папке программы?' +
    #10#13 + #10#13 + 'Внимание! Существующая база при этом будет очищена!' +
    #10#13 + #10#13 + ' (Нет - указать путь и имя вручную)' + #10#13,
    'Создание базы', MB_YESNOCANCEL or MB_ICONQUESTION);
  // Если создаем базу по месту
  if MBResult = IDYES then
  begin
    DBFilename := ExtractFilePath(Application.ExeName) + 'stages.sqlite';
    IsNameSet := True;
  end
  // Если сами указываем место
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
  // Если не передумали
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
    MessageBox(Self.Handle,
      'Если вы видите это сообщение, то база успешно создана.',
      'Создание базы данных', MB_OK or MB_ICONINFORMATION);
  end;
end;

// Выполнение запроса
procedure TfmDBService.btExecClick(Sender: TObject);
var
  str: string;
begin
  zqCommon.Close;
  zqCommon.SQL := mmSQL.Lines;
  zqCommon.ExecSQL;
  str := 'Запрос выполнен.' + #10#13 + 'Записей обработано: ' +
    inttostr(zqCommon.RowsAffected);
  MessageBox(Self.Handle, Pchar(str), 'Обслуживание базы данных',
    MB_OK or MB_ICONINFORMATION);
end;

// Открытие файла базы данных
procedure TfmDBService.btOpenDBClick(Sender: TObject);
begin
  if odOpenDB.Execute then
  begin
    zConn.Database := odOpenDB.FileName;
    zConn.Connect;
    btExec.Enabled := True;
    btOpenDS.Enabled := True;
    btOpenDB.Enabled := False;
    btCloseDB.Enabled := True;
    MessageBox(Self.Handle, 'База открыта. Можно выполнять запросы.',
      'Обслуживание базы данных', MB_OK or MB_ICONINFORMATION);
  end;
end;

// Открыть набор данных из сапроса
procedure TfmDBService.btOpenDSClick(Sender: TObject);
var
  str: string;
begin
  zqCommon.Close;
  zqCommon.SQL := mmSQL.Lines;
  zqCommon.Open;
  str := 'Набор данных создан и открыт.' + #10#13 + 'Записей обработано: ' +
    inttostr(zqCommon.RowsAffected);
  MessageBox(Self.Handle, Pchar(str), 'Обслуживание базы данных',
    MB_OK or MB_ICONINFORMATION);
end;

// Оптимизация базы
procedure TfmDBService.btOptimClick(Sender: TObject);
var
  DB: TSQLiteDatabase; // База данных
begin
  if odOpenDB.Execute then
  begin
    DB := TSQLiteDatabase.Create(odOpenDB.FileName);
    DB.ExecSQL('REINDEX;');
    DB.ExecSQL('VACUUM;');
    DB.Free;
    MessageBox(Self.Handle, 'База данных оптимизирована.',
      'Оптимизация базы данных', MB_OK or MB_ICONINFORMATION);
  end;
end;

end.
