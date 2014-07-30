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
  //послать один символ в порт
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
      WaitCommEvent(CommHandle,TransMask,@Ovr); //ждем
      if (TransMask and EV_RXFLAG)=EV_RXFLAG then //проверяем нужное событие
      begin
        ClearCommError(CommHandle,Errs,@Stat);//сбрасываем флаг
        Kols := Stat.cbInQue;
        ReadFile(CommHandle,Resive,Kols,Kols,@Ovr);//читаем
        //тут должна идти обработка принятой информации из Resive
        ProcData(string(Resive));
        //не очень хороший вариант вывода, но для примера подойдет
      end;//mask
    end;//while
end;

function PortInit(Comport:PChar):boolean;
var
  ThreadID:dword;
begin
  //создание и иницализация порта
  KolByte:=0;

  //создание порта и получение его хэндла
  CommHandle := CreateFile(Comport,GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,
         FILE_ATTRIBUTE_NORMAL or FILE_FLAG_OVERLAPPED,0);
  if CommHandle<>INVALID_HANDLE_VALUE
  then
  begin
    //ставим маску - "по пришествии определенного символа"
    SetCommMask(CommHandle,EV_RXFLAG);

    //построение DCB
    GetCommState(CommHandle,DCB);
    DCB.BaudRate:=CBR_9600;
    DCB.Parity:=NOPARITY;
    DCB.ByteSize:=8;
    DCB.StopBits:=TWOSTOPBITS;
    DCB.EvtChar:=chr(13);//задание символа для флага
    //устанавливаем DCB
    SetCommState(CommHandle,DCB);
    //создаем паралельный поток
    //там будет вертеться процедура приема строки
    //с порта - ReadComm
    CommThread := CreateThread(nil,0,@ReadComm,nil,0,ThreadID);
    Result:=True;
  end
  else
  begin
    MessageBox(fmMain.Handle,StrCat('Не удалось открыть порт ',Comport), 'Ошибка!', MB_OK or MB_ICONEXCLAMATION);
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
