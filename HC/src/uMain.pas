unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls, StdCtrls,
  inifiles;

type
  TMain = class(TForm)
    Label1: TLabel;
    lPosition: TLabel;
    Label3: TLabel;
    lNextPosition: TLabel;
    Label5: TLabel;
    lTime: TLabel;
    pbTime: TProgressBar;
    Chart: TChart;
    btGo: TButton;
    StageTimer: TTimer;
    btLoad: TButton;
    odOpen: TOpenDialog;
    Series1: TBarSeries;
    Label2: TLabel;
    procedure StageTimerTimer(Sender: TObject);
    procedure btGoClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

  HMarr: array of array [1 .. 2] of integer; // Массив этапов
  totaltime: integer; // общее время цикла
  curstage: integer; // Текущей этак цикла
  CurTime: integer = 0; // Настройки этапа цикла
  sttime: integer; // время
  scnt: integer; // количество этапов в цикле

implementation

{$R *.dfm}

procedure TMain.btGoClick(Sender: TObject);
begin
  sttime := HMarr[0][2]; // Получаем время первого этапа
  curstage := 0; // Обозначаем номер первого этапа (счет с нуля)
  // Текущая позиция
  lPosition.Caption := IntToStr(HMarr[0][1]);
  // Проверяем на конец цикла (всего одна позиция?)
  if (curstage + 1) > scnt then
    lNextPosition.Caption := 'конец цикла'
  else
    lNextPosition.Caption := IntToStr(HMarr[curstage][1]);
  StageTimer.Enabled := true; // Запускаем таймер
  // StageTimer.Enabled := true
  // else
  // StageTimer.Enabled := False;
end;

procedure TMain.btLoadClick(Sender: TObject);
var
  hmfile: TIniFile; // файл с режимом
  i: integer; // счетчик для циклов
begin
  // открываем файл и подготавлием всё для запуска цикла
  if odOpen.Execute then
  begin
    btGo.Enabled := true;
    totaltime := 0;
    // Открытие файла
    hmfile := TIniFile.Create(odOpen.FileName);
    scnt := hmfile.ReadInteger('settings', 'count', 0);
    // Подготовка массива
    SetLength(HMarr, scnt);
    ZeroMemory(HMarr, sizeof(HMarr));
    // Чтение цикла в массив
    for i := 1 to scnt do
    begin
      // Позиция
      HMarr[i - 1][1] := hmfile.ReadInteger('stages', 'stage' + IntToStr(i), 0);
      // Время
      HMarr[i - 1][2] := hmfile.ReadInteger('stages', 'time' + IntToStr(i), 0);
      totaltime := totaltime + HMarr[i - 1][2];
    end;
    // Загрузка файла окончена
    // Подготовка интерфейса
    Chart.Series[0].Clear;
    for i := 1 to scnt do
      Chart.Series[0].AddXY(5 * i, HMarr[i - 1][1] + 0.1, IntToStr(i), clGreen);
    lPosition.Caption := '0';
    curstage := 0;
    pbTime.Max := HMarr[0][2];
    pbTime.Position := 0;
    if (curstage + 1) > scnt then
      lNextPosition.Caption := 'конец цикла'
    else
      lNextPosition.Caption := IntToStr(HMarr[curstage][1]);
    lTime.Caption := IntToStr(HMarr[curstage][2]);
    ShowMessage('Файл загружен! Общее время цикла ' + IntToStr(totaltime)
      + ' сек.');
  end;
end;

// Таймер
procedure TMain.StageTimerTimer(Sender: TObject);
begin
  CurTime := CurTime + 1;
  // Проверка на конец этапа
  if CurTime >= sttime then
  // Если время отработки этапа прошло
  begin
    Beep;
    // Если номер пройденного цикла равен количеству циклов
    if (curstage + 1) >= scnt then
    begin
      StageTimer.Enabled := false;
      ShowMessage('Цикл испытаний закончен!');
    end
    else
    // Если закончился только один из этапов
    begin
      curstage := curstage + 1;
      // Загружаем настройки следующего этапа
      // Сброс програссбара
      pbTime.Position := 0;
      // Время нового цикла
      pbTime.Max := HMarr[curstage][2];
      // Сброс счетчика времени
      CurTime := 0;
      // Количество сотавшихся секунд
      sttime := HMarr[curstage][2];
      lTime.Caption := IntToStr(HMarr[curstage][2]);
      // Новый цикл
      lPosition.Caption := IntToStr(HMarr[curstage][1]);
      // Следующий цикл
      if (curstage + 1) >= scnt then
        lNextPosition.Caption := 'конец цикла'
      else
        lNextPosition.Caption := IntToStr(HMarr[curstage + 1][1]);
    end;
  end
  else // Ничего не закончилось
  begin
    // Увеличим програссбар
    pbTime.Position := pbTime.Position + 1;
    // Уменьшим оставшееся время
    lTime.Caption := IntToStr(HMarr[curstage][2] - CurTime);
  end;

  // CurTime := CurTime + 1;
  // lPosition.Caption := inttostr(CurTime);
  // lNextPosition.Caption := inttostr(CurTime + 1);
  // lTime.Caption := inttostr(CurTime);
end;

end.
