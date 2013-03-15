unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, ExtCtrls, ComCtrls, XPMan;

type
  TfmMain = class(TForm)
    mXcoord: TMemo;
    mYcoord: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    sdTable: TSaveDialog;
    btGen: TButton;
    Label3: TLabel;
    pGenStatus: TPanel;
    pbGenState: TProgressBar;
    XPMan: TXPManifest;
    procedure FormShow(Sender: TObject);
    procedure btGenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

// Очистка полей
procedure TfmMain.FormShow(Sender: TObject);
begin
  mXcoord.Lines.Clear;
  mYcoord.Lines.Clear;
end;

// Генерация
procedure TfmMain.btGenClick(Sender: TObject);
var
  xycount, i: integer;
  tabfile: TIniFile;
  minmemo: string[1];
  X, Y: real;
begin
  // Количество точек
  try
    if sdTable.Execute then
    begin
      // Отклчение всего ненужного
      btGen.Enabled := False;
      mXcoord.Enabled := False;
      mYcoord.Enabled := False;
      // Отображение прогрессбара
      pGenStatus.Visible := True;
      Self.Repaint;
      if mXcoord.Lines.Count > mYcoord.Lines.Count then
      // Какую координату будем добивать нулями?
      begin
        // X, если X больше
        xycount := mXcoord.Lines.Count;
        minmemo := 'Y';
      end
      else
      // Y, если Y больше
      begin
        xycount := mYcoord.Lines.Count;
        minmemo := 'X';
      end;
      // Настройка прогрессбара
      pbGenState.Max := xycount;
      pbGenState.Position := 0;
      pbGenState.Step := 1;

      // Файл для записи
      tabfile := TIniFile.Create(sdTable.FileName);
      if FileExists(sdTable.FileName) then
        // Если файл уже есть, то сносим его, чтобы не наполнять мусором
        DeleteFile(sdTable.FileName);
      // Запись настроек
      tabfile.WriteInteger('InitialData', 'RegCount', xycount + 1);
      for i := 0 to xycount - 1 do
      // Запись точек
      begin
        // Проверка на выход за пределы массива строк меньшего memo
        // Случай с выходом за пределы по X
        if (minmemo = 'X') and (i >= mXcoord.Lines.Count) then
        // Если добиваем нулями X
        begin
          Y := StrToFloat(mYcoord.Lines[i]);
          // Запис X
          tabfile.WriteFloat('TableData', 'X' + inttostr(i + 1), 0);
          tabfile.WriteFloat('TableData', 'F' + inttostr(i + 1), Y);
          pbGenState.StepIt;
        end
        else
        // Если добиваем нулями Y
          if (minmemo = 'Y') and (i >= mYcoord.Lines.Count) then
        begin
          X := StrToFloat(mXcoord.Lines[i]);
          // Запис значений
          tabfile.WriteFloat('TableData', 'X' + inttostr(i + 1), X);
          tabfile.WriteFloat('TableData', 'F' + inttostr(i + 1), 0);
          pbGenState.StepIt;
        end
        else
        // Если зачений поровну
        begin
          X := StrToFloat(mXcoord.Lines[i]);
          Y := StrToFloat(mYcoord.Lines[i]);
          tabfile.WriteFloat('TableData', 'X' + inttostr(i + 1), X);
          tabfile.WriteFloat('TableData', 'F' + inttostr(i + 1), Y);
          pbGenState.StepIt;
        end; // норма
      end; // for
      // Закрытие файла и сообщение о результате
      tabfile.Free;
      pGenStatus.Visible := False;
      MessageBox(Self.Handle, 'Выполнено!', 'Информация',
        MB_OK or MB_ICONINFORMATION);
      // Включение контролов
      btGen.Enabled := True;
      mXcoord.Enabled := True;
      mYcoord.Enabled := True;
    end;
  except
    on E: EIniFileException do
    // Проблема с записью
    begin
      tabfile.Free;
      btGen.Enabled := True;
      mXcoord.Enabled := True;
      mYcoord.Enabled := True;
      pGenStatus.Visible := False;
      MessageBox(Self.Handle, pchar('Возникла ошибка при создании файла:' +
        #10#13 + E.Message + #00), 'Ошибка!', MB_OK or MB_ICONSTOP);
    End; // EIniFileException
    on E: EConvertError do
    // Проблема с данными
    begin
      tabfile.Free;
      btGen.Enabled := True;
      mXcoord.Enabled := True;
      mYcoord.Enabled := True;
      pGenStatus.Visible := False;
      MessageBox(Self.Handle, pchar('Возникла ошибка при обработке значений:' +
        #10#13 + E.Message), 'Ошибка!', MB_OK or MB_ICONSTOP);
    End; // EConvertError
  end; // except
end;

end.
