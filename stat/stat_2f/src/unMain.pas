unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, MyFunctions, math, inifiles, XPMan;

type
  TfmMain = class(TForm)
    gbSaveLoad: TGroupBox;
    btLoad: TBitBtn;
    btSave: TBitBtn;
    pbSaveLoad: TProgressBar;
    gbParam: TGroupBox;
    lA: TLabel;
    lB: TLabel;
    eA: TEdit;
    eB: TEdit;
    udA: TUpDown;
    udB: TUpDown;
    btCreate: TButton;
    btRaname: TButton;
    gbData: TGroupBox;
    sbData: TScrollBox;
    gbLog: TGroupBox;
    mLog: TMemo;
    btClear: TButton;
    gbCalc: TGroupBox;
    Label6: TLabel;
    btResult: TButton;
    btCalc: TButton;
    udPrsn: TUpDown;
    ePrsn: TEdit;
    cbDebug: TCheckBox;
    cbSpaces: TCheckBox;
    odLoad: TOpenDialog;
    sdSave: TSaveDialog;
    XPMan: TXPManifest;
    procedure FormShow(Sender: TObject);
    procedure btCreateClick(Sender: TObject);
    procedure btCalcClick(Sender: TObject);
    procedure MakeVarLabels;
    procedure btLoadClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btRanameClick(Sender: TObject);
    procedure btResultClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  MemoArr: array of array of TMemo; // Массив мемо
  LabArr: array of array of array [1 .. 2] of TLabel;
  ArrCellSumm: array of array of real;
  iA, jB: integer; // Размерность
  ShortA: string = 'A';
  ShortB: string = 'B';
  FullA: string = 'A';
  FullB: string = 'B';
  repmes: Boolean = true;

implementation

uses
  unResult, unRename;

{$R *.dfm}

{ === Рсчет === }
procedure TfmMain.btCalcClick(Sender: TObject);
var
  Sum, SumPartQ, Suml2, SumA, SumB, Sum2, SumA2, SumB2, Q, Q0, QA, QB, QAB,
    Qtmp: real; // Всякие расзные суммы и дисперсии
  ssA, ssB, ssAB, ssRand, ssSum: integer;
  // степени свободы
  skA, skB, skAB, skRand, skSum, MemoMid: real;
  // Ср.кв.
  // SumCArr: array of real; // Массив для суммы слобцов в каждом табе
  i, j, l, lcount: integer; // счетчики
  Prsn: integer; // Точночть вывода результата
  time: uint; // понтоый таймер
begin
  time := GetTickCount;
  SetRoundMode(rmNearest);
  Prsn := udPrsn.Position;
  // Ищем мемо с максимальным количеством строк
  lcount := 0;
  for i := 0 to iA - 1 do
    for j := 0 to jB - 1 do
      if lcount < MemoArr[i, j].Lines.Count then
        lcount := MemoArr[i, j].Lines.Count;
  if lcount = 1 then
  begin
    repmes := false;
    AddLog(mLog, 'Внимание! Нет повторения измерений.');
  end
  else
    repmes := true;

  // Обрабатываем мемо, в которых количество строк меньше lcount
  for i := 0 to iA - 1 do
    for j := 0 to jB - 1 do
      if MemoArr[i, j].Lines.Count < lcount then
      begin
        MemoMid := 0;
        for l := 0 to MemoArr[i, j].Lines.Count - 1 do
          MemoMid := MemoMid + StrToFloat(MemoArr[i, j].Lines[l]);
        if MemoArr[i, j].Lines.Count = 0 then
        begin
          if NOT cbSpaces.Checked then
            MemoMid := 0
        end
        else
          MemoMid := MemoMid / MemoArr[i, j].Lines.Count;
        if NOT((cbSpaces.Checked = true) and
          (MemoArr[i, j].Lines.Count = 0)) then
          for l := MemoArr[i, j].Lines.Count + 1 to lcount do
            MemoArr[i, j].Lines.Add(floattostr(MemoMid));
      end;

  // Массив с суммами всех строк в каждом мемо (ArrCellSumm),
  // сумму квадратов всех замеров (Suml2) и сумму всех замеров (Sum)
  SetLength(ArrCellSumm, iA);
  ZeroMemory(ArrCellSumm, sizeof(ArrCellSumm));
  Sum := 0;
  Sum2 := 0;
  Suml2 := 0;
  for i := 0 to iA - 1 do // Прыгаем по табам
  begin
    SetLength(ArrCellSumm[i], jB);
    ZeroMemory(ArrCellSumm[i], sizeof(ArrCellSumm[i]));
    for j := 0 to jB - 1 do // Прыгаем по столбцам
    begin
      ArrCellSumm[i, j] := 0;
      for l := 0 to MemoArr[i, j].Lines.Count - 1 do // Строки в мемо
      begin
        ArrCellSumm[i, j] := ArrCellSumm[i, j] +
          StrToFloat(MemoArr[i, j].Lines[l]);
        Suml2 := Suml2 + power(StrToFloat(MemoArr[i, j].Lines[l]), 2);
        Sum := Sum + StrToFloat(MemoArr[i, j].Lines[l]);
      end;
      Sum2 := Sum2 + power(ArrCellSumm[i, j], 2);
    end;
  end;
  if cbDebug.Checked then
  begin
    AddLog(mLog, 'Sum=' + floattostr(Sum) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
    AddLog(mLog, 'Sum2=' + floattostr(Sum2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
    AddLog(mLog, 'Suml2=' + floattostr(Suml2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  end;
  // Сумма по всех B для каждого A и квадрат этой суммы
  SumA2 := 0;
  for i := 0 to iA - 1 do
  begin
    SumA := 0;
    for j := 0 to jB - 1 do
      SumA := SumA + ArrCellSumm[i, j];
    SumA2 := SumA2 + power(SumA, 2);
  end;
  if cbDebug.Checked then
    AddLog(mLog, 'SumA2:=' + floattostr(SumA2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  // Сумма по всех A для каждого B и квадрат этой суммы
  SumB2 := 0;
  for j := 0 to jB - 1 do
  begin
    SumB := 0;
    for i := 0 to iA - 1 do
      SumB := SumB + ArrCellSumm[i, j];
    SumB2 := SumB2 + power(SumB, 2);
  end;
  if cbDebug.Checked then
    AddLog(mLog, 'SumB2:=' + floattostr(SumB2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  // Считается, что в каждом мемо одинаковое количество строк lcount
  // Вычисляем все Q
  SumPartQ := power(Sum, 2) / iA / jB / lcount;
  if cbDebug.Checked then
    AddLog(mLog, 'SumPartQ:=' + floattostr(SumPartQ) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  // QA
  QA := SumA2 / jB / lcount - SumPartQ;
  if cbDebug.Checked then
    AddLog(mLog, 'QA:=' + floattostr(QA) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  fmResult.sgResult.Cells[1, 1] := floattostr(RoundTo(QA, Prsn));
  // QB
  QB := SumB2 / iA / lcount - SumPartQ;
  if cbDebug.Checked then
    AddLog(mLog, 'QB:=' + floattostr(QB) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  fmResult.sgResult.Cells[1, 2] := floattostr(RoundTo(QB, Prsn));
  if repmes then
  begin
    // QAB
    QAB := Sum2 / lcount - SumPartQ - QA - QB;
    if cbDebug.Checked then
      AddLog(mLog, 'QAB:=' + floattostr(QAB) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    fmResult.sgResult.Cells[1, 3] := floattostr(RoundTo(QAB, Prsn));
    // Q0
    Qtmp := QA + QB + QAB;
    Q := Suml2 - SumPartQ;
    Q0 := Q - Qtmp;
    if cbDebug.Checked then
      AddLog(mLog, 'Q0:=' + floattostr(Q0) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    fmResult.sgResult.Cells[1, 4] := floattostr(RoundTo(Q0, Prsn));
    // Q
    // Q := Suml2 - SumPartQ;
    fmResult.sgResult.Cells[1, 5] := floattostr(RoundTo(Q, Prsn));
    if cbDebug.Checked then
    begin
      AddLog(mLog, 'Q:=' + floattostr(Q) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
      Qtmp := QA + QB + QAB;
      AddLog(mLog, 'Qtmp:=' + floattostr(Qtmp) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    end;
  end
  else
  begin
    // Q0
    Qtmp := QA + QB;
    Q := Suml2 - SumPartQ;
    Q0 := Q - Qtmp;
    // Q0 := Suml2 - SumPartQ - QA - QB - QC - QAB - QAC - QBC - QABC;
    if cbDebug.Checked then
      AddLog(mLog, 'Q0:=' + floattostr(Q0) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    fmResult.sgResult.Cells[1, 3] := floattostr(RoundTo(Q0, Prsn));
    // Q
    // Q := Suml2 - SumPartQ;
    fmResult.sgResult.Cells[1, 4] := floattostr(RoundTo(Q, Prsn));
    if cbDebug.Checked then
    begin
      AddLog(mLog, 'Q:=' + floattostr(Q) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
      Qtmp := QA + QB;
      AddLog(mLog, 'Qtmp:=' + floattostr(Qtmp) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    end;
  end;
  // Вычисляем степени свободы
  ssA := iA - 1;
  fmResult.sgResult.Cells[2, 1] := floattostr(ssA);
  ssB := jB - 1;
  fmResult.sgResult.Cells[2, 2] := floattostr(ssB);
  if repmes then
  begin
    ssAB := ssA * ssB;
    fmResult.sgResult.Cells[2, 3] := floattostr(ssAB);
    ssRand := jB * iA * (lcount - 1);
    fmResult.sgResult.Cells[2, 4] := floattostr(ssRand);
    ssSum := ssA + ssB + ssAB + ssRand;
    fmResult.sgResult.Cells[2, 5] := floattostr(ssSum);
  end
  else
  begin
    ssRand := ssA * ssB;
    fmResult.sgResult.Cells[2, 3] := floattostr(ssRand);
    ssSum := ssA + ssB + ssRand;
    fmResult.sgResult.Cells[2, 4] := floattostr(ssSum);
  end;
  // Ср.кв.
  skA := QA / ssA;
  fmResult.sgResult.Cells[3, 1] := floattostr(RoundTo(skA, Prsn));
  skB := QB / ssB;
  fmResult.sgResult.Cells[3, 2] := floattostr(RoundTo(skB, Prsn));
  if repmes then
  begin
    skAB := QAB / ssAB;
    fmResult.sgResult.Cells[3, 3] := floattostr(RoundTo(skAB, Prsn));
    skRand := Q0 / ssRand;
    fmResult.sgResult.Cells[3, 4] := floattostr(RoundTo(skRand, Prsn));
    skSum := skA + skB + skAB + skRand;
    fmResult.sgResult.Cells[3, 5] := floattostr(RoundTo(skSum, Prsn));
  end
  else
  begin
    skRand := Q0 / ssRand;
    fmResult.sgResult.Cells[3, 3] := floattostr(RoundTo(skRand, Prsn));
    skSum := skA + skB + skRand;
    fmResult.sgResult.Cells[3, 4] := floattostr(RoundTo(skSum, Prsn));
  end;
  // Эмпир.
  fmResult.sgResult.Cells[4, 1] := floattostr(RoundTo(skA / skRand, Prsn));
  fmResult.sgResult.Cells[4, 2] := floattostr(RoundTo(skB / skRand, Prsn));
  if repmes then
    fmResult.sgResult.Cells[4, 3] := floattostr(RoundTo(skAB / skRand, Prsn));
  // Всё!
  time := GetTickCount - time;
  fmResult.lTime.Caption := 'Вычисления заняли ' +
    floattostr(time / 1000) + ' сек';
  AddLog(mLog, 'Вычисления заняли ' + floattostr(time / 1000) + ' сек)');
  fmResult.ShowModal;
end;

{ === Подготовка интерейса === }
procedure TfmMain.btCreateClick(Sender: TObject);
const
  High: integer = 150;
  Top: integer = 30;
  Interval: integer = 35;
  Margin: integer = 35;
  Width: integer = 100;
var
  i, j: integer; // Счетчики
  time: uint; // Понтовый таймер
begin
  time := GetTickCount;
  btCalc.Enabled := true;
  btSave.Enabled := true;
  AddLog(mLog, 'Создание полей...');
  // Удаление всех мемов и скроллбоксов
  for i := 0 to iA - 1 do
    for j := 0 to jB - 1 do
    begin
      MemoArr[i, j].Free;
      LabArr[i, j, 1].Free;
      LabArr[i, j, 2].Free;
    end;
  // Создание мемо
  iA := udA.Position;
  SetLength(LabArr, iA);
  ZeroMemory(LabArr, sizeof(LabArr));
  SetLength(MemoArr, udA.Position);
  for i := 0 to udA.Position - 1 do
  begin
    SetLength(MemoArr[i], udB.Position);
    ZeroMemory(MemoArr[i], sizeof(MemoArr[i]));
    jB := udB.Position;
    SetLength(LabArr[i], udB.Position);
    ZeroMemory(LabArr[i], sizeof(MemoArr[i]));
    for j := 0 to udB.Position - 1 do
    begin
      // Установка мемо
      MemoArr[i, j] := TMemo.Create(Self);
      MemoArr[i, j].Top := Top + High * j + Interval * j;
      MemoArr[i, j].Left := Margin + Width * i + Interval * i;
      MemoArr[i, j].Height := High;
      MemoArr[i, j].Width := Width;
      MemoArr[i, j].ScrollBars := ssBoth;
      MemoArr[i, j].Parent := sbData;
      // Установка подписей столбцов
      LabArr[i, j, 1] := TLabel.Create(Self);
      LabArr[i, j, 1].Caption := ShortA + ' ' + IntToStr(i + 1);
      LabArr[i, j, 1].Top := Top - 15 + High * j + Interval * j;
      LabArr[i, j, 1].Left := Margin + (Width div 2) -
        (LabArr[i, j, 1].Width div 2) + Width * i + Interval * i;
      LabArr[i, j, 1].Parent := sbData;
      // Установка подписей строк
      LabArr[i, j, 2] := TLabel.Create(Self);
      LabArr[i, j, 2].Caption := ShortB + ' ' + IntToStr(j + 1);
      LabArr[i, j, 2].Top := Top + ( High div 2) -
        (LabArr[i, j, 2].Height div 2) + High * j + Interval * j;
      LabArr[i, j, 2].Left := Margin - 5 - LabArr[i, j, 2].Width + Width * i +
        Interval * i;
      LabArr[i, j, 2].Parent := sbData;
    end;
  end;
  time := GetTickCount - time;
  AddLog(mLog, 'Готово! (' + floattostr(time / 1000) + ' сек)');
end;

{ === Загрузка данных из файла === }
procedure TfmMain.btLoadClick(Sender: TObject);
var
  src: TIniFile;
  // Файл с данными
  i, j, k: integer; // Счетчики
  time: uint;
begin
  if odLoad.Execute then
  begin
    time := GetTickCount;
    AddLog(mLog, 'Загрузка данных из ' + odLoad.FileName + '...');
    // Открываем файл
    src := TIniFile.Create(odLoad.FileName);
    // Параметры массива.
    udA.Position := src.ReadInteger('series', 'numA', 0);
    udB.Position := src.ReadInteger('series', 'numB', 0);
    // Названия полей
    FullA := src.ReadString('varnames', 'FullA', 'A');
    FullB := src.ReadString('varnames', 'FullB', 'B');
    ShortA := src.ReadString('varnames', 'ShortA', 'A');
    ShortB := src.ReadString('varnames', 'ShortB', 'B');
    // Подготовка интерфейса
    btCreateClick(Self);
    MakeVarLabels;
    pbSaveLoad.Max := iA * jB;
    pbSaveLoad.Position := 0;
    // Чтение элементов массива
    for i := 1 to iA do
      for j := 1 to jB do
      begin
        for k := 0 to src.ReadInteger('ser_' + IntToStr(i) + '_' + IntToStr(j),
          'num', 0) - 1 do
          MemoArr[i - 1, j - 1].Lines.Add
            (src.ReadString('ser_' + IntToStr(i) + '_' + IntToStr(j),
            'val' + IntToStr(k), ''));
        pbSaveLoad.StepIt;
      end;
    src.Free;
    AddLog(mLog, 'Загрузка данных завершена. (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  end;
end;

{ === Окно переименования параметров === }
procedure TfmMain.btRanameClick(Sender: TObject);
begin
  fmRename.ShowModal;
end;

{ === Показать окно результатов === }
procedure TfmMain.btResultClick(Sender: TObject);
begin
  fmResult.ShowModal;
end;

{ === Сохранение данных === }
procedure TfmMain.btSaveClick(Sender: TObject);
var
  src: TIniFile;
  // Файл с данными
  i, j, k: integer; // Счетчики
  time: uint;
begin
  if sdSave.Execute then
  begin
    pbSaveLoad.Max := iA * jB;
    pbSaveLoad.Position := 0;
    time := GetTickCount;
    AddLog(mLog, 'Сохранение даных в ' + sdSave.FileName + '...');
    // Удаляем старый файл, если такой есть, чтобы не накапливать в нем мусор
    if FileExists(sdSave.FileName) then
      DeleteFile(sdSave.FileName);
    // Создаем новый файл и открываем его
    src := TIniFile.Create(sdSave.FileName);
    // Параметры сохраняемого массива
    src.WriteInteger('series', 'numA', iA);
    src.WriteInteger('series', 'numB', jB);
    // Названия полей
    src.WriteString('varnames', 'FullA', FullA);
    src.WriteString('varnames', 'FullB', FullB);
    src.WriteString('varnames', 'ShortA', ShortA);
    src.WriteString('varnames', 'ShortB', ShortB);
    // Запись секций с элементами массива
    for i := 1 to iA do
      for j := 1 to jB do
      begin
        src.WriteInteger('ser_' + IntToStr(i) + '_' + IntToStr(j), 'num',
          MemoArr[i - 1, j - 1].Lines.Count);
        for k := 0 to MemoArr[i - 1, j - 1].Lines.Count - 1 do
          src.WriteString('ser_' + IntToStr(i) + '_' + IntToStr(j),
            'val' + IntToStr(k), MemoArr[i - 1, j - 1].Lines[k]);
        pbSaveLoad.StepIt;
      end;
    src.Free;
    AddLog(mLog, 'Сохранение данных завершено. (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  end;
end;

{ === Очистка лога при запуске === }
procedure TfmMain.FormShow(Sender: TObject);
begin
  mLog.Clear;
end;

{ === Задаем названия === }
procedure TfmMain.MakeVarLabels;
var
  i, j: integer;
  time: uint;
begin
  time := GetTickCount;
  AddLog(mLog, 'Выполняется переименование...');
  lA.Caption := FullA + ' (' + ShortA + '):';
  lB.Caption := FullB + ' (' + ShortB + '):';
  for i := 0 to iA - 1 do
    for j := 0 to jB - 1 do
    begin
      LabArr[i, j, 1].Caption := ShortA + ' ' + IntToStr(i + 1);
      LabArr[i, j, 2].Caption := ShortB + ' ' + IntToStr(j + 1);
    end;
  AddLog(mLog, 'Выполнено!' + ' (' + floattostr((GetTickCount - time) / 1000)
    + ' сек)');
end;

end.
