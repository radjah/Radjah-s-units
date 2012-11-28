unit unIVK_tarMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Grids, MyFunctions, math, inifiles;

type
  TfmIVK_tarMain = class(TForm)
    GroupBox1: TGroupBox;
    leCount: TLabeledEdit;
    btSet: TButton;
    sgData: TStringGrid;
    udCount: TUpDown;
    GroupBox2: TGroupBox;
    btCalc: TButton;
    sgResult: TStringGrid;
    procedure btSetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCalcClick(Sender: TObject);
    procedure SaveData;
    procedure LoadData;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmIVK_tarMain: TfmIVK_tarMain;

implementation

{$R *.dfm}

{ === ������ ������ � ����� === }
procedure TfmIVK_tarMain.SaveData;
var
  INIFile: TIniFile; // ���� ������
  i: integer; // �������
begin
  try
    // �������/��������� ini-����
    INIFile := TIniFile.Create(ExtractFilePath(Application.ExeName) +
      'IVK_tar.ini');
    // ���������� �������
    INIFile.WriteInteger('DataInfo', 'Count', sgData.RowCount - 1);
    for i := 1 to sgData.RowCount - 1 do
    // ������ ������ � ����
    begin
      INIFile.WriteString('Data', 'X' + IntToStr(i), sgData.Cells[1, i]);
      INIFile.WriteString('Data', 'Y' + IntToStr(i), sgData.Cells[2, i]);
    end;
    INIFile.Free;
  except
    on E: EIniFileException do
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ ���������� ������', MB_OK or MB_ICONERROR);
  end;
end;

{ === �������� ������ === }
procedure TfmIVK_tarMain.LoadData;
var
  INIFile: TIniFile; // ���� ������
  i: integer; // �������
begin
  try
    if FileExists(ExtractFilePath(Application.ExeName) + 'IVK_tar.ini') then
    begin
      INIFile := TIniFile.Create(ExtractFilePath(Application.ExeName) +
        'IVK_tar.ini');
      // �������� �������
      udCount.Position := INIFile.ReadInteger('DataInfo', 'Count', 3);
      btSetClick(Self);
      for i := 1 to udCount.Position do
      begin
        sgData.Cells[1, i] := INIFile.ReadString('Data',
          'X' + IntToStr(i), '0');
        sgData.Cells[2, i] := INIFile.ReadString('Data',
          'Y' + IntToStr(i), '0');
      end;
    end;
  except
    on E: EIniFileException do
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ ���������� ������', MB_OK or MB_ICONERROR);
  end;
end;

{ === ������ ������������� === }
procedure TfmIVK_tarMain.btCalcClick(Sender: TObject);
var
  xArr: array of real; // ������ ��������
  yArr: array of real; // ������ ����������� ����������
  n, x, y, x2, x3, x4, xy, x2y: real; // ��������������� ����������
  da, db, dc, d: real; // ������������
  i: integer; // �������
  aArr, bArr, cArr, dArr: Matrice; // �������
begin
  // ���������� ��������
  SetLength(xArr, sgData.RowCount - 1);
  SetLength(yArr, sgData.RowCount - 1);
  for i := 1 to sgData.RowCount - 1 do
  begin
    xArr[i - 1] := StrToFloat(sgData.Cells[1, i]);
    yArr[i - 1] := StrToFloat(sgData.Cells[2, i]);
  end;
  // ���������� ��������������� ���������� � ������������ ���������� ��������
  // / x2  x   n   y   \
  // | x3  x2  x   xy  |
  // \ x4  x3  x2  x2y /
  // ������� d      || ������� da    ||  ������� db   || ������� dc       ||
  // / x2  x   n  \ || / y   x  n  \ || / x2 y   n  \ || / x2  x   y   \  ||
  // | x3  x2  x  | || | xy  x2 x  | || | x3 xy  x  | || | x3  x2  xy  |  ||
  // \ x4  x3  x2 / || \ x2y x3 x2 / || \ x4 x2y x2 / || \ x4  x3  x2y /  ||
  // ��������� ��������������� ����������
  // c
  n := sgData.RowCount - 1;
  // �������������
  x := 0;
  y := 0;
  x2 := 0;
  x3 := 0;
  x4 := 0;
  xy := 0;
  x2y := 0;
  for i := 1 to sgData.RowCount - 1 do
  // ������� �����
  begin
    x := x + xArr[i - 1];
    y := y + yArr[i - 1];
    x2 := x2 + Power(xArr[i - 1], 2);
    x3 := x3 + Power(xArr[i - 1], 3);
    x4 := x4 + Power(xArr[i - 1], 4);
    xy := xy + xArr[i - 1] * yArr[i - 1];
    x2y := x2y + Power(xArr[i - 1], 2) * yArr[i - 1];
  end;
  // ����������� ����������� ���������� �� ��������
  // x
  dArr[2, 1] := x;
  dArr[3, 2] := x;
  aArr[2, 1] := x;
  aArr[3, 2] := x;
  bArr[3, 2] := x;
  cArr[2, 1] := x;
  // y
  aArr[1, 1] := y;
  bArr[2, 1] := y;
  cArr[3, 1] := y;
  // x2
  dArr[1, 1] := x2;
  dArr[2, 2] := x2;
  dArr[3, 3] := x2;
  aArr[2, 2] := x2;
  aArr[3, 3] := x2;
  bArr[1, 1] := x2;
  bArr[3, 3] := x2;
  cArr[1, 1] := x2;
  cArr[2, 2] := x2;
  // x3
  dArr[1, 2] := x3;
  dArr[2, 3] := x3;
  aArr[2, 3] := x3;
  bArr[1, 2] := x3;
  cArr[1, 2] := x3;
  cArr[2, 3] := x3;
  // x4
  dArr[1, 3] := x4;
  bArr[1, 3] := x4;
  cArr[1, 3] := x4;
  // xy
  aArr[1, 2] := xy;
  bArr[2, 2] := xy;
  cArr[3, 2] := xy;
  // x2y
  aArr[1, 3] := x2y;
  bArr[2, 3] := x2y;
  cArr[3, 3] := x2y;
  // n
  dArr[3, 1] := n;
  aArr[3, 1] := n;
  bArr[3, 1] := n;
  // ��������� ������������
  d := Det(dArr, 3);
  da := Det(aArr, 3);
  db := Det(bArr, 3);
  dc := Det(cArr, 3);
  // ���������� �������������
  sgResult.Cells[1, 1] := FloatToStr(da / d);
  sgResult.Cells[1, 2] := FloatToStr(db / d);
  sgResult.Cells[1, 3] := FloatToStr(dc / d);
  SaveData;
end;
{ // ��� ����� �� ����������
  var
  i, j, k, m1, k1: integer; // ��������
  r, s: real; // ���������� ����-�� ���
  n, m: integer;
  q: array of real; // double q[200];
  a: array [0 .. 10] of array [0 .. 11] of real;
  c: array [0 .. 2] of real; // double c[11]; ���������
  begin
  // ������ ���� �� ����. ���� ��������� ��� �� C � ��� �� Pascal
  // � ��������� ������������
  n := sgData.RowCount;
  // ����� ������ q[]
  SetLength(q, sgData.RowCount - 1);
  // ���������
  ZeroMemory(c, SizeOf(c));
  // ���������� ���������
  for i := 0 to Length(q) - 1 do
  q[i] := 1;
  // ������
  m := 2;
  n := n - 1;
  for i := 0 to m do
  // ���� 1 �� 3
  begin
  // �������������
  s := 0;
  r := 0;
  for j := 0 to n do
  begin
  s := s + q[j];
  r := r + q[j] * StrToFloat(sgData.Cells[2, j + 1]);
  q[j] := q[j] * StrToFloat(sgData.Cells[1, j + 1]);
  end;
  a[0][i] := s;
  a[i][m + 1] := r;
  end;
  for i := 1 to m do
  // ���� 2 �� 3
  begin
  s := 0;
  for j := 0 to n do
  begin
  if j < m then
  a[i][j] := a[i - 1][j + 1];
  s := s + q[j];
  q[j] := q[j] * StrToFloat(sgData.Cells[1, j + 1]);
  end;
  a[i][m] := s;
  end;
  // m1 = 3
  m1 := m + 1;
  for k := 0 to m do
  begin
  k1 := k + 1;
  s := a[k][k];
  for j := k1 to m1 do
  a[k][j] := a[k][j] / s;
  for i := k1 to m do
  begin
  r := a[i][k];
  for j := k1 to m1 do
  a[i][j] := a[i][j] - a[k][j] * r;
  end;
  end;
  for i := m downto 0 do
  // ���� 3 �� 3
  begin
  s := a[i][m1];
  for j := i + 1 to m do
  s := s - a[i][j] * c[j];

  end;

  end; }

{ === ��������� ���������� ������� === }
procedure TfmIVK_tarMain.btSetClick(Sender: TObject);
var
  i: integer; // �������
begin
  sgData.RowCount := udCount.Position + 1;
  // ���������
  for i := 1 to sgData.RowCount - 1 do
    sgData.Cells[0, i] := IntToStr(i);
end;

{ === ������������� ����� === }
procedure TfmIVK_tarMain.FormShow(Sender: TObject);
var
  i: integer; // �������
begin
  // ��������� �������
  sgData.Cells[0, 0] := '�����';
  sgData.Cells[1, 0] := '���';
  sgData.Cells[2, 0] := '��������';
  sgResult.Cells[0, 0] := '�����';
  sgResult.Cells[1, 0] := '��������';
  // ���������
  for i := 1 to sgData.RowCount - 1 do
    sgData.Cells[0, i] := IntToStr(i);
  LoadData;
  sgResult.Cells[0, 1] := 'a';
  sgResult.Cells[0, 2] := 'b';
  sgResult.Cells[0, 3] := 'c';
end;

end.
