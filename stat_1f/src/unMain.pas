unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, math, MyFunctions, Buttons, inifiles, StrUtils,
  XPMan;

type
  TfmMain = class(TForm)
    eCount: TEdit;
    Label1: TLabel;
    udCount: TUpDown;
    btCreateMemo: TButton;
    btCalc: TButton;
    cbEmptyStr: TCheckBox;
    mLog: TMemo;
    sdSave: TSaveDialog;
    odLoad: TOpenDialog;
    btLoad: TBitBtn;
    btSave: TBitBtn;
    XPManifest1: TXPManifest;
    Label2: TLabel;
    blClear: TButton;
    pbSaveLoad: TProgressBar;
    sbData: TScrollBox;
    procedure btCreateMemoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCalcClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure blClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  MemoArr: array of TMemo;
  LabelArr: array of TLabel;

implementation

{$R *.dfm}

uses unResult;

{ === ������� ���� ��� ����� ������ === }
procedure TfmMain.btCreateMemoClick(Sender: TObject);
// ��������� ��� �������
const
  Interval: integer = 10;
  Width: integer = 100;
  LMargin: integer = 10;
  Top: integer = 5;
var
  i: integer; // �������
begin
  // �������� ������
  if Length(MemoArr) > 1 then
    for i := 0 to Length(MemoArr) - 1 do
    begin
      MemoArr[i].Free;
      LabelArr[i].Free;
    end;
  // �������� �����
  AddLog(mLog, '�������� ����� �����...');
  setlength(MemoArr, udCount.Position);
  setlength(LabelArr, udCount.Position);
  ZeroMemory(MemoArr, sizeof(MemoArr));
  ZeroMemory(LabelArr, sizeof(LabelArr));
  for i := 0 to udCount.Position - 1 do
  begin
    MemoArr[i] := TMemo.Create(Self);
    MemoArr[i].Height := 300;
    MemoArr[i].Width := Width;
    MemoArr[i].Left := LMargin + i * Interval + i * Width;
    MemoArr[i].Top := Top + 20;
    MemoArr[i].Parent := sbData;
    MemoArr[i].ScrollBars := ssBoth;
    LabelArr[i] := TLabel.Create(Self);
    LabelArr[i].Top := Top;
    LabelArr[i].Left := LMargin + i * Interval + i * Width;
    LabelArr[i].Caption := '��������� �' + inttostr(i + 1);
    LabelArr[i].Parent := sbData;
//    if (LMargin + (i + 1) * Interval + (i + 1) * Width) > 500 then
//      fmMain.Width := LMargin * 2 + (i + 1) * Interval + (i + 1) * Width

  end;
  btCalc.Enabled := true;
  AddLog(mLog, '������!');
end;

{ === �������� ������ �� ����� === }
procedure TfmMain.btLoadClick(Sender: TObject);
var
  i, j: integer; // �������
  sercount: integer; // ���������� ����������
  src: TIniFile;
begin
  if odLoad.Execute then
  begin
    AddLog(mLog, '�������� ������ �� ' + odLoad.FileName + '...');
    src := TIniFile.Create(odLoad.FileName);
    // �������� ���������� ��������� � ������� ������ ���������� �����
    sercount := src.ReadInteger('series', 'num', 0);
    pbSaveLoad.Max := src.ReadInteger('series', 'num', 0);
    pbSaveLoad.Position := 0;
    udCount.Position:=sercount;
    btCreateMemoClick(Self);
    // ��������� ����
    for i := 0 to sercount - 1 do
    begin
      for j := 1 to src.ReadInteger('ser' + inttostr(i + 1), 'num', 0) do
        MemoArr[i].Lines.Add(src.ReadString('ser' + inttostr(i + 1),
          'val' + inttostr(j), ''));
      pbSaveLoad.StepIt;
    end;
    src.Free;
    AddLog(mLog, '������ ���������!');
  end;
end;

{ === ���������� ������ � ���� === }
procedure TfmMain.btSaveClick(Sender: TObject);
var
  count, i, j: integer; // �������
  src: TIniFile;
begin
  if sdSave.Execute then
  begin
    count := 0;
    for i := 0 to Length(MemoArr) - 1 do
      count := count + MemoArr[i].Lines.count;
    pbSaveLoad.Position := 0;
    pbSaveLoad.Max := count;
    if RightStr(sdSave.FileName, 4) <> '.src' then
      sdSave.FileName := sdSave.FileName + '.src';
    AddLog(mLog, '���������� ������ � ' + sdSave.FileName + '...');
    src := TIniFile.Create(sdSave.FileName);
    if FileExists(sdSave.FileName) then DeleteFile(sdSave.FileName);
    // ��������� ���������� ���������
    src.WriteInteger('series', 'num', Length(MemoArr));
    // ��������� ��� ����
    for i := 0 to Length(MemoArr) - 1 do
    begin
      src.WriteInteger('ser' + inttostr(i + 1), 'num', MemoArr[i].Lines.count);
      for j := 0 to MemoArr[i].Lines.count - 1 do
      begin
        src.WriteString('ser' + inttostr(i + 1), 'val' + inttostr(j + 1),
          MemoArr[i].Lines[j]);
        pbSaveLoad.StepIt;
      end;
    end;
    src.Free;
    AddLog(mLog, '������ ���������!');
  end;
end;

{ === ������� ���� === }
procedure TfmMain.blClearClick(Sender: TObject);
begin
  mLog.Lines.Clear;
end;

{ === ����! === }
procedure TfmMain.btCalcClick(Sender: TObject);
var
  // ������� ��� ������������ Memo
  sum2arr, sumarr: array of real; // ����� �������� �� �����������
  j, i, k: integer; // ��������
  time: uint;
  count: integer; // ����� ���������� ���������
  emptynumarr: array of integer; // ������ � �������� ������ �����
  stage2, stage3, stage5, stage6, stage7_Q, stage8_Q0, stage9_QA, D_X,
    stage11_D0_X, stage12_DA_X, stage13_F, FE: real; // ������������� ����������
begin
  time := GetTickCount;
  AddLog(mLog, '��������� ������ �����...');

  { === ��������� ������ ����� === }
  for j := 0 to Length(MemoArr) - 1 do
  begin
    for i := 0 to MemoArr[j].Lines.count - 1 do
    begin
      if MemoArr[j].Lines[i] = '' then
        // ���� ������ ������ ��������� ������
        if cbEmptyStr.Checked = true then
          MemoArr[j].Lines[i] := '0'
        else
        // ���� ������ ������ ���������
        // ���������� ������ � �������� ������ �����
        begin
          setlength(emptynumarr, Length(emptynumarr) + 1);
          emptynumarr[Length(emptynumarr) - 1] := i;
        end;
    end;
    // ������� Memo �� ������ �����
    for k := Length(emptynumarr) - 1 downto 0 do
      MemoArr[j].Lines.Delete(emptynumarr[k]);
    // ������� �������
    setlength(emptynumarr, 0);
  end;

  { === 0) ����� ���������� ��������� === }
  count := 0;
  for i := 0 to Length(MemoArr) - 1 do
    count := count + MemoArr[i].Lines.count;
  AddLog(mLog, '���������� �������� - ' + inttostr(count));

  { === 1) ����� ��������� �� �������� === }
  setlength(sumarr, Length(MemoArr));
  ZeroMemory(sumarr, sizeof(sumarr));
  for j := 0 to Length(MemoArr) - 1 do
  begin
    for i := 0 to MemoArr[j].Lines.count - 1 do
    begin
      sumarr[j] := sumarr[j] + StrToFloat(MemoArr[j].Lines[i]);
    end;
    // AddLog(mLog, 'sumarr[' + inttostr(j) + ']=' + floattostr(sumarr[j]));
  end;

  { === 2) ����� ���� ����������� === }
  stage2 := 0;
  for j := 0 to Length(MemoArr) - 1 do
    for i := 0 to MemoArr[j].Lines.count - 1 do
    begin
      stage2 := stage2 + StrToFloat(MemoArr[j].Lines[i]);
      // AddLog(mLog, 'stage2=' + floattostr(stage2));
    end;

  { === 3) ����� �� �������� � �������� === }
  stage3 := 0;
  setlength(sum2arr, Length(sumarr));
  ZeroMemory(sum2arr, sizeof(sum2arr));
  for i := 0 to Length(sumarr) - 1 do
  begin
    sum2arr[i] := Power(sumarr[i], 2);
    stage3 := stage3 + sum2arr[i];
  end;
  AddLog(mLog, '����� ��������� ���� ' + floattostr(stage3));

  { === 5) ����� ��������� === }
  stage5 := 0;
  for j := 0 to Length(MemoArr) - 1 do
  begin
    for i := 0 to MemoArr[j].Lines.count - 1 do
    begin
      stage5 := stage5 + Power(StrToFloat(MemoArr[j].Lines[i]), 2);
      { AddLog(mLog, floattostr(StrToFloat(MemoArr[j].Lines[i])) + ' ' +
        floattostr(stage5)); }
    end;
  end;
  AddLog(mLog, '����� ��������� ���������� ' + floattostr(stage5));

  { === 6) �����^2 / ���-�� ��������� === }
  stage6 := 0;
  for i := 0 to Length(MemoArr) - 1 do
    stage6 := stage6 + Power(sumarr[i], 2) / MemoArr[i].Lines.count;
  AddLog(mLog, '�����^2 * ���-�� ��������� ' + floattostr(stage6));

  { === 7) ������� Q === }
  stage7_Q := stage5 - 1 / count * stage2 * stage2;
  AddLog(mLog, 'Q = ' + floattostr(stage7_Q));
  fmResult.eQ.Text := floattostr(stage7_Q);

  { === 8) ������� Q0=== }
  stage8_Q0 := stage5 - stage6;
  AddLog(mLog, 'Q0 = ' + floattostr(stage8_Q0));
  fmResult.eQ0.Text := floattostr(stage8_Q0);

  { === 9) ������� QA=== }
  stage9_QA := stage6 - 1 / count * Power(stage2, 2);
  AddLog(mLog, 'QA = ' + floattostr(stage9_QA));
  fmResult.eQA.Text := floattostr(stage9_QA);

  { === 10) ������� D[X] === }
  D_X := stage7_Q / (count - 1);
  AddLog(mLog, 'D[X] = ' + floattostr(D_X));
  fmResult.eDX.Text := floattostr(D_X);

  { === 11) ������� D0[X] === }
  stage11_D0_X := stage8_Q0 / (count - 1);
  AddLog(mLog, 'D0[X] = ' + floattostr(stage11_D0_X));
  fmResult.eD0X.Text := floattostr(stage11_D0_X);

  { === 12) ������� DA[X] === }
  stage12_DA_X := stage9_QA / (count - 1);
  AddLog(mLog, 'DA[X] = ' + floattostr(stage12_DA_X));
  fmResult.eDAX.Text := floattostr(stage12_DA_X);

  { === 13) ������� F === }
  stage13_F := count / Length(MemoArr);
  AddLog(mLog, 'F = ' + floattostr(stage13_F));
  fmResult.eF.Text := floattostr(stage13_F);

  { === 14) ������� FE === }
  FE := (stage13_F * stage12_DA_X + stage11_D0_X) / stage11_D0_X;
  AddLog(mLog, 'FE = ' + floattostr(FE));
  fmResult.eFE.Text := floattostr(FE);

  fmResult.LTime.Caption := '���������� ������ ' +
    inttostr(GetTickCount - time) + '��';
  fmResult.ShowModal;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  // ShowMessage(inttostr(Length(MemoArr)));
  mLog.Lines.Clear;
end;

end.
