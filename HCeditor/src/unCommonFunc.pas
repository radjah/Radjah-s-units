unit unCommonFunc;

interface

uses
  DB, ZDataset;

// ����������� ��������� ���������
procedure ReopenDS(DataSets: array of TDataSet);
// ������� ��������� ���������
procedure CloseDS(DataSets: array of TDataSet);

implementation

procedure ReopenDS(DataSets: array of TDataSet);
var
  i: integer; // �������
begin
  for i := 0 to Length(DataSets) - 1 do
  begin
    DataSets[i].Close;
    DataSets[i].Open;
  end;
end;

procedure CloseDS(DataSets: array of TDataSet);
var
  i: integer; // �������
begin
  for i := 0 to Length(DataSets) - 1 do
  begin
    DataSets[i].Close;
  end;
end;

end.
