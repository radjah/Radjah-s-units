unit unDCMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, unStruct, OleAuto, ComCtrls, MyFunctions,
  ExcelAddOns;

type
  TfmDCMain = class(TForm)
    leDataFile: TLabeledEdit;
    leExcelFile: TLabeledEdit;
    btDataFile: TButton;
    btExcelFile: TButton;
    odDataFile: TOpenDialog;
    sdExcelFile: TSaveDialog;
    btConvert: TButton;
    procedure btDataFileClick(Sender: TObject);
    procedure btExcelFileClick(Sender: TObject);
    procedure btConvertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDCMain: TfmDCMain;

implementation

{$R *.dfm}

{ === �������������� === }
procedure TfmDCMain.btConvertClick(Sender: TObject);
var
  Excel, Book, Sheet: variant; // ���������� ��� Excel
  ExpData: TExpData;
  ExpDataFile: file of TExpData;
  row: integer; // ������� ����� �������
begin
  try
    // ��������� ���� ������
    AssignFile(ExpDataFile, leDataFile.Text);
    Reset(ExpDataFile);
    // ������� ������ Excel
    Excel := CreateOleObject('Excel.Application');
    // ������� � ��������
    Excel.DisplayAlerts := false;
    // ������ ����� �����
    Excel.WorkBooks.Add;
    Book := Excel.WorkBooks.Item[1];
    Sheet := Excel.WorkBooks.Item[1].Worksheets.Item[1];
    row := 1;
    // �������� ������ � ������
    while not EOF(ExpDataFile) do
    begin
      Read(ExpDataFile, ExpData);
      // ID �������
      Sheet.Cells[row, 1].FormulaR1C1 := ExpData.SigID;
      // ����� ������
      Sheet.Cells[row, 2].FormulaR1C1 := ExpData.DT;
      // ��������
      Sheet.Cells[row, 3].FormulaR1C1 := ExpData.Val;
      row := row + 1;
    end;
    // ��������� � ���������
    CloseFile(ExpDataFile);
    Book.SaveAs(leExcelFile.Text, xlWorkbookNormal);
    Excel.Quit;
  except
    on E: EOleError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ ��� ������', MB_OK or MB_ICONERROR);
      Excel.Quit;
      CloseFile(ExpDataFile);
    end;
  end;
end;

{ === ����� ��������� ����� === }
procedure TfmDCMain.btDataFileClick(Sender: TObject);
begin
  if odDataFile.Execute then
  begin
    leDataFile.Text := odDataFile.FileName;
    leExcelFile.Text := odDataFile.FileName + '.xls';
    sdExcelFile.FileName := odDataFile.FileName + '.xls';
  end;
end;

{ === �������� ��������������� ����� === }
procedure TfmDCMain.btExcelFileClick(Sender: TObject);
begin
  if sdExcelFile.Execute then
    leExcelFile.Text := sdExcelFile.FileName;
end;

end.
