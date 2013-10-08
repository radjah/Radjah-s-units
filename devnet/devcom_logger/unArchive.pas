unit unArchive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZDataset, DB, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractTable, StdCtrls, Grids, DBGrids;

type
  TfmArchive = class(TForm)
    dbgArchive: TDBGrid;
    lArcTime: TLabel;
    lArcDiff: TLabel;
    lArcUd: TLabel;
    Label4: TLabel;
    ztMeasArchive: TZTable;
    dsArchive: TDataSource;
    zqArchive: TZQuery;
    ztWeight: TZTable;
    dsWeight: TDataSource;
    btExport: TButton;
    sdExport: TSaveDialog;
    zqDelete: TZQuery;
    btDelete: TButton;
    zqDelMeas: TZQuery;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure dbgArchiveColEnter(Sender: TObject);
    procedure dbgArchiveCellClick(Column: TColumn);
    procedure dbgArchiveKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btExportClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure ztMeasArchiveBeforeScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmArchive: TfmArchive;

implementation

uses unDevNetLogger, MyFunctions, ComObj, ExcelAddOns;

{$R *.dfm}

{ === Обновление таблиц при открытии формы === }
procedure TfmArchive.FormShow(Sender: TObject);
begin
  ReopenDatasets([ztMeasArchive,ztWeight]);
end;

{ === Обработка архива === }
procedure TfmArchive.dbgArchiveColEnter(Sender: TObject);
var
  WeightStart,WeightEnd:real; // Значение массы на начало и конец замера
  ArcTime:real; // Продолжительность замера
  WeightDiff:real; // Расход зазамер
begin
  if ztMeasArchive.RecordCount>0 then
  begin
    // Запускаем запрос
    zqArchive.Close;
    zqArchive.SQL.Strings[1]:='meas_id='+ztMeasArchive.FieldByName('id').AsString;
    zqArchive.Open;
    // Получение данных
    ArcTime:=ztMeasArchive.FieldByName('mtime').AsFloat;
    lArcTime.Caption:='Время: ' + FloatToStr(ArcTime) + ' сек.';
    zqArchive.First;
    WeightStart:=zqArchive.FieldByName('brutto').AsFloat;
    zqArchive.Last;
    WeightEnd:=zqArchive.FieldByName('brutto').AsFloat;
    WeightDiff:=Abs(WeightStart-WeightEnd);
    lArcDiff.Caption:='Разница: ' + Format('%.3f',[WeightDiff]);
    if ArcTime<>0 then
    lArcUd.Caption:='Часовой: ' +  Format('%.3f',[WeightDiff/ArcTime*3600])
    else
    lArcUd.Caption:='Часовой:'
  end;
end;

{ === Обновление информации при выборе ячеек мышкой === }
procedure TfmArchive.dbgArchiveCellClick(Column: TColumn);
begin
  dbgArchiveColEnter(Self);
end;

{ === Обновление информации при навигации курсорными клавишами === }
procedure TfmArchive.dbgArchiveKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  dbgArchiveColEnter(Self);
end;

{ === Экспорт данных в Excel === }
procedure TfmArchive.btExportClick(Sender: TObject);
var
  Excel, Book, Sheet, ArrayData, Cell1, Cell2, Range: variant; // для Excel
  i : integer; // Счатчик
  BeginCol, BeginRow, RowCount, ColCount: integer; // Количество строк и столбцов
begin
  try
  if sdExport.Execute then
  begin
    // Запрос
    zqArchive.Close;
    zqArchive.SQL.Strings[1]:='meas_id='+ztMeasArchive.FieldByName('id').AsString;
    zqArchive.Open;
    // Создаём новый объект
    Excel := CreateOleObject('Excel.Application');
    // Молчать в тряпочку
    Excel.DisplayAlerts := False;
    // Создаём новую книгу
    Excel.WorkBooks.Add;
    Book := Excel.WorkBooks.Item[1];
    // Прибиваем лишние листы
    for i := 1 to Book.Sheets.Count - 1 do
      Book.Sheets.Item[1].Delete;
    Sheet := Excel.WorkBooks.Item[1].Worksheets.Item[1];
    // Массив данных для вывода
    RowCount := ztWeight.RecordCount+1;
    BeginCol := 1;
    BeginRow := 1;
    ColCount := 4; // Время, Брутто, Нетто, Тара
    ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
    ArrayData[1, 1]:='Время';
    ArrayData[1, 2]:='Брутто';
    ArrayData[1, 3]:='Нетто';
    ArrayData[1, 4]:='Тара';
    ztWeight.First;
    for i:=2 to RowCount do
      // Заполняем массив
       begin
         // Время
         ArrayData[i, 1] := ztWeight.FieldByName('date').AsDateTime;
         // Брутто
         ArrayData[i, 2] := ztWeight.FieldByName('brutto').AsFloat;
         // Нетто
         ArrayData[i, 3] := ztWeight.FieldByName('netto').AsFloat;
         // Тара
         ArrayData[i, 4] := ztWeight.FieldByName('tara').AsFloat;
         // Следующая запись
         ztWeight.Next;
       end;
    // Пишем кусок данных на указанный лист
    Cell1 := Sheet.Cells[BeginRow, BeginCol];
    Cell2 := Sheet.Cells[BeginRow + RowCount - 1,
      BeginCol + ColCount - 1];
    Range := Sheet.Range[Cell1, Cell2];
    Range.Value := ArrayData;
    // Сохраняем
    sdExport.DefaultExt := 'xls';
    Book.SaveAs(sdExport.FileName, xlWorkbookNormal);
    Excel.Quit;
    MessageBox(Self.Handle, 'Экспорт выполнен.',
        'Информация', MB_OK or MB_ICONINFORMATION);
  end;
  except
    on E: EOleException do
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка при работе', MB_OK or MB_ICONERROR);
    on E: EVariantError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка', MB_OK or MB_ICONERROR);
      Excel:=Unassigned;
    end;
  end;
end;

{ === Удаление замера === }
procedure TfmArchive.btDeleteClick(Sender: TObject);
begin
  if MessageBox(Self.Handle, 'Удалить замер?', 'Вопрос', MB_YESNO or MB_ICONQUESTION)=IDYES
  then
  begin
    zqDelete.Close;
    zqDelete.SQL.Strings[1]:='meas_id='+ztMeasArchive.FieldByName('id').AsString;
    zqDelete.ExecSQL;
    zqDelete.Close;
    zqDelMeas.SQL.Strings[1]:='id='+ztMeasArchive.FieldByName('id').AsString;
    zqDelMeas.ExecSQL;
    ztWeight.Refresh;
    ztMeasArchive.Refresh;
    dbgArchiveColEnter(Self);
  end;
end;

{ === Еще один обработчик для обновления информации === }
procedure TfmArchive.ztMeasArchiveBeforeScroll(DataSet: TDataSet);
begin
  dbgArchiveColEnter(Self);
end;

end.
