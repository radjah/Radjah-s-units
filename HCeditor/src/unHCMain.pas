unit unHCMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls, StdCtrls,
  inifiles, mmsystem;

type
  THCMain = class(TForm)
    Label1: TLabel;
    lPosition: TLabel;
    Label3: TLabel;
    lNextPosition: TLabel;
    Label5: TLabel;
    lTime: TLabel;
    pbTime: TProgressBar;
    Chart: TChart;
    btGo: TButton;
    btLoad: TButton;
    odOpen: TOpenDialog;
    Label2: TLabel;
    Series1: TLineSeries;
    lStages: TLabel;
    Label4: TLabel;
    Button1: TButton;
    procedure btGoClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    // procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MMTimer1: integer; // Код мультимедийного таймера
  end;

procedure MyTimerCallBackProg(uTimerID, uMessage: UINT;
  dwUser, dw1, dw2: DWORD); stdcall;

var
  HCMain: THCMain;
  HMarr: array of array [1 .. 2] of integer; // Массив этапов
  totaltime: integer; // общее время цикла
  curstage: integer; // Текущей этак цикла
  CurTime: integer = 1; // Настройки этапа цикла
  sttime: integer; // время
  scnt: integer; // количество этапов в цикле
  tickcount: longint;

implementation

uses
  unAbout;

{$R *.dfm}

// Обработка тика таймера
procedure MyTimerCallBackProg(uTimerID, uMessage: UINT;
  dwUser, dw1, dw2: DWORD); stdcall;
var
  str: string;
begin
  HCMain.pbTime.Position := HCMain.pbTime.Position + 1;
  // Проверка на конец этапа
  if CurTime >= sttime then
  // Если время отработки этапа прошло
  begin
    Beep;
    // Если номер пройденного цикла равен количеству циклов
    if (curstage + 1) >= scnt then
    begin
      // Остановка таймера
      timeKillEvent(HCMain.MMTimer1);
      tickcount := GetTickCount - tickcount;
      HCMain.btLoad.Enabled := True;
      HCMain.lTime.Caption := '0';
      CurTime := 0;
      str := 'Цикл испытаний закончен!' + #10#13 + 'Затрачено времени ' +
        floattostr(tickcount / 1000) + ' сек.';
      MessageBox(HCMain.Handle, pchar(str), 'Конец цикла',
        MB_OK or MB_ICONINFORMATION);
      HCMain.btGo.Enabled := True;
      // Возвращаем значения для начала цикла
      HCMain.lPosition.Caption := '0';
      curstage := 0;
      HCMain.lStages.Caption := '0/' + inttostr(scnt);
      HCMain.pbTime.Max := HMarr[0][2];
      HCMain.pbTime.Position := 0;
      if (curstage + 1) > scnt then
        HCMain.lNextPosition.Caption := 'конец цикла'
      else
        HCMain.lNextPosition.Caption := inttostr(HMarr[curstage][1]);
      HCMain.lTime.Caption := inttostr(HMarr[curstage][2]);
      CurTime := CurTime + 1;
    end
    else
    // Если закончился только один из этапов
    begin
      curstage := curstage + 1;
      HCMain.lStages.Caption := inttostr(curstage + 1) + '/' + inttostr(scnt);
      // Загружаем настройки следующего этапа
      // Сброс програссбара
      HCMain.pbTime.Position := 0;
      // Время нового цикла
      HCMain.pbTime.Max := HMarr[curstage][2];
      // Сброс счетчика времени
      CurTime := 1;
      // Количество сотавшихся секунд
      sttime := HMarr[curstage][2];
      HCMain.lTime.Caption := inttostr(HMarr[curstage][2]);
      // Новый цикл
      HCMain.lPosition.Caption := inttostr(HMarr[curstage][1]);
      // Следующий цикл
      if (curstage + 1) >= scnt then
        HCMain.lNextPosition.Caption := 'конец цикла'
      else
        HCMain.lNextPosition.Caption := inttostr(HMarr[curstage + 1][1]);
    end;
  end
  else // Ничего не закончилось
  begin
    // Увеличим програссбар
    // pbTime.Position := pbTime.Position + 1;
    // Уменьшим оставшееся время
    HCMain.lTime.Caption := inttostr(HMarr[curstage][2] - CurTime);
    CurTime := CurTime + 1;
  end;
  // CurTime := CurTime + 1;
  // lPosition.Caption := inttostr(CurTime);
  // lNextPosition.Caption := inttostr(CurTime + 1);
  // lTime.Caption := inttostr(CurTime);
end;

// Запуск цикла
procedure THCMain.btGoClick(Sender: TObject);
begin
  btGo.Enabled := false;
  sttime := HMarr[0][2]; // Получаем время первого этапа
  curstage := 0; // Обозначаем номер первого этапа (счет с нуля)
  lStages.Caption := inttostr(curstage + 1) + '/' + inttostr(scnt);
  // Текущая позиция
  lPosition.Caption := inttostr(HMarr[0][1]);
  // Проверяем на конец цикла (всего одна позиция?)
  if (curstage + 1) > scnt then
    lNextPosition.Caption := 'конец цикла'
  else
    lNextPosition.Caption := inttostr(HMarr[curstage + 1][1]);
  btLoad.Enabled := false;
  tickcount := GetTickCount;
  // Запуск мультимедийного таймера
  MMTimer1 := timeSetEvent(1000, 10, @MyTimerCallBackProg, 100, TIME_PERIODIC);
end;

// Загрузка цикла из файла.
procedure THCMain.btLoadClick(Sender: TObject);
var
  hmfile: TIniFile; // файл с режимом
  i: integer; // счетчик для циклов
  ctotaltime: integer; // время
  str: string;
begin
  // открываем файл и подготавлием всё для запуска цикла
  if odOpen.Execute then
  begin
    btGo.Enabled := True;
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
      HMarr[i - 1][1] := hmfile.ReadInteger('stages', 'stage' + inttostr(i), 0);
      // Время
      HMarr[i - 1][2] := hmfile.ReadInteger('stages', 'time' + inttostr(i), 0);
      totaltime := totaltime + HMarr[i - 1][2];
    end;
    // Загрузка файла окончена
    // Подготовка интерфейса
    Chart.Series[0].Clear;
    Series1.AddXY(0, 0);
    ctotaltime := 0;
    for i := 1 to scnt do
    begin
      ctotaltime := ctotaltime + HMarr[i - 1][2];
      Chart.Series[0].AddXY(ctotaltime, HMarr[i - 1][1]);
    end;
    lPosition.Caption := '0';
    curstage := 0;
    pbTime.Max := HMarr[0][2];
    pbTime.Position := 0;
    lStages.Caption := '0/' + inttostr(scnt);
    if (curstage + 1) > scnt then
      lNextPosition.Caption := 'конец цикла'
    else
      lNextPosition.Caption := inttostr(HMarr[curstage][1]);
    lTime.Caption := inttostr(HMarr[curstage][2]);
    str := 'Общее время цикла: ' + inttostr(totaltime) + ' сек.' + #10#13 +
      'Количество этапов: ' + inttostr(scnt);
    MessageBox(HCMain.Handle, pchar(str), 'Цикл загружен',
      MB_OK or MB_ICONINFORMATION);
  end;
end;

procedure THCMain.Button1Click(Sender: TObject);
begin
  fmAbout.lProgrammName.Caption := 'Программа испытаний';
  fmAbout.ShowModal;
end;

procedure THCMain.FormShow(Sender: TObject);
begin
  lPosition.Caption := '__';
  lNextPosition.Caption := '__';
  lTime.Caption := '__';
  lStages.Caption := '__/__';
end;

end.
