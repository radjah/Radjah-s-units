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
  MemoArr: array of array of TMemo; // ������ ����
  LabArr: array of array of array [1 .. 2] of TLabel;
  ArrCellSumm: array of array of real;
  iA, jB: integer; // �����������
  ShortA: string = 'A';
  ShortB: string = 'B';
  FullA: string = 'A';
  FullB: string = 'B';
  repmes: Boolean = true;

implementation

uses
  unResult, unRename;

{$R *.dfm}

{ === ����� === }
procedure TfmMain.btCalcClick(Sender: TObject);
var
  Sum, SumPartQ, Suml2, SumA, SumB, Sum2, SumA2, SumB2, Q, Q0, QA, QB, QAB,
    Qtmp: real; // ������ ������� ����� � ���������
  ssA, ssB, ssAB, ssRand, ssSum: integer;
  // ������� �������
  skA, skB, skAB, skRand, skSum, MemoMid: real;
  // ��.��.
  // SumCArr: array of real; // ������ ��� ����� ������� � ������ ����
  i, j, l, lcount: integer; // ��������
  Prsn: integer; // �������� ������ ����������
  time: uint; // ������� ������
begin
  time := GetTickCount;
  SetRoundMode(rmNearest);
  Prsn := udPrsn.Position;
  // ���� ���� � ������������ ����������� �����
  lcount := 0;
  for i := 0 to iA - 1 do
    for j := 0 to jB - 1 do
      if lcount < MemoArr[i, j].Lines.Count then
        lcount := MemoArr[i, j].Lines.Count;
  if lcount = 1 then
  begin
    repmes := false;
    AddLog(mLog, '��������! ��� ���������� ���������.');
  end
  else
    repmes := true;

  // ������������ ����, � ������� ���������� ����� ������ lcount
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

  // ������ � ������� ���� ����� � ������ ���� (ArrCellSumm),
  // ����� ��������� ���� ������� (Suml2) � ����� ���� ������� (Sum)
  SetLength(ArrCellSumm, iA);
  ZeroMemory(ArrCellSumm, sizeof(ArrCellSumm));
  Sum := 0;
  Sum2 := 0;
  Suml2 := 0;
  for i := 0 to iA - 1 do // ������� �� �����
  begin
    SetLength(ArrCellSumm[i], jB);
    ZeroMemory(ArrCellSumm[i], sizeof(ArrCellSumm[i]));
    for j := 0 to jB - 1 do // ������� �� ��������
    begin
      ArrCellSumm[i, j] := 0;
      for l := 0 to MemoArr[i, j].Lines.Count - 1 do // ������ � ����
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
      floattostr((GetTickCount - time) / 1000) + ' ���)');
    AddLog(mLog, 'Sum2=' + floattostr(Sum2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' ���)');
    AddLog(mLog, 'Suml2=' + floattostr(Suml2) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' ���)');
  end;
  // ����� �� ���� B ��� ������� A � ������� ���� �����
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
      floattostr((GetTickCount - time) / 1000) + ' ���)');
  // ����� �� ���� A ��� ������� B � ������� ���� �����
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
      floattostr((GetTickCount - time) / 1000) + ' ���)');
  // ���������, ��� � ������ ���� ���������� ���������� ����� lcount
  // ��������� ��� Q
  SumPartQ := power(Sum, 2) / iA / jB / lcount;
  if cbDebug.Checked then
    AddLog(mLog, 'SumPartQ:=' + floattostr(SumPartQ) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' ���)');
  // QA
  QA := SumA2 / jB / lcount - SumPartQ;
  if cbDebug.Checked then
    AddLog(mLog, 'QA:=' + floattostr(QA) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' ���)');
  fmResult.sgResult.Cells[1, 1] := floattostr(RoundTo(QA, Prsn));
  // QB
  QB := SumB2 / iA / lcount - SumPartQ;
  if cbDebug.Checked then
    AddLog(mLog, 'QB:=' + floattostr(QB) + ' (' +
      floattostr((GetTickCount - time) / 1000) + ' ���)');
  fmResult.sgResult.Cells[1, 2] := floattostr(RoundTo(QB, Prsn));
  if repmes then
  begin
    // QAB
    QAB := Sum2 / lcount - SumPartQ - QA - QB;
    if cbDebug.Checked then
      AddLog(mLog, 'QAB:=' + floattostr(QAB) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' ���)');
    fmResult.sgResult.Cells[1, 3] := floattostr(RoundTo(QAB, Prsn));
    // Q0
    Qtmp := QA + QB + QAB;
    Q := Suml2 - SumPartQ;
    Q0 := Q - Qtmp;
    if cbDebug.Checked then
      AddLog(mLog, 'Q0:=' + floattostr(Q0) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' ���)');
    fmResult.sgResult.Cells[1, 4] := floattostr(RoundTo(Q0, Prsn));
    // Q
    // Q := Suml2 - SumPartQ;
    fmResult.sgResult.Cells[1, 5] := floattostr(RoundTo(Q, Prsn));
    if cbDebug.Checked then
    begin
      AddLog(mLog, 'Q:=' + floattostr(Q) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' ���)');
      Qtmp := QA + QB + QAB;
      AddLog(mLog, 'Qtmp:=' + floattostr(Qtmp) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' ���)');
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
        floattostr((GetTickCount - time) / 1000) + ' ���)');
    fmResult.sgResult.Cells[1, 3] := floattostr(RoundTo(Q0, Prsn));
    // Q
    // Q := Suml2 - SumPartQ;
    fmResult.sgResult.Cells[1, 4] := floattostr(RoundTo(Q, Prsn));
    if cbDebug.Checked then
    begin
      AddLog(mLog, 'Q:=' + floattostr(Q) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' ���)');
      Qtmp := QA + QB;
      AddLog(mLog, 'Qtmp:=' + floattostr(Qtmp) + ' (' +
        floattostr((GetTickCount - time) / 1000) + ' ���)');
    end;
  end;
  // ��������� ������� �������
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
  // ��.��.
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
  // �����.
  fmResult.sgResult.Cells[4, 1] := floattostr(RoundTo(skA / skRand, Prsn));
  fmResult.sgResult.Cells[4, 2] := floattostr(RoundTo(skB / skRand, Prsn));
  if repmes then
    fmResult.sgResult.Cells[4, 3] := floattostr(RoundTo(skAB / skRand, Prsn));
  // ��!
  time := GetTickCount - time;
  fmResult.lTime.Caption := '���������� ������ ' +
    floattostr(time / 1000) + ' ���';
  AddLog(mLog, '���������� ������ ' + floattostr(time / 1000) + ' ���)');
  fmResult.ShowModal;
end;

{ === ���������� ��������� === }
procedure TfmMain.btCreateClick(Sender: TObject);
const
  High: integer = 150;
  Top: integer = 30;
  Interval: integer = 35;
  Margin: integer = 35;
  Width: integer = 100;
var
  i, j: integer; // ��������
  time: uint; // �������� ������
begin
  time := GetTickCount;
  btCalc.Enabled := true;
  btSave.Enabled := true;
  AddLog(mLog, '�������� �����...');
  // �������� ���� ����� � ������������
  for i := 0 to iA - 1 do
    for j := 0 to jB - 1 do
    begin
      MemoArr[i, j].Free;
      LabArr[i, j, 1].Free;
      LabArr[i, j, 2].Free;
    end;
  // �������� ����
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
      // ��������� ����
      MemoArr[i, j] := TMemo.Create(Self);
      MemoArr[i, j].Top := Top + High * j + Interval * j;
      MemoArr[i, j].Left := Margin + Width * i + Interval * i;
      MemoArr[i, j].Height := High;
      MemoArr[i, j].Width := Width;
      MemoArr[i, j].ScrollBars := ssBoth;
      MemoArr[i, j].Parent := sbData;
      // ��������� �������� ��������
      LabArr[i, j, 1] := TLabel.Create(Self);
      LabArr[i, j, 1].Caption := ShortA + ' ' + IntToStr(i + 1);
      LabArr[i, j, 1].Top := Top - 15 + High * j + Interval * j;
      LabArr[i, j, 1].Left := Margin + (Width div 2) -
        (LabArr[i, j, 1].Width div 2) + Width * i + Interval * i;
      LabArr[i, j, 1].Parent := sbData;
      // ��������� �������� �����
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
  AddLog(mLog, '������! (' + floattostr(time / 1000) + ' ���)');
end;

{ === �������� ������ �� ����� === }
procedure TfmMain.btLoadClick(Sender: TObject);
var
  src: TIniFile;
  // ���� � �������
  i, j, k: integer; // ��������
  time: uint;
begin
  if odLoad.Execute then
  begin
    time := GetTickCount;
    AddLog(mLog, '�������� ������ �� ' + odLoad.FileName + '...');
    // ��������� ����
    src := TIniFile.Create(odLoad.FileName);
    // ��������� �������.
    udA.Position := src.ReadInteger('series', 'numA', 0);
    udB.Position := src.ReadInteger('series', 'numB', 0);
    // �������� �����
    FullA := src.ReadString('varnames', 'FullA', 'A');
    FullB := src.ReadString('varnames', 'FullB', 'B');
    ShortA := src.ReadString('varnames', 'ShortA', 'A');
    ShortB := src.ReadString('varnames', 'ShortB', 'B');
    // ���������� ����������
    btCreateClick(Self);
    MakeVarLabels;
    pbSaveLoad.Max := iA * jB;
    pbSaveLoad.Position := 0;
    // ������ ��������� �������
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
    AddLog(mLog, '�������� ������ ���������. (' +
      floattostr((GetTickCount - time) / 1000) + ' ���)');
  end;
end;

{ === ���� �������������� ���������� === }
procedure TfmMain.btRanameClick(Sender: TObject);
begin
  fmRename.ShowModal;
end;

{ === �������� ���� ����������� === }
procedure TfmMain.btResultClick(Sender: TObject);
begin
  fmResult.ShowModal;
end;

{ === ���������� ������ === }
procedure TfmMain.btSaveClick(Sender: TObject);
var
  src: TIniFile;
  // ���� � �������
  i, j, k: integer; // ��������
  time: uint;
begin
  if sdSave.Execute then
  begin
    pbSaveLoad.Max := iA * jB;
    pbSaveLoad.Position := 0;
    time := GetTickCount;
    AddLog(mLog, '���������� ����� � ' + sdSave.FileName + '...');
    // ������� ������ ����, ���� ����� ����, ����� �� ����������� � ��� �����
    if FileExists(sdSave.FileName) then
      DeleteFile(sdSave.FileName);
    // ������� ����� ���� � ��������� ���
    src := TIniFile.Create(sdSave.FileName);
    // ��������� ������������ �������
    src.WriteInteger('series', 'numA', iA);
    src.WriteInteger('series', 'numB', jB);
    // �������� �����
    src.WriteString('varnames', 'FullA', FullA);
    src.WriteString('varnames', 'FullB', FullB);
    src.WriteString('varnames', 'ShortA', ShortA);
    src.WriteString('varnames', 'ShortB', ShortB);
    // ������ ������ � ���������� �������
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
    AddLog(mLog, '���������� ������ ���������. (' +
      floattostr((GetTickCount - time) / 1000) + ' ���)');
  end;
end;

{ === ������� ���� ��� ������� === }
procedure TfmMain.FormShow(Sender: TObject);
begin
  mLog.Clear;
end;

{ === ������ �������� === }
procedure TfmMain.MakeVarLabels;
var
  i, j: integer;
  time: uint;
begin
  time := GetTickCount;
  AddLog(mLog, '����������� ��������������...');
  lA.Caption := FullA + ' (' + ShortA + '):';
  lB.Caption := FullB + ' (' + ShortB + '):';
  for i := 0 to iA - 1 do
    for j := 0 to jB - 1 do
    begin
      LabArr[i, j, 1].Caption := ShortA + ' ' + IntToStr(i + 1);
      LabArr[i, j, 2].Caption := ShortB + ' ' + IntToStr(j + 1);
    end;
  AddLog(mLog, '���������!' + ' (' + floattostr((GetTickCount - time) / 1000)
    + ' ���)');
end;

end.
