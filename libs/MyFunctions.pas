unit MyFunctions;

interface

uses
  Windows, StrUtils, StdCtrls, SysUtils, DB, ADODB;

function ReplaceStr(const S, Srch, Replace: string): string;
function GetPath(const S: string): string;
procedure AddLog(LogMemo: TMemo; LogStr: string);
procedure ReopenDatasets(DS: array of TDataSet);

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

end.
