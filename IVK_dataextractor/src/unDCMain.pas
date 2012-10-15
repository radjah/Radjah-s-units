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
  Excel, Book, Sheet: variant; // Переменный для Excel
  ExpData: TExpData;
  ExpDataFile: file of TExpData;
  row: integer; // Счетчик строк таблицы
begin
  try
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
    row := 1;
    // Начинаем читать и писать
    while not EOF(ExpDataFile) do
    begin
      Read(ExpDataFile, ExpData);
      // ID сигнала
      Sheet.Cells[row, 1].FormulaR1C1 := ExpData.SigID;
      // Время замера
      Sheet.Cells[row, 2].FormulaR1C1 := ExpData.DT;
      // Значение
      Sheet.Cells[row, 3].FormulaR1C1 := ExpData.Val;
      row := row + 1;
    end;
    // Закрываем и сохраняем
    CloseFile(ExpDataFile);
    Book.SaveAs(leExcelFile.Text, xlWorkbookNormal);
    Excel.Quit;
  except
    on E: EOleError do
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
