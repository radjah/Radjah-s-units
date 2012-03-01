unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls, StdCtrls,
  inifiles, mmsystem;

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
    btLoad: TButton;
    odOpen: TOpenDialog;
    Label2: TLabel;
    Series1: TLineSeries;
    lStages: TLabel;
    Label4: TLabel;
    procedure btGoClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    // procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MMTimer1: integer; // ��� ��������������� �������
  end;


procedure MyTimerCallBackProg(uTimerID, uMessage: UINT;
  dwUser, dw1, dw2: DWORD); stdcall;

var
  Main: TMain;
  HMarr: array of array [1 .. 2] of integer; // ������ ������
  totaltime: integer; // ����� ����� �����
  curstage: integer; // ������� ���� �����
  CurTime: integer = 1; // ��������� ����� �����
  sttime: integer; // �����
  scnt: integer; // ���������� ������ � �����
  tickcount: longint;

implementation

{$R *.dfm}

// ��������� ���� �������
procedure MyTimerCallBackProg(uTimerID, uMessage: UINT;
  dwUser, dw1, dw2: DWORD); stdcall;
var
  str: string;
begin
  Main.pbTime.Position := Main.pbTime.Position + 1;
  // �������� �� ����� �����
  if CurTime >= sttime then
  // ���� ����� ��������� ����� ������
  begin
    Beep;
    // ���� ����� ����������� ����� ����� ���������� ������
    if (curstage + 1) >= scnt then
    begin
      // ��������� �������
      timeKillEvent(Main.MMTimer1);
      tickcount := GetTickCount - tickcount;
      Main.btLoad.Enabled := True;
      Main.lTime.Caption := '0';
      CurTime := 0;
      str := '���� ��������� ��������!' + #10#13 + '��������� ������� ' +
        floattostr(tickcount / 1000) + ' ���.';
      MessageBox(Main.Handle, pchar(str), '����� �����',
        MB_OK or MB_ICONINFORMATION);
      Main.btGo.Enabled := True;
      // ���������� �������� ��� ������ �����
      Main.lPosition.Caption := '0';
      curstage := 0;
      Main.lStages.Caption := '0/' + inttostr(scnt);
      Main.pbTime.Max := HMarr[0][2];
      Main.pbTime.Position := 0;
      if (curstage + 1) > scnt then
        Main.lNextPosition.Caption := '����� �����'
      else
        Main.lNextPosition.Caption := inttostr(HMarr[curstage][1]);
      Main.lTime.Caption := inttostr(HMarr[curstage][2]);
      CurTime := CurTime + 1;
    end
    else
    // ���� ���������� ������ ���� �� ������
    begin
      curstage := curstage + 1;
      Main.lStages.Caption := inttostr(curstage + 1) + '/' + inttostr(scnt);
      // ��������� ��������� ���������� �����
      // ����� ������������
      Main.pbTime.Position := 0;
      // ����� ������ �����
      Main.pbTime.Max := HMarr[curstage][2];
      // ����� �������� �������
      CurTime := 1;
      // ���������� ���������� ������
      sttime := HMarr[curstage][2];
      Main.lTime.Caption := inttostr(HMarr[curstage][2]);
      // ����� ����
      Main.lPosition.Caption := inttostr(HMarr[curstage][1]);
      // ��������� ����
      if (curstage + 1) >= scnt then
        Main.lNextPosition.Caption := '����� �����'
      else
        Main.lNextPosition.Caption := inttostr(HMarr[curstage + 1][1]);
    end;
  end
  else // ������ �� �����������
  begin
    // �������� �����������
    // pbTime.Position := pbTime.Position + 1;
    // �������� ���������� �����
    Main.lTime.Caption := inttostr(HMarr[curstage][2] - CurTime);
    CurTime := CurTime + 1;
  end;
  // CurTime := CurTime + 1;
  // lPosition.Caption := inttostr(CurTime);
  // lNextPosition.Caption := inttostr(CurTime + 1);
  // lTime.Caption := inttostr(CurTime);
end;

// ������ �����
procedure TMain.btGoClick(Sender: TObject);
begin
  btGo.Enabled := false;
  sttime := HMarr[0][2]; // �������� ����� ������� �����
  curstage := 0; // ���������� ����� ������� ����� (���� � ����)
  lStages.Caption := inttostr(curstage + 1) + '/' + inttostr(scnt);
  // ������� �������
  lPosition.Caption := inttostr(HMarr[0][1]);
  // ��������� �� ����� ����� (����� ���� �������?)
  if (curstage + 1) > scnt then
    lNextPosition.Caption := '����� �����'
  else
    lNextPosition.Caption := inttostr(HMarr[curstage + 1][1]);
  btLoad.Enabled := false;
  tickcount := GetTickCount;
  // ������ ��������������� �������
  MMTimer1 := timeSetEvent(1000, 10, @MyTimerCallBackProg, 100, TIME_PERIODIC);
end;

// �������� ����� �� �����.
procedure TMain.btLoadClick(Sender: TObject);
var
  hmfile: TIniFile; // ���� � �������
  i: integer; // ������� ��� ������
  ctotaltime: integer; // �����
  str: string;
begin
  // ��������� ���� � ������������ �� ��� ������� �����
  if odOpen.Execute then
  begin
    btGo.Enabled := True;
    totaltime := 0;
    // �������� �����
    hmfile := TIniFile.Create(odOpen.FileName);
    scnt := hmfile.ReadInteger('settings', 'count', 0);
    // ���������� �������
    SetLength(HMarr, scnt);
    ZeroMemory(HMarr, sizeof(HMarr));
    // ������ ����� � ������
    for i := 1 to scnt do
    begin
      // �������
      HMarr[i - 1][1] := hmfile.ReadInteger('stages', 'stage' + inttostr(i), 0);
      // �����
      HMarr[i - 1][2] := hmfile.ReadInteger('stages', 'time' + inttostr(i), 0);
      totaltime := totaltime + HMarr[i - 1][2];
    end;
    // �������� ����� ��������
    // ���������� ����������
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
      lNextPosition.Caption := '����� �����'
    else
      lNextPosition.Caption := inttostr(HMarr[curstage][1]);
    lTime.Caption := inttostr(HMarr[curstage][2]);
    str := '����� ����� �����: ' +
      inttostr(totaltime) + ' ���.' + #10#13 + '���������� ������: ' +
      inttostr(scnt);
    MessageBox(Main.Handle, pchar(str), '���� ��������',
      MB_OK or MB_ICONINFORMATION);
  end;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  lPosition.Caption := '__';
  lNextPosition.Caption := '__';
  lTime.Caption := '__';
  lStages.Caption := '__/__';
end;

end.
