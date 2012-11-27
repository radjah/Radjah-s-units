unit unChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, ExtCtrls, TeeProcs, Chart, Series;

type
  TfmChart = class(TForm)
    chPreview: TChart;
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
