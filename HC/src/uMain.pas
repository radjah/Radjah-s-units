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
    Series1: TBarSeries;
    Label2: TLabel;
    procedure StageTimerTimer(Sender: TObject);
    procedure btGoClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    // procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MMTimer1: integer; // ��� ��������������� �������
  end;
   { TTickThread = class(TThread)
    procedure Execute; override;
    public
    constructor Create;
    end; }
procedure MyTimerCallBackProg(uTimerID, uMessage: UINT;
  dwUser, dw1, dw2: DWORD); stdcall;

var
  Main: TMain;
  // TickThread: TTickThread;

  HMarr: array of array [1 .. 2] of integer; // ������ ������
  totaltime: integer; // ����� ����� �����
  curstage: integer; // ������� ���� �����
  CurTime: integer = 1; // ��������� ����� �����
  sttime: integer; // �����
  scnt: integer; // ���������� ������ � �����
  tickcount: longint;

implementation

{$R *.dfm}
// constructor TTickThread.Create;
// begin
// inherited Create(True);
// end;

// procedure TTickThread.Execute;
procedure MyTimerCallBackProg(uTimerID, uMessage: UINT;
  dwUser, dw1, dw2: DWORD); stdcall;
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
      // Main.StageTimer.Enabled := false;
      // ��������� �������
      timeKillEvent(Main.MMTimer1);
      Main.btLoad.Enabled := True;
      Main.lTime.Caption := '0';
      tickcount := GetTickCount - tickcount;
      ShowMessage('���� ��������� ��������!' + #10#13 + '��������� ������� ' +
        floattostr(tickcount / 1000) + ' ���.');
      // Application.ProcessMessages;
      Main.btGo.Enabled := True;
      // ���������� �������� ��� ������ �����
      Main.lPosition.Caption := '0';
      curstage := 0;
      Main.pbTime.Max := HMarr[0][2];
      Main.pbTime.Position := 0;
      if (curstage + 1) > scnt then
        Main.lNextPosition.Caption := '����� �����'
      else
        Main.lNextPosition.Caption := IntToStr(HMarr[curstage][1]);
      Main.lTime.Caption := IntToStr(HMarr[curstage][2]);
      CurTime := CurTime + 1;
    end
    else
    // ���� ���������� ������ ���� �� ������
    begin
      curstage := curstage + 1;
      // ��������� ��������� ���������� �����
      // ����� ������������
      Main.pbTime.Position := 0;
      // ����� ������ �����
      Main.pbTime.Max := HMarr[curstage][2];
      // ����� �������� �������
      CurTime := 1;
      // ���������� ���������� ������
      sttime := HMarr[curstage][2];
      Main.lTime.Caption := IntToStr(HMarr[curstage][2]);
      // ����� ����
      Main.lPosition.Caption := IntToStr(HMarr[curstage][1]);
      // ��������� ����
      if (curstage + 1) >= scnt then
        Main.lNextPosition.Caption := '����� �����'
      else
        Main.lNextPosition.Caption := IntToStr(HMarr[curstage + 1][1]);
    end;
  end
  else // ������ �� �����������
  begin
    // �������� �����������
    // pbTime.Position := pbTime.Position + 1;
    // �������� ���������� �����
    Main.lTime.Caption := IntToStr(HMarr[curstage][2] - CurTime);
    CurTime := CurTime + 1;
  end;
  // CurTime := CurTime + 1;
  // lPosition.Caption := inttostr(CurTime);
  // lNextPosition.Caption := inttostr(CurTime + 1);
  // lTime.Caption := inttostr(CurTime);
end;

procedure TMain.btGoClick(Sender: TObject);
begin
  btGo.Enabled := false;
  Application.ProcessMessages;
  sttime := HMarr[0][2]; // �������� ����� ������� �����
  curstage := 0; // ���������� ����� ������� ����� (���� � ����)
  // ������� �������
  lPosition.Caption := IntToStr(HMarr[0][1]);
  // ��������� �� ����� ����� (����� ���� �������?)
  if (curstage + 1) > scnt then
    lNextPosition.Caption := '����� �����'
  else
    lNextPosition.Caption := IntToStr(HMarr[curstage + 1][1]);
  // StageTimer.Enabled := True; // ��������� ������
  btLoad.Enabled := false;
  tickcount := GetTickCount;
  // ������ ��������������� �������
  MMTimer1 := timeSetEvent(1000, 10, @MyTimerCallBackProg, 100, TIME_PERIODIC);
  // StageTimer.Enabled := true
  // else
  // StageTimer.Enabled := False;
end;

procedure TMain.btLoadClick(Sender: TObject);
var
  hmfile: TIniFile; // ���� � �������
  i: integer; // ������� ��� ������
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
      HMarr[i - 1][1] := hmfile.ReadInteger('stages', 'stage' + IntToStr(i), 0);
      // �����
      HMarr[i - 1][2] := hmfile.ReadInteger('stages', 'time' + IntToStr(i), 0);
      totaltime := totaltime + HMarr[i - 1][2];
    end;
    // �������� ����� ��������
    // ���������� ����������
    Chart.Series[0].Clear;
    for i := 1 to scnt do
      Chart.Series[0].AddXY(5 * i, HMarr[i - 1][1] + 0.1, IntToStr(i), clGreen);
    lPosition.Caption := '0';
    curstage := 0;
    pbTime.Max := HMarr[0][2];
    pbTime.Position := 0;
    if (curstage + 1) > scnt then
      lNextPosition.Caption := '����� �����'
    else
      lNextPosition.Caption := IntToStr(HMarr[curstage][1]);
    lTime.Caption := IntToStr(HMarr[curstage][2]);
    ShowMessage('���� ��������! ����� ����� ����� ' + IntToStr(totaltime)
      + ' ���.');
  end;
end;

// procedure TMain.FormCreate(Sender: TObject);
// begin
// TickThread := TTickThread.Create;
// end;

// ������
procedure TMain.StageTimerTimer(Sender: TObject);
begin
  // TickThread.Execute;
end;

end.
