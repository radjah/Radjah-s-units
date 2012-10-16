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
  i: integer; // �������
  ValArrSigID, ValArrDT, ValArrVal: variant; // ������� ��� ����� ������.
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
      RowCount := 0; // ������� �������
      // ������ ����� ������ � 0 ���������
      ValArrSigID := VarArrayCreate([1, 0], varVariant);
      ValArrDT := VarArrayCreate([1, 0], varVariant);
      ValArrVal := VarArrayCreate([1, 0], varVariant);
      // �������� ������ � ������
      while not EOF(ExpDataFile) do
      begin
        // ������� ��������� ������ �� �����
        Read(ExpDataFile, ExpData);
        // ��������� ������
        VarArrayRedim(ValArrSigID, VarArrayHighBound(ValArrSigID, 1) + 1);
        VarArrayRedim(ValArrDT, VarArrayHighBound(ValArrDT, 1) + 1);
        VarArrayRedim(ValArrVal, VarArrayHighBound(ValArrVal, 1) + 1);
        // ��������� ����� �������
        // ID �������
        ValArrSigID[VarArrayHighBound(ValArrSigID, 1)] := ExpData.SigID;
        // ����� ������
        ValArrDT[VarArrayHighBound(ValArrDT, 1)] := ExpData.DT;
        // ��������
        ValArrVal[VarArrayHighBound(ValArrVal, 1)] := ExpData.Val;
        if VarArrayHighBound(ValArrSigID, 1) < 10 then
          ShowMessage(IntToStr(VarArrayHighBound(ValArrSigID, 1)) + #10#13 +
            IntToStr(VarArrayHighBound(ValArrDT, 1)) + #10#13 +
            IntToStr(VarArrayHighBound(ValArrVal, 1)));
        { // ID �������
          Sheet.Cells[row, 1].FormulaR1C1 := ExpData.SigID;
          // ����� ������
          Sheet.Cells[row, 2].FormulaR1C1 := ExpData.DT;
          // ��������
          Sheet.Cells[row, 3].FormulaR1C1 := ExpData.Val; }
        // ����������� �������
        RowCount := RowCount + 1;
      end;
      // ��������� ���� ������
      CloseFile(ExpDataFile);
      // ������ �������!!!
      // �������������� ����������� ��� ����������
      Cell1 := Sheet.Cells[BeginRow, 1];
      Cell2 := Sheet.Cells[BeginRow + RowCount - 1, 1];
      Range := Sheet.Range[Cell1, Cell2];
      // ������� ������
      Range.Value := ValArrSigID;
      // �������������� ����������� ��� ����������
      Cell1 := Sheet.Cells[BeginRow, 2];
      Cell2 := Sheet.Cells[BeginRow + RowCount - 1, 2];
      Range := Sheet.Range[Cell1, Cell2];
      // ������� ������
      Range.Value := ValArrDT;
      // �������������� ����������� ��� ����������
      Cell1 := Sheet.Cells[BeginRow, 3];
      Cell2 := Sheet.Cells[BeginRow + RowCount - 1, 3];
      Range := Sheet.Range[Cell1, Cell2];
      // ������� ������
      Range.Value := ValArrVal;
      // ���������
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
