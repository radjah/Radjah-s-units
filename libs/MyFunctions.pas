unit MyFunctions;

interface

uses
  Windows, StrUtils, StdCtrls, SysUtils;

function ReplaceStr(const S, Srch, Replace: string): string;
function GetPath(const S: string): string;
procedure AddLog(LogMemo: TMemo; LogStr: string);

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

end.
