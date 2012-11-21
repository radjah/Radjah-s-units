unit uSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, sMaskEdit, sCustomComboEdit, sTooledit, IniFiles,
  Buttons, sBitBtn, StrUtils, MyFunctions;

type
  TfmSettings = class(TForm)
    deDefDir: TsDirectoryEdit;
    Label1: TLabel;
    Label2: TLabel;
    mePR: TsMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    btSave: TsBitBtn;
    btCancel: TsBitBtn;
    procedure btSaveClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSettings: TfmSettings;
  inifile:TIniFile;

implementation

{$R *.dfm}
{=== ���������� �������� ===}
procedure TfmSettings.btSaveClick(Sender: TObject);
begin
  // ����
  if deDefDir.Text='' then
  begin
    MessageBox(self.Handle, '���� �� ������!'+#09#13+
    '������������ ��������� ��-���������.','���������� ������!',
    MB_ICONWARNING+MB_OK);
    inifile.DeleteKey('settings','defpath');
  end else
  inifile.WriteString('settings','defpath',deDefDir.Text);
  // ������
  if strtoint(ReplaceStr(mePR.Text,' ','0'))<100 then
  begin
    MessageBox(self.Handle, '������ ������ ����������� ��� �����������!'+
    #09#13+'������������ ��������� ��-���������.','���������� ������!',
    MB_ICONWARNING+MB_OK);
    inifile.DeleteKey('settings','defpr');
  end else
  inifile.WriteString('settings','defpr',mePR.Text);
  inifile.Free;
  Close;
end;

procedure TfmSettings.btCancelClick(Sender: TObject);
begin
  inifile.Free;
  Close;
end;

{=== ������ �������� ===}
procedure TfmSettings.FormShow(Sender: TObject);
var
  str:ansistring;
begin
  str:=GetPath(Application.ExeName);
  inifile:=TIniFile.Create(str+'convset.ini');
  deDefDir.Text:=inifile.ReadString('settings','defpath','');
  mePR.Text:=inifile.ReadString('settings','defpr','');
end;

end.
