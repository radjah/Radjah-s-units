unit unHCEditorMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractTable, ZDataset, ZAbstractConnection, ZConnection, StdCtrls,
  IniFiles;

type
  TfmHCEditorMain = class(TForm)
    ZConnect: TZConnection;
    ztCycle: TZTable;
    dsCycle: TDataSource;
    dbgCycle: TDBGrid;
    btCreat: TButton;
    btEdit: TButton;
    btStageEditor: TButton;
    zqCommon: TZQuery;
    btDelete: TButton;
    btExport: TButton;
    sdExport: TSaveDialog;
    zqExport: TZQuery;
    btRename: TButton;
    btAbout: TButton;
    procedure btStageEditorClick(Sender: TObject);
    procedure btCreatClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btEditClick(Sender: TObject);
    procedure CheckCyclesTable;
    procedure FormShow(Sender: TObject);
    procedure ExportToHCF;
    procedure btExportClick(Sender: TObject);
    procedure btRenameClick(Sender: TObject);
    procedure btAboutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmHCEditorMain: TfmHCEditorMain;

implementation

uses unStageEditor, unCommonFunc, unCycleEditor, unPreview, unAbout;
{$R *.dfm}

// Проверка наличия циклов в таблице и вкл/выкл кнопок
procedure TfmHCEditorMain.CheckCyclesTable;
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
    btRename.Enabled := False;
  end
  else
  begin
    btEdit.Enabled := True;
    btDelete.Enabled := True;
    btExport.Enabled := True;
    btRename.Enabled := True;
  end;
  // ShowMessage(zqCommon.FieldByName('ccid').AsString);
end;

procedure TfmHCEditorMain.btAboutClick(Sender: TObject);
begin
  fmAbout.lProgrammName.Caption := 'Редактор циклов';
  fmAbout.ShowModal;
end;

// Создание нового цикла
procedure TfmHCEditorMain.btCreatClick(Sender: TObject);
var
  newname: string;
begin
  // Проверка на наличие этапов в базе
  zqCommon.Close;
  zqCommon.SQL.Clear;
  zqCommon.SQL.Add('select count(sid) as csid from stages');
  zqCommon.Open;
  if zqCommon.FieldByName('csid').AsInteger = 0 then
    MessageBox(Self.Handle, 'Не задано ни одного этапа!', 'Ошибка!',
      MB_OK or MB_ICONEXCLAMATION)
  else
  begin
    // Создание нового цикла
    newname := '';
    if InputQuery('Создание нового цикла', 'Введите название цикла',
      newname) then
      if trim(newname) = '' then
        MessageBox(Self.Handle,
          'Имя не может быть пустым или состоять из пробелов!', 'Ошибка!',
          MB_OK or MB_ICONEXCLAMATION)
      else
      begin
        SwitchRW(False, [ztCycle]);
        ztCycle.AppendRecord([NULL, newname]);
        btEditClick(Self);
        SwitchRW(True, [ztCycle]);
        CheckCyclesTable;
      end;
  end;
end;

// Удаление выбранного цикла
procedure TfmHCEditorMain.btDeleteClick(Sender: TObject);
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
procedure TfmHCEditorMain.btEditClick(Sender: TObject);
begin
  fmCycleEditor.CycleID := ztCycle.FieldByName('cid').AsInteger;
  fmCycleEditor.ShowModal;
end;

// Экспорт цикла в файл
procedure TfmHCEditorMain.btExportClick(Sender: TObject);
var
  totaltime: integer; // Время
  switchcnt: integer; // Количество переключений
begin
  // Получаем всю структуру цикла
  zqExport.Close;
  zqExport.SQL[3] := 'cstruct.cid = ' + ztCycle.FieldByName('cid').AsString;
  zqExport.Open;
  zqExport.First;
  // Счетчики
  totaltime := 0;
  switchcnt := 0;
  fmPreview.Series1.Clear;
  fmPreview.Series1.AddXY(0, 0);
  while not zqExport.Eof do
  begin
    totaltime := totaltime + zqExport.FieldByName('ptime').AsInteger;
    switchcnt := switchcnt + 1;
    fmPreview.Series1.AddXY(totaltime, zqExport.FieldByName('clevel')
      .AsInteger);
    zqExport.Next;
  end;
  fmPreview.lbTotalTime.Caption := 'Продолжительность цикла: ' +
    IntToStr(totaltime) + ' сек.';
  fmPreview.lbSwitchCount.Caption := 'Количество переключений: ' +
    IntToStr(switchcnt);
  fmPreview.ShowModal;
end;

// Переименование
procedure TfmHCEditorMain.btRenameClick(Sender: TObject);
var
  newname: string;
  cid: string;
begin
  newname := ztCycle.FieldByName('cname').AsString;
  if InputQuery('Переименование цикла', 'Введите название цикла', newname) then
  begin
    cid := ztCycle.FieldByName('cid').AsString;
    SwitchRW(False, [ztCycle]);
    zqCommon.Close;
    zqCommon.SQL.Clear;
    zqCommon.SQL.Add('UPDATE cycle SET cname=''' + newname + '''');
    zqCommon.SQL.Add('WHERE cid=' + cid);
    zqCommon.ExecSQL;
    SwitchRW(True, [ztCycle]);
  end;
end;

// Экспорт цикла в файл
procedure TfmHCEditorMain.ExportToHCF;
var
  steps: integer; // Тут храним количество переключений
  hcfile: TIniFile; // Файл цикла
begin
  if sdExport.Execute then
  begin
    hcfile := TIniFile.Create(sdExport.FileName);
    if hcfile.SectionExists('stages') then
      hcfile.EraseSection('stages');
    if hcfile.SectionExists('settings') then
      hcfile.EraseSection('settings');
    zqExport.First;
    steps := 0;
    // Читаем всю структуру и пишем в файл
    while not zqExport.Eof do
    begin
      steps := steps + 1;
      hcfile.WriteInteger('stages', 'stage' + IntToStr(steps),
        zqExport.FieldByName('clevel').AsInteger);
      hcfile.WriteInteger('stages', 'time' + IntToStr(steps),
        zqExport.FieldByName('ptime').AsInteger);
      zqExport.Next;
    end;
    hcfile.WriteInteger('settings', 'count', steps);
    hcfile.Free;
  end;
end;

// Редактирование выбранного цикла
procedure TfmHCEditorMain.btStageEditorClick(Sender: TObject);
begin
  fmStageEditor.ShowModal;
end;

// Получение пути к базе данных
procedure TfmHCEditorMain.FormCreate(Sender: TObject);
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
  begin
    ZConnect.Database := dbfile;
    ZConnect.Connect;
    ztCycle.Open;
  end;
end;

procedure TfmHCEditorMain.FormShow(Sender: TObject);
begin
  CheckCyclesTable;
end;

end.
