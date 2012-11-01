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
  Excel, Book, Sheet, Cell1, Cell2, Range: variant; // ���������� ��� Excel
  ExpData: TExpData;
  ExpDataFile: file of TExpData;
  BeginCol, BeginRow: integer; // ���������� ������ �����
  RowCount, ColCount: integer; // ���������� ����� � �������
  ValArrSigID: array of integer; // ������ ���������������
  ValArrDT: array of TDateTime; // ������ ��������� �������
  ValArrVal: array of real; // ������ ��������
  i: integer; // �������
  ValArr: variant; // ������� ��� ����� ������.
begin
  try
    if (trim(leDataFile.Text) = '') or (trim(leExcelFile.Text) = '') then
      MessageBox(Self.Handle, '�� ������ �������� �/��� �������������� ����.',
        '������', MB_OK or MB_ICONERROR)
    else
    begin
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
      // ���������� ������ �������� ���� �������, � ������� ����� �������� ������
      BeginCol := 1;
      BeginRow := 1;
      ColCount := 3;
      RowCount := 0; // ������� �������
      // �������� ������ � ������
      while not EOF(ExpDataFile) do
      begin
        // ������� ��������� ������ �� �����
        Read(ExpDataFile, ExpData);
        // ��������� ������
        SetLength(ValArrSigID, length(ValArrSigID) + 1);
        SetLength(ValArrDT, length(ValArrDT) + 1);
        SetLength(ValArrVal, length(ValArrVal) + 1);
        // ��������� ����� �������
        // ID �������
        ValArrSigID[RowCount] := ExpData.SigID;
        // ����� ������
        ValArrDT[RowCount] := ExpData.DT;
        // ��������
        ValArrVal[RowCount] := ExpData.Val;
        // ����������� �������
        RowCount := RowCount + 1;
      end;
      // ��������� ���� ������
      CloseFile(ExpDataFile);
      ValArr := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
      // ������ �������!!!
      for i := 0 to RowCount - 1 do
      begin
        ValArr[i + 1, 1] := ValArrSigID[i];
        ValArr[i + 1, 2] := ValArrDT[i];
        ValArr[i + 1, 3] := ValArrVal[i];
      end;
      // �������������� ����������� ��� ����������
      Cell1 := Sheet.Cells[BeginRow, BeginCol];
      Cell2 := Sheet.Cells[BeginRow + RowCount - 1, BeginCol + ColCount - 1];
      Range := Sheet.Range[Cell1, Cell2];
      Range.Value := ValArr;
      Book.SaveAs(leExcelFile.Text, xlWorkbookNormal);
      // ���������
      Excel.Quit;
      MessageBox(Self.Handle, '�������������� ���������!', '���������',
        MB_OK or MB_ICONINFORMATION);
    end;
  except
    on E: EOleError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ ��� ������', MB_OK or MB_ICONERROR);
      Excel.Quit;
      CloseFile(ExpDataFile);
    end;
    on E: EVariantError do
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
