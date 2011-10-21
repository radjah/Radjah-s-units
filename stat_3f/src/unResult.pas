unit unResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TfmResult = class(TForm)
    sgResult: TStringGrid;
    btClose: TButton;
    lTime: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmResult: TfmResult;

implementation

uses
  unMain;

{$R *.dfm}

procedure TfmResult.FormShow(Sender: TObject);
begin
  With sgResult do
  begin
    // ������� �����
    Cells[0, 1] := ShortA;
    Cells[0, 2] := ShortB;
    Cells[0, 3] := ShortC;
    Cells[0, 4] := ShortA+'x'+ShortB;
    Cells[0, 5] := ShortA+'x'+ShortC;
    Cells[0, 6] := ShortB+'x'+ShortC;
    if repmes then
    begin
    sgResult.RowCount:=10;
    Cells[0, 7] := ShortA+'x'+ShortB+'x'+ShortC;
    Cells[0, 8] := '����.';
    Cells[0, 9] := '�����';
    end else
    begin
    sgResult.RowCount:=9;
    Cells[0, 7] := '����.';
    Cells[0, 8] := '�����';
    end;
    // ������� ��������
    Cells[1, 0] := 'Q';
    Cells[2, 0] := '��.��.';
    Cells[3, 0] := '��.��.';
    Cells[4, 0] := '�����.';
  end;
end;

end.
