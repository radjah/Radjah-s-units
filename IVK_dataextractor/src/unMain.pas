unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  unDataModule, ADODB, Grids, DBGrids, OleAuto, ComCtrls, MyFunctions,
  ExcelAddOns, unView, unStruct, unChart, Buttons, TeeProcs, Chart, Series;

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
    cbFillTime: TCheckBox;
    btPlot: TButton;
    procedure btConnectClick(Sender: TObject);
    procedure btGetTagsClick(Sender: TObject);
    procedure btExtractClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btViewClick(Sender: TObject);
    procedure ExtractData(SigIdx: integer; TablesName: string;
      TableCount: integer);
    procedure btClearClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure MakeDataArr(MethodFlag: boolean);
    procedure btPlotClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  TableCountSingle: integer; // ���������� ������ � ��������
  TablesNameSingle: string; // ������� ������
  ExpDataArr: array of TExpData; // ������ ��� ������

implementation

{$R *.dfm}

{ === ���������� ������ ��� ��������� ��� ���������� === }
procedure TfmMain.ExtractData(SigIdx: integer; TablesName: string;
  TableCount: integer);
var
  tabs, samples: integer; // �������
  timeshift: integer; // ����� ������� � �����
  samplecount: integer; // ���������� ������� � ����� ������
begin
  try
    // �������
    // ShowMessage('SigIdx = ' + IntToStr(SigIdx) + #10#13 + 'TablesName = ' +
    // TablesName + #10#13 + 'TableCount = ' + IntToStr(TableCount));
    samplecount := 36;
    timeshift := 4;
    // ��������� �������
    AddLog(mLog, '��������� ������������...');
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
          ' IS NULL)) and Signal_Index=' + IntToStr(SigIdx));
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
    // �������
    // ShowMessage('qForExport.RecordCount = ' + IntToStr(qForExport.RecordCount) +
    // #10#13 + 'qForExport.FieldCount = ' + IntToStr(qForExport.FieldCount));
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

{ === ���������� ������ �� ������� � ������ === }
procedure TfmMain.MakeDataArr(MethodFlag: boolean);
var
  row: integer; // �������
  begTD, curTD: TDateTime; // ��� ��������� ���� � �������
  datasumm: real; // ���������� ��� ����� ��������
  datacount: integer; // ������� ��� ��������
begin
  // ������ ��� ������ � ������
  SetLength(ExpDataArr, 0);
  row := 0;
  datasumm := 0;
  datacount := 0;
  begTD := qForExport.FieldByName('TD').AsDateTime;
  while NOT qForExport.Eof do
  // ���� �� ������� ��� ������
  begin
    // �������� �������� ����-�����
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
      // ����������
      SetLength(ExpDataArr, row + 1);
      // ���������� �����
      // ID �������
      ExpDataArr[row].SigID := qForExport.FieldByName('SI').AsInteger;
      // ����� ������
      ExpDataArr[row].DT := begTD;
      // ��������
      ExpDataArr[row].Val := datasumm / datacount;
      // ���������� �������
      // ��������� �� ���� �� ������������ ������� �������
      row := row + 1;
      if MethodFlag = True then
      // ���� ����������� ������ ���������������
      begin
        // ��������� � ������������ ������� �������
        begTD := begTD + StrToTime('0:00:01');
        while begTD < curTD do
        // ���� �� ������� �� ����� ��������� �������
        begin
          // ���������� ������
          SetLength(ExpDataArr, row + 1);
          // ��������� ����� ������� �� �������
          ExpDataArr[row] := ExpDataArr[row - 1];
          ExpDataArr[row].DT := begTD;
          // ���������� �������
          // ��������� �� ���� �� ������������ ������� �������
          row := row + 1;
          // ���������� �����
          begTD := begTD + StrToTime('0:00:01');
        end;
      end;
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
  // �������
  // ShowMessage('row = ' + IntToStr(row));
  // ���������� ������
  SetLength(ExpDataArr, row + 1);
  // ���������� �����
  // ID �������
  ExpDataArr[row].SigID := qForExport.FieldByName('SI').AsInteger;
  // ����� ������
  ExpDataArr[row].DT := begTD;
  // ��������
  ExpDataArr[row].Val := datasumm / datacount;
end;

{ === ���������� ���������� ��������� � ������ === }
procedure TfmMain.btAddClick(Sender: TObject);
begin
  try
    IVK_DM.tbSignalList.AppendRecord
      ([nil, IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
      Trim(IVK_DM.tbTags.FieldByName('Logging_Name').AsString),
      TablesNameSingle, TableCountSingle]);
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
  AddLog(mLog, '������ ������.');
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
      btPlot.Enabled := False;
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
  BeginCol, BeginRow, i, j: integer; // �������
  RowCount, ColCount: integer; // ���������� ����� � ��������
  // ���������� ��� Excel
  Excel, Book, Sheet, ArrayData, Cell1, Cell2, Range: variant;
  ExpDataFile: file of TExpData;
  ExportMethodFlag: boolean;
  // ���� ���� ��������:
  // True - �� ������
  // False - ������ ���������
begin
  try
    if sdResult.Execute then
    // ������ �� ������������ ���� ��� ����������?
    begin
      { = ��������� ���������� = }
      if sdResult.FilterIndex = 1 then
      // Excel?
      begin
        if IVK_DM.tbSignalList.RecordCount = 0 then
        // ��� �������?
        begin
          // ������ ��, ��� �������?
          if MessageBox(Self.Handle, '������ ��� ���������� ����.' + #10#13 +
            '������� ������ ��������� ������?', '������', MB_OKCANCEL or
            MB_ICONQUESTION) = IDOK then
            ExportMethodFlag := False
            // ����� �� ��������
          else
            Exit;
        end
        else
          // ������������ �� ������
          ExportMethodFlag := True;
      end
      // ���� �������������� ����
      else
      begin
        if MessageBox(Self.Handle, '��������� ������ ����������� � ����������� '
          + '���������� �������� ������������.' + #10#13 +
          '������� ������ ��������� ������?', '������', MB_OKCANCEL or
          MB_ICONQUESTION) = IDOK then
          ExportMethodFlag := False
          // ����� �� ��������
        else
          Exit;
      end;
      { = ��� �������� ��������, ����� �������� ���������. = }
      // ��������� ��������� �����
      AddLog(mLog, '������� ������ �������...');
      if ExportMethodFlag then
      // ��� ������ Excel
      begin
        // ���������� � ������ �������
        IVK_DM.tbSignalList.First;
        // ������ ����� ������
        Excel := CreateOleObject('Excel.Application');
        // ������� � ��������
        Excel.DisplayAlerts := False;
        AddLog(mLog, '������ Excel ������');
        // ������ ����� �����
        Excel.WorkBooks.Add;
        Book := Excel.WorkBooks.Item[1];
        // ��������� ������ �����
        for i := 1 to Book.Sheets.Count - 1 do
          Book.Sheets.Item[1].Delete;
        // � ������ ������ ����������
        for i := 1 to IVK_DM.tbSignalList.RecordCount - 1 do
          Book.Sheets.Add;
        // ������ � ����� ���������� ������� �����
        // ���������� ����������� ����������
        // ���������� � ����������
        for i := 1 to IVK_DM.tbSignalList.RecordCount do
        // ��� ������� ���������� ���������
        begin
          Sheet := Book.Worksheets.Item[i];
          // ������ ������
          ExtractData(IVK_DM.tbSignalList.FieldByName('Tag_Index').AsInteger,
            IVK_DM.tbSignalList.FieldByName('Table_Name').AsString,
            IVK_DM.tbSignalList.FieldByName('Tables_Number').AsInteger);
          // �������� �� ������ �����
          if qForExport.RecordCount > 0 then
          // ���� �� ��������� ���������� ��� ������.
          begin
            AddLog(mLog, '����������� ������ ������...');
            MakeDataArr(ExportMethodFlag);
            // ������ ������ ��� ������
            RowCount := Length(ExpDataArr);
            ColCount := 3;
            ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
            for j := 1 to RowCount do
            // ��������� ������
            begin
              // ID �������
              ArrayData[j, 1] := ExpDataArr[j - 1].SigID;
              // ����� ������
              ArrayData[j, 2] := ExpDataArr[j - 1].DT;
              // ��������
              ArrayData[j, 3] := ExpDataArr[j - 1].Val;
            end;
            // ���������� ������ �������� ���� �������,
            // � ������� ����� �������� ������
            BeginCol := 1;
            BeginRow := 1;
            ColCount := 3; // ID, �����, ��������
            // ����� ����� ������ �� ��������� ����
            Cell1 := Sheet.Cells[BeginRow, BeginCol];
            Cell2 := Sheet.Cells[BeginRow + RowCount - 1,
              BeginCol + ColCount - 1];
            Range := Sheet.Range[Cell1, Cell2];
            Range.Value := ArrayData;
            AddLog(mLog, '������ ��������!');
            // ������� ���������� ������
            VarClear(ArrayData);
          end
          else
            AddLog(mLog, '��������� �������� ��� ������! ����������.');
          // �������� �����.
          Sheet.Name := IVK_DM.tbSignalList.FieldByName('Logging_Name')
            .AsString;
          IVK_DM.tbSignalList.Next;
        end;
        // ��������� � �������
        // ��������� ����������
        sdResult.DefaultExt := 'xls';
        Book.SaveAs(sdResult.FileName, xlWorkbookNormal);
        AddLog(mLog, '���� ��������!');
        Excel.Quit;
        AddLog(mLog, '������ Excel ���������');
        AddLog(mLog, '������� ������ ��������!');
      end
      else
      // ���� ���������� ������ ��������� ��������
      begin
        // ����� ������
        ExtractData(IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
          TablesNameSingle, TableCountSingle);
        if qForExport.RecordCount > 0 then
        // ���� �� ��������� ���������� ���� ������.
        begin
          MakeDataArr(ExportMethodFlag);
          RowCount := Length(ExpDataArr);
          // ��� � ��� ���� ������ ������� ���� �������
          // �� ���������� ���� ���������� ����� ����������
          if sdResult.FilterIndex = 1 then
          // ���� ������� Excel
          begin
            // ������ ����� ������
            Excel := CreateOleObject('Excel.Application');
            // ������� � ��������
            Excel.DisplayAlerts := False;
            AddLog(mLog, '������ Excel ������');
            // ������ ����� �����
            Excel.WorkBooks.Add;
            Book := Excel.WorkBooks.Item[1];
            // ��������� ������ �����
            for i := 1 to Book.Sheets.Count - 1 do
              Book.Sheets.Item[1].Delete;
            Sheet := Excel.WorkBooks.Item[1].Worksheets.Item[1];
            // ������ ������ ��� ������
            BeginCol := 1;
            BeginRow := 1;
            ColCount := 3; // ID, �����, ��������
            ArrayData := VarArrayCreate([1, RowCount, 1, ColCount], varVariant);
            for j := 1 to RowCount do
            // ��������� ������
            begin
              // ID �������
              ArrayData[j, 1] := ExpDataArr[j - 1].SigID;
              // ����� ������
              ArrayData[j, 2] := ExpDataArr[j - 1].DT;
              // ��������
              ArrayData[j, 3] := ExpDataArr[j - 1].Val;
            end;
            // ����� ����� ������ �� ��������� ����
            Cell1 := Sheet.Cells[BeginRow, BeginCol];
            Cell2 := Sheet.Cells[BeginRow + RowCount - 1,
              BeginCol + ColCount - 1];
            Range := Sheet.Range[Cell1, Cell2];
            Range.Value := ArrayData;
            Sheet.Name := Trim(IVK_DM.tbTags.FieldByName('Logging_Name')
              .AsString);
            AddLog(mLog, '������ ��������!');
            // ���������
            sdResult.DefaultExt := 'xls';
            Book.SaveAs(sdResult.FileName, xlWorkbookNormal);
            AddLog(mLog, '���� ��������!');
            // �������
            Excel.Quit;
            AddLog(mLog, '������ Excel ���������');
          end
          else
          // ���� ������� �������������� ����
          begin
            sdResult.DefaultExt := 'msr';
            // ��������� ����������
            AssignFile(ExpDataFile, sdResult.FileName);
            // ��������� �� ������
            Rewrite(ExpDataFile);
            // ���������� ������ � ����
            for i := 0 to RowCount - 1 do
              Write(ExpDataFile, ExpDataArr[i]);
            AddLog(mLog, '������ ��������!');
            // ��������� ����
            CloseFile(ExpDataFile);
            AddLog(mLog, '���� ��������!');
          end;
          AddLog(mLog, '������� ������ ��������!');
        end
        else
          // ��������, ��� � ��������� ���������� ��� ������
          AddLog(mLog, '��������� �������� ��� ������! ����������.');
      end;
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
    on E: EVariantError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������:' + #10#13 + E.Message),
        '������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
      if Excel <> varEmpty then
        Excel.Quit;
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
    TableCountSingle := IVK_DM.tbTWX_GLOBAL.FieldByName('Tables_Number')
      .AsInteger;
    TablesNameSingle := Trim(IVK_DM.tbTWX_GLOBAL.FieldByName('Table_Name')
      .AsString);
    // qGetTabCount.SQL[2] := 'Table_Tags=''' + IVK_DM.tbTWX_GLOBAL.FieldByName
    // ('Table_Tags').AsString + '''';
    if IVK_DM.tbTags.RecordCount > 0 then
    // ���� � ��������� ������ ���� ����
    begin
      btExtract.Enabled := True;
      btView.Enabled := True;
      btPlot.Enabled := True;
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

{ === ���������� ������ �� ��������� ���������� ������� �� ���������� === }
procedure TfmMain.btPlotClick(Sender: TObject);
var
  i, j: integer; // �������
begin
  // ������� ��� �������
  fmChart.chPreview.SeriesList.Clear;
  // ���������� �������
  fmChart.chPreview.Legend.Visible := True;
  if IVK_DM.tbSignalList.RecordCount > 0 then
  // ���� � ������ ���� ��������� ���������, �� ������ �� ���
  begin
    IVK_DM.tbSignalList.First;
    for i := 0 to IVK_DM.tbSignalList.RecordCount - 1 do
    // ��� ������� ���������
    begin
      // ������� ������;
      ExtractData(IVK_DM.tbSignalList.FieldByName('Tag_Index').AsInteger,
        IVK_DM.tbSignalList.FieldByName('Table_Name').AsString,
        IVK_DM.tbSignalList.FieldByName('Tables_Number').AsInteger);
      // ������������� � ������ � ���������������
      MakeDataArr(True);
      // ��������� ������
      fmChart.chPreview.AddSeries(TLineSeries);
      fmChart.chPreview.Series[i].XValues.DateTime := True;
      // ��������
      fmChart.chPreview.Series[i].Title := IVK_DM.tbSignalList.FieldByName
        ('Logging_Name').AsString;
      // ���������
      if qForExport.RecordCount > 0 then
        // ���� ������ ����
        for j := 0 to Length(ExpDataArr) - 1 do
          // ��������� ��� �������� �� ������
          fmChart.chPreview.Series[i].AddXY(ExpDataArr[j].DT, ExpDataArr[j].Val)
      else
        // ����� ��������
        AddLog(mLog, '��������� �������� ��� ������! ����������.');
      // ��������� ��������
      IVK_DM.tbSignalList.Next;
    end;
  end
  else
  // ���� ���������� � ������ ���, ���������� ������ ���������.
  begin
    // ������ ������
    ExtractData(IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
      TablesNameSingle, TableCountSingle);
    // ������������� � ������ � ���������������
    MakeDataArr(True);
    // ������ �������
    fmChart.chPreview.Legend.Visible := False;
    // ��������� ������
    fmChart.chPreview.AddSeries(TLineSeries);
    // ��������
    fmChart.chPreview.Series[0].Title := IVK_DM.tbSignalList.FieldByName
      ('Logging_Name').AsString;
    fmChart.chPreview.Series[0].XValues.DateTime := True;
    // ���������
    if qForExport.RecordCount > 0 then
      // ���� ������ ����
      for j := 0 to Length(ExpDataArr) - 1 do
        // ��������� ��� �������� �� ������
        fmChart.chPreview.Series[0].AddXY(ExpDataArr[j].DT, ExpDataArr[j].Val)
    else
      // ����� ��������
      AddLog(mLog, '��������� �������� ��� ������! ����������.');
  end;
  // ���������� ����� � ���������
  fmChart.ShowModal;
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
  ExtractData(IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger,
    TablesNameSingle, TableCountSingle);
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
