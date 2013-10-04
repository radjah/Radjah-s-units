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
    gbResult: TGroupBox;
    lTime: TLabel;
    lDiff: TLabel;
    lUd: TLabel;
    mmDevNet: TMainMenu;
    mDevNetServer: TMenuItem;
    mPortDlg: TMenuItem;
    mParamDlg: TMenuItem;
    mSelectDevDlg: TMenuItem;
    mShowHide: TMenuItem;
    N2: TMenuItem;
    mExit: TMenuItem;
    edGross: TEdit;
    edNett: TEdit;
    edTara: TEdit;
    lbDiscret: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    eBeginBrutto: TEdit;
    eBeginNetto: TEdit;
    eBeginTara: TEdit;
    eEndBrutto: TEdit;
    eEndNetto: TEdit;
    eEndTara: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    N3: TMenuItem;
    mMeas: TMenuItem;
    N4: TMenuItem;
    mConnect: TMenuItem;
    mScales: TMenuItem;
    mOpenPort: TMenuItem;
    mClosePort: TMenuItem;
    mDisconnect: TMenuItem;
    mScaleButtons: TMenuItem;
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
    procedure mScaleButtonsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MMTimer1: integer; // ��� ��������������� �������
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
  DevNet: OleVariant; // ������ OLE
  MeasureArr, BeginArr, EndArr:array[0..2] of real; // ������ ���������
  bBegin, bEnd, bMes:boolean; // �����
  TickCount:Integer; // �����
  MeasID:Integer; // ID ������
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
//      ShowMessage('����� ��� ������������.');
      // ������ �������
      fmDevNetLogger.Caption:='������ ��� Devnet '+DevNet.GetVersion;
      // �������� ������
      mPortDlg.Enabled:=True;
      mParamDlg.Enabled:=True;
      mSelectDevDlg.Enabled:=True;
      mShowHide.Enabled:=True;
      mOpenPort.Enabled:=True;
      mConnect.Enabled:=False;
      mDisconnect.Enabled:=True;
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

{ === ��������/������ ���� ������� === }
procedure TfmDevNetLogger.btShowHideClick(Sender: TObject);
begin
  DevNet.Visible:=(NOT DevNet.Visible);
end;

{ === �������� ����� � ������ ������ === }
procedure TfmDevNetLogger.btOpenPortClick(Sender: TObject);
begin
  If DevNet.OpenPort then
  // ���� ������ ���������� �� �����
  begin
//  ShowMessage('���� ������!');
    // ��������� ������
    //MMTimer1 := timeSetEvent(500, 10, @TimerCallBackProg, 100, TIME_PERIODIC);
    TimerDevNet.Enabled:=True;
    // ����������� ������
    mOpenPort.Enabled:=False;
    mClosePort.Enabled:=True;
    btStart.Enabled:=True;
    btZero.Enabled:=True;
    btTara.Enabled:=True;
    btBN.Enabled:=True;
    btUnZero.Enabled:=True;
    btUnTara.Enabled:=True;
  end
  // ����� ��������
  else ShowMessage('�� ������� ������� ����!');
end;

// ��������� �������� ���� � ����� �� �����
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
  // ��������� ����������� ����������
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
  // �������� �� ����
  IsOK := DevNet.GetWeight(1, TypeWeight, WeightVal, ErrState,
    Flags0, Reserve1, Reserve2, Reserve3);
  // �������� �� ������
  if IsOK and (ErrState = 0) then
  begin
    Edit.Color := clGreen;
    Edit.Font.Color := clYellow;
    // ��������� ��������
    D := Discret;
    if WeightVal > 2000 * D then
      D := 3 * Discret
    else if WeightVal > 500 * D then
      D := 2 * Discret;
    // ����� ����
    Edit.Text := Format('%7.*f', [PntPos, WeightVal]);
    MeasureArr[TypeWeight]:=WeightVal;
    // ����� ��������
    fmDevNetLogger.lbDiscret.Caption := '+/- ' + Format('%5.*f', [PntPos, D]) + ' ��'; // �� �����
  end
  else
  // ����� ������
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

{ === ������������� ����� ����� === }
procedure TimerCallBackProg(uTimerID, uMessage: UINT;
  dwUser, dw1, dw2: DWORD); stdcall;
begin
  GetWeightFromDevNet(M06A_Brutto, fmDevNetLogger.edGross);
end;

{ === ������ === }
procedure TfmDevNetLogger.TimerDevNetTimer(Sender: TObject);
var
  CurTime:real; // �����
  Diff:real; // ������� ���������
begin
  // �������� ������
  GetWeightFromDevNet(M06A_Brutto, fmDevNetLogger.edGross);
  GetWeightFromDevNet(M06A_Netto, fmDevNetLogger.edNett);
  GetWeightFromDevNet(M06A_Tare, fmDevNetLogger.edTara);
  // ��������� ������
  // ���� ������ ������ �����
  if bBegin=True then
  begin
    bBegin:=False;
    TickCount:=GetTickCount;
    // ������ �������� � �������
    ztbMeasure.AppendRecord([NULL, Now, 0.0, leMeasure.Text,NULL]);
    ztbMeasure.Last;
    MeasID:=ztbMeasure.FieldByName('id').AsInteger;
    eBeginBrutto.Text:=Format('%7.2f', [MeasureArr[M06A_Brutto]]);
    BeginArr[M06A_Brutto]:=MeasureArr[M06A_Brutto];
    eBeginNetto.Text:=Format('%7.2f', [MeasureArr[M06A_Netto]]);
    BeginArr[M06A_Netto]:=MeasureArr[M06A_Netto];
    eBeginTara.Text:=Format('%7.2f', [MeasureArr[M06A_Tare]]);
    BeginArr[M06A_Tare]:=MeasureArr[M06A_Tare];
    eEndBrutto.Text:='';
    eEndNetto.Text:='';
    eEndTara.Text:='';
    lDiff.Caption:='';
    lUd.Caption:='';
  end;
  // ���� ����� ����
  if bMes=True then
  begin
    CurTime:=(GetTickCount-TickCount)/1000;
    ztbWeight.AppendRecord([NULL,Now,MeasureArr[M06A_Brutto],MeasureArr[M06A_Netto],MeasureArr[M06A_Tare],MeasID]);
    lTime.Caption:='�����: '+FloatToStr((GetTickCount-TickCount)/1000)+' ���.';
    Diff:=Abs(BeginArr[M06A_Brutto]-MeasureArr[M06A_Brutto]);
    lDiff.Caption:='�������: '+FloatToStr(Diff);
    if CurTime<>0 then
    lUd.Caption:='�������: '+Format('%.3f',[(Diff/CurTime*3600)]);
  end;
  // ���� ����� ����������
  if bEnd=True then
  begin
    bEnd:=False;
    CurTime:=(GetTickCount-TickCount)/1000;
    ztbWeight.AppendRecord([NULL,Now,MeasureArr[M06A_Brutto],MeasureArr[M06A_Netto],MeasureArr[M06A_Tare],MeasID]);
    ztbMeasure.Edit;
    ztbMeasure.FieldByName('stop').AsDateTime:=Now;
    ztbMeasure.FieldByName('mtime').AsFloat:=CurTime;
    ztbMeasure.Post;
    eEndBrutto.Text:=Format('%7.2f', [MeasureArr[M06A_Brutto]]);
    eEndNetto.Text:=Format('%7.2f', [MeasureArr[M06A_Netto]]);
    eEndTara.Text:=Format('%7.2f', [MeasureArr[M06A_Tare]]);
    lTime.Caption:='�����: '+FloatToStr(CurTime)+' ���.';
    Diff:=Abs(BeginArr[M06A_Brutto]-MeasureArr[M06A_Brutto]);
    lDiff.Caption:='�������: '+FloatToStr(Diff);
    lUd.Caption:='�������: '+Format('%.3f',[(Diff/CurTime*3600)]);
    ReopenDatasets([fmArchive.ztMeasArchive]);
  end;
end;

{ === ���������� �����, ������� ���� � ����� ������ === }
procedure TfmDevNetLogger.btDisconnectClick(Sender: TObject);
begin
  TimerDevNet.Enabled:=False;
  btClosePortClick(Self);
  fmDevNetLogger.Caption:='������ ��� DevNet';
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

{ === �������� ����� === }
procedure TfmDevNetLogger.btClosePortClick(Sender: TObject);
begin
  TimerDevNet.Enabled:=False;
  DevNet.ClosePort;
  mOpenPort.Enabled:=True;
  mClosePort.Enabled:=False;
  btStart.Enabled:=False;
  btStop.Enabled:=False;
  btZero.Enabled:=False;
  btTara.Enabled:=False;
  btBN.Enabled:=False;
  btUnZero.Enabled:=False;
  btUnTara.Enabled:=False;
end;

{ === ������ ������ ��������� ���� === }
procedure TfmDevNetLogger.btZeroClick(Sender: TObject);
begin
  DevNet.SetToZero(1);
end;

{ === ������ ������ ��������� ���� ���� === }
procedure TfmDevNetLogger.btTaraClick(Sender: TObject);
begin
  DevNet.TakeToTare(1);
end;

{ === ������ ������ ������ ����������� === }
procedure TfmDevNetLogger.btBNClick(Sender: TObject);
begin
  DevNet.SelectMode(1);
end;

{ === ������ � �������� ���� === }
procedure TfmDevNetLogger.btUnZeroClick(Sender: TObject);
begin
  DevNet.UndoZero(1);
end;

{ === ������ ��������� ���� ���� === }
procedure TfmDevNetLogger.btUnTaraClick(Sender: TObject);
begin
  DevNet.UndoTare(1);
end;

{ === ��������� ����� ��� ������� === }
procedure TfmDevNetLogger.FormShow(Sender: TObject);
var
  dbfile: TFileName;
begin
  dbfile := ExtractFilePath(Application.ExeName) + 'devnet_log.sqlite';
  if NOT(FileExists(dbfile)) then
  begin
    MessageBox(Self.Handle, '���� ������ �� �������!' , '������!',
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

{ === ������ === }
procedure TfmDevNetLogger.btStartClick(Sender: TObject);
begin
  // ���������� ������ ����� ��� �������
  bBegin:=True;
  bMes:=True;
  // ���������
  pMeasure.Font.Color:=clRed;
  fmDevNetLogger.Repaint;
  pMeasure.Caption:='�����';
  btStart.Enabled:=False;
  btStop.Enabled:=True;
end;

{ === ��������� === }
procedure TfmDevNetLogger.btStopClick(Sender: TObject);
begin
  // ���������� ������ ����� ��� �������
  bEnd:=True;
  bMes:=False;
  // ���������
  pMeasure.Font.Color:=clWindowText;
  pMeasure.Caption:='��� ������';
  btStart.Enabled:=True;
  btStop.Enabled:=False;
end;

{ === ����� === }
procedure TfmDevNetLogger.mExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfmDevNetLogger.mMeasClick(Sender: TObject);
begin
  fmArchive.Show;
end;

procedure TfmDevNetLogger.mScaleButtonsClick(Sender: TObject);
begin
  gbButtons.Visible:= not mScaleButtons.Checked;
  mScaleButtons.Checked:= not mScaleButtons.Checked;
end;

end.
