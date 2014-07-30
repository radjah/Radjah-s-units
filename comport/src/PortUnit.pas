unit PortUnit;

interface
 uses windows, sysutils;

var
    CommHandle : integer;
    DCB : TDCB;
    Ovr : TOverlapped;
    Stat : TComStat;
    CommThread : THandle;
    hEvent : THandle;
    Flag,StopResive : boolean;
    KolByte,Kols,Mask,TransMask,Errs : DWord;
function PortInit(Comport:PChar):boolean;
procedure ReadComm;
procedure WriteComm(A:byte);
procedure KillComm;
procedure ProcData(str:string);

implementation

uses
  unMain;

procedure KillComm;
begin
  TerminateThread(CommThread,0);
  CloseHandle(CommHandle);
end;

procedure WriteComm(A:byte);
var
  Transmit:array [0..255] of char;
begin
  //������� ���� ������ � ����
   KolByte:=1;
   Transmit[0]:=chr(A);
   WriteFile(CommHandle,Transmit,KolByte,KolByte,@Ovr);
end;

procedure ReadComm;
var
  Resive:array [0..255] of char;

begin
  while true do
    begin
      TransMask:=0;
      WaitCommEvent(CommHandle,TransMask,@Ovr); //����
      if (TransMask and EV_RXFLAG)=EV_RXFLAG then //��������� ������ �������
      begin
        ClearCommError(CommHandle,Errs,@Stat);//���������� ����
        Kols := Stat.cbInQue;
        ReadFile(CommHandle,Resive,Kols,Kols,@Ovr);//������
        //��� ������ ���� ��������� �������� ���������� �� Resive
        ProcData(string(Resive));
        //�� ����� ������� ������� ������, �� ��� ������� ��������
      end;//mask
    end;//while
end;

function PortInit(Comport:PChar):boolean;
var
  ThreadID:dword;
begin
  //�������� � ������������ �����
  KolByte:=0;

  //�������� ����� � ��������� ��� ������
  CommHandle := CreateFile(Comport,GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,
         FILE_ATTRIBUTE_NORMAL or FILE_FLAG_OVERLAPPED,0);
  if CommHandle<>INVALID_HANDLE_VALUE
  then
  begin
    //������ ����� - "�� ���������� ������������� �������"
    SetCommMask(CommHandle,EV_RXFLAG);

    //���������� DCB
    GetCommState(CommHandle,DCB);
    DCB.BaudRate:=CBR_9600;
    DCB.Parity:=NOPARITY;
    DCB.ByteSize:=8;
    DCB.StopBits:=TWOSTOPBITS;
    DCB.EvtChar:=chr(13);//������� ������� ��� �����
    //������������� DCB
    SetCommState(CommHandle,DCB);
    //������� ����������� �����
    //��� ����� ��������� ��������� ������ ������
    //� ����� - ReadComm
    CommThread := CreateThread(nil,0,@ReadComm,nil,0,ThreadID);
    Result:=True;
  end
  else
  begin
    MessageBox(fmMain.Handle,StrCat('�� ������� ������� ���� ',Comport), '������!', MB_OK or MB_ICONEXCLAMATION);
    Result:=False;
  end;
end;

procedure ProcData(str:string);
var
  epsilon:real;
  temp:integer;
begin
  if Length(Trim(str))=13
  then
  begin
//    fmMain.mMeasure.Lines.Add(trim(str));
    epsilon:=(StrToFloat(copy(trim(str),7,2))+1)/100;
    temp:=StrToInt(Trim(copy(trim(str),9,4)));
    fmMain.mMeasure.Lines.Add('t='+IntToStr(temp)+' e='+FloatToStr(epsilon));
  end;
end;

end.
