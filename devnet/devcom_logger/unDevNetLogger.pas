unit unDevNetLogger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DevNetDec, StdCtrls, mmsystem, ExtCtrls, XPMan, DB,
  ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  ZAbstractConnection, ZConnection, Grids, DBGrids, Menus;

type
  TfmDevNetLogger = class(TForm)
    TimerDevNet: TTimer;
    gbButtons: TGroupBox;
    btZero: TButton;
    btTara: TButton;
    btUnZero: TButton;
    btUnTara: TButton;
    XPManifest1: TXPManifest;
    ZConnection: TZConnection;
    ztbWeight: TZTable;
    ztbMeasure: TZTable;
    mmDevNet: TMainMenu;
    mDevNetServer: TMenuItem;
    mPortDlg: TMenuItem;
    mParamDlg: TMenuItem;
    mSelectDevDlg: TMenuItem;
    mShowHide: TMenuItem;
    N2: TMenuItem;
    mExit: TMenuItem;
    edNett: TEdit;
    lbDiscret: TLabel;
    N3: TMenuItem;
    mMeas: TMenuItem;
    N4: TMenuItem;
    mConnect: TMenuItem;
    mScales: TMenuItem;
    mOpenPort: TMenuItem;
    mClosePort: TMenuItem;
    mDisconnect: TMenuItem;
    eTemp: TEdit;
    gmMeasure: TGroupBox;
    gbResult: TGroupBox;
    lTime: TLabel;
    lDiff: TLabel;
    lUd: TLabel;
    btStop: TButton;
    btStart: TButton;
    leMeasure: TLabeledEdit;
    pMeasure: TPanel;
    procedure btConnectClick(Sender: TObject);
    procedure btPortDlgClick(Sender: TObject);
    procedure btParamDlgClick(Sender: TObject);
    procedure btSelectDevDlgClick(Sender: TObject);
    procedure btShowHideClick(Sender: TObject);
    procedure btOpenPortClick(Sender: TObject);
    procedure TimerDevNetTimer(Sender: TObject);
    procedure btDisconnectClick(Sender: TObject);
    procedure btClosePortClick(Sender: TObject);
    procedure btZeroClick(Sender: TObject);
    procedure btTaraClick(Sender: TObject);
    procedure btBNClick(Sender: TObject);
    procedure btUnZeroClick(Sender: TObject);
    procedure btUnTaraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btStartClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure mExitClick(Sender: TObject);
    procedure mMeasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MMTimer1: integer; // Код мультимедийного таймера
  end;

  procedure GetWeightFromDevNet(TypeWeight: Byte; Edit: TEdit);
  procedure TimerCallBackProg(uTimerID, uMessage: UINT;
      dwUser, dw1, dw2: DWORD); stdcall;

var
  fmDevNetLogger: TfmDevNetLogger;


implementation

uses
  ComObj, unArchive, MyFunctions;

var
  DevNet: OleVariant; // Объект OLE
  MeasureArr, BeginArr:array[0..2] of real; // Массив измерений
  bBegin, bEnd, bMes:boolean; // Флаги
  TickCount:Integer; // Время
  MeasID:Integer; // ID замера
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
//      ShowMessage('Вроде как подключились.');
      // Версия сервера
      fmDevNetLogger.Caption:='Клиент для Devnet '+DevNet.GetVersion;
      // Включаем кнопки
      mPortDlg.Enabled:=True;
      mParamDlg.Enabled:=True;
      mSelectDevDlg.Enabled:=True;
      mShowHide.Enabled:=True;
      mOpenPort.Enabled:=True;
      mConnect.Enabled:=False;
      mDisconnect.Enabled:=True;
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

{ === Показать/скрыть окно сервера === }
procedure TfmDevNetLogger.btShowHideClick(Sender: TObject);
begin
  DevNet.Visible:=(NOT DevNet.Visible);
end;

{ === Открытие порта и запуск опроса === }
procedure TfmDevNetLogger.btOpenPortClick(Sender: TObject);
begin
  If DevNet.OpenPort then
  // Если сервер достучался до весов
  begin
//  ShowMessage('Порт открыт!');
    // Запускаем таймер
    //MMTimer1 := timeSetEvent(500, 10, @TimerCallBackProg, 100, TIME_PERIODIC);
    TimerDevNet.Enabled:=True;
    // Переключаем кнопки
    mOpenPort.Enabled:=False;
    mClosePort.Enabled:=True;
    btStart.Enabled:=True;
    btZero.Enabled:=True;
    btTara.Enabled:=True;
    btUnZero.Enabled:=True;
    btUnTara.Enabled:=True;
  end
  // Иначе ругаемся
  else ShowMessage('Не удалось открыть порт!');
end;

// Получение значение веса и вывод на форму
procedure GetWeightFromDevNet(TypeWeight:Byte; Edit: TEdit);
var
  MaxRange: Byte;
  Discret, D: Double;
  PntPos: Byte;
  WeightVal: Double;
  Flags0: Byte;
  ErrState: Byte;
  Reserve1, Reserve2, Reserve3: Byte;
  VariantVar: OleVariant;
  IsOK: Boolean;
begin
  // Получение необходимых параметров
  if DevNet.GetConstant(1, M06A_MaxRange, VariantVar) then
    MaxRange := VariantVar
  else
    MaxRange := 0;
  if DevNet.GetConstant(1, M06A_PntPos, VariantVar) then
    PntPos := VariantVar
  else
    PntPos := 3;
  if DevNet.GetConstant(1, M06A_Discret + MaxRange,
    VariantVar) then
    Discret := VariantVar
  else
    Discret := 0.001;
  MeasureArr[TypeWeight]:=0;
  // Отвечают ли весы
  IsOK := DevNet.GetWeight(1, TypeWeight, WeightVal, ErrState,
    Flags0, Reserve1, Reserve2, Reserve3);
  // Проверка на ошибки
  if IsOK and (ErrState = 0) then
  begin
    Edit.Color := clGreen;
    Edit.Font.Color := clYellow;
    // Установка точности
    D := Discret;
    if WeightVal > 2000 * D then
      D := 3 * Discret
    else if WeightVal > 500 * D then
      D := 2 * Discret;
    // Вывод веса
    Edit.Text := Format('%7.*f', [PntPos, WeightVal]);
    MeasureArr[TypeWeight]:=WeightVal;
    // Вывод точности
    fmDevNetLogger.lbDiscret.Caption := '+/- ' + Format('%5.*f', [PntPos, D]) + ' кг'; // По ГОСТу
  end
  else
  // Вывод ошибки
  begin
    Edit.Color := clBlack;
    Edit.Font.Color := clRed;
    if IsOK then
      Edit.Text := 'Err ' + Format('%2d', [ErrState])
    else
      Edit.Text := '--------';
    fmDevNetLogger.lbDiscret.Caption := '';
  end;
end;

{ === Периодический опрос весов === }
procedure TimerCallBackProg(uTimerID, uMessage: UINT;
  dwUser, dw1, dw2: DWORD); stdcall;
begin
//  GetWeightFromDevNet(M06A_Brutto, fmDevNetLogger.edGross);
end;

{ === Таймер === }
procedure TfmDevNetLogger.TimerDevNetTimer(Sender: TObject);
var
  CurTime:real; // Время
  Diff:real; // Разница показаний
begin
  // Получаем данные
  GetWeightFromDevNet(M06A_Brutto, fmDevNetLogger.eTemp);
  GetWeightFromDevNet(M06A_Netto, fmDevNetLogger.edNett);
  GetWeightFromDevNet(M06A_Tare, fmDevNetLogger.eTemp);
  // Обработка флагов
  // Если только начали замер
  if bBegin=True then
  begin
    bBegin:=False;
    TickCount:=GetTickCount;
    // Запись названия в таблицу
    ztbMeasure.AppendRecord([NULL, Now, 0.0, leMeasure.Text,NULL]);
    ztbMeasure.Last;
    MeasID:=ztbMeasure.FieldByName('id').AsInteger;
    BeginArr[M06A_Brutto]:=MeasureArr[M06A_Brutto];
    BeginArr[M06A_Netto]:=MeasureArr[M06A_Netto];
    BeginArr[M06A_Tare]:=MeasureArr[M06A_Tare];
    lDiff.Caption:='';
    lUd.Caption:='';
  end;
  // Если замер идет
  if bMes=True then
  begin
    CurTime:=(GetTickCount-TickCount)/1000;
    ztbWeight.AppendRecord([NULL,Now,MeasureArr[M06A_Brutto],MeasureArr[M06A_Netto],MeasureArr[M06A_Tare],MeasID]);
    lTime.Caption:='Время: '+FloatToStr((GetTickCount-TickCount)/1000)+' сек.';
    Diff:=Abs(BeginArr[M06A_Brutto]-MeasureArr[M06A_Brutto]);
    lDiff.Caption:='Разница: '+FloatToStr(Diff);
    if CurTime<>0 then
    lUd.Caption:='Часовой: '+Format('%.3f',[(Diff/CurTime*3600)]);
  end;
  // Если замер закончился
  if bEnd=True then
  begin
    bEnd:=False;
    CurTime:=(GetTickCount-TickCount)/1000;
    ztbWeight.AppendRecord([NULL,Now,MeasureArr[M06A_Brutto],MeasureArr[M06A_Netto],MeasureArr[M06A_Tare],MeasID]);
    ztbMeasure.Edit;
    ztbMeasure.FieldByName('stop').AsDateTime:=Now;
    ztbMeasure.FieldByName('mtime').AsFloat:=CurTime;
    ztbMeasure.Post;
    lTime.Caption:='Время: '+FloatToStr(CurTime)+' сек.';
    Diff:=Abs(BeginArr[M06A_Brutto]-MeasureArr[M06A_Brutto]);
    lDiff.Caption:='Разница: '+FloatToStr(Diff);
    lUd.Caption:='Часовой: '+Format('%.3f',[(Diff/CurTime*3600)]);
    ReopenDatasets([fmArchive.ztMeasArchive]);
  end;
end;

{ === Остановить опрос, закрыть порт и убить сервер === }
procedure TfmDevNetLogger.btDisconnectClick(Sender: TObject);
begin
  TimerDevNet.Enabled:=False;
  btClosePortClick(Self);
  fmDevNetLogger.Caption:='Клиент для DevNet';
  DevNet:=Unassigned;
  mPortDlg.Enabled:=False;
  mParamDlg.Enabled:=False;
  mSelectDevDlg.Enabled:=False;
  mShowHide.Enabled:=False;
  mOpenPort.Enabled:=False;
  mClosePort.Enabled:=False;
  mConnect.Enabled:=True;
  mDisconnect.Enabled:=False;
end;

{ === Закрытие порта === }
procedure TfmDevNetLogger.btClosePortClick(Sender: TObject);
begin
  TimerDevNet.Enabled:=False;
  DevNet.ClosePort;
  mOpenPort.Enabled:=True;
  mClosePort.Enabled:=False;
  edNett.Text:='';
  edNett.Color:=clBlack;
  btStart.Enabled:=False;
  btStop.Enabled:=False;
  btZero.Enabled:=False;
  btTara.Enabled:=False;
//  btBN.Enabled:=False;
  btUnZero.Enabled:=False;
  btUnTara.Enabled:=False;
end;

{ === Нажать кнопку установки нуля === }
procedure TfmDevNetLogger.btZeroClick(Sender: TObject);
begin
  DevNet.SetToZero(1);
end;

{ === Нажать кнопку установки веса тары === }
procedure TfmDevNetLogger.btTaraClick(Sender: TObject);
begin
  DevNet.TakeToTare(1);
end;

{ === Нажать кнопку режима отображения === }
procedure TfmDevNetLogger.btBNClick(Sender: TObject);
begin
  DevNet.SelectMode(1);
end;

{ === Отмена у становки нуля === }
procedure TfmDevNetLogger.btUnZeroClick(Sender: TObject);
begin
  DevNet.UndoZero(1);
end;

{ === Отмена установки веса тары === }
procedure TfmDevNetLogger.btUnTaraClick(Sender: TObject);
begin
  DevNet.UndoTare(1);
end;

{ === Настройка формы при запуске === }
procedure TfmDevNetLogger.FormShow(Sender: TObject);
var
  dbfile: TFileName;
begin
  dbfile := ExtractFilePath(Application.ExeName) + 'devnet_log.sqlite';
  if NOT(FileExists(dbfile)) then
  begin
    MessageBox(Self.Handle, 'База данных не найдена!' , 'Ошибка!',
      MB_OK or MB_ICONERROR);
    Application.Terminate;
  end
  else
  begin
    ZConnection.Database := dbfile;
    ZConnection.Connect;
    ztbWeight.Open;
    ztbMeasure.Open;
  end;
end;

{ === Запуск === }
procedure TfmDevNetLogger.btStartClick(Sender: TObject);
begin
  // Выставляем нужные флаги для таймера
  bBegin:=True;
  bMes:=True;
  // Индикация
  pMeasure.Font.Color:=clRed;
  fmDevNetLogger.Repaint;
  pMeasure.Caption:='ЗАМЕР';
  btStart.Enabled:=False;
  btStop.Enabled:=True;
end;

{ === Остановка === }
procedure TfmDevNetLogger.btStopClick(Sender: TObject);
begin
  // Выставляем нужные флаги для таймера
  bEnd:=True;
  bMes:=False;
  // Индикация
  pMeasure.Font.Color:=clWindowText;
  pMeasure.Caption:='Нет замера';
  btStart.Enabled:=True;
  btStop.Enabled:=False;
end;

{ === Выход === }
procedure TfmDevNetLogger.mExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfmDevNetLogger.mMeasClick(Sender: TObject);
begin
  fmArchive.Show;
end;

end.
