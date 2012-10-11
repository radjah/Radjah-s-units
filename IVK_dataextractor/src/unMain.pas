unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  unDataModule, ADODB, Grids, DBGrids, OleAuto, ComCtrls, MyFunctions,
  ExcelAddOns, unView;

type
  TfmMain = class(TForm)
    btConnect: TButton;
    qExtractor: TADOQuery;
    dsTagGroup: TDataSource;
    dbgTagGroup: TDBGrid;
    Label1: TLabel;
    btGetTags: TButton;
    dsTagList: TDataSource;
    dbgTagList: TDBGrid;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    dtpDateBegin: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    dtpDateEnd: TDateTimePicker;
    dtpTimeBegin: TDateTimePicker;
    dtpTimeEnd: TDateTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    btExtract: TButton;
    qGetTabCount: TADOQuery;
    qGetTabCountTables_Number: TIntegerField;
    qGetTabCountTable_Name: TStringField;
    qTempTable: TADOQuery;
    qClearTmp: TADOQuery;
    Label7: TLabel;
    mLog: TMemo;
    qForExport: TADOQuery;
    sdResult: TSaveDialog;
    btView: TButton;
    procedure btConnectClick(Sender: TObject);
    procedure btGetTagsClick(Sender: TObject);
    procedure btExtractClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btViewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

{ === Подключение и отключение === }
procedure TfmMain.btConnectClick(Sender: TObject);
begin
  try
    if IVK_DM.connIVK_DB.Connected then
    // Обработка отключения
    begin
      IVK_DM.tbTags.Close;
      IVK_DM.tbTWX_GLOBAL.Close;
      IVK_DM.connIVK_DB.Close;
      // IVK_DM.connIVK_DB.Connected := false;
      btConnect.Caption := 'Соединить';
      btExtract.Enabled := false;
      btGetTags.Enabled := false;
      btView.Enabled := false;
      AddLog(mLog, 'Соединение с базой разорвано!');
    end
    else
    // Обработка подключения
    begin
      IVK_DM.connIVK_DB.Connected := True;
      IVK_DM.tbTWX_GLOBAL.Open;
      AddLog(mLog, 'Соединение с базой установлено!');
      // Временная таблица
      qTempTable.ExecSQL;
      AddLog(mLog, 'Временная таблица создана.');
      btConnect.Caption := 'Отключить';
      btGetTags.Enabled := True;
    end;
  except
    // Если не смогли соединиться
    on E: EOleException do
    begin
      MessageBox(Self.Handle,
        pchar('Возникла ошибка при подключении/отключении:' + #10#13 +
        E.Message), 'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
    // Если не смогли открыть что-то
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка при работе с базой:' +
        #10#13 + E.Message), 'Ошибка подключения/отключения',
        MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
  end;
end;

{ === Составление запроса и извлечение данных === }
procedure TfmMain.btExtractClick(Sender: TObject);
var
  tabs, samples, row: integer; // Счатчик
  tablename: string; // Префикс имени таблицы
  tabcount: integer; // Количество таблиц с данными
  samplecount: integer; // Количество замеров в одной строке
  sigidx: integer; // Индекс сигнала
  Excel, Book, Sheet: variant; // Переменный для Excel
begin
  try
    if sdResult.Execute then
    begin
      AddLog(mLog, 'Экспорт данных начался...');
      samplecount := 36;
      // Параметры выборки
      AddLog(mLog, 'Получение конфигурации...');
      qGetTabCount.Open;
      tabcount := qGetTabCount.FieldByName('Tables_Number').AsInteger;
      tablename := qGetTabCount.FieldByName('Table_Name').AsString;
      sigidx := IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger;
      // Подготовка компонента
      qExtractor.Close;
      qExtractor.SQL.Clear;
      qClearTmp.ExecSQL;
      AddLog(mLog, 'Очистка временной таблицы...');
      // ShowMessage('tabcount=' + IntToStr(tabcount) + #10#13 + 'tablename=' +
      // tablename + #10#13 + 'sigidx=' + IntToStr(sigidx));
      // Генерация запроса
      AddLog(mLog, 'Формирование запроса...');
      for tabs := 1 to tabcount do
      begin
        // Формирование запроса для таблицы
        for samples := 1 to samplecount do
        begin
          // Поля для выборки
          qExtractor.SQL.Add('INSERT INTO #tmpselect');
          qExtractor.SQL.Add('SELECT Signal_Index as SI, Sample_TDate_' +
            IntToStr(samples) + ' as TD, Sample_MSec_' + IntToStr(samples) +
            ' as SMS, Sample_Value_' + IntToStr(samples) + ' as VAL');
          // Таблица для выборки
          qExtractor.SQL.Add('FROM ' + Trim(tablename) + '_' + IntToStr(tabs));
          // Условия выборки
          qExtractor.SQL.Add('WHERE (NOT (Sample_TDate_' + IntToStr(samples) +
            ' IS NULL)) AND (NOT (Sample_MSec_' + IntToStr(samples) +
            ' IS NULL)) AND (NOT (Sample_Value_' + IntToStr(samples) +
            ' IS NULL)) and Signal_Index=' + IntToStr(sigidx));
          qExtractor.SQL.Add('and Sample_TDate_' + IntToStr(samples) +
            ' BETWEEN ''' + FormatDateTime('yyyymmdd', dtpDateBegin.Date) + ' '
            + FormatDateTime('hh:nn:ss', dtpTimeBegin.Time) + ''' AND ''' +
            FormatDateTime('yyyymmdd', dtpDateEnd.Date) + ' ' +
            FormatDateTime('hh:nn:ss', dtpTimeEnd.Time) + '''');
          // if NOT((tabs = tabcount) and (samples = samplecount)) then
          // qExtractor.SQL.Add('union all');
        end; // for samples
        // qExtractor.SQL.Add('order by SI, TD, SMS');
      end;
      AddLog(mLog, 'Заполнение временной таблицы...');
      qExtractor.ExecSQL;
      qForExport.Close;
      qForExport.Open;
      qForExport.First;
      // Создаем новую таблицу
      Excel := CreateOleObject('Excel.Application');
      // Молчать в тряпочку
      Excel.DisplayAlerts := false;
      AddLog(mLog, 'Объект Excel создан');
      // Создаём новую книгу
      Excel.WorkBooks.Add;
      Book := Excel.WorkBooks.Item[1];
      Excel.WorkBooks.Item[1].Worksheets.Add;
      Sheet := Excel.WorkBooks.Item[1].Worksheets.Item[1];
      AddLog(mLog, 'Выполняется запись данных...');
      // Читаем все данные в Excel
      row := 1;
      while NOT qForExport.Eof do
      begin
        Sheet.Cells[row, 1].FormulaR1C1 := qForExport.FieldByName('SI')
          .AsInteger;
        Sheet.Cells[row, 2].FormulaR1C1 := qForExport.FieldByName('TD')
          .AsDateTime;
        Sheet.Cells[row, 3].FormulaR1C1 := qForExport.FieldByName('SMS')
          .AsInteger;
        Sheet.Cells[row, 4].FormulaR1C1 :=
          qForExport.FieldByName('VAL').AsFloat;
        row := row + 1;
        qForExport.Next;
      end;
      AddLog(mLog, 'Данные записаны!');
      Book.SaveAs(sdResult.FileName, xlWorkbookNormal);
      AddLog(mLog, 'Файл сохранен!');
      // Выходим
      Excel.Quit;
      AddLog(mLog, 'Объект Excel уничтожен');
      // qExtractor.SQL.SaveToFile('q.txt');
      AddLog(mLog, 'Экспорт данных завершен!');
    end;
  except
    // Если не смогли соединиться
    on E: EOleException do
    begin
      MessageBox(Self.Handle,
        pchar('Возникла ошибка при подключении/отключении:' + #10#13 +
        E.Message), 'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
    // Если не смогли открыть что-то
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка при работе с базой:' +
        #10#13 + E.Message), 'Ошибка подключения/отключения',
        MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
  end;
end;

{ === Получить список тегов в выбранной группе === }
procedure TfmMain.btGetTagsClick(Sender: TObject);
begin
  try
    IVK_DM.tbTags.Close;
    IVK_DM.tbTags.tablename := IVK_DM.tbTWX_GLOBAL.FieldByName
      ('Table_Tags').AsString;
    IVK_DM.tbTags.Open;
    qGetTabCount.Close;
    qGetTabCount.SQL[2] := 'Table_Tags=''' + IVK_DM.tbTWX_GLOBAL.FieldByName
      ('Table_Tags').AsString + '''';
    if IVK_DM.tbTags.RecordCount > 0 then
    begin
      btExtract.Enabled := True;
      btView.Enabled := True;
    end
    else
    begin
      btExtract.Enabled := false;
      btView.Enabled := false;
    end;
  except
    // Если не смогли соединиться
    on E: EOleException do
    begin
      MessageBox(Self.Handle,
        pchar('Возникла ошибка при подключении/отключении:' + #10#13 +
        E.Message), 'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
    // Если не смогли открыть что-то
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка при работе с базой:' +
        #10#13 + E.Message), 'Ошибка подключения/отключения',
        MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
  end;
end;

{ === Просмотр === }
procedure TfmMain.btViewClick(Sender: TObject);
var
  tabs, samples, row: integer; // Счатчик
  tablename: string; // Префикс имени таблицы
  tabcount: integer; // Количество таблиц с данными
  samplecount: integer; // Количество замеров в одной строке
  sigidx: integer; // Индекс сигнала
begin
  samplecount := 36;
  // Параметры выборки
  AddLog(mLog, 'Получение конфигурации...');
  qGetTabCount.Open;
  tabcount := qGetTabCount.FieldByName('Tables_Number').AsInteger;
  tablename := qGetTabCount.FieldByName('Table_Name').AsString;
  sigidx := IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger;
  // Подготовка компонента
  qExtractor.Close;
  qExtractor.SQL.Clear;
  qClearTmp.ExecSQL;
  AddLog(mLog, 'Очистка временной таблицы...');
  // ShowMessage('tabcount=' + IntToStr(tabcount) + #10#13 + 'tablename=' +
  // tablename + #10#13 + 'sigidx=' + IntToStr(sigidx));
  // Генерация запроса
  AddLog(mLog, 'Формирование запроса...');
  for tabs := 1 to tabcount do
  begin
    // Формирование запроса для таблицы
    for samples := 1 to samplecount do
    begin
      // Поля для выборки
      qExtractor.SQL.Add('INSERT INTO #tmpselect');
      qExtractor.SQL.Add('SELECT Signal_Index as SI, Sample_TDate_' +
        IntToStr(samples) + ' as TD, Sample_MSec_' + IntToStr(samples) +
        ' as SMS, Sample_Value_' + IntToStr(samples) + ' as VAL');
      // Таблица для выборки
      qExtractor.SQL.Add('FROM ' + Trim(tablename) + '_' + IntToStr(tabs));
      // Условия выборки
      qExtractor.SQL.Add('WHERE (NOT (Sample_TDate_' + IntToStr(samples) +
        ' IS NULL)) AND (NOT (Sample_MSec_' + IntToStr(samples) +
        ' IS NULL)) AND (NOT (Sample_Value_' + IntToStr(samples) +
        ' IS NULL)) and Signal_Index=' + IntToStr(sigidx));
      qExtractor.SQL.Add('and Sample_TDate_' + IntToStr(samples) + ' BETWEEN '''
        + FormatDateTime('yyyymmdd', dtpDateBegin.Date) + ' ' +
        FormatDateTime('hh:nn:ss', dtpTimeBegin.Time) + ''' AND ''' +
        FormatDateTime('yyyymmdd', dtpDateEnd.Date) + ' ' +
        FormatDateTime('hh:nn:ss', dtpTimeEnd.Time) + '''');
      // if NOT((tabs = tabcount) and (samples = samplecount)) then
      // qExtractor.SQL.Add('union all');
    end; // for samples
    // qExtractor.SQL.Add('order by SI, TD, SMS');
  end;
  AddLog(mLog, 'Заполнение временной таблицы...');
  qExtractor.ExecSQL;
  qForExport.Close;
  qForExport.Open;
  qForExport.First;
  fmView.ShowModal;
end;

{ === Установка начальных значений === }
procedure TfmMain.FormShow(Sender: TObject);
begin
  dtpDateBegin.DateTime := Now;
  dtpDateEnd.DateTime := Now;
  dtpTimeBegin.DateTime := Now;
  dtpTimeEnd.DateTime := Now;
end;

end.
