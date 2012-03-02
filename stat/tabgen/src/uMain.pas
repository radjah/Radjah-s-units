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
  // ShowMessage(inttostr(mXcoord.Lines.Count)+#10#13+inttostr(mXcoord.Lines.Count));
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
      btGen.Enabled := False;
      mXcoord.Enabled := False;
      mYcoord.Enabled := False;
      pGenStatus.Visible := True;
      Self.Repaint;
      if mXcoord.Lines.Count > mYcoord.Lines.Count then
      begin
        xycount := mXcoord.Lines.Count;
        minmemo := 'Y';
      end
      else
      begin
        xycount := mYcoord.Lines.Count;
        minmemo := 'X';
      end;
      // ShowMessage('Minmemo='+minmemo);
      pbGenState.Max := xycount;
      pbGenState.Position := 0;
      pbGenState.Step := 1;

      // Количество точек
      tabfile := TIniFile.Create(sdTable.FileName);
      if FileExists(sdTable.FileName) then
        DeleteFile(sdTable.FileName);
      tabfile.WriteInteger('InitialData', 'RegCount', xycount + 1);
      for i := 0 to xycount - 1 do
      begin
        // Проверка на выход за пределы массива строк меньшего memo
        // Случай с выходом за пределы по X
        if (minmemo = 'X') and (i >= mXcoord.Lines.Count) then
        begin
          Y := StrToFloat(mYcoord.Lines[i]);
          // Запис X
          tabfile.WriteFloat('TableData', 'X' + inttostr(i + 1), 0);
          tabfile.WriteFloat('TableData', 'F' + inttostr(i + 1), Y);
          pbGenState.StepIt;
        end { перебор по X }
        else
        // Случай с выходом за пределы по Y
          if (minmemo = 'Y') and (i >= mYcoord.Lines.Count) then
        begin
          X := StrToFloat(mXcoord.Lines[i]);
          // Запис значений
          tabfile.WriteFloat('TableData', 'X' + inttostr(i + 1), X);
          tabfile.WriteFloat('TableData', 'F' + inttostr(i + 1), 0);
          pbGenState.StepIt;
        end { перебор по Y }
        else
        // Выхода за пределы массива нет
        begin
          X := StrToFloat(mXcoord.Lines[i]);
          Y := StrToFloat(mYcoord.Lines[i]);
          tabfile.WriteFloat('TableData', 'X' + inttostr(i + 1), X);
          tabfile.WriteFloat('TableData', 'F' + inttostr(i + 1), Y);
          pbGenState.StepIt;
        end; // норма
      end; // for
      tabfile.Free;
      pGenStatus.Visible := False;
      MessageBox(Self.Handle, 'Выполнено!', 'Информация',
        MB_OK or MB_ICONINFORMATION);
      btGen.Enabled := True;
      mXcoord.Enabled := True;
      mYcoord.Enabled := True;
    end;
  except
    on E: EIniFileException do
    begin
      tabfile.Free;
      btGen.Enabled := True;
      mXcoord.Enabled := True;
      mYcoord.Enabled := True;
      pGenStatus.Visible := False;
      MessageBox(Self.Handle, pchar('Возникла ошибка при создании файла:' +
        #10#13 + E.Message +#00), 'Ошибка!', MB_OK or MB_ICONSTOP);
    End; // EIniFileException
    on E: EConvertError do
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

// Заполнение поля с именем файла.
end.
