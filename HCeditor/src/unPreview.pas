unit unPreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TfmPreview = class(TForm)
    chPreview: TChart;
    Series1: TLineSeries;
    Button1: TButton;
    GroupBox1: TGroupBox;
    lbTotalTime: TLabel;
    lbSwitchCount: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPreview: TfmPreview;

implementation

uses
  unMain;

{$R *.dfm}

procedure TfmPreview.Button1Click(Sender: TObject);
begin
  fmMain.ExportToHCF;
end;

end.
