unit unCommonFunc;

interface

uses
  DB, ADODB, Windows;

  function GetNewName(NameTpl:string):boolean;
  function GetNewDig:boolean;
  function ConfirmDel(hWin:HWND;str:string):boolean;
  function ConfirmAdd(hWin:HWND;str:string):boolean;
  procedure ReopenDatasets(DS:array of TDataSet);

var
  NewDig:integer;
  ResultName:string[255];
  ResultBool:boolean;
  AutoMode:boolean=False;

implementation

uses unName,unNewDig;

// ����� ����� ��� ��������� ����� ������ �������
function GetNewName(NameTpl:string):boolean;
begin
  fmName.edName.Text:=NameTpl;
  fmName.ShowModal;
  Result:=ResultBool;
end;

// ����� ����� ��� ��������� ��������� ��������
function GetNewDig:boolean;
begin
  fmNewDig.ShowModal;
  Result:=ResultBool;
end;

// ������������� ������ ������
procedure ReopenDatasets(DS:array of TDataSet);
var
  i:integer;
begin
  for i:=0 to Length(DS)-1 do
  begin
    DS[i].Close;
    DS[i].Open;
  end
end;

// ������������� ��������
function ConfirmDel(hWin:HWND;str:string):boolean;
var
confstr:pchar;
begin
  if NOT AutoMode then
  begin
    confstr:=pchar('�� ������������� ������ ������� '+str+'?');
    Result:=False;
    if MessageBox(hWin,confstr,'������������ ��������',MB_YESNO or MB_ICONQUESTION)=IDYES then
    Result:=True;
  end else Result:=True;
end;

// ������������� ����������
function ConfirmAdd(hWin:HWND;str:string):boolean;
var
confstr:pchar;
begin
  if NOT AutoMode then
  begin
    confstr:=pchar('�� ������������� ������ �������� '+str+'?');
    Result:=False;
    if MessageBox(hWin,confstr,'������������ ����������',MB_YESNO or MB_ICONQUESTION)=IDYES then
    Result:=True;
  end else Result:=True;
end;

end.
