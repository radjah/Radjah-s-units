unit unDevNetLogger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DevNetDec, StdCtrls;

type
  TfmDevNetLogger = class(TForm)
    btConnect: TButton;
    leVersion: TLabel;
    gbSettings: TGroupBox;
    btPortDlg: TButton;
    btParamDlg: TButton;
    btSelectDevDlg: TButton;
    btList: TButton;
    procedure btConnectClick(Sender: TObject);
    procedure btPortDlgClick(Sender: TObject);
    procedure btParamDlgClick(Sender: TObject);
    procedure btSelectDevDlgClick(Sender: TObject);
    procedure btListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDevNetLogger: TfmDevNetLogger;


implementation

uses
  ComObj;

var
  DevNet: OleVariant;
{$R *.dfm}

{ === ����������� � ������� === }
procedure TfmDevNetLogger.btConnectClick(Sender: TObject);
begin
  // ������������ � �����������
  try
    DevNet := GetActiveOleObject('DevNet.Drv');
  except
  // ���� �� ������, �� ������� ����
  try
      DevNet := CreateOleObject('DevNet.Drv');
      // �������� ����
      DevNet.Visible:=False;
      // ��������
      ShowMessage('����� ��� ������������.');
      // ������ �������
      leVersion.Caption:=DevNet.GetVersion;
      // �������� ������
      btPortDlg.Enabled:=True;
      btParamDlg.Enabled:=True;
      btSelectDevDlg.Enabled:=True;
      btList.Enabled:=True;
  except
  // ������ �� �����
      ShowMessage
        ('������ ������������� DevNet.Drv �� ��������������� � Windows.' +
        #13#10 + '��� ����������� ��������� ���� DevNet.exe');
  end;
  end;
end;

{ === ��������� ����� === }
procedure TfmDevNetLogger.btPortDlgClick(Sender: TObject);
begin
  DevNet.SetPortDlg;
end;

{ === ��������� ������� === }
procedure TfmDevNetLogger.btParamDlgClick(Sender: TObject);
begin
  DevNet.SetParamDlg;
end;

{ === ����� �������� === }
procedure TfmDevNetLogger.btSelectDevDlgClick(Sender: TObject);
begin
  DevNet.SelectDevDlg;
end;

{ === ������ �������� === }
procedure TfmDevNetLogger.btListClick(Sender: TObject);
var
  DevList:string;
begin
  DevNet.GetDevList(DevList);
  ShowMessage(DevList);
end;

end.
