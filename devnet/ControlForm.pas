/// ///////////////////////////////////////////////////////////////////////////
//
// $HDR$
// Last Edited By: $Author:pol$
// Last Edit Time: $Date:11/04/13 10:55:52$
//
/// ////////////////////////////// ChangeLog: /////////////////////////////////
//
// Legend:
// + = Feature added
// * = Feature modified/improved
// - = Problem resolved
// ! = Note
//
// $Log:  88894: ControlForm.pas
//
// Rev 1.4    11/04/13 10:55:52  pol
//
// Rev 1.3    02/11/12 11:06:02  pol
/// ///////////////////////////////////////////////////////////////////////////
//
unit ControlForm;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, Buttons, Spin, mdMailSlot;

type
  TControlScalesForm = class(TForm)
    btnClose: TButton;
    gbScale: TGroupBox;
    lbWeight: TLabel;
    edWeight: TEdit;
    lbDiscret: TLabel;
    tmrCheck: TTimer;
    rgRemoteControl: TRadioGroup;
    btnSetToZero: TButton;
    btnTakeToTare: TButton;
    btnSaveWeight: TButton;
    lbCommand: TLabel;
    edCommand: TEdit;
    lbAnswer: TLabel;
    edAnswer: TEdit;
    btnTurnOnDosator: TButton;
    btnTurnOffDosator: TButton;
    btnStartDosator: TButton;
    btnStopDosator: TButton;
    sbScaleDriver: TSpeedButton;
    btnGetLimits: TButton;
    btnSetLimits: TButton;
    sedScaleNum: TSpinEdit;
    tmrWeightPoll: TTimer;
    SpeedButton1: TSpeedButton;
    procedure MailSlotBinMessageAvail(Sender: TObject; Data: PAnsiChar;
      Len: Integer);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrCheckTimer(Sender: TObject);
    procedure sedScaleNumChange(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure rgRemoteControlClick(Sender: TObject);
    procedure edCommandKeyPress(Sender: TObject; var Key: Char);
    procedure sbScaleDriverClick(Sender: TObject);
    procedure MailSlotDrvBinMessageAvail(Sender: TObject; Data: PAnsiChar;
      Len: Integer);
    procedure tmrWeightPollTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure SendCommand;
    function GetNum: String;
  end;

var
  ControlScalesForm: TControlScalesForm;

implementation

uses
  ComObj, Variants;

{$R *.DFM}

const
  ANY_ERROR_DELAY = 2000;
  fClb = 1; // весы в режиме 'калибровка'
  fClbZero = 2; // весы в режиме 'калибровка нуля'
  fStable = 4; // значения веса стабильны
  fNearZero = 8; // значения веса в диапазоне -0.5d..+0.5d
  fIsMin20d = 16; // значение веса меньше 20d
  fUnderLoad = 32; // значение веса существенно меньше нуля
  fOverLoad = 64; // значение веса больше НПВ+9d
  fNoLoadCell = 128; // ошибка подключения (обрыв, повреждение) тензодатчика

type
  PPlatformRec = ^TPlatformRec;

  TPlatformRec = record
    PlatformNum: Byte;
    TypeDev: Byte;
    VersionDev: Byte;
    Weight: Double;
    ClbZero: Double;
    PntPos: Byte;
    ErrState: Byte;
    Flags0: Byte;
    Flags1: Byte;
    DFlags: Byte;
    DState: Byte;
  end;

var
  tLastPoll: Longint;
  Discret: Double;
  PointPos: Byte;
  Limits: String = '0123456789ABCDEF'; // Уставки (16 байт)
  DevNet: OleVariant;
  MailSlot: TmdSafeMail;
  MailSlotDrv: TmdSafeMail;

procedure TControlScalesForm.SendCommand;
begin
  SendSafeMail('.', 'DevNetRpc', edCommand.Text);
end;

function TControlScalesForm.GetNum: String;
begin
  Result := sedScaleNum.Text;
  if Length(sedScaleNum.Text) = 1 then
    Result := '0' + sedScaleNum.Text;
end;

procedure TControlScalesForm.FormCreate(Sender: TObject);
var
  PN, BR: Byte;
  AC: Boolean;
begin
  try
    DevNet := GetActiveOleObject('DevNet.Drv');
  except
    try
      DevNet := CreateOleObject('DevNet.Drv');
    except
      rgRemoteControl.ItemIndex := 0;
      ShowMessage
        ('Сервер автоматизации DevNet.Drv не зарегистрирован в Windows.' +
        #13#10 + 'Для регистрации запустите файл DevNet.exe');
    end;
  end;
  try
    if not DevNet.TestPort(PN, BR, AC) then
      DevNet.OpenPort;
    if DevNet.Visible then
      DevNet.Visible := False; // Скрыть окно DevNet.exe
  except
  end;
  try // Открыть доступ к MailSlot
    MailSlot := nil; //
    MailSlot := TmdSafeMail.Create(Self); //
    if MailSlot = nil then
      Abort; //
    MailSlot.Slot := 'DevNet'; //
    MailSlot.Active := True; //
  except
    ShowMessage('Не удалось открыть доступ к MailSlot.');
  end;
  try // Открыть доступ к MailSlot
    MailSlotDrv := nil; //
    MailSlotDrv := TmdSafeMail.Create(Self); //
    if MailSlotDrv = nil then
      Abort; //
    MailSlotDrv.Slot := 'DevNetDrv'; //
    MailSlotDrv.Active := True; //
  except
    ShowMessage('Не удалось открыть доступ к MailSlot.');
  end;
  edWeight.DoubleBuffered := True;
  sedScaleNumChange(nil);
  rgRemoteControlClick(nil);
end;

procedure TControlScalesForm.MailSlotBinMessageAvail(Sender: TObject;
  Data: PAnsiChar; Len: Integer);
var
  PlatformRec: PPlatformRec;
  Weight, ClbZero, D: Double;
  WeightStr, DiscretStr: String;
begin
  PlatformRec := PPlatformRec(Data);
  if PlatformRec^.PlatformNum <> sedScaleNum.Value then
    Exit;
  if (PlatformRec^.Flags0 and (fUnderLoad or fOverLoad or fNoLoadCell)) = 0 then
  begin
    if (PlatformRec^.Flags0 and (fClb or fClbZero)) = 0 then
    begin
      Weight := PlatformRec^.Weight;
      ClbZero := PlatformRec^.ClbZero;
      PointPos := PlatformRec^.PntPos;
      D := Discret;
      if Weight > 2000 * D then
        D := 3 * Discret
      else if Weight > 500 * D then
        D := 2 * Discret;
      WeightStr := Format('%7.*f', [PointPos, Weight]);
      DiscretStr := '+/- ' + Format('%5.*f', [PointPos, D]); // По ГОСТу
    end
    else
    begin
      WeightStr := 'Калибр.';
      DiscretStr := '';
    end;
  end
  else
  begin
    WeightStr := '--------';
    DiscretStr := '';
  end;
  if DiscretStr = '' then
  begin
    edWeight.Color := clBlack;
    edWeight.Font.Color := clRed;
  end
  else
  begin
    edWeight.Color := clGreen;
    if (PlatformRec^.Flags0 and fStable) <> 0 then
      edWeight.Font.Color := clMoneyGreen
    else
      edWeight.Font.Color := clBlue;
  end;
  edWeight.Text := WeightStr;
  lbDiscret.Caption := DiscretStr;
  tLastPoll := GetTickCount;
end;

procedure TControlScalesForm.btnCloseClick(Sender: TObject);
begin
  try
    if not DevNet.Visible then
      DevNet.Visible := True; // Показать окно DevNet.exe
    DevNet := UnAssigned;
  except
  end;
  Close;
end;

procedure TControlScalesForm.tmrCheckTimer(Sender: TObject);
begin
  if Abs(GetTickCount - tLastPoll) > ANY_ERROR_DELAY then
  begin
    edWeight.Color := clBlack;
    edWeight.Font.Color := clBlack;
    edWeight.Text := '';
    lbDiscret.Caption := '';
  end;
end;

procedure TControlScalesForm.sedScaleNumChange(Sender: TObject);
var
  LastTick: Longint;
  tmpVar: OleVariant;
begin
  edWeight.Text := '';
  lbDiscret.Caption := '';
  tLastPoll := GetTickCount;
  LastTick := GetTickCount;
  // Ожидать выхода прибора на рабочий режим 5 сек.
  while not DevNet.IsReadyDev(sedScaleNum.Value) do
  begin
    if (GetTickCount - LastTick) > 5000 then
      Break;
    Application.ProcessMessages;
  end;
  if DevNet.IsReadyDev(sedScaleNum.Value) then
  begin
    DevNet.GetConstant(sedScaleNum.Value, 7, tmpVar);
    Discret := tmpVar;
    DevNet.GetConstant(sedScaleNum.Value, 3, tmpVar);
    PointPos := tmpVar;
  end
  else
  begin
    Discret := 0;
    PointPos := 0;
  end;
end;

procedure TControlScalesForm.ButtonClick(Sender: TObject);
const
  MailSlotCmd: array [0 .. 8] of PChar = ('SZ', 'ST', 'SW', 'GL', 'SL', 'SS1',
    'SS0', 'SX1', 'SX0');
  OleAutomationCmd: array [0 .. 8] of PChar = ('SetToZero', 'TakeToTare',
    'SaveWeight', 'GetLimits', 'SetLimits', 'SwitchDosator', 'SwitchDosator',
    'TurnDosator', 'TurnDosator');
  AnswerStr: array [Boolean] of PChar = ('False', 'True');
var
  tg: Longint;
  Res: Boolean;
begin
  tg := TButton(Sender).Tag;
  if rgRemoteControl.ItemIndex = 0 then
  begin
    edCommand.Text := '@D' + GetNum + MailSlotCmd[tg];
    if tg <> 4 then
      SendCommand
    else
      SendSafeMail('.', 'DevNetRpc', edCommand.Text + Limits);
  end
  else
  begin
    edCommand.Text := OleAutomationCmd[tg] + '(' + sedScaleNum.Text + ')';
    case tg of
      0:
        Res := DevNet.SetToZero(sedScaleNum.Value);
      1:
        Res := DevNet.TakeToTare(sedScaleNum.Value);
      2:
        Res := DevNet.SaveWeight(sedScaleNum.Value);
      3:
        Res := DevNet.GetLimits(sedScaleNum.Value, Limits);
      4:
        Res := DevNet.SetLimits(sedScaleNum.Value, Limits);
      5:
        Res := DevNet.SwitchDosator(sedScaleNum.Value, 1);
      6:
        Res := DevNet.SwitchDosator(sedScaleNum.Value, 0);
      7:
        Res := DevNet.TurnDosator(sedScaleNum.Value, 1);
      8:
        Res := DevNet.TurnDosator(sedScaleNum.Value, 0);
    end;
    edAnswer.Text := AnswerStr[Res];
  end;
end;

procedure TControlScalesForm.rgRemoteControlClick(Sender: TObject);
begin
  edCommand.Text := '';
  edAnswer.Text := edCommand.Text;
  lbCommand.Enabled := rgRemoteControl.ItemIndex = 0;
  edCommand.Enabled := lbCommand.Enabled;
  lbAnswer.Enabled := lbCommand.Enabled;
  edAnswer.Enabled := lbCommand.Enabled;
  if rgRemoteControl.ItemIndex = 0 then
  begin
    MailSlot.OnBinMessageAvail := MailSlotBinMessageAvail;
    MailSlotDrv.OnBinMessageAvail := MailSlotDrvBinMessageAvail;
  end
  else
  begin
    MailSlot.OnBinMessageAvail := nil;
    MailSlotDrv.OnBinMessageAvail := nil;
  end;
  tmrWeightPoll.Enabled := rgRemoteControl.ItemIndex = 1;
  tmrCheck.Enabled := not tmrWeightPoll.Enabled;
end;

procedure TControlScalesForm.edCommandKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    SendCommand;
end;

procedure TControlScalesForm.sbScaleDriverClick(Sender: TObject);
begin
  if rgRemoteControl.ItemIndex = 0 then
  begin
    edCommand.Text := '@SV';
    if sbScaleDriver.Down then
      edCommand.Text := edCommand.Text + '1'
    else
      edCommand.Text := edCommand.Text + '0';
    SendCommand;
  end
  else
  begin
    edCommand.Text := 'Visible := ';
    if sbScaleDriver.Down then
      edCommand.Text := edCommand.Text + 'True'
    else
      edCommand.Text := edCommand.Text + 'False';
    DevNet.Visible := sbScaleDriver.Down;
  end;
end;

procedure TControlScalesForm.MailSlotDrvBinMessageAvail(Sender: TObject;
  Data: PChar; Len: Integer);
begin
  edAnswer.Text := Data;
  if Pos('GL', Data) <> 0 then
  begin
    Inc(Data, 6);
    SetString(Limits, Data, 16);
  end;
end;

procedure TControlScalesForm.tmrWeightPollTimer(Sender: TObject);
const
  M06A_Brutto = 0;
  M06A_MaxRange = 2;
  M06A_PntPos = 3;
  M06A_Discret = 7;
var
  MaxRange: Byte;
  Discret, D: Double;
  PntPos: Byte;
  Brutto: Double;
  Flags0: Byte;
  ErrState: Byte;
  Reserve1, Reserve2, Reserve3: Byte;
  VariantVar: OleVariant;
  IsOK: Boolean;
begin
  if DevNet.GetConstant(sedScaleNum.Value, M06A_MaxRange, VariantVar) then
    MaxRange := VariantVar
  else
    MaxRange := 0;
  if DevNet.GetConstant(sedScaleNum.Value, M06A_PntPos, VariantVar) then
    PntPos := VariantVar
  else
    PntPos := 3;
  if DevNet.GetConstant(sedScaleNum.Value, M06A_Discret + MaxRange,
    VariantVar) then
    Discret := VariantVar
  else
    Discret := 0.001;

  IsOK := DevNet.GetWeight(sedScaleNum.Value, M06A_Brutto, Brutto, ErrState,
    Flags0, Reserve1, Reserve2, Reserve3);
  if IsOK and (ErrState = 0) then
  begin
    edWeight.Color := clGreen;
    if (Flags0 and fStable) <> 0 then
      edWeight.Font.Color := clMoneyGreen
    else
      edWeight.Font.Color := clBlue;

    D := Discret;
    if Brutto > 2000 * D then
      D := 3 * Discret
    else if Brutto > 500 * D then
      D := 2 * Discret;
    edWeight.Text := Format('%7.*f', [PointPos, Brutto]);
    lbDiscret.Caption := '+/- ' + Format('%5.*f', [PointPos, D]); // По ГОСТу
  end
  else
  begin
    edWeight.Color := clBlack;
    edWeight.Font.Color := clRed;
    if IsOK then
      edWeight.Text := 'Err ' + Format('%2d', [ErrState])
    else
      edWeight.Text := '--------';

    lbDiscret.Caption := '';
  end;
end;

procedure TControlScalesForm.SpeedButton1Click(Sender: TObject);
begin
  edCommand.Text := '@PT';
  SendSafeMail('.', 'DevNetRpc', edCommand.Text);
end;

end.
