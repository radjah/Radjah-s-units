unit unCommonFunc;

interface

uses
  DB, ZDataset;

// Переоткрыть несколько датасетов
procedure ReopenDS(DataSets: array of TDataSet);
// Закрыть несколько датасетов
procedure CloseDS(DataSets: array of TDataSet);
// Переключение RW<->RO
procedure SwitchRW(IsRO:boolean;DataSets: array of TZTable);

implementation

procedure ReopenDS(DataSets: array of TDataSet);
var
  i: integer; // счетчик
begin
  for i := 0 to Length(DataSets) - 1 do
  begin
    DataSets[i].Close;
    DataSets[i].Open;
  end;
end;

procedure CloseDS(DataSets: array of TDataSet);
var
  i: integer; // счетчик
begin
  for i := 0 to Length(DataSets) - 1 do
  begin
    DataSets[i].Close;
  end;
end;

procedure SwitchRW(IsRO:boolean;DataSets: array of TZTable);
var
  i: integer; // счетчик
begin
  for i := 0 to Length(DataSets) - 1 do
  begin
    DataSets[i].Close;
    DataSets[i].ReadOnly:=IsRO;
    DataSets[i].Open;
  end;
end;

end.
