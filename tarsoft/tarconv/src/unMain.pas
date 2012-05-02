unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, shlobj, ExtCtrls, IniFiles, ComObj, MyFunctions;

type
  TfmMain = class(TForm)
    odXLSFile: TOpenDialog;
    btConver: TButton;
    leFolder: TLabeledEdit;
    Label1: TLabel;
    lePrefix: TLabeledEdit;
    leTarFile: TLabeledEdit;
    btTarFile: TButton;
    Label2: TLabel;
    btAdvSettings: TButton;
    Label3: TLabel;
    btConvert: TButton;
    cbSaveSettings: TCheckBox;
    procedure btConverClick(Sender: TObject);
    procedure btAdvSettingsClick(Sender: TObject);
    procedure btTarFileClick(Sender: TObject);
    procedure btConvertClick(Sender: TObject);
    procedure ConvertFile;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  iniset: TIniFile;

const
  TarXMLHead = '<?xml version="1.0"?>' + #10#13 +
    '<Settings xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
    ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' + #10#13 +
    '<version>33817089</version>';
  TarDTS = '<CalibrationTable><rows><TableRow><H>4</H><V>-46</V></TableRow>' +
    '<TableRow><H>20</H><V>100</V></TableRow></rows></CalibrationTable>';

implementation

uses unAdvSettings, unViewDebug;

{$R *.dfm}

procedure TfmMain.btAdvSettingsClick(Sender: TObject);
begin
  fmAdvSettings.ShowModal;
end;

procedure TfmMain.btConverClick(Sender: TObject);

var
  Dir: array [0 .. MAX_PATH] of char;
  BrInfo: BROWSEINFO;
  lpItemID: PItemIDList;
begin
  // ����������� ����������� ������� ������ �����
  ZeroMemory(@BrInfo, sizeof(BrInfo));
  BrInfo.hwndOwner := Self.Handle;
  BrInfo.lpszTitle :=
    '�������� �����, � ������� ����� �������� ����� ��������:';
  BrInfo.ulFlags := BIF_EDITBOX or BIF_RETURNONLYFSDIRS or
    BIF_RETURNFSANCESTORS;
  // �������� ������ ������ �����
  lpItemID := SHBrowseForFolder(BrInfo);
  // ���� ����� ���� �������, �� �������� ���������
  if lpItemID <> nil then
  begin
    SHGetPathFromIDList(lpItemID, Dir);
    GlobalFreePtr(lpItemID);
    // ���������, ���� ���� ������ ��������� �����
    if Dir = '' then
      ShowMessage('� ���������� ����� ������ ��������� �����!')
    else
      leFolder.Text := Dir;
  end;
end;

procedure TfmMain.btConvertClick(Sender: TObject);
begin
  try
    if cbSaveSettings.Checked = True then
    begin
      ConvertFile;
      iniset := TIniFile.Create(ExtractFilePath(Application.ExeName) +
        'tarconv.ini');
      iniset.WriteString('Main', 'Savedir', leFolder.Text);
      iniset.WriteString('Main', 'Prefix', lePrefix.Text);
      iniset.Free;
    end
    else
      ConvertFile;
  except
    on E: EIniFileException do
    begin
      MessageBox(Self.Handle, Pchar('�� ������� ��������� ���� ��������.' +
        #10#13 + E.Message), '������ ����������!', MB_OK or MB_ICONERROR);
      iniset.Free;
    end;
  end;
end;

// ����������� �����
procedure TfmMain.ConvertFile;

var
  TarFileXLS, Book, Sheet: variant;
  SetFileFirst, SetFileSecond: TStringList;
  i: integer;
  FileFirstNum, FileSecondNum: string;
begin
  try
    if FileExists(ExtractFilePath(Application.ExeName) + 'tarconv.ini') then
    begin
      if FileExists(leTarFile.Text) then
      begin
        // ������� TStringList-� ��� ���������� ������
        SetFileFirst := TStringList.Create;
        SetFileFirst.Clear;
        SetFileSecond := TStringList.Create;
        SetFileSecond.Clear;
        // ������� ����� �������
        TarFileXLS := CreateOleObject('Excel.Application');
        // ������� � ��������
        TarFileXLS.DisplayAlerts := False;
        // ��������� ���������
        TarFileXLS.WorkBooks.Add(leTarFile.Text);
        Book := TarFileXLS.WorkBooks.Item[1];
        Sheet := TarFileXLS.WorkBooks.Item[1].Worksheets.Item[1];
        iniset := TIniFile.Create(ExtractFilePath(Application.ExeName) +
          'tarconv.ini');
        // ���������
        SetFileFirst.Add(TarXMLHead);
        SetFileSecond.Add(TarXMLHead);
        // ������ ��������� �������� �� ini-�����
        SetFileFirst.Add('<filters>' + #10#13 + '<FiltersConf>');
        SetFileSecond.Add('<filters>' + #10#13 + '<FiltersConf>');
        // 1-� ������ ��������
        // ���������
        SetFileFirst.Add('<aperture>' + iniset.ReadString('Filters',
          'P1Aperture', '0') + '</aperture>');
        SetFileSecond.Add('<aperture>' + iniset.ReadString('Filters',
          'P1Aperture', '0') + '</aperture>');
        // ���������
        SetFileFirst.Add('<median>' + iniset.ReadString('Filters', 'P1Median',
          '1') + '</median>');
        SetFileSecond.Add('<median>' + iniset.ReadString('Filters', 'P1Median',
          '1') + '</median>');
        // ��������
        SetFileFirst.Add('<kalman>' + iniset.ReadString('Filters', 'P1Median',
          '1') + '</kalman>');
        SetFileSecond.Add('<kalman>' + iniset.ReadString('Filters', 'P1Median',
          '1') + '</kalman>');
        // �������
        SetFileFirst.Add('</FiltersConf>' + #10#13 + '<FiltersConf>');
        SetFileSecond.Add('</FiltersConf>' + #10#13 + '<FiltersConf>');
        // 2-� ������ ��������
        // ���������
        SetFileFirst.Add('<aperture>' + iniset.ReadString('Filters',
          'P2Aperture', '0') + '</aperture>');
        SetFileSecond.Add('<aperture>' + iniset.ReadString('Filters',
          'P2Aperture', '0') + '</aperture>');
        // ���������
        SetFileFirst.Add('<median>' + iniset.ReadString('Filters', 'P2Median',
          '1') + '</median>');
        SetFileSecond.Add('<median>' + iniset.ReadString('Filters', 'P2Median',
          '1') + '</median>');
        // ��������
        SetFileFirst.Add('<kalman>' + iniset.ReadString('Filters', 'P2Median',
          '1') + '</kalman>');
        SetFileSecond.Add('<kalman>' + iniset.ReadString('Filters', 'P2Median',
          '1') + '</kalman>');
        // �������
        SetFileFirst.Add('</FiltersConf>' + #10#13 + '<FiltersConf>');
        SetFileSecond.Add('</FiltersConf>' + #10#13 + '<FiltersConf>');
        // ������ �����������
        // ���������
        SetFileFirst.Add('<aperture>' + iniset.ReadString('Filters',
          'TAperture', '0') + '</aperture>');
        SetFileSecond.Add('<aperture>' + iniset.ReadString('Filters',
          'TAperture', '0') + '</aperture>');
        // ���������
        SetFileFirst.Add('<median>' + iniset.ReadString('Filters', 'TMedian',
          '1') + '</median>');
        SetFileSecond.Add('<median>' + iniset.ReadString('Filters', 'TMedian',
          '1') + '</median>');
        // ��������
        SetFileFirst.Add('<kalman>' + iniset.ReadString('Filters', 'TMedian',
          '1') + '</kalman>');
        SetFileSecond.Add('<kalman>' + iniset.ReadString('Filters', 'TMedian',
          '1') + '</kalman>');
        // �������
        SetFileFirst.Add('</FiltersConf>' + #10#13 + '</filters>' + #10#13 +
          '<tables>');
        SetFileSecond.Add('</FiltersConf>' + #10#13 + '</filters>' + #10#13 +
          '<tables>');
        // ������������ �������
        // 1-� ������ ��������
        // ���������
        SetFileFirst.Add('<CalibrationTable>' + #10#13 + '<rows>');
        SetFileSecond.Add('<CalibrationTable>' + #10#13 + '<rows>');
        // ������ ��������� ������� ��� ������� � ������� �����
        for i := 4 to 11 do
        begin
          // ���������
          SetFileFirst.Add('<TableRow>');
          SetFileSecond.Add('<TableRow>');
          // ������ ��������
          SetFileFirst.Add('<H>' + string(Sheet.Cells[i, 1].Value) + '</H>');
          SetFileSecond.Add('<H>' + string(Sheet.Cells[i, 5].Value) + '</H>');
          SetFileFirst.Add('<V>' + string(Sheet.Cells[i, 2].Value) + '</V>');
          SetFileSecond.Add('<V>' + string(Sheet.Cells[i, 6].Value) + '</V>');
          // ����������� ���
          SetFileFirst.Add('</TableRow>');
          SetFileSecond.Add('</TableRow>');
        end;
        // ��������� ������������ ������� 1-�� �������
        SetFileFirst.Add('</rows>' + #10#13 + '</CalibrationTable>');
        SetFileSecond.Add('</rows>' + #10#13 + '</CalibrationTable>');
        // 2-� ������ ��������
        // ���������
        SetFileFirst.Add('<CalibrationTable>' + #10#13 + '<rows>');
        SetFileSecond.Add('<CalibrationTable>' + #10#13 + '<rows>');
        // ������ ��������� ������� ��� ������� � ������� �����
        for i := 4 to 11 do
        begin
          // ���������
          SetFileFirst.Add('<TableRow>');
          SetFileSecond.Add('<TableRow>');
          // ������ ��������
          SetFileFirst.Add('<H>' + string(Sheet.Cells[i, 3].Value) + '</H>');
          SetFileSecond.Add('<H>' + string(Sheet.Cells[i, 7].Value) + '</H>');
          SetFileFirst.Add('<V>' + string(Sheet.Cells[i, 4].Value) + '</V>');
          SetFileSecond.Add('<V>' + string(Sheet.Cells[i, 8].Value) + '</V>');
          // ����������� ���
          SetFileFirst.Add('</TableRow>');
          SetFileSecond.Add('</TableRow>');
        end;
        // ��������� ������������ ������� 2-�� �������
        SetFileFirst.Add('</rows>' + #10#13 + '</CalibrationTable>');
        SetFileSecond.Add('</rows>' + #10#13 + '</CalibrationTable>');
        // ��������� ���
        SetFileFirst.Add(TarDTS);
        SetFileSecond.Add(TarDTS);
        // ��������� ����
        iniset := TIniFile.Create(ExtractFilePath(Application.ExeName) +
          'tarconv.ini');
        // ���������
        SetFileFirst.Add('<CalibrationTable>' + #10#13 + '<rows>');
        SetFileSecond.Add('<CalibrationTable>' + #10#13 + '<rows>');
        for i := 1 to iniset.ReadInteger('Fuel', 'Pointscount', 0) do
        begin
          // ���������
          SetFileFirst.Add('<TableRow>');
          SetFileSecond.Add('<TableRow>');
          // ������ ��������
          SetFileFirst.Add('<H>' + iniset.ReadString('Fuel', 'H' + IntToStr(i),
            '0') + '</H>');
          SetFileSecond.Add('<H>' + iniset.ReadString('Fuel', 'H' + IntToStr(i),
            '0') + '</H>');
          SetFileFirst.Add('<V>' + iniset.ReadString('Fuel', 'V' + IntToStr(i),
            '0') + '</V>');
          SetFileSecond.Add('<V>' + iniset.ReadString('Fuel', 'V' + IntToStr(i),
            '0') + '</V>');
          // ����������� ���
          SetFileFirst.Add('</TableRow>');
          SetFileSecond.Add('</TableRow>');
        end;
        // ��������� ���������
        SetFileFirst.Add('</rows></CalibrationTable></tables>');
        SetFileSecond.Add('</rows></CalibrationTable></tables>');
        // ����� ������
        SetFileFirst.Add
          ('<arcFirst>60000</arcFirst><arcPeriod>60000</arcPeriod></Settings>');
        SetFileSecond.Add
          ('<arcFirst>60000</arcFirst><arcPeriod>60000</arcPeriod></Settings>');
        // ���������� ������
        FileFirstNum := ReplaceStr(string(Sheet.Cells[3, 1].Value), '-1', '');

        FileSecondNum := ReplaceStr(string(Sheet.Cells[3, 5].Value), '-1', '');
        SetFileFirst.SaveToFile(leFolder.Text + '\' + lePrefix.Text + ' ' +
          FileFirstNum + '.set');
        SetFileSecond.SaveToFile(leFolder.Text + '\' + lePrefix.Text + ' ' +
          FileSecondNum + '.set');
        // SetFileFirst.SaveToFile(leFolder.Text+'\'+lePrefix.Text+'.set');
        // �� ���������
        SetFileFirst.Free;
        SetFileSecond.Free;
        TarFileXLS.Quit;
        MessageBox(Self.Handle, '�������������� ���������.', '����������',
          MB_OK or MB_ICONINFORMATION);
      end
      else
        MessageBox(Self.Handle, Pchar('�� ������� ������� ����' + #10#13 +
          leTarFile.Text), '������ ������ � ������!',
          MB_OK or MB_ICONEXCLAMATION);
    end
    else
      MessageBox(Self.Handle, '���� �������� �� ������!', '������!',
        MB_OK or MB_ICONERROR);
  except
    on E: EOleError do
    begin
      MessageBox(Self.Handle, Pchar('������ ������ � XLS-������' + #10#13 +
        E.Message), '������ ������ � ������!', MB_OK or MB_ICONERROR);
      TarFileXLS.Quit;
      fmViewDebug.mFirst.Lines := SetFileFirst;
      fmViewDebug.mSecond.Lines := SetFileSecond;
      fmViewDebug.ShowModal;
    end;
    on E: EIniFileException do
    begin
      MessageBox(Self.Handle, Pchar('�� ������� ���������� ���� ��������.' +
        #10#13 + E.Message), '������ ������ ��������!', MB_OK or MB_ICONERROR);
      TarFileXLS.Quit;
      fmViewDebug.mFirst.Lines := SetFileFirst;
      fmViewDebug.mSecond.Lines := SetFileSecond;
      fmViewDebug.ShowModal;
    end;
    on E: EConvertError do
    begin
      MessageBox(Self.Handle, Pchar('������ �������������� ����� ������:' +
        #10#13 + E.Message + #10#13 + '��������� ���������� �����.'),
        '������ ������ � ������!', MB_OK or MB_ICONERROR);
      TarFileXLS.Quit;
      fmViewDebug.mFirst.Lines := SetFileFirst;
      fmViewDebug.mSecond.Lines := SetFileSecond;
      fmViewDebug.ShowModal;
    end;
  end;
end;

// �������� ��������
procedure TfmMain.FormShow(Sender: TObject);
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'tarconv.ini') then
  begin
    iniset := TIniFile.Create(ExtractFilePath(Application.ExeName) +
      'tarconv.ini');
    leFolder.Text := iniset.ReadString('Main', 'Savedir', '');
    lePrefix.Text := iniset.ReadString('Main', 'Prefix', '');
    iniset.Free;
  end;
end;

// ���������� ���� ��� ����� ���������
procedure TfmMain.btTarFileClick(Sender: TObject);
begin
  if odXLSFile.Execute then
    leTarFile.Text := odXLSFile.FileName;
end;

end.
