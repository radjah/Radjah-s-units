/// ///////////////////////////////////////////////////////////////////////////
//
// $HDR$
// Last Edited By: $Author:pol$
// Last Edit Time: $Date:26/05/11 14:52:41$
//
/// ////////////////////////////// ChangeLog: /////////////////////////////////
//
// Legend:
// + = Feature added
// * = Feature modified/improved
// - = Problem resolved
// ! = Note
//
// $Log:  124431: RollIntf.pas
//
// Rev 1.0    26/05/11 14:52:40  pol
//
// Rev 1.0    22.01.09 16:54:16  ms
/// ///////////////////////////////////////////////////////////////////////////
//
unit RollIntf;

interface

uses
  Windows, Classes, Messages, RollBuf;

type
  TRollIntf = class(TRollBuffer)
  public
    constructor Create(Mode: TRollAccsess);
    function Get(var Msg; Len: Integer): Integer;
    function Put(const Msg; Len: Integer): Integer;
  end;

  TIntfReader = class(TRollIntf)
  private
    FWnd: HWND;
    FOnNotify: TNotifyEvent;
    procedure WndProc(var Message: TMessage);
  public
    constructor Create(OnNotify: TNotifyEvent);
    destructor Destroy; override;
  end;

  TIntfWriter = class(TRollIntf)
  public
    constructor Create;
  end;

implementation

const
  IntfBufSize = 4096;

constructor TRollIntf.Create(Mode: TRollAccsess);
begin
  inherited Create('RollIntfBuffer', IntfBufSize, [Mode], True);
end;

function TRollIntf.Get(var Msg; Len: Integer): Integer;
begin
  Result := Read(Msg, Len);
end;

function TRollIntf.Put(const Msg; Len: Integer): Integer;
begin
  if Readers <= 0 then
  begin
    Result := 0;
    Exit;
  end;
  Result := Write(Msg, Len);
  if Result <= 0 then
  begin
    Clear;
    Result := Write(Msg, Len);
  end;
end;

constructor TIntfReader.Create(OnNotify: TNotifyEvent);
begin
  inherited Create(raReader);
  if Readers > 1 then
    RollError('Many readers to Roll Interface.');
  FWnd := AllocateHWnd(WndProc);
  FOnNotify := OnNotify;
  WindowNotify := FWnd;
end;

destructor TIntfReader.Destroy;
begin
  if WindowNotify = FWnd then
    WindowNotify := 0;
  if FWnd <> 0 then
    DeallocateHWnd(FWnd);
  inherited Destroy;
end;

procedure TIntfReader.WndProc(var Message: TMessage);
begin
  with Message do
    case Msg of
      WM_ROLLNOTIFY:
        if Assigned(FOnNotify) then
          FOnNotify(Self);
    else
      Result := DefWindowProc(FWnd, Msg, wParam, lParam);
    end;
end;

constructor TIntfWriter.Create;
begin
  inherited Create(raWriter);
end;

end.
