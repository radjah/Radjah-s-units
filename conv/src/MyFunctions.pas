unit MyFunctions;

interface

uses
  Windows, StrUtils;

function ReplaceStr(const S, Srch, Replace: string):string;
function GetPath(const S:string):string;

implementation

{=== Замена текста в строек ===}
function ReplaceStr(const S, Srch, Replace: string):string;
var
  i:integer;
  Source:string;
begin
  Source:=S;
  Result:='';
  repeat
    i:=pos(Srch,Source);
    if i>0 then
    begin
      Result:=Result+Copy(Source,1,i-1)+Replace;
      Source:=Copy(Source,i+Length(Srch),MaxInt);
    end else
    Result:=Result+Source;
    until i<=0;
end;

function GetPath(const S:string):string;
var
  temvar:string;
begin
  temvar:=ReverseString(S);
  Result:=ReverseString(Midstr(temvar,Pos('\',temvar),MAX_PATH));
end;

end.
 