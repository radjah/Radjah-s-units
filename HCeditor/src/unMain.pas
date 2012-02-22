unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractTable, ZDataset, ZAbstractConnection, ZConnection, StdCtrls,
  ZSqlUpdate, IniFiles;

type
  TfmMain = class(TForm)
    ZConnect: TZConnection;
    ztCycle: TZTable;
    dsCycle: TDataSource;
    dbgCycle: TDBGrid;
    btCreat: TButton;
    btEdit: TButton;
    btStageEditor: TButton;
    zqCommon: TZQuery;
    btDelete: TButton;
    zqCreateDB: TZQuery;
    btExport: TButton;
    sdExport: TSaveDialog;
    zqExport: TZQuery;
    procedure btStageEditorClick(Sender: TObject);
    procedure btCreatClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure CheckCyclesTable;
    procedure FormShow(Sender: TObject);
    procedure btExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses unStageEditor, unCommonFunc, unCycleEditor;
{$R *.dfm}

// Проверка наличия циклов в таблице и вкл/выкл кнопок
procedure TfmMain.CheckCyclesTable;
var
  ccount: integer;
begin
  zqCommon.Close;
  zqCommon.SQL.Clear;
  zqCommon.SQL.Add('select COUNT(cid) as ccid from cycle');
  zqCommon.Open;
  ccount := zqCommon.FieldByName('ccid').AsInteger;
  if ccount = 0 then
  begin
    btEdit.Enabled := False;
    btDelete.Enabled := False;
    btExport.Enabled := False;
  end
  else
  begin
    btEdit.Enabled := True;
    btDelete.Enabled := True;
    btExport.Enabled := True;
  end;
  // ShowMessage(zqCommon.FieldByName('ccid').AsString);
end;

// Создание нового цикла
procedure TfmMain.btCreatClick(Sender: TObject);
var
  newname: string[128];
begin
  newname := InputBox('Создание нового цикла', 'Введите название цикла', '');
  SwitchRW(False, [ztCycle]);
  if Length(newname) > 0 then
    ztCycle.AppendRecord([NULL, newname]);
  btEditClick(Self);
  SwitchRW(True, [ztCycle]);
  CheckCyclesTable;
end;

// Удаление выбранного цикла
procedure TfmMain.btDeleteClick(Sender: TObject);
var
  str: string;
begin
  str := 'Удалить цикл "' + ztCycle.FieldByName('cname').AsWideString +
    '" и все его этапы?';
  if MessageBox(Self.Handle, Pchar(str), 'Запрос', MB_YESNO OR MB_ICONQUESTION)
    = IDYES then
  begin
    // Удаление всех этапов цикла
    zqCommon.Close;
    zqCommon.SQL.Clear;
    zqCommon.SQL.Add('Delete from cstruct where cid=' +
      ztCycle.FieldByName('cid').AsString);
    zqCommon.ExecSQL;
    // Удаление самого цикла
    zqCommon.Close;
    zqCommon.SQL.Clear;
    zqCommon.SQL.Add('Delete from cycle where cid=' + ztCycle.FieldByName('cid')
      .AsString);
    zqCommon.ExecSQL;
    ReopenDS([ztCycle]);
  end;
  CheckCyclesTable;
end;

// Измененеие выбранного цикла
procedure TfmMain.btEditClick(Sender: TObject);
begin
  fmCycleEditor.CycleID := ztCycle.FieldByName('cid').AsInteger;
  fmCycleEditor.ShowModal;
end;

// Экспорт цикла в файл
procedure TfmMain.btExportClick(Sender: TObject);
var
  steps: integer; // Тут храним количество переключений
  hcfile: TIniFile; // Файл цикла
begin
  if sdExport.Execute then
  begin
    hcfile := TIniFile.Create(sdExport.FileName);
    // Получаем всю структуру цикла
    zqExport.Close;
    zqExport.SQL[3] := 'cstruct.cid = ' + ztCycle.FieldByName('cid').AsString;
    zqExport.Open;
    steps := 0;
    // Читаем всю структуру и пишем в файл
    while not zqExport.Eof do
    begin
      steps := steps + 1;
      hcfile.WriteInteger('stages', 'stage' + inttostr(steps),
        zqExport.FieldByName('clevel').AsInteger);
      hcfile.WriteInteger('stages', 'time' + inttostr(steps),
        zqExport.FieldByName('ptime').AsInteger);
      zqExport.Next;
    end;
    hcfile.WriteInteger('settings', 'count', steps);
    hcfile.Free;
  end;
end;

{
  procedure TfmMain.btDeleteClick(Sender: TObject);
  var
  str: String;
  begin
  str := concat('Удалить цикл "', ztCycle.FieldByName('cname').AsString,
  '" и все его этапы?', #00);
  if MessageDlg(str, mtConfirmation, [mbYes, mbNo], 0,
  mbYes) = mrYes then
  ShowMessage('Ня!');
  end; }

procedure TfmMain.btStageEditorClick(Sender: TObject);
begin
  fmStageEditor.ShowModal;
end;

// Получение пути к базе данных
procedure TfmMain.FormCreate(Sender: TObject);
var
  dbfile: TFileName;
begin
  dbfile := ExtractFilePath(Application.ExeName) + 'stages.sqlite';
  if NOT(FileExists(dbfile)) then
  begin
    MessageBox(Self.Handle, 'База данных не найдена!' + #10#13 +
      'Запустите программу creatdb.exe из папки программы.', 'Ошибка!',
      MB_OK or MB_ICONERROR);
    Application.Terminate;
  end
  else
  { begin
    ZConnect.Database := dbfile;
    zqCreateDB.ExecSQL;
    ZConnect.Connect;
    // zqCreateDB.ExecSQL;
    ztCycle.Open;
    end
    else
    begin
    ZConnect.Connect;
    ztCycle.Open;
    end; }
  begin
    ZConnect.Database := dbfile;
    ZConnect.Connect;
    ztCycle.Open;
  end;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  CheckCyclesTable;
end;

end.
