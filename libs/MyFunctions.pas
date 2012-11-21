unit MyFunctions;

interface

uses
  Windows, StrUtils, StdCtrls, SysUtils, DB, ADODB;

const
  N1 = 10; // ��������� (������������ ����� (�� ����������))

type
  Matrice = array [1 .. N1, 1 .. N1] of real; // ���� ��� �������

function ReplaceStr(const S, Srch, Replace: string): string;
function GetPath(const S: string): string;
procedure AddLog(LogMemo: TMemo; LogStr: string);
procedure ReopenDatasets(DS: array of TDataSet);
function Det(A: Matrice; N: integer): real;

implementation

{ === ������ ������ � ������ === }
function ReplaceStr(const S, Srch, Replace: string): string;
var
  i: integer;
  Source: string;
begin
  Source := S;
  Result := '';
  repeat
    i := pos(Srch, Source);
    if i > 0 then
    begin
      Result := Result + Copy(Source, 1, i - 1) + Replace;
      Source := Copy(Source, i + Length(Srch), MaxInt);
    end
    else
      Result := Result + Source;
  until i <= 0;
end;

{ === ��������� ���� �� ������� ������ ����� === }
function GetPath(const S: string): string;
var
  temvar: string;
begin
  temvar := ReverseString(S);
  Result := ReverseString(Midstr(temvar, pos('\', temvar), MAX_PATH));
end;

{ === ���������� ������ � ��� === }
procedure AddLog(LogMemo: TMemo; LogStr: string);
begin
  LogMemo.Lines.Add(TimeToStr(Now) + ': ' + LogStr);
end;

{ === ������������� ������ ������ === }
procedure ReopenDatasets(DS: array of TDataSet);
var
  i: integer;
begin
  for i := 0 to Length(DS) - 1 do
  begin
    DS[i].Close;
    DS[i].Open;
  end
end;

{ === ������������ ������� n x n === }
Function Det(A: Matrice; N: integer): real;
var
  B: Matrice;
  i: integer;
  T, Mn, S: real;

  Function Minor(var C: Matrice; A: Matrice; N, i, J: integer): real;
  // ���������� ��������������� ������
  var
    Im, Jm, Ia, Ja, Nm: integer;
    // Im - ������ ������, Jm - ������� ������, Ia - ������ ������� �, Ja - ������� ������� �, Nm - ������� (�����������) ������.
  begin
    Nm := N - 1; // ������� ������ �� ������� ������ ������� �������
    Im := 1; // ����� ������ ������
    Ia := 1;
    while Im <= Nm do
      if Ia <> i then
      begin
        Jm := 1;
        Ja := 1;
        while Jm <= Nm do
          if Ja <> J then
          begin
            C[Im, Jm] := A[Ia, Ja];
            Ja := Ja + 1;
            Jm := Jm + 1;
            // ���������� ����� ������� ����� ������ ����� ������� ?
          end
          else
            Ja := Ja + 1;
        Ia := Ia + 1;
        Im := Im + 1;
      end
      else
        Ia := Ia + 1;
  end; { *Minor* }

begin
  if N = 1 then // ����  n=1
    Det := A[N, N]; // ����� ������� ���������� ����� �� �������
  if N = 2 then
    Det := A[1, 1] * A[2, 2] - A[2, 1] * A[1, 2];
  // ����� ������� ���������� ����� �� �������
  if N > 2 then // �� ��� ������ 2
  begin
    S := 0; // �����
    for i := 1 to N do
    begin
      Mn := Minor(B, A, N, i, 1); // ������� �������������� �����
      if (i mod 2) = 1 then // ���� ����� ������� �� 2 ����� �������
      begin
        T := Det(B, N - 1);
        S := S + T * A[i, 1];
      end
      else // ���� �� ����� �����������
      begin
        T := Det(B, N - 1);
        S := S - T * A[i, 1];
      end;
    end;
    Det := S;
  end;
end; { *Determ* }

end.
