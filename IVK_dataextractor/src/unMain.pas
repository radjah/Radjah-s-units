unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  unDataModule, ADODB, Grids, DBGrids, OleAuto, ComCtrls, MyFunctions,
  ExcelAddOns, unView, unStruct, Buttons;

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
    qTempTable: TADOQuery;
    qClearTmp: TADOQuery;
    Label7: TLabel;
    mLog: TMemo;
    qForExport: TADOQuery;
    sdResult: TSaveDialog;
    btView: TButton;
    odConn: TOpenDialog;
    qSignalList: TADOQuery;
    dbgSignalList: TDBGrid;
    dsSignalList: TDataSource;
    btAdd: TBitBtn;
    btRemove: TBitBtn;
    btClear: TBitBtn;
    qClearList: TADOQuery;
    Label8: TLabel;
    procedure btConnectClick(Sender: TObject);
    procedure btGetTagsClick(Sender: TObject);
    procedure btExtractClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btViewClick(Sender: TObject);
    procedure ExtractData(SigIdx: integer; TablesName: string;
      TableCount: integer);
    procedure btClearClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  TableCount: integer; // Количество таблиц с замерами
  TablesName: string; // Префикс таблиц

implementation

{$R *.dfm}

{ === Извлечение данных для просмотра или сохрарения === }
procedure TfmMain.ExtractData(SigIdx: integer; TablesName: string;
  TableCount: integer);
var
  tabs, samples: integer; // Счатчик
  timeshift: integer; // Сдвиг времени в часах
  samplecount: integer; // Количество замеров в одной строке
begin
  try
    samplecount := 36;
    timeshift := 4;
    // Параметры выборки
    AddLog(mLog, 'Получение конфигурации...');
    // Подготовка компонента
    qExtractor.Close;
    qExtractor.SQL.Clear;
    qClearTmp.ExecSQL;
    AddLog(mLog, 'Очистка временной таблицы...');
    // Генерация запроса
    AddLog(mLog, 'Формирование запроса...');
    for tabs := 1 to TableCount do
    begin
      // Формирование запроса для таблицы
      for samples := 1 to samplecount do
      begin
        // Поля для выборки
        qExtractor.SQL.Add('INSERT INTO #tmpselect');
        qExtractor.SQL.Add('SELECT Signal_Index as SI, DATEADD(hh,' +
          IntToStr(timeshift) + ',Sample_TDate_' + IntToStr(samples) +
          ') as TD, Sample_MSec_' + IntToStr(samples) + ' as SMS, Sample_Value_'
          + IntToStr(samples) + ' as VAL');
        // Таблица для выборки
        qExtractor.SQL.Add('FROM ' + TablesName + '_' + IntToStr(tabs));
        // Условия выборки
        qExtractor.SQL.Add('WHERE (NOT (Sample_TDate_' + IntToStr(samples) +
          ' IS NULL)) AND (NOT (Sample_MSec_' + IntToStr(samples) +
          ' IS NULL)) AND (NOT (Sample_Value_' + IntToStr(samples) +
          ' IS NULL)) and Signal_Index=' + IntToStr(SigIdx));
        qExtractor.SQL.Add('and Sample_TDate_' + IntToStr(samples) +
          ' BETWEEN DATEADD(hh,' + IntToStr(-timeshift) + ',''' +
          FormatDateTime('yyyymmdd', dtpDateBegin.Date) + ' ' +
          FormatDateTime('hh:nn:ss', dtpTimeBegin.Time) + ''') AND DATEADD(hh,'
          + IntToStr(-timeshift) + ',''' + FormatDateTime('yyyymmdd',
          dtpDateEnd.Date) + ' ' + FormatDateTime('hh:nn:ss',
          dtpTimeEnd.Time) + ''')');
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
  except
    // Если не смогли соединиться
    on E: EOleException do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
    // Если не смогли открыть что-то
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
  end;
end;

{ === Добавление выбранного параметра в список === }
procedure TfmMain.btAddClick(Sender: TObject);
begin
  try
    IVK_DM.tbSignalList.AppendRecord
      ([nil, IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
      Trim(IVK_DM.tbTags.FieldByName('Logging_Name').AsString), TablesName,
      TableCount]);
    if IVK_DM.tbSignalList.RecordCount > 0 then
      btRemove.Enabled := True;
  except
    on E: EDatabaseError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка работы с базой', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
  end;
end;

{ === Очистка списка сигналов === }
procedure TfmMain.btClearClick(Sender: TObject);
begin
  qClearList.Close;
  qClearList.ExecSQL;
  ReopenDatasets([IVK_DM.tbSignalList]);
end;

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
      // IVK_DM.connIVK_DB.Connected := False;
      btConnect.Caption := 'Соединить';
      // Отключение кнопок
      btExtract.Enabled := False;
      btGetTags.Enabled := False;
      btAdd.Enabled := False;
      btRemove.Enabled := False;
      btClear.Enabled := False;
      btView.Enabled := False;
      AddLog(mLog, 'Соединение с базой разорвано!');
    end
    else
    // Обработка подключения
    begin
      IVK_DM.connIVK_DB.Connected := True;
      IVK_DM.tbTWX_GLOBAL.Open;
      AddLog(mLog, 'Соединение с базой установлено!');
      // Временные таблицы
      qTempTable.ExecSQL;
      qSignalList.ExecSQL;
      IVK_DM.tbSignalList.Open;
      AddLog(mLog, 'Временные таблицы созданы.');
      btConnect.Caption := 'Отключить';
      // Включение кнопок
      btGetTags.Enabled := True;
      btClear.Enabled := True;
    end;
  except
    // Если не смогли соединиться
    on E: EOleException do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
    // Если не смогли открыть что-то
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
  end;
end;

{ === Составление запроса и извлечение данных === }
procedure TfmMain.btExtractClick(Sender: TObject);
var
  row, BeginCol, BeginRow, i: integer; // Счатчик
  begTD, curTD: TDateTime; // Для сравнения даты и времени
  datasumm: real; // Накопитель для суммы значений
  datacount: integer; // Счетчик для делителя
  RowCount, ColCount: integer; // Количество строк и столбцов
  Excel, Book, Sheet, ArrayData, Cell1, Cell2, Range: variant;
  // Переменный для Excel
  ExpData: TExpData;
  ExpDataFile: file of TExpData;
  ExportMethodFlag: boolean;
  // Флаг типа экспорта:
  // True - по списку
  // False - только выбранный
begin
  try
    if sdResult.Execute then
    begin
      // Проверяем условия экспорта
      // Excel?
      if sdResult.FilterIndex = 1 then
      begin
        // Нет записей?
        if IVK_DM.tbSignalList.RecordCount = 0 then
          // Только то, что выбрано?
          if MessageBox(Self.Handle, 'Список для экспорта пуст.' + #10#13 +
            'Экспортировать только выбранный сигнал?', 'Запрос',
            MB_OKCANCEL or MB_ICONQUESTION) = IDOK then
            ExportMethodFlag := False
            // Отказ от экспорта
          else
            Exit;
        // Экспортируем по списку
        ExportMethodFlag := True;
        // У нас всё еще Excel, поэтому начинаем шаманить
        // Проверяем выбранный метод
        AddLog(mLog, 'Экспорт данных начался...');
        if ExportMethodFlag then
        begin
          // Становимся в начало таблицы
          IVK_DM.tbSignalList.First;
          // Создаём новый объект
          Excel := CreateOleObject('Excel.Application');
          // Молчать в тряпочку
          Excel.DisplayAlerts := False;
          AddLog(mLog, 'Объект Excel создан');
          // Создаём новую книгу
          Excel.WorkBooks.Add;
          Book := Excel.WorkBooks.Item[1];
          // Прибиваем лишние листы
          for i := 1 to Book.Sheets.Count - 1 do
            Book.Sheets.Item[1].Delete;
          // и создаём нужное количество
          for i := 1 to IVK_DM.tbSignalList.RecordCount - 1 do
            Book.Sheets.Add;
          // Теперь в книге количество страниц равно
          // количеству извлекаемых параметров
          // Приступаем к извлечению
          for i := 1 to IVK_DM.tbSignalList.RecordCount do
          begin
            Sheet := Book.Worksheets.Item[i];
            // Достём данные
            ExtractData(IVK_DM.tbSignalList.FieldByName('Tag_Index').AsInteger,
              IVK_DM.tbSignalList.FieldByName('Table_Name').AsString,
              IVK_DM.tbSignalList.FieldByName('Tables_Number').AsInteger);
            // Координаты левого верхнего угла области,
            // в которую будем выводить данные
            BeginCol := 1;
            BeginRow := 1;
            // Количество строк и столбцов
            RowCount := qForExport.RecordCount;
            ColCount := qForExport.FieldCount;
            // Создаем новую таблицу
            // Excel.SheetsInNewWorkbook := 0;
            // Массив данных для вывода
            ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
            AddLog(mLog, 'Выполняется запись данных...');
            // Читаем все данные в Excel
            row := 1;
            datasumm := 0;
            datacount := 0;
            begTD := qForExport.FieldByName('TD').AsDateTime;
            while NOT qForExport.Eof do
            begin
              // Получаем значение дата-время в виде строки
              curTD := qForExport.FieldByName('TD').AsDateTime;
              // Если секунда замера не изменилась
              if begTD = curTD then
              // Накапливаем сумму и делитель
              begin
                datacount := datacount + 1;
                datasumm := datasumm + qForExport.FieldByName('VAL').AsFloat;
              end
              else
              // Иначе получаем среднее значение и выводим
              begin
                // ID сигнала
                ArrayData[row, 1] := qForExport.FieldByName('SI').AsVariant;
                // Время замера
                ArrayData[row, 2] := begTD;
                // Значение
                ArrayData[row, 3] := datasumm / datacount;
              end;
              row := row + 1;
              // Изменяем эталонное дата-время
              begTD := qForExport.FieldByName('TD').AsDateTime;
              // Сбрасываем количество замеров в новую секунду
              datacount := 1;
              // Запоминаем первое значение
              datasumm := qForExport.FieldByName('VAL').AsFloat;
              // Переходим на следующую запись
              qForExport.Next;
            end;
            // Сохраняем последнюю запись
            // ID сигнала
            ArrayData[row, 1] := qForExport.FieldByName('SI').AsVariant;
            // Время замера
            ArrayData[row, 2] := begTD;
            // Значение
            ArrayData[row, 3] := datasumm / datacount;
            AddLog(mLog, 'Данные записаны!');
            // Пишем кусок данных на указанный лист
            Cell1 := Sheet.Cells[BeginRow, BeginCol];
            Cell2 := Sheet.Cells[BeginRow + RowCount - 1,
              BeginCol + ColCount - 1];
            Range := Sheet.Range[Cell1, Cell2];
            Range.Value := ArrayData;
            VarClear(ArrayData);
          end;
          // Выходим
          Excel.Quit;
          AddLog(mLog, 'Объект Excel уничтожен');
          AddLog(mLog, 'Экспорт данных завершен!');
        end
        else
        // Если выкачивает только выбранный параметр
        begin
          // Достём данные
          ExtractData(IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
            TablesName, TableCount);
          // Координаты левого верхнего угла области,
          // в которую будем выводить данные
          BeginCol := 1;
          BeginRow := 1;
          // Количество строк и столбцов
          RowCount := qForExport.RecordCount;
          ColCount := qForExport.FieldCount;
          // Создаем новую таблицу
          // Excel.SheetsInNewWorkbook := 0;
          // Массив данных для вывода
          ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
          AddLog(mLog, 'Выполняется запись данных...');
          // Читаем все данные в Excel
          row := 1;
          datasumm := 0;
          datacount := 0;
          begTD := qForExport.FieldByName('TD').AsDateTime;
          while NOT qForExport.Eof do
          begin
            // Получаем значение дата-время в виде строки
            curTD := qForExport.FieldByName('TD').AsDateTime;
            // Если секунда замера не изменилась
            if begTD = curTD then
            // Накапливаем сумму и делитель
            begin
              datacount := datacount + 1;
              datasumm := datasumm + qForExport.FieldByName('VAL').AsFloat;
            end
            else
            // Иначе получаем среднее значение и выводим
            begin
              // ID сигнала
              ArrayData[row, 1] := qForExport.FieldByName('SI').AsVariant;
              // Время замера
              ArrayData[row, 2] := begTD;
              // Значение
              ArrayData[row, 3] := datasumm / datacount;
            end;
            row := row + 1;
            // Изменяем эталонное дата-время
            begTD := qForExport.FieldByName('TD').AsDateTime;
            // Сбрасываем количество замеров в новую секунду
            datacount := 1;
            // Запоминаем первое значение
            datasumm := qForExport.FieldByName('VAL').AsFloat;
            // Переходим на следующую запись
            qForExport.Next;
          end;
          // Сохраняем последнюю запись
          // ID сигнала
          ArrayData[row, 1] := qForExport.FieldByName('SI').AsVariant;
          // Время замера
          ArrayData[row, 2] := begTD;
          // Значение
          ArrayData[row, 3] := datasumm / datacount;
          AddLog(mLog, 'Данные записаны!');
          // Запись в Excel
          // Создаём новый объект
          Excel := CreateOleObject('Excel.Application');
          // Молчать в тряпочку
          Excel.DisplayAlerts := False;
          AddLog(mLog, 'Объект Excel создан');
          // Создаём новую книгу
          Excel.WorkBooks.Add;
          Book := Excel.WorkBooks.Item[1];
          // Прибиваем лишние листы
          for i := 1 to Book.Sheets.Count - 1 do
            Book.Sheets.Item[1].Delete;
          Sheet := Book.Worksheets.Item[1];
          // Пишем кусок данных на указанный лист
          Cell1 := Sheet.Cells[BeginRow, BeginCol];
          Cell2 := Sheet.Cells[BeginRow + RowCount - 1,
            BeginCol + ColCount - 1];
          Range := Sheet.Range[Cell1, Cell2];
          Range.Value := ArrayData;
          Book.SaveAs(sdResult.FileName, xlWorkbookNormal);
          AddLog(mLog, 'Файл сохранен!');
          VarClear(ArrayData);
          // Выходим
          Excel.Quit;
          AddLog(mLog, 'Объект Excel уничтожен');
          AddLog(mLog, 'Экспорт данных завершен!');
        end;
        // Сохранение в типизированный файл




        // Дальше идет старое говно

        // Выкачиваем первую порцию данных
        ExtractData();
        // Excel?
        if sdResult.FilterIndex = 1 then
        begin
          sdResult.DefaultExt := 'xls';
          // Sheet.Columns['B:B'].Select;
          // Excel.Selection.NumberFormat := 'dd/mm/yyyy h:mm:ss';
        end;
        // Файл данных?
        if sdResult.FilterIndex = 2 then
        begin
          sdResult.DefaultExt := 'msr';
          // Подготовка типизированного файла
          AssignFile(ExpDataFile, sdResult.FileName);
          Rewrite(ExpDataFile);
        end;
        AddLog(mLog, 'Выполняется запись данных...');

        // Если работаем с файлом данных
        if sdResult.FilterIndex = 2 then
        begin
          ExpData.SigID := qForExport.FieldByName('SI').AsInteger;
          ExpData.DT := begTD;
          ExpData.Val := datasumm / datacount;
          Write(ExpDataFile, ExpData);
        end;
        // Будем писать в следующую строку

      end;
      // Переходим на следующую запись
      qForExport.Next;
    end;
    // Сохраняем последнюю запись
    if sdResult.FilterIndex = 1 then
    begin
      // ID сигнала
      ArrayData[row, 1] := qForExport.FieldByName('SI').AsVariant;
      // Время замера
      ArrayData[row, 2] := begTD;
      // Значение
      ArrayData[row, 3] := datasumm / datacount;
    end;
    if sdResult.FilterIndex = 2 then
    begin
      ExpData.SigID := qForExport.FieldByName('SI').AsInteger;
      ExpData.DT := begTD;
      ExpData.Val := datasumm / datacount;
      Write(ExpDataFile, ExpData);
    end;
    AddLog(mLog, 'Данные записаны!');
    // Особая магия для Excel
    if sdResult.FilterIndex = 1 then
    begin
      Cell1 := Sheet.Cells[BeginRow, BeginCol];
      Cell2 := Sheet.Cells[BeginRow + RowCount - 1, BeginCol + ColCount - 1];
      Range := Sheet.Range[Cell1, Cell2];
      Range.Value := ArrayData;
      Book.SaveAs(sdResult.FileName, xlWorkbookNormal);
    end;
    if sdResult.FilterIndex = 2 then
      CloseFile(ExpDataFile);
    AddLog(mLog, 'Файл сохранен!');
    if sdResult.FilterIndex = 1 then
    begin
      // Выходим
      Excel.Quit;
      AddLog(mLog, 'Объект Excel уничтожен');
    end;
    // qExtractor.SQL.SaveToFile('q.txt');
    AddLog(mLog, 'Экспорт данных завершен!');
  end;
except
  // Если не смогли соединиться
  on E: EOleException do
  begin
    MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
      'Ошибка при работе', MB_OK or MB_ICONERROR);
    AddLog(mLog, 'Ошибка: ' + E.Message);
  end;
  // Если не смогли открыть что-то
  on E: EADOError do
  begin
    MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
      'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
    AddLog(mLog, 'Ошибка: ' + E.Message);
  end;
end;
end;

{ === Получить список тегов в выбранной группе === }
procedure TfmMain.btGetTagsClick(Sender: TObject);
begin
  try
    // Подготовка переменных
    IVK_DM.tbTags.Close;
    IVK_DM.tbTags.tablename := IVK_DM.tbTWX_GLOBAL.FieldByName
      ('Table_Tags').AsString;
    IVK_DM.tbTags.Open;
    // Правка запросов для получения количества таблиц при извлечении
    TableCount := IVK_DM.tbTWX_GLOBAL.FieldByName('Tables_Number').AsInteger;
    TablesName := Trim(IVK_DM.tbTWX_GLOBAL.FieldByName('Table_Name').AsString);
    // qGetTabCount.SQL[2] := 'Table_Tags=''' + IVK_DM.tbTWX_GLOBAL.FieldByName
    // ('Table_Tags').AsString + '''';
    // Если в выбранной группе есть теги
    if IVK_DM.tbTags.RecordCount > 0 then
    begin
      btExtract.Enabled := True;
      btView.Enabled := True;
      btAdd.Enabled := True;
    end
    // Если группа пустая
    else
    begin
      btExtract.Enabled := False;
      btView.Enabled := False;
    end;
  except
    // Если не смогли соединиться
    on E: EOleException do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
    // Если не смогли открыть что-то
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
  end;
end;

{ === Удаление параметра из набора === }
procedure TfmMain.btRemoveClick(Sender: TObject);
begin
  try
    IVK_DM.tbSignalList.Delete;
    if IVK_DM.tbSignalList.RecordCount = 0 then
      btRemove.Enabled := False;
  except
    on E: EDatabaseError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка подключения/отключения', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
    end;
  end;
end;

{ === Просмотр === }
procedure TfmMain.btViewClick(Sender: TObject);
begin
  ExtractData;
  AddLog(mLog, 'Запуск просмотра...');
  fmView.ShowModal;
end;

{ === Установка начальных значений === }
procedure TfmMain.FormShow(Sender: TObject);
begin
  dtpDateBegin.DateTime := Now;
  dtpDateEnd.DateTime := Now;
  dtpTimeBegin.DateTime := Now;
  dtpTimeEnd.DateTime := Now;
  if FileExists(ExtractFilePath(Application.ExeName) + '\conn.udl') then
    IVK_DM.connIVK_DB.ConnectionString := 'FILE NAME=' +
      ExtractFilePath(Application.ExeName) + '\conn.udl'
  else
  begin
    if odConn.Execute then
      IVK_DM.connIVK_DB.ConnectionString := 'FILE NAME=' + odConn.FileName
    else
      Close;
  end;

end;

end.
