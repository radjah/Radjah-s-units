unit unChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TfmChart = class(TForm)
    chMass: TChart;
    sMess: TLineSeries;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmChart: TfmChart;

implementation

{$R *.dfm}

end.
