unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  unDataModule, ADODB, Grids, DBGrids, OleAuto, ComCtrls, MyFunctions,
  ExcelAddOns, unView, unStruct, unChart, Buttons, TeeProcs, Chart, Series;

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
    cbFillTime: TCheckBox;
    btPlot: TButton;
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
    procedure MakeDataArr(MethodFlag: boolean);
    procedure btPlotClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  TableCountSingle: integer; // Количество таблиц с замерами
  TablesNameSingle: string; // Префикс таблиц
  ExpDataArr: array of TExpData; // Массив для данных

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
    // Отладка
    // ShowMessage('SigIdx = ' + IntToStr(SigIdx) + #10#13 + 'TablesName = ' +
    // TablesName + #10#13 + 'TableCount = ' + IntToStr(TableCount));
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
    // Отладка
    // ShowMessage('qForExport.RecordCount = ' + IntToStr(qForExport.RecordCount) +
    // #10#13 + 'qForExport.FieldCount = ' + IntToStr(qForExport.FieldCount));
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

{ === Извлечение данных из таблицы в массив === }
procedure TfmMain.MakeDataArr(MethodFlag: boolean);
var
  row: integer; // Счатчик
  begTD, curTD: TDateTime; // Для сравнения даты и времени
  datasumm: real; // Накопитель для суммы значений
  datacount: integer; // Счетчик для делителя
begin
  // Читаем все данные в массив
  SetLength(ExpDataArr, 0);
  row := 0;
  datasumm := 0;
  datacount := 0;
  begTD := qForExport.FieldByName('TD').AsDateTime;
  while NOT qForExport.Eof do
  // Пока не выбрали все данные
  begin
    // Получаем значение дата-время
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
      // Наращиваем
      SetLength(ExpDataArr, row + 1);
      // Записываем замер
      // ID сигнала
      ExpDataArr[row].SigID := qForExport.FieldByName('SI').AsInteger;
      // Время замера
      ExpDataArr[row].DT := begTD;
      // Значение
      ExpDataArr[row].Val := datasumm / datacount;
      // Отодвигаем границу
      // Указывает на пока не существующий элемент массива
      row := row + 1;
      if MethodFlag = True then
      // Если пропущенные замеры восстанавливаем
      begin
        // Добавляем к проверяемому времени секунду
        begTD := begTD + StrToTime('0:00:01');
        while begTD < curTD do
        // Пока не добежим до новой временной отметки
        begin
          // Наращиваем массив
          SetLength(ExpDataArr, row + 1);
          // Заполняем новый элемент из старого
          ExpDataArr[row] := ExpDataArr[row - 1];
          ExpDataArr[row].DT := begTD;
          // Отодвигаем границу
          // Указывает на пока не существующий элемент массива
          row := row + 1;
          // Отодвигаем время
          begTD := begTD + StrToTime('0:00:01');
        end;
      end;
      // Изменяем эталонное дата-время
      begTD := qForExport.FieldByName('TD').AsDateTime;
      // Сбрасываем количество замеров в новую секунду
      datacount := 1;
      // Запоминаем первое значение
      datasumm := qForExport.FieldByName('VAL').AsFloat;
    end;
    // Переходим на следующую запись
    qForExport.Next;
  end;
  // Сохраняем последнюю запись
  // Отладка
  // ShowMessage('row = ' + IntToStr(row));
  // Наращиваем массив
  SetLength(ExpDataArr, row + 1);
  // Записываем замер
  // ID сигнала
  ExpDataArr[row].SigID := qForExport.FieldByName('SI').AsInteger;
  // Время замера
  ExpDataArr[row].DT := begTD;
  // Значение
  ExpDataArr[row].Val := datasumm / datacount;
end;

{ === Добавление выбранного параметра в список === }
procedure TfmMain.btAddClick(Sender: TObject);
begin
  try
    IVK_DM.tbSignalList.AppendRecord
      ([nil, IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
      Trim(IVK_DM.tbTags.FieldByName('Logging_Name').AsString),
      TablesNameSingle, TableCountSingle]);
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
  AddLog(mLog, 'Список очищен.');
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
      btPlot.Enabled := False;
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
  BeginCol, BeginRow, i, j: integer; // Счатчик
  RowCount, ColCount: integer; // Количество строк и столбцов
  // Переменный для Excel
  Excel, Book, Sheet, ArrayData, Cell1, Cell2, Range: variant;
  ExpDataFile: file of TExpData;
  ExportMethodFlag: boolean;
  // Флаг типа экспорта:
  // True - по списку
  // False - только выбранный
begin
  try
    if sdResult.Execute then
    // Указал ли пользователь файл для сохранения?
    begin
      { = Настройки извлечения = }
      if sdResult.FilterIndex = 1 then
      // Excel?
      begin
        if IVK_DM.tbSignalList.RecordCount = 0 then
        // Нет записей?
        begin
          // Только то, что выбрано?
          if MessageBox(Self.Handle, 'Список для извлечения пуст.' + #10#13 +
            'Извлечь только выбранный сигнал?', 'Запрос', MB_OKCANCEL or
            MB_ICONQUESTION) = IDOK then
            ExportMethodFlag := False
            // Отказ от экспорта
          else
            Exit;
        end
        else
          // Экспортируем по списку
          ExportMethodFlag := True;
      end
      // Если типизированный файл
      else
      begin
        if MessageBox(Self.Handle, 'Выбранный формат несовместим с извлечением '
          + 'нескольких сигналов одновременно.' + #10#13 +
          'Извлечь только выбранный сигнал?', 'Запрос', MB_OKCANCEL or
          MB_ICONQUESTION) = IDOK then
          ExportMethodFlag := False
          // Отказ от экспорта
        else
          Exit;
      end;
      { = Все проверки пройдены, можно начинать обработку. = }
      // Проверяем выбранный метод
      AddLog(mLog, 'Экспорт данных начался...');
      if ExportMethodFlag then
      // Тут только Excel
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
        // Для каждого выбранного параметра
        begin
          Sheet := Book.Worksheets.Item[i];
          // Достаём данные
          ExtractData(IVK_DM.tbSignalList.FieldByName('Tag_Index').AsInteger,
            IVK_DM.tbSignalList.FieldByName('Table_Name').AsString,
            IVK_DM.tbSignalList.FieldByName('Tables_Number').AsInteger);
          // Проверка на пустой набор
          if qForExport.RecordCount > 0 then
          // Если за выбранный промежуток нет данных.
          begin
            AddLog(mLog, 'Выполняется запись данных...');
            MakeDataArr(ExportMethodFlag);
            // Массив данных для вывода
            RowCount := Length(ExpDataArr);
            ColCount := 3;
            ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
            for j := 1 to RowCount do
            // Заполняем массив
            begin
              // ID сигнала
              ArrayData[j, 1] := ExpDataArr[j - 1].SigID;
              // Время замера
              ArrayData[j, 2] := ExpDataArr[j - 1].DT;
              // Значение
              ArrayData[j, 3] := ExpDataArr[j - 1].Val;
            end;
            // Координаты левого верхнего угла области,
            // в которую будем выводить данные
            BeginCol := 1;
            BeginRow := 1;
            ColCount := 3; // ID, Время, Значение
            // Пишем кусок данных на указанный лист
            Cell1 := Sheet.Cells[BeginRow, BeginCol];
            Cell2 := Sheet.Cells[BeginRow + RowCount - 1,
              BeginCol + ColCount - 1];
            Range := Sheet.Range[Cell1, Cell2];
            Range.Value := ArrayData;
            AddLog(mLog, 'Данные записаны!');
            // Убиваем вариантный массив
            VarClear(ArrayData);
          end
          else
            AddLog(mLog, 'Обнаружен параметр без данных! Пропускаем.');
          // Название листа.
          Sheet.Name := IVK_DM.tbSignalList.FieldByName('Logging_Name')
            .AsString;
          IVK_DM.tbSignalList.Next;
        end;
        // Сохраняем и выходим
        // Настройки расширения
        sdResult.DefaultExt := 'xls';
        Book.SaveAs(sdResult.FileName, xlWorkbookNormal);
        AddLog(mLog, 'Файл сохранен!');
        Excel.Quit;
        AddLog(mLog, 'Объект Excel уничтожен');
        AddLog(mLog, 'Экспорт данных завершен!');
      end
      else
      // Если выкачивает только выбранный параметр
      begin
        // Достём данные
        ExtractData(IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
          TablesNameSingle, TableCountSingle);
        if qForExport.RecordCount > 0 then
        // Если за выбранный промежуток есть данные.
        begin
          MakeDataArr(ExportMethodFlag);
          RowCount := Length(ExpDataArr);
          // Тут у нас есть массив записей всех замеров
          // По выбранному типу определяем метод сохранения
          if sdResult.FilterIndex = 1 then
          // Если выбрали Excel
          begin
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
            Sheet := Excel.WorkBooks.Item[1].Worksheets.Item[1];
            // Массив данных для вывода
            BeginCol := 1;
            BeginRow := 1;
            ColCount := 3; // ID, Время, Значение
            ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
            for j := 1 to RowCount do
            // Заполняем массив
            begin
              // ID сигнала
              ArrayData[j, 1] := ExpDataArr[j - 1].SigID;
              // Время замера
              ArrayData[j, 2] := ExpDataArr[j - 1].DT;
              // Значение
              ArrayData[j, 3] := ExpDataArr[j - 1].Val;
            end;
            // Пишем кусок данных на указанный лист
            Cell1 := Sheet.Cells[BeginRow, BeginCol];
            Cell2 := Sheet.Cells[BeginRow + RowCount - 1,
              BeginCol + ColCount - 1];
            Range := Sheet.Range[Cell1, Cell2];
            Range.Value := ArrayData;
            Sheet.Name := Trim(IVK_DM.tbTags.FieldByName('Logging_Name')
              .AsString);
            AddLog(mLog, 'Данные записаны!');
            // Сохраняем
            sdResult.DefaultExt := 'xls';
            Book.SaveAs(sdResult.FileName, xlWorkbookNormal);
            AddLog(mLog, 'Файл сохранен!');
            // Выходим
            Excel.Quit;
            AddLog(mLog, 'Объект Excel уничтожен');
          end
          else
          // Если выбрали типизированный файл
          begin
            sdResult.DefaultExt := 'msr';
            // Связываем переменную
            AssignFile(ExpDataFile, sdResult.FileName);
            // Открываем на запись
            Rewrite(ExpDataFile);
            // Записываем замеры в файл
            for i := 0 to RowCount - 1 do
              Write(ExpDataFile, ExpDataArr[i]);
            AddLog(mLog, 'Данные записаны!');
            // Закрываем файл
            CloseFile(ExpDataFile);
            AddLog(mLog, 'Файл сохранен!');
          end;
          AddLog(mLog, 'Экспорт данных завершен!');
        end
        else
          // Ругаемся, что в выбранном промежутке нет данных
          AddLog(mLog, 'Обнаружен параметр без данных! Пропускаем.');
      end;
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
    on E: EVariantError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка', MB_OK or MB_ICONERROR);
      AddLog(mLog, 'Ошибка: ' + E.Message);
      if Excel <> varEmpty then
        Excel.Quit;
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
    TableCountSingle := IVK_DM.tbTWX_GLOBAL.FieldByName('Tables_Number')
      .AsInteger;
    TablesNameSingle := Trim(IVK_DM.tbTWX_GLOBAL.FieldByName('Table_Name')
      .AsString);
    // qGetTabCount.SQL[2] := 'Table_Tags=''' + IVK_DM.tbTWX_GLOBAL.FieldByName
    // ('Table_Tags').AsString + '''';
    if IVK_DM.tbTags.RecordCount > 0 then
    // Если в выбранной группе есть теги
    begin
      btExtract.Enabled := True;
      btView.Enabled := True;
      btPlot.Enabled := True;
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

{ === Отобразить график за выбранный промежуток времени по параметрам === }
procedure TfmMain.btPlotClick(Sender: TObject);
var
  i, j: integer; // Счетчик
begin
  // Удаляем все графики
  fmChart.chPreview.SeriesList.Clear;
  // Показываем легенду
  fmChart.chPreview.Legend.Visible := True;
  if IVK_DM.tbSignalList.RecordCount > 0 then
  // Если в списке есть выбранные параметры, то строим по ним
  begin
    IVK_DM.tbSignalList.First;
    for i := 0 to IVK_DM.tbSignalList.RecordCount - 1 do
    // Для каждого параметра
    begin
      // Достать данные;
      ExtractData(IVK_DM.tbSignalList.FieldByName('Tag_Index').AsInteger,
        IVK_DM.tbSignalList.FieldByName('Table_Name').AsString,
        IVK_DM.tbSignalList.FieldByName('Tables_Number').AsInteger);
      // Преобразовать в массив с восстановлением
      MakeDataArr(True);
      // Добавляем график
      fmChart.chPreview.AddSeries(TLineSeries);
      fmChart.chPreview.Series[i].XValues.DateTime := True;
      // Обзываем
      fmChart.chPreview.Series[i].Title := IVK_DM.tbSignalList.FieldByName
        ('Logging_Name').AsString;
      // Заполняем
      if qForExport.RecordCount > 0 then
        // Если данные есть
        for j := 0 to Length(ExpDataArr) - 1 do
          // Переносим все значения на график
          fmChart.chPreview.Series[i].AddXY(ExpDataArr[j].DT, ExpDataArr[j].Val)
      else
        // Иначе ругаемся
        AddLog(mLog, 'Обнаружен параметр без данных! Пропускаем.');
      // Следующий параметр
      IVK_DM.tbSignalList.Next;
    end;
  end
  else
  // Если параметров в списке нет, отображаем только выбранный.
  begin
    // Достаём данные
    ExtractData(IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
      TablesNameSingle, TableCountSingle);
    // Преобразовать в массив с восстановлением
    MakeDataArr(True);
    // Прячем легенду
    fmChart.chPreview.Legend.Visible := False;
    // Добавляем график
    fmChart.chPreview.AddSeries(TLineSeries);
    // Обзываем
    fmChart.chPreview.Series[0].Title := IVK_DM.tbSignalList.FieldByName
      ('Logging_Name').AsString;
    fmChart.chPreview.Series[0].XValues.DateTime := True;
    // Заполняем
    if qForExport.RecordCount > 0 then
      // Если данные есть
      for j := 0 to Length(ExpDataArr) - 1 do
        // Переносим все значения на график
        fmChart.chPreview.Series[0].AddXY(ExpDataArr[j].DT, ExpDataArr[j].Val)
    else
      // Иначе ругаемся
      AddLog(mLog, 'Обнаружен параметр без данных! Пропускаем.');
  end;
  // Отобразить форму с графиками
  fmChart.ShowModal;
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
  ExtractData(IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
    TablesNameSingle, TableCountSingle);
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
