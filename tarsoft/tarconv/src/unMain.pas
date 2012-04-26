unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, shlobj, ExtCtrls, IniFiles;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  iniset: TIniFile;

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
      iniset := TIniFile.Create(ExtractFilePath(Application.ExeName) +
        'tarconv.ini');
      iniset.WriteString('Main', 'Savedir', leFolder.Text);
      iniset.WriteString('Main', 'Prefix', lePrefix.Text);
      iniset.Free;
    end;
  except
    on E: EIniFileException do
      MessageBox(Self.Handle, Pchar('�� ������� ��������� ���� ��������.' +
        #10#13 + E.Message), '������ ����������!', MB_OK or MB_ICONERROR);
  end;

end;

// ���������� ���� ��� ����� ���������
procedure TfmMain.btTarFileClick(Sender: TObject);
begin
  if odXLSFile.Execute then
    leTarFile.Text := odXLSFile.FileName;
end;

end.
