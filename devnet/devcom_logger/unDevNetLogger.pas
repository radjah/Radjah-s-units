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
    MMTimer1: integer; // ��� ��������������� �������
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
  DevNet: OleVariant; // ������ OLE
  MeasureArr:array[0..2] of real; // ������ ���������
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
      lVersion.Caption:=DevNet.GetVersion;
      // �������� ������
      btPortDlg.Enabled:=True;
      btParamDlg.Enabled:=True;
      btSelectDevDlg.Enabled:=True;
      btShowHide.Enabled:=True;
      btOpenPort.Enabled:=True;
      btConnect.Enabled:=False;
      btDisconnect.Enabled:=True;
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
    btOpenPort.Enabled:=False;
    btClosePort.Enabled:=True;
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
    if (Flags0 and fStable) <> 0 then
      Edit.Font.Color := clMoneyGreen
    else
      Edit.Font.Color := clBlue;
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
    fmDevNetLogger.lbDiscret.Caption := '+/- ' + Format('%5.*f', [PntPos, D]); // �� �����
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
    leBeginBrutto.Text:=FloatToStr(MeasureArr[M06A_Brutto]);
    leBeginNetto.Text:=FloatToStr(MeasureArr[M06A_Netto]);
    leBeginTara.Text:=FloatToStr(MeasureArr[M06A_Tare]);
    leEndBrutto.Text:='';
    leEndNetto.Text:='';
    leEndTara.Text:='';
    lDiff.Caption:='';
    lUd.Caption:='';
  end;
  // ���� ����� ����
  if bMes=True then
  begin
    ztbWeight.AppendRecord([NULL,Now,MeasureArr[M06A_Brutto],MeasureArr[M06A_Netto],MeasureArr[M06A_Tare],MeasID]);
    lTime.Caption:='�����: '+FloatToStr((GetTickCount-TickCount)/1000)+' ���.'
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
    leEndBrutto.Text:=FloatToStr(MeasureArr[M06A_Brutto]);
    leEndNetto.Text:=FloatToStr(MeasureArr[M06A_Netto]);
    leEndTara.Text:=FloatToStr(MeasureArr[M06A_Tare]);
    lTime.Caption:='�����: '+FloatToStr(CurTime)+' ���.';
    Diff:=Abs(StrToFloat(leBeginBrutto.Text)-StrToFloat(leEndBrutto.Text));
    lDiff.Caption:='�������: '+FloatToStr(Diff);
    lUd.Caption:='�������: '+Format('%.3f',[(Diff/CurTime*3600)]);
    ztMeasArchive.Close;
    ztMeasArchive.Open;
    ztMeasArchive.Last;
    dbgArchiveColEnter(Self);
  end;
end;

{ === ���������� �����, ������� ���� � ����� ������ === }
procedure TfmDevNetLogger.btDisconnectClick(Sender: TObject);
begin
  TimerDevNet.Enabled:=False;
  btClosePortClick(Self);
  lVersion.Caption:='';
  fmDevNetLogger.Caption:='������ ��� DevNet';
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

{ === �������� ����� === }
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
    ztMeasArchive.Open;
  end;
end;

{ === ������ === }
procedure TfmDevNetLogger.btStartClick(Sender: TObject);
begin
  // ���������� ������ ����� ��� �������
  bBegin:=True;
  bMes:=True;
  // ���������
  pMeasure.Color:=clYellow;
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
  pMeasure.Color:=clBtnFace;
  pMeasure.Caption:='��� ������';
  btStart.Enabled:=True;
  btStop.Enabled:=False;
end;

{ === ��������� ������ === }
procedure TfmDevNetLogger.dbgArchiveColEnter(Sender: TObject);
var
  WeightStart,WeightEnd:real; // �������� ����� �� ������ � ����� ������
  ArcTime:real; // ����������������� ������
  WeightDiff:real; // ������ �������
begin
  if ztMeasArchive.RecordCount>0 then
  begin
    // ��������� ������
    zqArchive.Close;
    zqArchive.SQL.Strings[1]:='meas_id='+ztMeasArchive.FieldByName('id').AsString;
    zqArchive.Open;
    // ��������� ������
    ArcTime:=ztMeasArchive.FieldByName('mtime').AsFloat;
    lArcTime.Caption:='�����: ' + FloatToStr(ArcTime) + ' ���.';
    zqArchive.First;
    WeightStart:=zqArchive.FieldByName('brutto').AsFloat;
    zqArchive.Last;
    WeightEnd:=zqArchive.FieldByName('brutto').AsFloat;
    WeightDiff:=Abs(WeightStart-WeightEnd);
    lArcDiff.Caption:='�������: ' + Format('%.3f',[WeightDiff]);
    lArcUd.Caption:='�������: ' +  Format('%.3f',[WeightDiff/ArcTime*3600]);
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
