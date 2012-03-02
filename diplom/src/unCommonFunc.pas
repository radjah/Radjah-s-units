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

// Вызов формы для получения имени нового объекта
function GetNewName(NameTpl:string):boolean;
begin
  fmName.edName.Text:=NameTpl;
  fmName.ShowModal;
  Result:=ResultBool;
end;

// Вызов формы для получения числового значения
function GetNewDig:boolean;
begin
  fmNewDig.ShowModal;
  Result:=ResultBool;
end;

// Переоткрывает наборы данных
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

// Подтверждение удаления
function ConfirmDel(hWin:HWND;str:string):boolean;
var
confstr:pchar;
begin
  if NOT AutoMode then
  begin
    confstr:=pchar('Вы действительно хотите удалить '+str+'?');
    Result:=False;
    if MessageBox(hWin,confstr,'Подтвеждение удаления',MB_YESNO or MB_ICONQUESTION)=IDYES then
    Result:=True;
  end else Result:=True;
end;

// Подтверждение добавления
function ConfirmAdd(hWin:HWND;str:string):boolean;
var
confstr:pchar;
begin
  if NOT AutoMode then
  begin
    confstr:=pchar('Вы действительно хотите добавить '+str+'?');
    Result:=False;
    if MessageBox(hWin,confstr,'Подтвеждение добавления',MB_YESNO or MB_ICONQUESTION)=IDYES then
    Result:=True;
  end else Result:=True;
end;

end.
