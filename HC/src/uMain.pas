unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls, StdCtrls;

type
  TMain = class(TForm)
    Label1: TLabel;
    lPosition: TLabel;
    Label3: TLabel;
    lNextPosition: TLabel;
    Label5: TLabel;
    lTime: TLabel;
    pbTime: TProgressBar;
    Chart: TChart;
    Series1: TBarSeries;
    btGo: TButton;
    StageTimer: TTimer;
    btEditor: TButton;
    btLoad: TButton;
    procedure StageTimerTimer(Sender: TObject);
    procedure btGoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;
  CurTime: integer = 0;

implementation

{$R *.dfm}

procedure TMain.btGoClick(Sender: TObject);
begin
  if StageTimer.Enabled = False then
    StageTimer.Enabled := true
  else
    StageTimer.Enabled := False;
end;

procedure TMain.StageTimerTimer(Sender: TObject);
begin
  CurTime := CurTime + 1;
  lPosition.Caption := IntToStr(CurTime);
  lNextPosition.Caption := IntToStr(CurTime+1);
  lTime.Caption := IntToStr(CurTime);
end;

end.
