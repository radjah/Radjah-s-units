unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, synaser;

type
  TfmMain = class(TForm)
    mPorts: TMemo;
    btGetPorts: TButton;
    cbPortSelect: TComboBox;
    btOpen: TButton;
    btClose: TButton;
    mMeasure: TMemo;
    procedure btGetPortsClick(Sender: TObject);
    procedure btOpenClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;
  blserial:TBlockSerial;

implementation

Uses
  PortUnit;

{$R *.dfm}

procedure TfmMain.btGetPortsClick(Sender: TObject);
var
  comprts:TStringList;
  comstr:String;
begin
  comprts:=TStringList.Create;
//  comstr:=GetSerialPortNames;
  comprts.CommaText:=GetSerialPortNames;
  comprts.Sort;
  cbPortSelect.Items:=comprts;
  cbPortSelect.ItemIndex:=0;
//  Memo1.Lines.Add(GetSerialPortNames);
  mPorts.Lines:=comprts;
  if comprts.Count>0
  then
    btOpen.Enabled:=True;
    btClose.Enabled:=False;
end;

procedure TfmMain.btOpenClick(Sender: TObject);
begin
//  blserial:=TBlockSerial.Create;
//  blserial.Config(9600,8,'N',TWOSTOPBITS,false,false);
//  blserial.Connect(ComboBox1.Text);
  if PortInit(PChar(cbPortSelect.Text))
  then
  begin
    btOpen.Enabled:=False;
    btClose.Enabled:=True;
  end;
end;

procedure TfmMain.btCloseClick(Sender: TObject);
begin
  KillComm;
  btOpen.Enabled:=True;
  btClose.Enabled:=False;
end;

end.
