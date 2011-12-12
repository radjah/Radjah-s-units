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

  HMarr: array of array [1 .. 2] of integer; // ������ ������
  totaltime: integer; // ����� ����� �����
  curstage: integer; // ������� ���� �����
  CurTime: integer = 0; // ��������� ����� �����
  sttime: integer; // �����
  scnt: integer; // ���������� ������ � �����

implementation

{$R *.dfm}

procedure TMain.btGoClick(Sender: TObject);
begin
  sttime := HMarr[0][2]; // �������� ����� ������� �����
  curstage := 0; // ���������� ����� ������� ����� (���� � ����)
  // ������� �������
  lPosition.Caption := IntToStr(HMarr[0][1]);
  // ��������� �� ����� ����� (����� ���� �������?)
  if (curstage + 1) > scnt then
    lNextPosition.Caption := '����� �����'
  else
    lNextPosition.Caption := IntToStr(HMarr[curstage][1]);
  StageTimer.Enabled := true; // ��������� ������
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
    btGo.Enabled := true;
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

// ������
procedure TMain.StageTimerTimer(Sender: TObject);
begin
  CurTime := CurTime + 1;
  // �������� �� ����� �����
  if CurTime >= sttime then
  // ���� ����� ��������� ����� ������
  begin
    Beep;
    // ���� ����� ����������� ����� ����� ���������� ������
    if (curstage + 1) >= scnt then
    begin
      StageTimer.Enabled := false;
      ShowMessage('���� ��������� ��������!');
    end
    else
    // ���� ���������� ������ ���� �� ������
    begin
      curstage := curstage + 1;
      // ��������� ��������� ���������� �����
      // ����� ������������
      pbTime.Position := 0;
      // ����� ������ �����
      pbTime.Max := HMarr[curstage][2];
      // ����� �������� �������
      CurTime := 0;
      // ���������� ���������� ������
      sttime := HMarr[curstage][2];
      lTime.Caption := IntToStr(HMarr[curstage][2]);
      // ����� ����
      lPosition.Caption := IntToStr(HMarr[curstage][1]);
      // ��������� ����
      if (curstage + 1) >= scnt then
        lNextPosition.Caption := '����� �����'
      else
        lNextPosition.Caption := IntToStr(HMarr[curstage + 1][1]);
    end;
  end
  else // ������ �� �����������
  begin
    // �������� �����������
    pbTime.Position := pbTime.Position + 1;
    // �������� ���������� �����
    lTime.Caption := IntToStr(HMarr[curstage][2] - CurTime);
  end;

  // CurTime := CurTime + 1;
  // lPosition.Caption := inttostr(CurTime);
  // lNextPosition.Caption := inttostr(CurTime + 1);
  // lTime.Caption := inttostr(CurTime);
end;

end.
