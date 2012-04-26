unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, shlobj, ExtCtrls, IniFiles, ComObj;

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

implementation

uses
  unAdvSettings;

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
  SetFileFirst, SetFileSeconf: TStringList;
  i: integer;
begin
  try
    if FileExists(ExtractFilePath(Application.ExeName) + 'tarconv.ini') then
    begin
      if FileExists(leTarFile.Text) then
      begin
        // ������� ����� �������
        TarFileXLS := CreateOleObject('Excel.Application');
        // ������� � ��������
        TarFileXLS.DisplayAlerts := False;
        // ��������� ���������
        TarFileXLS.WorkBooks.Add(leTarFile.Text);
        Book := TarFileXLS.WorkBooks.Item[1];
        Sheet := TarFileXLS.WorkBooks.Item[1].Worksheets.Item[1];
        // ������� TStringList-� ��� ���������� ������
        SetFileFirst := TStringList.Create;
        SetFileSeconf := TStringList.Create;
        // ���������
        SetFileFirst.Add(TarXMLHead);
        SetFileSeconf.Add(TarXMLHead);
        // ������ ��������� �������� �� ini-�����
        SetFileFirst.Add('<filters>' + #10#13 + '<FiltersConf>');
        SetFileSeconf.Add('<filters>' + #10#13 + '<FiltersConf>');
        // 1-� ������ ��������
        // ���������
        SetFileFirst.Add('<aperture>' + iniset.ReadString('Filters',
          'P1Aperture', '0') + '</aperture>');
        SetFileSeconf.Add('<aperture>' + iniset.ReadString('Filters',
          'P1Aperture', '0') + '</aperture>');
        // ���������
        SetFileFirst.Add('<median>' + iniset.ReadString('Filters', 'P1Median',
          '1') + '</median>');
        SetFileSeconf.Add('<median>' + iniset.ReadString('Filters', 'P1Median',
          '1') + '</median>');
        // ��������
        SetFileFirst.Add('<kalman>' + iniset.ReadString('Filters', 'P1Median',
          '1') + '</kalman>');
        SetFileSeconf.Add('<kalman>' + iniset.ReadString('Filters', 'P1Median',
          '1') + '</kalman>');
        // �������
        SetFileFirst.Add('</FiltersConf>' + #10#13 + '<FiltersConf>');
        SetFileSeconf.Add('</FiltersConf>' + #10#13 + '<FiltersConf>');
        // 2-� ������ ��������
        // ���������
        SetFileFirst.Add('<aperture>' + iniset.ReadString('Filters',
          'P2Aperture', '0') + '</aperture>');
        SetFileSeconf.Add('<aperture>' + iniset.ReadString('Filters',
          'P2Aperture', '0') + '</aperture>');
        // ���������
        SetFileFirst.Add('<median>' + iniset.ReadString('Filters', 'P2Median',
          '1') + '</median>');
        SetFileSeconf.Add('<median>' + iniset.ReadString('Filters', 'P2Median',
          '1') + '</median>');
        // ��������
        SetFileFirst.Add('<kalman>' + iniset.ReadString('Filters', 'P2Median',
          '1') + '</kalman>');
        SetFileSeconf.Add('<kalman>' + iniset.ReadString('Filters', 'P2Median',
          '1') + '</kalman>');
        // �������
        SetFileFirst.Add('</FiltersConf>' + #10#13 + '<FiltersConf>');
        SetFileSeconf.Add('</FiltersConf>' + #10#13 + '<FiltersConf>');
        // ������ �����������
        // ���������
        SetFileFirst.Add('<aperture>' + iniset.ReadString('Filters',
          'TAperture', '0') + '</aperture>');
        SetFileSeconf.Add('<aperture>' + iniset.ReadString('Filters',
          'TAperture', '0') + '</aperture>');
        // ���������
        SetFileFirst.Add('<median>' + iniset.ReadString('Filters', 'TMedian',
          '1') + '</median>');
        SetFileSeconf.Add('<median>' + iniset.ReadString('Filters', 'TMedian',
          '1') + '</median>');
        // ��������
        SetFileFirst.Add('<kalman>' + iniset.ReadString('Filters', 'TMedian',
          '1') + '</kalman>');
        SetFileSeconf.Add('<kalman>' + iniset.ReadString('Filters', 'TMedian',
          '1') + '</kalman>');
        // �������
        SetFileFirst.Add('</FiltersConf>' + #10#13 + '</filters>');
        SetFileSeconf.Add('</FiltersConf>' + #10#13 + '</filters>');
        // ������������ �������
        // 1-� ������ ��������
        // ���������
        SetFileFirst.Add('<tables>' + #10#13 + '<CalibrationTable>' + #10#13 +
          '<rows>');
        SetFileSeconf.Add('<tables>' + #10#13 + '<CalibrationTable>' + #10#13 +
          '<rows>');
        // ������ ��������� ������� ��� ������� � ������� �����
        for i := 4 to 11 do
        begin
          // ��������!
        end;

        // SetFileFirst.SaveToFile(leFolder.Text+'\'+lePrefix.Text+'.set');
        // �� ���������
        SetFileFirst.Free;
        SetFileSeconf.Free;
        TarFileXLS.Quit;
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
    end;
    on E: EIniFileException do
      MessageBox(Self.Handle, Pchar('�� ������� ���������� ���� ��������.' +
        #10#13 + E.Message), '������ ������ ��������!', MB_OK or MB_ICONERROR);
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
