unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, GIFImg, ExtCtrls, MyFunctions, IniFiles,
  math;

type
  TfmMain = class(TForm)
    odLoad: TOpenDialog;
    sdSave: TSaveDialog;
    gbLog: TGroupBox;
    mLog: TMemo;
    btClear: TButton;
    gbData: TGroupBox;
    pcData: TPageControl;
    gbCalc: TGroupBox;
    btResult: TButton;
    btCalc: TButton;
    udPrsn: TUpDown;
    ePrsn: TEdit;
    Label6: TLabel;
    cbDebug: TCheckBox;
    gbSaveLoad: TGroupBox;
    btLoad: TBitBtn;
    btSave: TBitBtn;
    pbSaveLoad: TProgressBar;
    gbParam: TGroupBox;
    Image1: TImage;
    lA: TLabel;
    lB: TLabel;
    lC: TLabel;
    eA: TEdit;
    eB: TEdit;
    eC: TEdit;
    udA: TUpDown;
    udB: TUpDown;
    udC: TUpDown;
    btCreate: TButton;
    btRaname: TButton;
    cbSpaces: TCheckBox;
    procedure btCreateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure btCalcClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    procedure btResultClick(Sender: TObject);
    procedure btRanameClick(Sender: TObject);
    procedure MakeVarLabels;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  MemoArr: array of array of array of TMemo;
  // MemoArr[A,C,B] Все A, B, C между собой равны
  LabArr: array of array of array of array [1 .. 2] of TLabel;
  ArrCellSumm: array of array of array of real;
  SBArr: array of TScrollBox;
  iA, jC, kB, l: integer;
  repmes: boolean = true;
  // Для интерфейса
  ShortA: string = 'A';
  ShortB: string = 'B';
  ShortC: string = 'C';
  FullA: string = 'A';
  FullB: string = 'B';
  FullC: string = 'C';

implementation

uses
  unResult, unRename;

{$R *.dfm}

{ === Великая и ужасная процедура расчета === }
procedure TfmMain.btCalcClick(Sender: TObject);
var
  Sum, SumPartQ, Suml2, SumA, SumB, SumC, SumAB, SumBC, SumAC, Sum2, SumA2,
    SumB2, SumC2, SumAB2, SumBC2, SumAC2, Q, Q0, QA, QB, QC, QAB, QAC, QBC,
    QABC, Qtmp: real; // Всякие расзные суммы и дисперсии
  ssA, ssB, ssC, ssAB, ssAC, ssBC, ssABC, ssRand, ssSum: integer;
  // степени свободы
  skA, skB, skC, skAB, skAC, skBC, skABC, skRand, skSum, MemoMid: real;
  // Ср.кв.
  // SumCArr: array of real; // Массив для суммы слобцов в каждом табе
  i, j, k, l, lcount: integer; // счетчики
  Prsn: integer; // Точночть вывода результата
  time: uint; // понтоый таймер
begin
  time := GetTickCount;

  for i := 1 to fmResult.sgResult.RowCount - 1 do
    for j := 1 to fmResult.sgResult.ColCount - 1 do
      fmResult.sgResult.Cells[j, i] := '';
  SetRoundMode(rmNearest);
  Prsn := udPrsn.Position;
  // Ищем мемо с максимальным количеством строк
  lcount := 0;
  for i := 0 to iA - 1 do
    for j := 0 to jC - 1 do
      for k := 0 to kB - 1 do
        if lcount < MemoArr[i, j, k].Lines.Count then
          lcount := MemoArr[i, j, k].Lines.Count;
  if lcount = 1 then
  begin
    repmes := false;
    AddLog(mLog, 'Внимание! Нет повторения измерений.');
  end
  else
    repmes := true;

  // Обрабатываем мемо, в которых количество строк меньше lcount
  for i := 0 to iA - 1 do
    for j := 0 to jC - 1 do
      for k := 0 to kB - 1 do
        if MemoArr[i, j, k].Lines.Count < lcount then
        begin
          MemoMid := 0;
          for l := 0 to MemoArr[i, j, k].Lines.Count - 1 do
            MemoMid := MemoMid + StrToFloat(MemoArr[i, j, k].Lines[l]);
          if MemoArr[i, j, k].Lines.Count = 0 then
          begin
            if NOT cbSpaces.Checked then
              MemoMid := 0
          end
          else
            MemoMid := MemoMid / MemoArr[i, j, k].Lines.Count;
          if (cbSpaces.Checked = false) or
            (MemoArr[i, j, k].Lines.Count = 0) then
            for l := MemoArr[i, j, k].Lines.Count + 1 to lcount do
              MemoArr[i, j, k].Lines.Add(floattostr(MemoMid));
        end;

  // Массив с суммами всех строк в каждом мемо
  // Попутно считаем сумму квадратов сумм строк всех мемо,
  // сумму квадратов всех замеров и сумму всех замеров
  SetLength(ArrCellSumm, iA);
  ZeroMemory(ArrCellSumm, sizeof(ArrCellSumm));
  Sum := 0;
  Sum2 := 0;
  Suml2 := 0;
  for i := 0 to iA - 1 do // Прыгаем по табам
  begin
    SetLength(ArrCellSumm[i], jC);
    ZeroMemory(ArrCellSumm[i], sizeof(ArrCellSumm[i]));
    for j := 0 to jC - 1 do // Прыгаем по столбцам
    begin
      SetLength(ArrCellSumm[i, j], kB);
      ZeroMemory(ArrCellSumm[i, j], sizeof(ArrCellSumm[i, j]));
      for k := 0 to kB - 1 do // Прагаем по мемам
      begin
        ArrCellSumm[i, j, k] := 0;
        for l := 0 to MemoArr[i, j, k].Lines.Count - 1 do // Строки в мемо
        begin
          ArrCellSumm[i, j, k] := ArrCellSumm[i, j, k] +
            StrToFloat(MemoArr[i, j, k].Lines[l]);
          Suml2 := Suml2 + power(StrToFloat(MemoArr[i, j, k].Lines[l]), 2);
          Sum := Sum + StrToFloat(MemoArr[i, j, k].Lines[l]);
        end;
        Sum2 := Sum2 + power(ArrCellSumm[i, j, k], 2);
      end;
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
  // Насилуем массив во все элементы
  // Находим сумму всех элементво массива по табам и возводим в квадрат (A)
  SumA2 := 0;
  for i := 0 to iA - 1 do
  begin
    SumA := 0;
    for j := 0 to jC - 1 do
      for k := 0 to kB - 1 do
        SumA := SumA + ArrCellSumm[i, j, k];
    // AddLog(mLog, 'SumA:=' + FloatToStr(SumA));
    SumA2 := SumA2 + SumA * SumA;
  end;
  if cbDebug.Checked then
    AddLog(mLog, 'SumA2:=' + floattostr(SumA2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  // Считаем суммы квадратов сумм всех строк (B)
  SumB2 := 0;
  for k := 0 to kB - 1 do
  begin
    SumB := 0;
    for i := 0 to iA - 1 do
      for j := 0 to jC - 1 do
        SumB := SumB + ArrCellSumm[i, j, k];
    if cbDebug.Checked then
      AddLog(mLog, 'SumB:=' + floattostr(SumB) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    SumB2 := SumB2 + SumB * SumB;
  end;
  if cbDebug.Checked then
    AddLog(mLog, 'SumB2:=' + floattostr(SumB2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  // Сумма всех элементов по строкам и сумма квадратов этих сумм (С)
  // Я знаю, что пишу бред.
  SumC2 := 0;
  for j := 0 to jC - 1 do
  begin
    SumC := 0;
    for i := 0 to iA - 1 do
      for k := 0 to kB - 1 do
        SumC := SumC + ArrCellSumm[i, j, k];
    if cbDebug.Checked then
      AddLog(mLog, 'SumC:=' + floattostr(SumC) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    SumC2 := SumC2 + SumC * SumC;
  end;
  if cbDebug.Checked then
    AddLog(mLog, 'SumC2:=' + floattostr(SumC2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  // Сумма всех C для одного B на одном табе. Квадрат этих сумм (AB)
  SumAB2 := 0;
  for i := 0 to iA - 1 do
    for k := 0 to kB - 1 do
    begin
      SumAB := 0;
      for j := 0 to jC - 1 do
        SumAB := SumAB + ArrCellSumm[i, j, k];
      if cbDebug.Checked then
        AddLog(mLog, 'SumAB:=' + floattostr(SumAB) + ' (' +
          floattostr((GetTickCount - time) / 1000) + ' сек)');
      SumAB2 := SumAB2 + SumAB * SumAB;
    end;
  if cbDebug.Checked then
    AddLog(mLog, 'SumAB2:=' + floattostr(SumAB2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  // Сумма всех B для одного С на одном табе. Квадрат этих сумм (AC)
  SumAC2 := 0;
  for i := 0 to iA - 1 do
    for j := 0 to jC - 1 do
    begin
      SumAC := 0;
      for k := 0 to kB - 1 do
        SumAC := SumAC + ArrCellSumm[i, j, k];
      if cbDebug.Checked then
        AddLog(mLog, 'SumAC:=' + floattostr(SumAC) + ' (' +
          floattostr((GetTickCount - time) / 1000) + ' сек)');
      SumAC2 := SumAC2 + SumAC * SumAC;
    end;
  if cbDebug.Checked then
    AddLog(mLog, 'SumAC2:=' + floattostr(SumAC2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  // Сумма всех C для одного B на всех табах. Квадрат этих сумм (BC)
  // Смотрите пример, я немогу это правильно опасть прямо сейчас
  SumBC2 := 0;
  for k := 0 to kB - 1 do
    for j := 0 to jC - 1 do
    begin
      SumBC := 0;
      for i := 0 to iA - 1 do
        SumBC := SumBC + ArrCellSumm[i, j, k];
      if cbDebug.Checked then
        AddLog(mLog, 'SumBC:=' + floattostr(SumBC) + ' (' +
          floattostr((GetTickCount - time) / 1000) + ' сек)');
      SumBC2 := SumBC2 + SumBC * SumBC;
    end;
  if cbDebug.Checked then
    AddLog(mLog, 'SumBC2:=' + floattostr(SumBC2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  // Всё, тихий ужас с комбинациями расчитали
  // Считается, что в каждом мемо одинаковое количество строк lcount
  // Вычисляем все Q
  SumPartQ := power(Sum, 2) / iA / jC / kB / lcount;
  if cbDebug.Checked then
    AddLog(mLog, 'SumPartQ:=' + floattostr(SumPartQ) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  // QA
  QA := SumA2 / jC / kB / lcount - SumPartQ;
  if cbDebug.Checked then
    AddLog(mLog, 'QA:=' + floattostr(QA) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  fmResult.sgResult.Cells[1, 1] := floattostr(RoundTo(QA, Prsn));
  // QB
  QB := SumB2 / jC / iA / lcount - SumPartQ;
  if cbDebug.Checked then
    AddLog(mLog, 'QB:=' + floattostr(QB) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  fmResult.sgResult.Cells[1, 2] := floattostr(RoundTo(QB, Prsn));
  // QC
  QC := SumC2 / kB / iA / lcount - SumPartQ;
  if cbDebug.Checked then
    AddLog(mLog, 'QC:=' + floattostr(QC) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  fmResult.sgResult.Cells[1, 3] := floattostr(RoundTo(QC, Prsn));
  // QAB
  QAB := SumAB2 / jC / lcount - SumPartQ - QA - QB;
  if cbDebug.Checked then
    AddLog(mLog, 'QAB:=' + floattostr(QAB) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  fmResult.sgResult.Cells[1, 4] := floattostr(RoundTo(QAB, Prsn));
  // QAC
  QAC := SumAC2 / kB / lcount - SumPartQ - QA - QC;
  if cbDebug.Checked then
    AddLog(mLog, 'QAC:=' + floattostr(QAC) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  fmResult.sgResult.Cells[1, 5] := floattostr(RoundTo(QAC, Prsn));
  // QBC
  QBC := SumBC2 / iA / lcount - SumPartQ - QB - QC;
  if cbDebug.Checked then
    AddLog(mLog, 'QBC:=' + floattostr(QBC) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  fmResult.sgResult.Cells[1, 6] := floattostr(RoundTo(QBC, Prsn));
  // Были ли повторные измерения?
  if repmes then
  begin
    // QABC
    QABC := Sum2 / lcount - SumPartQ - QA - QB - QC - QAB - QAC - QBC;
    if cbDebug.Checked then
      AddLog(mLog, 'QABC:=' + floattostr(QABC) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    fmResult.sgResult.Cells[1, 7] := floattostr(RoundTo(QABC, Prsn));
    // Q0
    Qtmp := QA + QB + QC + QAB + QAC + QBC + QABC;
    Q := Suml2 - SumPartQ;
    Q0 := Q - Qtmp;
    // Q0 := Suml2 - SumPartQ - QA - QB - QC - QAB - QAC - QBC - QABC;
    if cbDebug.Checked then
      AddLog(mLog, 'Q0:=' + floattostr(Q0) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    fmResult.sgResult.Cells[1, 8] := floattostr(RoundTo(Q0, Prsn));
    // Q
    // Q := Suml2 - SumPartQ;
    fmResult.sgResult.Cells[1, 9] := floattostr(RoundTo(Q, Prsn));
    if cbDebug.Checked then
    begin
      AddLog(mLog, 'Q:=' + floattostr(Q) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
      Qtmp := QA + QB + QC + QAB + QAC + QBC + QABC;
      AddLog(mLog, 'Qtmp:=' + floattostr(Qtmp) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    end;
  end
  else
  begin
    // Q0
    Qtmp := QA + QB + QC + QAB + QAC + QBC;
    Q := Suml2 - SumPartQ;
    Q0 := Q - Qtmp;
    // Q0 := Suml2 - SumPartQ - QA - QB - QC - QAB - QAC - QBC - QABC;
    if cbDebug.Checked then
      AddLog(mLog, 'Q0:=' + floattostr(Q0) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    fmResult.sgResult.Cells[1, 7] := floattostr(RoundTo(Q0, Prsn));
    // Q
    // Q := Suml2 - SumPartQ;
    fmResult.sgResult.Cells[1, 8] := floattostr(RoundTo(Q, Prsn));
    if cbDebug.Checked then
    begin
      AddLog(mLog, 'Q:=' + floattostr(Q) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
      Qtmp := QA + QB + QC + QAB + QAC + QBC;
      AddLog(mLog, 'Qtmp:=' + floattostr(Qtmp) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' сек)');
    end;
  end;

  // Вычисляем степени свободы
  ssA := iA - 1;
  fmResult.sgResult.Cells[2, 1] := floattostr(ssA);
  ssB := kB - 1;
  fmResult.sgResult.Cells[2, 2] := floattostr(ssB);
  ssC := jC - 1;
  fmResult.sgResult.Cells[2, 3] := floattostr(ssC);
  ssAB := ssA * ssB;
  fmResult.sgResult.Cells[2, 4] := floattostr(ssAB);
  ssAC := ssA * ssC;
  fmResult.sgResult.Cells[2, 5] := floattostr(ssAC);
  ssBC := ssB * ssC;
  fmResult.sgResult.Cells[2, 6] := floattostr(ssBC);
  if repmes then
  begin
    ssABC := ssA * ssB * ssC;
    fmResult.sgResult.Cells[2, 7] := floattostr(ssABC);
    ssRand := iA*kB*jC*(lcount - 1);
    fmResult.sgResult.Cells[2, 8] := floattostr(ssRand);
    ssSum := ssA + ssB + ssC + ssAB + ssAC + ssBC + ssABC + ssRand;
    fmResult.sgResult.Cells[2, 9] := floattostr(ssSum);
  end
  else
  begin
    ssRand := ssA * ssB * ssC;
    fmResult.sgResult.Cells[2, 7] := floattostr(ssRand);
    ssSum := ssA + ssB + ssC + ssAB + ssAC + ssBC + ssRand;
    fmResult.sgResult.Cells[2, 8] := floattostr(ssSum);
  end;
  // Ср.кв.
  skA := QA / ssA;
  fmResult.sgResult.Cells[3, 1] := floattostr(RoundTo(skA, Prsn));
  skB := QB / ssB;
  fmResult.sgResult.Cells[3, 2] := floattostr(RoundTo(skB, Prsn));
  skC := QC / ssC;
  fmResult.sgResult.Cells[3, 3] := floattostr(RoundTo(skC, Prsn));
  skAB := QAB / ssAB;
  fmResult.sgResult.Cells[3, 4] := floattostr(RoundTo(skAB, Prsn));
  skAC := QAC / ssAC;
  fmResult.sgResult.Cells[3, 5] := floattostr(RoundTo(skAC, Prsn));
  skBC := QBC / ssBC;
  fmResult.sgResult.Cells[3, 6] := floattostr(RoundTo(skBC, Prsn));
  if repmes then
  begin
    skABC := QABC / ssABC;
    fmResult.sgResult.Cells[3, 7] := floattostr(RoundTo(skABC, Prsn));
    skRand := Q0 / ssRand;
    fmResult.sgResult.Cells[3, 8] := floattostr(RoundTo(skRand, Prsn));
    skSum := skA + skB + skC + skAB + skAC + skBC + skABC + skRand;
    fmResult.sgResult.Cells[3, 9] := floattostr(RoundTo(skSum, Prsn));
  end
  else
  begin
    skRand := Q0 / ssRand;
    fmResult.sgResult.Cells[3, 7] := floattostr(RoundTo(skRand, Prsn));
    skSum := skA + skB + skC + skAB + skAC + skBC + skRand;
    fmResult.sgResult.Cells[3, 8] := floattostr(RoundTo(skSum, Prsn));
  end;
  // Эмпир.
  fmResult.sgResult.Cells[4, 1] := floattostr(RoundTo(skA / skRand, Prsn));
  fmResult.sgResult.Cells[4, 2] := floattostr(RoundTo(skB / skRand, Prsn));
  fmResult.sgResult.Cells[4, 3] := floattostr(RoundTo(skC / skRand, Prsn));
  fmResult.sgResult.Cells[4, 4] := floattostr(RoundTo(skAB / skRand, Prsn));
  fmResult.sgResult.Cells[4, 5] := floattostr(RoundTo(skAC / skRand, Prsn));
  fmResult.sgResult.Cells[4, 6] := floattostr(RoundTo(skBC / skRand, Prsn));
  if repmes then
    fmResult.sgResult.Cells[4, 7] := floattostr(RoundTo(skABC / skRand, Prsn));
  // Всё!
  time := GetTickCount - time;
  fmResult.lTime.Caption := 'Вычисления заняли ' +
    floattostr(time / 1000) + ' сек';
  AddLog(mLog, 'Вычисления заняли ' + floattostr(time / 1000) + ' сек)');
  // fmResult.Parent:=fmMain;
  fmResult.ShowModal;
end;

{ === Очистка лога === }
procedure TfmMain.btClearClick(Sender: TObject);
begin
  mLog.Lines.Clear;
end;

{ === Подготовка интерфейса === }
procedure TfmMain.btCreateClick(Sender: TObject);
const
  High: integer = 150;
  Top: integer = 30;
  Interval: integer = 35;
  Margin: integer = 35;
  Width: integer = 100;
var
  i, j, k: integer; // счетчик
  time: uint;
  newts: TTabSheet;
begin
  time := GetTickCount;
  btCalc.Enabled := true;
  btSave.Enabled := true;
  AddLog(mLog, 'Создание полей...');
  // Удаление всех мемов и скроллбоксов
  for i := 0 to iA - 1 do
    for j := 0 to jC - 1 do
      for k := 0 to kB - 1 do
      begin
        MemoArr[i, j, k].Free;
        LabArr[i, j, k, 1].Free;
        LabArr[i, j, k, 2].Free;
      end;
  for i := 0 to Length(SBArr) - 1 do
    SBArr[i].Free;
  // Удаление всех табов
  for i := pcData.PageCount - 1 downto 0 do
    pcData.Pages[i].Free;
  // Создание табов
  // Массив скроллбоксов
  SetLength(SBArr, udA.Position);
  ZeroMemory(SBArr, sizeof(SBArr));
  iA := udA.Position;
  SetLength(LabArr, udA.Position);
  ZeroMemory(LabArr, sizeof(LabArr));
  SetLength(MemoArr, udA.Position);
  // Первый уровень массивов
  ZeroMemory(MemoArr, sizeof(MemoArr));
  for i := 1 to udA.Position do
  begin
    newts := TTabSheet.Create(pcData);
    newts.PageControl := pcData;
    newts.Caption := ShortA + ' ' + IntToStr(i);
    // Создание скроллбокса на табе
    SBArr[i - 1] := TScrollBox.Create(Self);
    with SBArr[i - 1] do
    begin
      Top := 0;
      Left := 0;
      Height := pcData.Pages[i - 1].Height;
      Width := pcData.Pages[i - 1].Width;
      AutoScroll := true;
      HorzScrollBar.Visible := true;
      VertScrollBar.Visible := true;
      Parent := pcData.Pages[i - 1];
    end;
    // Создание мемов на табе
    SetLength(MemoArr[i - 1], udC.Position);
    ZeroMemory(MemoArr[i - 1], sizeof(MemoArr[i - 1]));
    jC := udC.Position;
    SetLength(LabArr[i - 1], udC.Position);
    ZeroMemory(LabArr[i - 1], sizeof(MemoArr[i - 1]));
    for j := 0 to udC.Position - 1 do
    begin
      SetLength(MemoArr[i - 1, j], udB.Position);
      ZeroMemory(MemoArr[i - 1, j], sizeof(MemoArr[i - 1, j]));
      kB := udB.Position;
      SetLength(LabArr[i - 1, j], udB.Position);
      ZeroMemory(LabArr[i - 1, j], sizeof(MemoArr[i - 1, j]));
      for k := 0 to udB.Position - 1 do
      begin
        // Установка мемо
        MemoArr[i - 1, j, k] := TMemo.Create(Self);
        MemoArr[i - 1, j, k].Top := Top + High * k + Interval * k;
        MemoArr[i - 1, j, k].Left := Margin + Width * j + Interval * j;
        MemoArr[i - 1, j, k].Height := High;
        MemoArr[i - 1, j, k].Width := Width;
        MemoArr[i - 1, j, k].ScrollBars := ssBoth;
        // MemoArr[i - 1, j, k].Parent := pcData.Pages[i - 1];
        MemoArr[i - 1, j, k].Parent := SBArr[i - 1];
        // Установка подписей столбцов
        LabArr[i - 1, j, k, 1] := TLabel.Create(Self);
        LabArr[i - 1, j, k, 1].Caption := ShortC + ' ' + IntToStr(j + 1);
        LabArr[i - 1, j, k, 1].Top := Top - 15 + High * k + Interval * k;
        LabArr[i - 1, j, k, 1].Left := Margin + (Width div 2) -
          (LabArr[i - 1, j, k, 1].Width div 2) + Width * j + Interval * j;
        LabArr[i - 1, j, k, 1].Parent := SBArr[i - 1];
        // Установка подписей строк
        LabArr[i - 1, j, k, 2] := TLabel.Create(Self);
        LabArr[i - 1, j, k, 2].Caption := ShortB + ' ' + IntToStr(k + 1);
        LabArr[i - 1, j, k, 2].Top := Top + ( High div 2) -
          (LabArr[i - 1, j, k, 2].Height div 2) + High * k + Interval * k;
        LabArr[i - 1, j, k, 2].Left := Margin - 5 - LabArr[i - 1, j, k, 2].Width
          + Width * j + Interval * j;
        LabArr[i - 1, j, k, 2].Parent := SBArr[i - 1];
      end;
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
  i, j, k, l: integer; // Счетчики
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
    udC.Position := src.ReadInteger('series', 'numC', 0);
    // Названия полей
    FullA := src.ReadString('varnames', 'FullA', 'A');
    FullB := src.ReadString('varnames', 'FullB', 'B');
    FullC := src.ReadString('varnames', 'FullC', 'C');
    ShortA := src.ReadString('varnames', 'ShortA', 'A');
    ShortB := src.ReadString('varnames', 'ShortB', 'B');
    ShortC := src.ReadString('varnames', 'ShortC', 'C');
    // Подготовка интерфейса
    btCreateClick(Self);
    MakeVarLabels;
    pbSaveLoad.Max := iA * jC * kB;
    pbSaveLoad.Position := 0;
    // Чтение элементов массива
    for i := 1 to iA do
      for j := 1 to jC do
        for k := 1 to kB do
        begin
          for l := 0 to src.ReadInteger('ser_' + IntToStr(i) + '_' + IntToStr(j)
            + '_' + IntToStr(k), 'num', 0) - 1 do
            MemoArr[i - 1, j - 1, k - 1].Lines.Add
              (src.ReadString('ser_' + IntToStr(i) + '_' + IntToStr(j) + '_' +
              IntToStr(k), 'val' + IntToStr(l), ''));
          pbSaveLoad.StepIt;
        end;
    AddLog(mLog, 'Загрузка данных завершена. (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  end;
end;

{ === Показать окно результата === }
procedure TfmMain.btRanameClick(Sender: TObject);
begin
  fmRename.ShowModal;
end;

procedure TfmMain.btResultClick(Sender: TObject);
begin
  fmResult.ShowModal;
end;

{ === Сохранение данных === }
procedure TfmMain.btSaveClick(Sender: TObject);
var
  src: TIniFile;
  // Файл с данными
  i, j, k, l: integer; // Счетчики
  time: uint;
begin
  if sdSave.Execute then
  begin
    pbSaveLoad.Max := iA * jC * kB;
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
    src.WriteInteger('series', 'numB', kB);
    src.WriteInteger('series', 'numC', jC);
    // Названия полей
    src.WriteString('varnames', 'FullA', FullA);
    src.WriteString('varnames', 'FullB', FullB);
    src.WriteString('varnames', 'FullC', FullC);
    src.WriteString('varnames', 'ShortA', ShortA);
    src.WriteString('varnames', 'ShortB', ShortB);
    src.WriteString('varnames', 'ShortC', ShortC);
    // Запись секций с элементами массива
    for i := 1 to iA do
      for j := 1 to jC do
        for k := 1 to kB do
        begin
          src.WriteInteger('ser_' + IntToStr(i) + '_' + IntToStr(j) + '_' +
            IntToStr(k), 'num', MemoArr[i - 1, j - 1, k - 1].Lines.Count);
          for l := 0 to MemoArr[i - 1, j - 1, k - 1].Lines.Count - 1 do
            src.WriteString('ser_' + IntToStr(i) + '_' + IntToStr(j) + '_' +
              IntToStr(k), 'val' + IntToStr(l),
              MemoArr[i - 1, j - 1, k - 1].Lines[l]);
          pbSaveLoad.StepIt;
        end;
    AddLog(mLog, 'Сохранение данных завершено. (' +
      floattostr((GetTickCount - time) / 1000) + ' сек)');
  end;

end;

{ === Очистка лога при запуске === }
procedure TfmMain.FormShow(Sender: TObject);
begin
  mLog.Lines.Clear;
end;

{ === Задаем названия === }
procedure TfmMain.MakeVarLabels;
var
  i, j, k: integer;
  time: uint;
begin
  time := GetTickCount;
  AddLog(mLog, 'Выполняется переименование...');
  lA.Caption := FullA + ' (' + ShortA + '):';
  lB.Caption := FullB + ' (' + ShortB + '):';
  lC.Caption := FullC + ' (' + ShortC + '):';
  for i := 0 to iA - 1 do
    for j := 0 to jC - 1 do
      for k := 0 to kB - 1 do
      begin
        LabArr[i, j, k, 1].Caption := ShortC + ' ' + IntToStr(j + 1);
        LabArr[i, j, k, 2].Caption := ShortB + ' ' + IntToStr(k + 1);
      end;
  AddLog(mLog, 'Выполнено!' + ' (' + floattostr((GetTickCount - time) / 1000)
    + ' сек)');
end;

end.
