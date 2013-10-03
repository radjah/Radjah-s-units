unit unDevNetLogger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DevNetDec, StdCtrls, mmsystem, ExtCtrls, XPMan, DB,
  ZAbstractRODataset, ZAbstractDataset, ZAbstractTable, ZDataset,
  ZAbstractConnection, ZConnection, Grids, DBGrids;

type
  TfmDevNetLogger = class(TForm)
    gbSettings: TGroupBox;
    btPortDlg: TButton;
    btParamDlg: TButton;
    btSelectDevDlg: TButton;
    btShowHide: TButton;
    gbData: TGroupBox;
    edGross: TEdit;
    edNett: TEdit;
    edTara: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbDiscret: TLabel;
    TimerDevNet: TTimer;
    gbButtons: TGroupBox;
    btZero: TButton;
    btTara: TButton;
    btBN: TButton;
    btUnZero: TButton;
    btUnTara: TButton;
    XPManifest1: TXPManifest;
    ZConnection: TZConnection;
    ztbWeight: TZTable;
    ztbMeasure: TZTable;
    pMeasure: TPanel;
    leMeasure: TLabeledEdit;
    btStart: TButton;
    btStop: TButton;
    gbBegin: TGroupBox;
    gbEnd: TGroupBox;
    leBeginBrutto: TLabeledEdit;
    leBeginNetto: TLabeledEdit;
    leBeginTara: TLabeledEdit;
    leEndBrutto: TLabeledEdit;
    leEndNetto: TLabeledEdit;
    leEndTara: TLabeledEdit;
    gbResult: TGroupBox;
    lTime: TLabel;
    lDiff: TLabel;
    lUd: TLabel;
    gbServer: TGroupBox;
    btConnect: TButton;
    btDisconnect: TButton;
    gbPort: TGroupBox;
    btOpenPort: TButton;
    btClosePort: TButton;
    lVersion: TLabel;
    gbArchive: TGroupBox;
    dbgArchive: TDBGrid;
    Label4: TLabel;
    ztMeasArchive: TZTable;
    dsArchive: TDataSource;
    zqArchive: TZQuery;
    lArcTime: TLabel;
    lArcDiff: TLabel;
    lArcUd: TLabel;
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
    procedure dbgArchiveColEnter(Sender: TObject);
    procedure dbgArchiveCellClick(Column: TColumn);
    procedure dbgArchiveKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
  ComObj;

var
  DevNet: OleVariant; // Объект OLE
  MeasureArr:array[0..2] of real; // Массив измерений
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
      lVersion.Caption:=DevNet.GetVersion;
      // Включаем кнопки
      btPortDlg.Enabled:=True;
      btParamDlg.Enabled:=True;
      btSelectDevDlg.Enabled:=True;
      btShowHide.Enabled:=True;
      btOpenPort.Enabled:=True;
      btConnect.Enabled:=False;
      btDisconnect.Enabled:=True;
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
    btOpenPort.Enabled:=False;
    btClosePort.Enabled:=True;
    btStart.Enabled:=True;
    btZero.Enabled:=True;
    btTara.Enabled:=True;
    btBN.Enabled:=True;
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
    if (Flags0 and fStable) <> 0 then
      Edit.Font.Color := clMoneyGreen
    else
      Edit.Font.Color := clBlue;
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
    fmDevNetLogger.lbDiscret.Caption := '+/- ' + Format('%5.*f', [PntPos, D]); // По ГОСТу
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
  GetWeightFromDevNet(M06A_Brutto, fmDevNetLogger.edGross);
end;

{ === Таймер === }
procedure TfmDevNetLogger.TimerDevNetTimer(Sender: TObject);
var
  CurTime:real; // Время
  Diff:real; // Разница показаний
begin
  // Получаем данные
  GetWeightFromDevNet(M06A_Brutto, fmDevNetLogger.edGross);
  GetWeightFromDevNet(M06A_Netto, fmDevNetLogger.edNett);
  GetWeightFromDevNet(M06A_Tare, fmDevNetLogger.edTara);
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
    leBeginBrutto.Text:=FloatToStr(MeasureArr[M06A_Brutto]);
    leBeginNetto.Text:=FloatToStr(MeasureArr[M06A_Netto]);
    leBeginTara.Text:=FloatToStr(MeasureArr[M06A_Tare]);
    leEndBrutto.Text:='';
    leEndNetto.Text:='';
    leEndTara.Text:='';
    lDiff.Caption:='';
    lUd.Caption:='';
  end;
  // Если замер идет
  if bMes=True then
  begin
    ztbWeight.AppendRecord([NULL,Now,MeasureArr[M06A_Brutto],MeasureArr[M06A_Netto],MeasureArr[M06A_Tare],MeasID]);
    lTime.Caption:='Время: '+FloatToStr((GetTickCount-TickCount)/1000)+' сек.'
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
    leEndBrutto.Text:=FloatToStr(MeasureArr[M06A_Brutto]);
    leEndNetto.Text:=FloatToStr(MeasureArr[M06A_Netto]);
    leEndTara.Text:=FloatToStr(MeasureArr[M06A_Tare]);
    lTime.Caption:='Время: '+FloatToStr(CurTime)+' сек.';
    Diff:=Abs(StrToFloat(leBeginBrutto.Text)-StrToFloat(leEndBrutto.Text));
    lDiff.Caption:='Разница: '+FloatToStr(Diff);
    lUd.Caption:='Часовой: '+Format('%.3f',[(Diff/CurTime*3600)]);
    ztMeasArchive.Close;
    ztMeasArchive.Open;
    ztMeasArchive.Last;
    dbgArchiveColEnter(Self);
  end;
end;

{ === Остановить опрос, закрыть порт и убить сервер === }
procedure TfmDevNetLogger.btDisconnectClick(Sender: TObject);
begin
  TimerDevNet.Enabled:=False;
  btClosePortClick(Self);
  lVersion.Caption:='';
  fmDevNetLogger.Caption:='Клиент для DevNet';
  DevNet:=Unassigned;
  btPortDlg.Enabled:=False;
  btParamDlg.Enabled:=False;
  btSelectDevDlg.Enabled:=False;
  btShowHide.Enabled:=False;
  btOpenPort.Enabled:=False;
  btClosePort.Enabled:=False;
  btConnect.Enabled:=True;
  btDisconnect.Enabled:=False;
end;

{ === Закрытие порта === }
procedure TfmDevNetLogger.btClosePortClick(Sender: TObject);
begin
  TimerDevNet.Enabled:=False;
  DevNet.ClosePort;
  btOpenPort.Enabled:=True;
  btClosePort.Enabled:=False;
  btStart.Enabled:=False;
  btStop.Enabled:=False;
  btZero.Enabled:=False;
  btTara.Enabled:=False;
  btBN.Enabled:=False;
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
    ztMeasArchive.Open;
  end;
end;

{ === Запуск === }
procedure TfmDevNetLogger.btStartClick(Sender: TObject);
begin
  // Выставляем нужные флаги для таймера
  bBegin:=True;
  bMes:=True;
  // Индикация
  pMeasure.Color:=clYellow;
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
  pMeasure.Color:=clBtnFace;
  pMeasure.Caption:='НЕТ ЗАМЕРА';
  btStart.Enabled:=True;
  btStop.Enabled:=False;
end;

{ === Обработка архива === }
procedure TfmDevNetLogger.dbgArchiveColEnter(Sender: TObject);
var
  WeightStart,WeightEnd:real; // Значение массы на начало и конец замера
  ArcTime:real; // Продолжительность замера
  WeightDiff:real; // Расход зазамер
begin
  if ztMeasArchive.RecordCount>0 then
  begin
    // Запускаем запрос
    zqArchive.Close;
    zqArchive.SQL.Strings[1]:='meas_id='+ztMeasArchive.FieldByName('id').AsString;
    zqArchive.Open;
    // Получение данных
    ArcTime:=ztMeasArchive.FieldByName('mtime').AsFloat;
    lArcTime.Caption:='Время: ' + FloatToStr(ArcTime) + ' сек.';
    zqArchive.First;
    WeightStart:=zqArchive.FieldByName('brutto').AsFloat;
    zqArchive.Last;
    WeightEnd:=zqArchive.FieldByName('brutto').AsFloat;
    WeightDiff:=Abs(WeightStart-WeightEnd);
    lArcDiff.Caption:='Разница: ' + Format('%.3f',[WeightDiff]);
    lArcUd.Caption:='Часовой: ' +  Format('%.3f',[WeightDiff/ArcTime*3600]);
  end;
end;

procedure TfmDevNetLogger.dbgArchiveCellClick(Column: TColumn);
begin
  dbgArchiveColEnter(Self);
end;

procedure TfmDevNetLogger.dbgArchiveKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  dbgArchiveColEnter(Self);
end;

end.
