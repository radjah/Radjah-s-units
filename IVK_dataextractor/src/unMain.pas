unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  unDataModule, ADODB, Grids, DBGrids, OleAuto, ComCtrls, MyFunctions,
  ExcelAddOns, unView, unStruct, Buttons;

type
  TfmMain = class(TForm)
    btConnect: TButton;
    qExtractor: TADOQuery;
    dsTagGroup: TDataSource;
    dbgTagGroup: TDBGrid;
    Label1: TLabel;
    btGetTags: TButton;
    dsTagList: TDataSource;
    dbgTagList: TDBGrid;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    dtpDateBegin: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    dtpDateEnd: TDateTimePicker;
    dtpTimeBegin: TDateTimePicker;
    dtpTimeEnd: TDateTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    btExtract: TButton;
    qTempTable: TADOQuery;
    qClearTmp: TADOQuery;
    Label7: TLabel;
    mLog: TMemo;
    qForExport: TADOQuery;
    sdResult: TSaveDialog;
    btView: TButton;
    odConn: TOpenDialog;
    qSignalList: TADOQuery;
    dbgSignalList: TDBGrid;
    dsSignalList: TDataSource;
    btAdd: TBitBtn;
    btRemove: TBitBtn;
    btClear: TBitBtn;
    qClearList: TADOQuery;
    Label8: TLabel;
    procedure btConnectClick(Sender: TObject);
    procedure btGetTagsClick(Sender: TObject);
    procedure btExtractClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btViewClick(Sender: TObject);
    procedure ExtractData;
    procedure btClearClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  TableCount: integer; // ���������� ������ � ��������
  TablesName: string; // ������� ������

implementation

{$R *.dfm}

{ === ���������� ������ ��� ��������� ��� ���������� === }
procedure TfmMain.ExtractData;
var
  tabs, samples: integer; // �������
  timeshift: integer; // ����� ������� � �����
  samplecount: integer; // ���������� ������� � ����� ������
  sigidx: integer; // ������ �������
begin
  try
    samplecount := 36;
    timeshift := 4;
    // ��������� �������
    AddLog(mLog, '��������� ������������...');
    sigidx := IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger;
    // ���������� ����������
    qExtractor.Close;
    qExtractor.SQL.Clear;
    qClearTmp.ExecSQL;
    AddLog(mLog, '������� ��������� �������...');
    // ��������� �������
    AddLog(mLog, '������������ �������...');
    for tabs := 1 to TableCount do
    begin
      // ������������ ������� ��� �������
      for samples := 1 to samplecount do
      begin
        // ���� ��� �������
        qExtractor.SQL.Add('INSERT INTO #tmpselect');
        qExtractor.SQL.Add('SELECT Signal_Index as SI, DATEADD(hh,' +
          IntToStr(timeshift) + ',Sample_TDate_' + IntToStr(samples) +
          ') as TD, Sample_MSec_' + IntToStr(samples) + ' as SMS, Sample_Value_'
          + IntToStr(samples) + ' as VAL');
        // ������� ��� �������
        qExtractor.SQL.Add('FROM ' + TablesName + '_' + IntToStr(tabs));
        // ������� �������
        qExtractor.SQL.Add('WHERE (NOT (Sample_TDate_' + IntToStr(samples) +
          ' IS NULL)) AND (NOT (Sample_MSec_' + IntToStr(samples) +
          ' IS NULL)) AND (NOT (Sample_Value_' + IntToStr(samples) +
          ' IS NULL)) and Signal_Index=' + IntToStr(sigidx));
        qExtractor.SQL.Add('and Sample_TDate_' + IntToStr(samples) +
          ' BETWEEN DATEADD(hh,' + IntToStr(-timeshift) + ',''' +
          FormatDateTime('yyyymmdd', dtpDateBegin.Date) + ' ' +
          FormatDateTime('hh:nn:ss', dtpTimeBegin.Time) + ''') AND DATEADD(hh,'
          + IntToStr(-timeshift) + ',''' + FormatDateTime('yyyymmdd',
          dtpDateEnd.Date) + ' ' + FormatDateTime('hh:nn:ss',
          dtpTimeEnd.Time) + ''')');
        // if NOT((tabs = tabcount) and (samples = samplecount)) then
        // qExtractor.SQL.Add('union all');
      end; // for samples
      // qExtractor.SQL.Add('order by SI, TD, SMS');
    end;
    AddLog(mLog, '���������� ��������� �������...');
    qExtractor.ExecSQL;
    qForExport.Close;
    qForExport.Open;
    qForExport.First;
  except
    // ���� �� ������ �����������
    on E: EOleException do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
    // ���� �� ������ ������� ���-��
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
  end;
end;

{ === ���������� ���������� ��������� � ������ === }
procedure TfmMain.btAddClick(Sender: TObject);
begin
  try
    IVK_DM.tbSignalList.AppendRecord
      ([nil, IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
      Trim(IVK_DM.tbTags.FieldByName('Logging_Name').AsString), TablesName,
      TableCount]);
    if IVK_DM.tbSignalList.RecordCount > 0 then
      btRemove.Enabled := True;
  except
    on E: EDatabaseError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ ������ � �����', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
  end;
end;

{ === ������� ������ �������� === }
procedure TfmMain.btClearClick(Sender: TObject);
begin
  qClearList.Close;
  qClearList.ExecSQL;
  ReopenDatasets([IVK_DM.tbSignalList]);
end;

{ === ����������� � ���������� === }
procedure TfmMain.btConnectClick(Sender: TObject);
begin
  try
    if IVK_DM.connIVK_DB.Connected then
    // ��������� ����������
    begin
      IVK_DM.tbTags.Close;
      IVK_DM.tbTWX_GLOBAL.Close;
      IVK_DM.connIVK_DB.Close;
      // IVK_DM.connIVK_DB.Connected := False;
      btConnect.Caption := '���������';
      // ���������� ������
      btExtract.Enabled := False;
      btGetTags.Enabled := False;
      btAdd.Enabled := False;
      btRemove.Enabled := False;
      btClear.Enabled := False;
      btView.Enabled := False;
      AddLog(mLog, '���������� � ����� ���������!');
    end
    else
    // ��������� �����������
    begin
      IVK_DM.connIVK_DB.Connected := True;
      IVK_DM.tbTWX_GLOBAL.Open;
      AddLog(mLog, '���������� � ����� �����������!');
      // ��������� �������
      qTempTable.ExecSQL;
      qSignalList.ExecSQL;
      IVK_DM.tbSignalList.Open;
      AddLog(mLog, '��������� ������� �������.');
      btConnect.Caption := '���������';
      // ��������� ������
      btGetTags.Enabled := True;
      btClear.Enabled := True;
    end;
  except
    // ���� �� ������ �����������
    on E: EOleException do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
    // ���� �� ������ ������� ���-��
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
  end;
end;

{ === ����������� ������� � ���������� ������ === }
procedure TfmMain.btExtractClick(Sender: TObject);
var
  row, BeginCol, BeginRow: integer; // �������
  begTD, curTD: TDateTime; // ��� ��������� ���� � �������
  datasumm: real; // ���������� ��� ����� ��������
  datacount: integer; // ������� ��� ��������
  RowCount, ColCount: integer; // ���������� ����� � ��������
  Excel, Book, Sheet, ArrayData, Cell1, Cell2, Range: variant;
  // ���������� ��� Excel
  ExpData: TExpData;
  ExpDataFile: file of TExpData;
begin
  try
    if sdResult.Execute then
    begin
      AddLog(mLog, '������� ������ �������...');
      ExtractData;
      // Excel?
      if sdResult.FilterIndex = 1 then
      begin
        sdResult.DefaultExt := 'xls';
        // ���������� ������ �������� ���� �������,
        // � ������� ����� �������� ������
        BeginCol := 1;
        BeginRow := 1;
        // ���������� ����� � ��������
        RowCount := qForExport.RecordCount;
        ColCount := qForExport.FieldCount;
        // ������� ����� �������
        Excel := CreateOleObject('Excel.Application');
        // ������� � ��������
        Excel.DisplayAlerts := False;
        AddLog(mLog, '������ Excel ������');
        // Excel.SheetsInNewWorkbook := 0;
        // ������ ����� �����
        Excel.WorkBooks.Add;
        Book := Excel.WorkBooks.Item[1];
        // Excel.WorkBooks.Item[1].Worksheets.Add;
        Sheet := Excel.WorkBooks.Item[1].Worksheets.Item[1];
        // ������ ������ ��� ������
        ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
        // Sheet.Columns['B:B'].Select;
        // Excel.Selection.NumberFormat := 'dd/mm/yyyy h:mm:ss';
      end;
      // ���� ������?
      if sdResult.FilterIndex = 2 then
      begin
        sdResult.DefaultExt := 'msr';
        // ���������� ��������������� �����
        AssignFile(ExpDataFile, sdResult.FileName);
        Rewrite(ExpDataFile);
      end;
      AddLog(mLog, '����������� ������ ������...');
      // ������ ��� ������ � Excel
      row := 1;
      datasumm := 0;
      datacount := 0;
      begTD := qForExport.FieldByName('TD').AsDateTime;
      while NOT qForExport.Eof do
      begin
        // �������� �������� ���������� � ���� ������
        curTD := qForExport.FieldByName('TD').AsDateTime;
        // ���� ������� ������ �� ����������
        if begTD = curTD then
        // ����������� ����� � ��������
        begin
          datacount := datacount + 1;
          datasumm := datasumm + qForExport.FieldByName('VAL').AsFloat;
        end
        else
        // ����� �������� ������� �������� � �������
        begin
          // ���� �������� � Excel
          if sdResult.FilterIndex = 1 then
          begin
            // ID �������
            ArrayData[row, 1] := qForExport.FieldByName('SI').AsVariant;
            // ����� ������
            ArrayData[row, 2] := begTD;
            // ��������
            ArrayData[row, 3] := datasumm / datacount;
          end;
          // ���� �������� � ������ ������
          if sdResult.FilterIndex = 2 then
          begin
            ExpData.SigID := qForExport.FieldByName('SI').AsInteger;
            ExpData.DT := begTD;
            ExpData.Val := datasumm / datacount;
            Write(ExpDataFile, ExpData);
          end;
          // ����� ������ � ��������� ������
          row := row + 1;
          // �������� ��������� ����-�����
          begTD := qForExport.FieldByName('TD').AsDateTime;
          // ���������� ���������� ������� � ����� �������
          datacount := 1;
          // ���������� ������ ��������
          datasumm := qForExport.FieldByName('VAL').AsFloat;
        end;
        // ��������� �� ��������� ������
        qForExport.Next;
      end;
      // ��������� ��������� ������
      if sdResult.FilterIndex = 1 then
      begin
        // ID �������
        ArrayData[row, 1] := qForExport.FieldByName('SI').AsVariant;
        // ����� ������
        ArrayData[row, 2] := begTD;
        // ��������
        ArrayData[row, 3] := datasumm / datacount;
      end;
      if sdResult.FilterIndex = 2 then
      begin
        ExpData.SigID := qForExport.FieldByName('SI').AsInteger;
        ExpData.DT := begTD;
        ExpData.Val := datasumm / datacount;
        Write(ExpDataFile, ExpData);
      end;
      AddLog(mLog, '������ ��������!');
      // ������ ����� ��� Excel
      if sdResult.FilterIndex = 1 then
      begin
        Cell1 := Sheet.Cells[BeginRow, BeginCol];
        Cell2 := Sheet.Cells[BeginRow + RowCount - 1, BeginCol + ColCount - 1];
        Range := Sheet.Range[Cell1, Cell2];
        Range.Value := ArrayData;
        Book.SaveAs(sdResult.FileName, xlWorkbookNormal);
      end;
      if sdResult.FilterIndex = 2 then
        CloseFile(ExpDataFile);
      AddLog(mLog, '���� ��������!');
      if sdResult.FilterIndex = 1 then
      begin
        // �������
        Excel.Quit;
        AddLog(mLog, '������ Excel ���������');
      end;
      // qExtractor.SQL.SaveToFile('q.txt');
      AddLog(mLog, '������� ������ ��������!');
    end;
  except
    // ���� �� ������ �����������
    on E: EOleException do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ ��� ������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
    // ���� �� ������ ������� ���-��
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
  end;
end;

{ === �������� ������ ����� � ��������� ������ === }
procedure TfmMain.btGetTagsClick(Sender: TObject);
begin
  try
    // ���������� ����������
    IVK_DM.tbTags.Close;
    IVK_DM.tbTags.tablename := IVK_DM.tbTWX_GLOBAL.FieldByName
      ('Table_Tags').AsString;
    IVK_DM.tbTags.Open;
    // ������ �������� ��� ��������� ���������� ������ ��� ����������
    TableCount := IVK_DM.tbTWX_GLOBAL.FieldByName('Tables_Number').AsInteger;
    TablesName := Trim(IVK_DM.tbTWX_GLOBAL.FieldByName('Table_Name').AsString);
    // qGetTabCount.SQL[2] := 'Table_Tags=''' + IVK_DM.tbTWX_GLOBAL.FieldByName
    // ('Table_Tags').AsString + '''';
    // ���� � ��������� ������ ���� ����
    if IVK_DM.tbTags.RecordCount > 0 then
    begin
      btExtract.Enabled := True;
      btView.Enabled := True;
      btAdd.Enabled := True;
    end
    // ���� ������ ������
    else
    begin
      btExtract.Enabled := False;
      btView.Enabled := False;
    end;
  except
    // ���� �� ������ �����������
    on E: EOleException do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
    // ���� �� ������ ������� ���-��
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
  end;
end;

{ === �������� ��������� �� ������ === }
procedure TfmMain.btRemoveClick(Sender: TObject);
begin
  try
    IVK_DM.tbSignalList.Delete;
    if IVK_DM.tbSignalList.RecordCount = 0 then
      btRemove.Enabled := False;
  except
    on E: EDatabaseError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
  end;
end;

{ === �������� === }
procedure TfmMain.btViewClick(Sender: TObject);
begin
  ExtractData;
  AddLog(mLog, '������ ���������...');
  fmView.ShowModal;
end;

{ === ��������� ��������� �������� === }
procedure TfmMain.FormShow(Sender: TObject);
begin
  dtpDateBegin.DateTime := Now;
  dtpDateEnd.DateTime := Now;
  dtpTimeBegin.DateTime := Now;
  dtpTimeEnd.DateTime := Now;
  if FileExists(ExtractFilePath(Application.ExeName) + '\conn.udl') then
    IVK_DM.connIVK_DB.ConnectionString := 'FILE NAME=' +
      ExtractFilePath(Application.ExeName) + '\conn.udl'
  else
  begin
    if odConn.Execute then
      IVK_DM.connIVK_DB.ConnectionString := 'FILE NAME=' + odConn.FileName
    else
      Close;
  end;

end;

end.
