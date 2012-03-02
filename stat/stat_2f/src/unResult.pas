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
    // Подписи строк
    Cells[0, 1] := ShortA;
    Cells[0, 2] := ShortB;
    if repmes then
    begin
    sgResult.RowCount:=6;
    Cells[0, 3] := ShortA+'x'+ShortB;
    Cells[0, 4] := 'Случ.';
    Cells[0, 5] := 'ИТОГО';
    end else
    begin
    sgResult.RowCount:=5;
    Cells[0, 3] := 'Случ.';
    Cells[0, 4] := 'ИТОГО';
    end;
    // Подписи столбцов
    Cells[1, 0] := 'Q';
    Cells[2, 0] := 'Ст.св.';
    Cells[3, 0] := 'Ср.кв.';
    Cells[4, 0] := 'Эмпир.';
  end;
end;

end.
