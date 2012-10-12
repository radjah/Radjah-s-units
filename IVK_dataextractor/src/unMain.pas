unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, StdCtrls,
  unDataModule, ADODB, Grids, DBGrids, OleAuto, ComCtrls, MyFunctions,
  ExcelAddOns, unView;

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
    qGetTabCount: TADOQuery;
    qGetTabCountTables_Number: TIntegerField;
    qGetTabCountTable_Name: TStringField;
    qTempTable: TADOQuery;
    qClearTmp: TADOQuery;
    Label7: TLabel;
    mLog: TMemo;
    qForExport: TADOQuery;
    sdResult: TSaveDialog;
    btView: TButton;
    odConn: TOpenDialog;
    procedure btConnectClick(Sender: TObject);
    procedure btGetTagsClick(Sender: TObject);
    procedure btExtractClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btViewClick(Sender: TObject);
    procedure ExtractData;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.ExtractData;
var
  tabs, samples: integer; // �������
  timeshift: integer; // ����� ������� � �����
  tablename: string; // ������� ����� �������
  tabcount: integer; // ���������� ������ � �������
  samplecount: integer; // ���������� ������� � ����� ������
  sigidx: integer; // ������ �������
begin
  try
    samplecount := 36;
    timeshift := 4;
    // ��������� �������
    AddLog(mLog, '��������� ������������...');
    qGetTabCount.Open;
    tabcount := qGetTabCount.FieldByName('Tables_Number').AsInteger;
    tablename := qGetTabCount.FieldByName('Table_Name').AsString;
    sigidx := IVK_DM.tbTags.FieldByName('Tag_Index').AsInteger;
    // ���������� ����������
    qExtractor.Close;
    qExtractor.SQL.Clear;
    qClearTmp.ExecSQL;
    AddLog(mLog, '������� ��������� �������...');
    // ShowMessage('tabcount=' + IntToStr(tabcount) + #10#13 + 'tablename=' +
    // tablename + #10#13 + 'sigidx=' + IntToStr(sigidx));
    // ��������� �������
    AddLog(mLog, '������������ �������...');
    for tabs := 1 to tabcount do
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
        qExtractor.SQL.Add('FROM ' + Trim(tablename) + '_' + IntToStr(tabs));
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
      MessageBox(Self.Handle,
        pchar('�������� ������ ��� �����������/����������:' + #10#13 +
        E.Message), '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
    // ���� �� ������ ������� ���-��
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������ ��� ������ � �����:' +
        #10#13 + E.Message), '������ �����������/����������',
        MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
  end;
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
      // IVK_DM.connIVK_DB.Connected := false;
      btConnect.Caption := '���������';
      btExtract.Enabled := false;
      btGetTags.Enabled := false;
      btView.Enabled := false;
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
      AddLog(mLog, '��������� ������� �������.');
      btConnect.Caption := '���������';
      btGetTags.Enabled := True;
    end;
  except
    // ���� �� ������ �����������
    on E: EOleException do
    begin
      MessageBox(Self.Handle,
        pchar('�������� ������ ��� �����������/����������:' + #10#13 +
        E.Message), '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
    // ���� �� ������ ������� ���-��
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������ ��� ������ � �����:' +
        #10#13 + E.Message), '������ �����������/����������',
        MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
  end;
end;

{ === ����������� ������� � ���������� ������ === }
procedure TfmMain.btExtractClick(Sender: TObject);
var
  row: integer; // �������
  begTD, curTD: TDateTime; // ��� ��������� ���� � �������
  datasumm: real; // ���������� ��� ����� ��������
  datacount: integer; // ������� ��� ��������
  Excel, Book, Sheet: variant; // ���������� ��� Excel
begin
  try
    if sdResult.Execute then
    begin
      AddLog(mLog, '������� ������ �������...');
      ExtractData;
      // ������� ����� �������
      Excel := CreateOleObject('Excel.Application');
      // ������� � ��������
      Excel.DisplayAlerts := false;
      AddLog(mLog, '������ Excel ������');
      // ������ ����� �����
      Excel.WorkBooks.Add;
      Book := Excel.WorkBooks.Item[1];
      Excel.WorkBooks.Item[1].Worksheets.Add;
      Sheet := Excel.WorkBooks.Item[1].Worksheets.Item[1];
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
          // ID �������
          Sheet.Cells[row, 1].FormulaR1C1 := qForExport.FieldByName('SI')
            .AsInteger;
          // ����� ������
          Sheet.Cells[row, 2].FormulaR1C1 := begTD;
          // ��������
          Sheet.Cells[row, 3].FormulaR1C1 := datasumm / datacount;
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
      Sheet.Cells[row, 1].FormulaR1C1 := qForExport.FieldByName('SI').AsInteger;
      // ����� ������
      Sheet.Cells[row, 2].FormulaR1C1 := begTD;
      // ��������
      Sheet.Cells[row, 3].FormulaR1C1 := datasumm / datacount;
      AddLog(mLog, '������ ��������!');
      Book.SaveAs(sdResult.FileName, xlWorkbookNormal);
      AddLog(mLog, '���� ��������!');
      // �������
      Excel.Quit;
      AddLog(mLog, '������ Excel ���������');
      // qExtractor.SQL.SaveToFile('q.txt');
      AddLog(mLog, '������� ������ ��������!');
    end;
  except
    // ���� �� ������ �����������
    on E: EOleException do
    begin
      MessageBox(Self.Handle,
        pchar('�������� ������ ��� �����������/����������:' + #10#13 +
        E.Message), '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
    // ���� �� ������ ������� ���-��
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������ ��� ������ � �����:' +
        #10#13 + E.Message), '������ �����������/����������',
        MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
  end;
end;

{ === �������� ������ ����� � ��������� ������ === }
procedure TfmMain.btGetTagsClick(Sender: TObject);
begin
  try
    IVK_DM.tbTags.Close;
    IVK_DM.tbTags.tablename := IVK_DM.tbTWX_GLOBAL.FieldByName
      ('Table_Tags').AsString;
    IVK_DM.tbTags.Open;
    qGetTabCount.Close;
    qGetTabCount.SQL[2] := 'Table_Tags=''' + IVK_DM.tbTWX_GLOBAL.FieldByName
      ('Table_Tags').AsString + '''';
    if IVK_DM.tbTags.RecordCount > 0 then
    begin
      btExtract.Enabled := True;
      btView.Enabled := True;
    end
    else
    begin
      btExtract.Enabled := false;
      btView.Enabled := false;
    end;
  except
    // ���� �� ������ �����������
    on E: EOleException do
    begin
      MessageBox(Self.Handle,
        pchar('�������� ������ ��� �����������/����������:' + #10#13 +
        E.Message), '������ �����������/����������', MB_OK or MB_ICONERROR);
      AddLog(mLog, '������: ' + E.Message);
    end;
    // ���� �� ������ ������� ���-��
    on E: EADOError do
    begin
      MessageBox(Self.Handle, pchar('�������� ������ ��� ������ � �����:' +
        #10#13 + E.Message), '������ �����������/����������',
        MB_OK or MB_ICONERROR);
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
