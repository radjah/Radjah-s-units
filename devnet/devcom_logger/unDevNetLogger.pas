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

{ === Подключение к серверу === }
procedure TfmDevNetLogger.btConnectClick(Sender: TObject);
begin
  // Подключаемся к запущенному
  try
    DevNet := GetActiveOleObject('DevNet.Drv');
  except
  // Если не смогли, то создаем свой
  try
      DevNet := CreateOleObject('DevNet.Drv');
      // Скрываем окно
      DevNet.Visible:=False;
      // Радуемся
      ShowMessage('Вроде как подключились.');
      // Версия сервера
      leVersion.Caption:=DevNet.GetVersion;
      // Включаем кнопки
      btPortDlg.Enabled:=True;
      btParamDlg.Enabled:=True;
      btSelectDevDlg.Enabled:=True;
      btList.Enabled:=True;
  except
  // Совсем всё плохо
      ShowMessage
        ('Сервер автоматизации DevNet.Drv не зарегистрирован в Windows.' +
        #13#10 + 'Для регистрации запустите файл DevNet.exe');
  end;
  end;
end;

{ === Настройка порта === }
procedure TfmDevNetLogger.btPortDlgClick(Sender: TObject);
begin
  DevNet.SetPortDlg;
end;

{ === Настройка сервера === }
procedure TfmDevNetLogger.btParamDlgClick(Sender: TObject);
begin
  DevNet.SetParamDlg;
end;

{ === Выбор приборов === }
procedure TfmDevNetLogger.btSelectDevDlgClick(Sender: TObject);
begin
  DevNet.SelectDevDlg;
end;

{ === Список приборов === }
procedure TfmDevNetLogger.btListClick(Sender: TObject);
var
  DevList:string;
begin
  DevNet.GetDevList(DevList);
  ShowMessage(DevList);
end;

end.
