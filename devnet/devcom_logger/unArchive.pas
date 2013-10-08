unit unArchive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZDataset, DB, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractTable, StdCtrls, Grids, DBGrids;

type
  TfmArchive = class(TForm)
    dbgArchive: TDBGrid;
    lArcTime: TLabel;
    lArcDiff: TLabel;
    lArcUd: TLabel;
    Label4: TLabel;
    ztMeasArchive: TZTable;
    dsArchive: TDataSource;
    zqArchive: TZQuery;
    ztWeight: TZTable;
    dsWeight: TDataSource;
    btExport: TButton;
    sdExport: TSaveDialog;
    zqDelete: TZQuery;
    btDelete: TButton;
    zqDelMeas: TZQuery;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure dbgArchiveColEnter(Sender: TObject);
    procedure dbgArchiveCellClick(Column: TColumn);
    procedure dbgArchiveKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btExportClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure ztMeasArchiveBeforeScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmArchive: TfmArchive;

implementation

uses unDevNetLogger, MyFunctions, ComObj, ExcelAddOns;

{$R *.dfm}

{ === ���������� ������ ��� �������� ����� === }
procedure TfmArchive.FormShow(Sender: TObject);
begin
  ReopenDatasets([ztMeasArchive,ztWeight]);
end;

{ === ��������� ������ === }
procedure TfmArchive.dbgArchiveColEnter(Sender: TObject);
var
  WeightStart,WeightEnd:real; // �������� ����� �� ������ � ����� ������
  ArcTime:real; // ����������������� ������
  WeightDiff:real; // ������ �������
begin
  if ztMeasArchive.RecordCount>0 then
  begin
    // ��������� ������
    zqArchive.Close;
    zqArchive.SQL.Strings[1]:='meas_id='+ztMeasArchive.FieldByName('id').AsString;
    zqArchive.Open;
    // ��������� ������
    ArcTime:=ztMeasArchive.FieldByName('mtime').AsFloat;
    lArcTime.Caption:='�����: ' + FloatToStr(ArcTime) + ' ���.';
    zqArchive.First;
    WeightStart:=zqArchive.FieldByName('brutto').AsFloat;
    zqArchive.Last;
    WeightEnd:=zqArchive.FieldByName('brutto').AsFloat;
    WeightDiff:=Abs(WeightStart-WeightEnd);
    lArcDiff.Caption:='�������: ' + Format('%.3f',[WeightDiff]);
    if ArcTime<>0 then
    lArcUd.Caption:='�������: ' +  Format('%.3f',[WeightDiff/ArcTime*3600])
    else
    lArcUd.Caption:='�������:'
  end;
end;

{ === ���������� ���������� ��� ������ ����� ������ === }
procedure TfmArchive.dbgArchiveCellClick(Column: TColumn);
begin
  dbgArchiveColEnter(Self);
end;

{ === ���������� ���������� ��� ��������� ���������� ��������� === }
procedure TfmArchive.dbgArchiveKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  dbgArchiveColEnter(Self);
end;

{ === ������� ������ � Excel === }
procedure TfmArchive.btExportClick(Sender: TObject);
var
  Excel, Book, Sheet, ArrayData, Cell1, Cell2, Range: variant; // ��� Excel
  i : integer; // �������
  BeginCol, BeginRow, RowCount, ColCount: integer; // ���������� ����� � ��������
begin
  try
  if sdExport.Execute then
  begin
    // ������
    zqArchive.Close;
    zqArchive.SQL.Strings[1]:='meas_id='+ztMeasArchive.FieldByName('id').AsString;
    zqArchive.Open;
    // ������ ����� ������
    Excel := CreateOleObject('Excel.Application');
    // ������� � ��������
    Excel.DisplayAlerts := False;
    // ������ ����� �����
    Excel.WorkBooks.Add;
    Book := Excel.WorkBooks.Item[1];
    // ��������� ������ �����
    for i := 1 to Book.Sheets.Count - 1 do
      Book.Sheets.Item[1].Delete;
    Sheet := Excel.WorkBooks.Item[1].Worksheets.Item[1];
    // ������ ������ ��� ������
    RowCount := ztWeight.RecordCount+1;
    BeginCol := 1;
    BeginRow := 1;
    ColCount := 4; // �����, ������, �����, ����
    ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
    ArrayData[1, 1]:='�����';
    ArrayData[1, 2]:='������';
    ArrayData[1, 3]:='�����';
    ArrayData[1, 4]:='����';
    ztWeight.First;
    for i:=2 to RowCount do
      // ��������� ������
       begin
         // �����
         ArrayData[i, 1] := ztWeight.FieldByName('date').AsDateTime;
         // ������
         ArrayData[i, 2] := ztWeight.FieldByName('brutto').AsFloat;
         // �����
         ArrayData[i, 3] := ztWeight.FieldByName('netto').AsFloat;
         // ����
         ArrayData[i, 4] := ztWeight.FieldByName('tara').AsFloat;
         // ��������� ������
         ztWeight.Next;
       end;
    // ����� ����� ������ �� ��������� ����
    Cell1 := Sheet.Cells[BeginRow, BeginCol];
    Cell2 := Sheet.Cells[BeginRow + RowCount - 1,
      BeginCol + ColCount - 1];
    Range := Sheet.Range[Cell1, Cell2];
    Range.Value := ArrayData;
    // ���������
    sdExport.DefaultExt := 'xls';
    Book.SaveAs(sdExport.FileName, xlWorkbookNormal);
    Excel.Quit;
    MessageBox(Self.Handle, '������� ��������.',
        '����������', MB_OK or MB_ICONINFORMATION);
  end;
  except
    on E: EOleException do
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ ��� ������', MB_OK or MB_ICONERROR);
    on E: EVariantError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������', MB_OK or MB_ICONERROR);
      Excel:=Unassigned;
    end;
  end;
end;

{ === �������� ������ === }
procedure TfmArchive.btDeleteClick(Sender: TObject);
begin
  if MessageBox(Self.Handle, '������� �����?', '������', MB_YESNO or MB_ICONQUESTION)=IDYES
  then
  begin
    zqDelete.Close;
    zqDelete.SQL.Strings[1]:='meas_id='+ztMeasArchive.FieldByName('id').AsString;
    zqDelete.ExecSQL;
    zqDelete.Close;
    zqDelMeas.SQL.Strings[1]:='id='+ztMeasArchive.FieldByName('id').AsString;
    zqDelMeas.ExecSQL;
    ztWeight.Refresh;
    ztMeasArchive.Refresh;
    dbgArchiveColEnter(Self);
  end;
end;

{ === ��� ���� ���������� ��� ���������� ���������� === }
procedure TfmArchive.ztMeasArchiveBeforeScroll(DataSet: TDataSet);
begin
  dbgArchiveColEnter(Self);
end;

end.
