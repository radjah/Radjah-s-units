/// ///////////////////////////////////////////////////////////////////////////
//
// $HDR$
// Last Edited By: $Author:pol$
// Last Edit Time: $Date:26/05/11 14:52:40$
//
/// ////////////////////////////// ChangeLog: /////////////////////////////////
//
// Legend:
// + = Feature added
// * = Feature modified/improved
// - = Problem resolved
// ! = Note
//
// $Log:  124429: RollBuf.pas
//
// Rev 1.0    26/05/11 14:52:40  pol
//
// Rev 1.0    22.01.09 16:54:16  ms
/// ///////////////////////////////////////////////////////////////////////////
//
unit RollBuf;

interface

uses
  SysUtils, Windows, Messages;

const
  RollMaxSize = $8000;
  RollMaxMessages = 255;
  WM_ROLLNOTIFY = WM_USER + 1;

type
  TRollHead = packed record
    size: Word; { size of buffer }
    iptr: Word; { index in buffer of first byte to read }
    ilen: Word; { number bytes to read }

    readers: Byte;
    writers: Byte;

    msgMode: ByteBool; { message buffer }
    msgCount: Byte; { Count of message to read }

    wndNotify: HWND; { Reader's Notify window }
  end;

  PRollHead = ^TRollHead;

  TRollData = packed record
    head: TRollHead;
    data: array [0 .. RollMaxSize - 1] of Byte;
  end;

  PRollData = ^TRollData;

  TRollAccsess = (raReader, raWriter);
  TRollMode = set of TRollAccsess;

  TRollBuffer = class(TObject)
  private
    FName: string;
    FHandle: THandle; { handle of Shared memory mapped file }
    FHLock: THandle; { Mutex handle to Lock support }
    FData: PRollData; { shared memory area }
    FMode: TRollMode;

    function head: PRollHead;
    function data: PByte;

    function GetNotify: HWND;
    procedure SetNotify(val: HWND);

  protected
    procedure Lock;
    procedure Unlock;

    procedure NotifyReader;

    procedure SaveState(var aState: Longint);
    procedure RestoreState(aState: Longint);

    function InternalRead(var aBuf; len: integer): integer;
    function InternalWrite(const aBuf; len: integer): integer;

  public
    constructor Create(const aName: string; aSize: Word; anAcc: TRollMode;
      isMsg: Boolean);
    destructor Destroy; override;

    procedure GetStatus(var aStatus: TRollHead);

    procedure Clear;
    function Capacity: integer;
    function Write(const aBuf; len: integer): integer;

    function Available: integer;
    function Empty: Boolean;
    function msgCount: integer;
    function Read(var aBuf; len: integer): integer;

    function Overflow: Boolean;

    function readers: integer;
    function writers: integer;
    function size: Word;
    property Name: string read FName;
    property WindowNotify: HWND read GetNotify write SetNotify;
  end;

  ERollError = class(Exception)
  end;

procedure RollError(const msg: string);

implementation

procedure RollError(const msg: string);
begin
  raise ERollError.Create(msg);
end;

constructor TRollBuffer.Create(const aName: string; aSize: Word;
  anAcc: TRollMode; isMsg: Boolean);
var
  fInit: Boolean;
  sb: array [0 .. 255] of char;
begin
  inherited Create;

  FName := aName;
  FData := nil;
  FMode := anAcc;
  FHLock := CreateMutex(nil, False, StrPCopy(sb, 'lock' + FName));

  if FHLock = 0 then
    RollError('Could not create Lock Mutex');

  FHandle := CreateFileMapping($FFFFFFFF, { use paging file }
    nil, { no security attr. }
    PAGE_READWRITE, { read/write access }
    0, { size: high 32-bits }
    sizeof(TRollHead) + aSize, { size: low 32-bits }
    StrPCopy(sb, 'mem' + FName) { name of map object }
    );

  if FHandle = 0 then
    RollError('Could not create FileMapping');

  { The first process to attach initializes memory. }
  fInit := (GetLastError() <> ERROR_ALREADY_EXISTS);

  { Get a pointer to the file-mapped shared memory. }

  FData := PRollData(MapViewOfFile(FHandle, { object to map view of }
    FILE_MAP_WRITE, { read/write access }
    0, { high offset:   map from }
    0, { low offset:    beginning }
    0)); { default: map entire file }

  if not Assigned(FData) then
    RollError('Could not MapViewOfFile');

  { Initialize memory if this is first attachment. }
  if fInit then
  begin
    FillChar(FData^, sizeof(TRollHead) + aSize, #0);
    head^.size := aSize;
    head^.msgMode := isMsg;
  end
  else
  begin
    if size <> aSize then
      RollError('Incopatible buffer sizes.');
    if head^.msgMode <> isMsg then
      RollError('Incopatible Message modes.');
  end;

  { }
  if raReader in FMode then
    Inc(head^.readers);

  if raWriter in FMode then
    Inc(head^.writers);
end;

destructor TRollBuffer.Destroy;
begin
  { Unmap shared memory from the process's address space. }
  if Assigned(FData) then
  begin
    if raReader in FMode then
      Dec(head^.readers);

    if raWriter in FMode then
      Dec(head^.writers);

    UnmapViewOfFile(FData);
  end;

  { Close the process's handle to the file-mapping object. }
  if FHandle <> 0 then
    CloseHandle(FHandle);

  if FHLock <> 0 then
    CloseHandle(FHLock);

  inherited Destroy;
end;

function TRollBuffer.head: PRollHead;
begin
  Result := PRollHead(FData);
end;

function TRollBuffer.data: PByte;
begin
  Result := @(FData^.data);
end;

procedure TRollBuffer.GetStatus(var aStatus: TRollHead);
begin
  Move(head^, aStatus, sizeof(TRollHead));
end;

procedure TRollBuffer.Lock;
begin
  case WaitForSingleObject(FHLock, 5000) of
    WAIT_OBJECT_0: { O'key }
      ;
    WAIT_TIMEOUT:
      RollError('Cannot get ownership due to time-out.');
    WAIT_ABANDONED:
      RollError('Got ownership of the abandoned mutex object.');
  else
    RollError('Unexpected Lock result');
  end;
end;

procedure TRollBuffer.Unlock;
begin
  if not ReleaseMutex(FHLock) then
    RollError('Cannot release lock mutex object.');
end;

function TRollBuffer.readers: integer;
begin
  Result := head^.readers;
end;

function TRollBuffer.writers: integer;
begin
  Result := head^.writers;
end;

function TRollBuffer.GetNotify: HWND;
begin
  Result := head^.wndNotify;
end;

procedure TRollBuffer.SetNotify(val: HWND);
begin
  head^.wndNotify := val;
end;

procedure TRollBuffer.NotifyReader;
var
  msg: TMsg;
begin
  with head^ do
    if (ilen > 0) and (wndNotify <> 0) and not PeekMessage(msg, wndNotify,
      WM_ROLLNOTIFY, WM_ROLLNOTIFY, PM_NOREMOVE) then
      PostMessage(wndNotify, WM_ROLLNOTIFY, 0, 0);
end;

function TRollBuffer.size: Word;
begin
  Result := head^.size;
end;

function TRollBuffer.Capacity: integer;
begin
  with head^ do
  begin
    Result := size - ilen;
    if msgMode then
      Dec(Result, sizeof(Word));
  end;
end;

procedure TRollBuffer.Clear;
begin
  Lock;
  with head^ do
    try
      iptr := 0;
      ilen := 0;
      msgCount := 0;
    finally
      Unlock;
    end;
end;

function wmin(w1, w2: Word): Word;
begin
  if w1 < w2 then
    Result := w1
  else
    Result := w2;
end;

function TRollBuffer.InternalRead(var aBuf; len: integer): integer;
var
  l1, l2: Word;
  p: PByte;
begin
  with head^ do
  begin
    Result := wmin(ilen, len);
    l1 := Result;
    l2 := 0;

    if (iptr + l1) > size then
    begin
      l2 := (l1 + iptr) - size;
      Dec(l1, l2);
    end;

    Move(FData^.data[iptr], aBuf, l1);

    if l2 > 0 then
    begin
      p := @aBuf;
      Inc(p, l1);
      Move(data^, p^, l2);
      iptr := l2;
    end
    else
      Inc(iptr, Result);

    Dec(ilen, Result);
  end;
end;

procedure TRollBuffer.SaveState(var aState: Longint);
begin
  with head^ do
    aState := MakeLong(iptr, ilen);
end;

procedure TRollBuffer.RestoreState(aState: Longint);
begin
  with head^ do
  begin
    iptr := LoWord(aState);
    ilen := HiWord(aState);
  end;
end;

function TRollBuffer.InternalWrite(const aBuf; len: integer): integer;
var
  l1, l2: Word;
  p: PByte;
  optr: Word;
begin
  with head^ do
  begin
    Result := len;
    l1 := Result;
    l2 := 0;
    optr := iptr + ilen;

    if (optr >= size) then
      Dec(optr, size);

    if (optr + Result) >= size then
    begin
      l2 := (optr + Result) - size;
      Dec(l1, l2);
    end;

    Move(aBuf, FData^.data[optr], l1);

    if l2 > 0 then
    begin
      p := @aBuf;
      Inc(p, l1);
      Move(p^, data^, l2);
    end;

    Inc(ilen, Result);
  end;
end;

function TRollBuffer.Write(const aBuf; len: integer): integer;
var
  szw: Word;
begin
  Result := 0;
  if (len <= 0) or (len > Capacity) or (msgCount >= RollMaxMessages) then
    Exit;

  Lock;
  with head^ do
    try
      if msgMode then
      begin
        szw := len;
        InternalWrite(szw, sizeof(szw));
        Inc(msgCount);
      end;

      Result := InternalWrite(aBuf, len);

      NotifyReader;

    finally
      Unlock;
    end;
end;

function TRollBuffer.Available: integer;
begin
  Result := head^.ilen
end;

function TRollBuffer.msgCount: integer;
begin
  Result := head^.msgCount;
end;

function TRollBuffer.Empty: Boolean;
begin
  Result := Available <= 0;
end;

function TRollBuffer.Read(var aBuf; len: integer): integer;
var
  szw: Word;
  sts: Longint;
begin
  Result := 0;
  if Empty or (len <= 0) then
    Exit;

  Lock;
  with head^ do
    try
      if msgMode then
      begin
        SaveState(sts);
        InternalRead(szw, sizeof(szw));
        if (len < szw) then
        begin
          RestoreState(sts);
          Exit;
        end;

        len := szw;
        Dec(msgCount);
      end;

      Result := InternalRead(aBuf, len);

      NotifyReader;
    finally
      Unlock;
    end;
end;

function TRollBuffer.Overflow: Boolean;
begin
  with head^ do
    Result := (msgCount > RollMaxMessages) or (ilen >= size);
end;

end.
