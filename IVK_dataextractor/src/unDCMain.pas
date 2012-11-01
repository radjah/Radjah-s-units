unit unDCMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, unStruct, OleAuto, ComCtrls, MyFunctions,
  ExcelAddOns;

type
  TfmDCMain = class(TForm)
    leDataFile: TLabeledEdit;
    leExcelFile: TLabeledEdit;
    btDataFile: TButton;
    btExcelFile: TButton;
    odDataFile: TOpenDialog;
    sdExcelFile: TSaveDialog;
    btConvert: TButton;
    procedure btDataFileClick(Sender: TObject);
    procedure btExcelFileClick(Sender: TObject);
    procedure btConvertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDCMain: TfmDCMain;

implementation

{$R *.dfm}

{ === Преобразование === }
procedure TfmDCMain.btConvertClick(Sender: TObject);
var
  Excel, Book, Sheet, Cell1, Cell2, Range: variant; // Переменный для Excel
  ExpData: TExpData;
  ExpDataFile: file of TExpData;
  BeginCol, BeginRow: integer; // Координата первой ячеёки
  RowCount, ColCount: integer; // Количество строк и столбов
  ValArrSigID: array of integer; // Массив идентификаторов
  ValArrDT: array of TDateTime; // Массив временных отметок
  ValArrVal: array of real; // Массив значений
  i: integer; // счетчик
  ValArr: variant; // Массивы для приёма данных.
begin
  try
    if (trim(leDataFile.Text) = '') or (trim(leExcelFile.Text) = '') then
      MessageBox(Self.Handle, 'Не указан исходный и/или результирующий файл.',
        'Ошибка', MB_OK or MB_ICONERROR)
    else
    begin
      // Открываем файл данных
      AssignFile(ExpDataFile, leDataFile.Text);
      Reset(ExpDataFile);
      // Создаем объект Excel
      Excel := CreateOleObject('Excel.Application');
      // Молчать в тряпочку
      Excel.DisplayAlerts := false;
      // Создаём новую книгу
      Excel.WorkBooks.Add;
      Book := Excel.WorkBooks.Item[1];
      Sheet := Excel.WorkBooks.Item[1].Worksheets.Item[1];
      // Координаты левого верхнего угла области, в которую будем выводить данные
      BeginCol := 1;
      BeginRow := 1;
      ColCount := 3;
      RowCount := 0; // Счетчик записей
      // Начинаем читать и писать
      while not EOF(ExpDataFile) do
      begin
        // Читайем очередную запись из файла
        Read(ExpDataFile, ExpData);
        // Расширяем массив
        SetLength(ValArrSigID, length(ValArrSigID) + 1);
        SetLength(ValArrDT, length(ValArrDT) + 1);
        SetLength(ValArrVal, length(ValArrVal) + 1);
        // Заполняем новый элемент
        // ID сигнала
        ValArrSigID[RowCount] := ExpData.SigID;
        // Время замера
        ValArrDT[RowCount] := ExpData.DT;
        // Значение
        ValArrVal[RowCount] := ExpData.Val;
        // Увеличиваем счетчик
        RowCount := RowCount + 1;
      end;
      // Закрываем файл данных
      CloseFile(ExpDataFile);
      ValArr := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
      // СРАНЫЕ КОСТЫЛИ!!!
      for i := 0 to RowCount - 1 do
      begin
        ValArr[i + 1, 1] := ValArrSigID[i];
        ValArr[i + 1, 2] := ValArrDT[i];
        ValArr[i + 1, 3] := ValArrVal[i];
      end;
      // Подготавливаем переменныые для сохранения
      Cell1 := Sheet.Cells[BeginRow, BeginCol];
      Cell2 := Sheet.Cells[BeginRow + RowCount - 1, BeginCol + ColCount - 1];
      Range := Sheet.Range[Cell1, Cell2];
      Range.Value := ValArr;
      Book.SaveAs(leExcelFile.Text, xlWorkbookNormal);
      // Закрываем
      Excel.Quit;
      MessageBox(Self.Handle, 'Преобразование выполнено!', 'Сообщение',
        MB_OK or MB_ICONINFORMATION);
    end;
  except
    on E: EOleError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка при работе', MB_OK or MB_ICONERROR);
      Excel.Quit;
      CloseFile(ExpDataFile);
    end;
    on E: EVariantError do
    begin
      MessageBox(Self.Handle, pchar('Возникла ошибка:' + #10#13 + E.Message),
        'Ошибка при работе', MB_OK or MB_ICONERROR);
      Excel.Quit;
      CloseFile(ExpDataFile);
    end;
  end;
end;

{ === Поиск исходного файла === }
procedure TfmDCMain.btDataFileClick(Sender: TObject);
begin
  if odDataFile.Execute then
  begin
    leDataFile.Text := odDataFile.FileName;
    leExcelFile.Text := odDataFile.FileName + '.xls';
    sdExcelFile.FileName := odDataFile.FileName + '.xls';
  end;
end;

{ === Указание результирующего файла === }
procedure TfmDCMain.btExcelFileClick(Sender: TObject);
begin
  if sdExcelFile.Execute then
    leExcelFile.Text := sdExcelFile.FileName;
end;

end.
