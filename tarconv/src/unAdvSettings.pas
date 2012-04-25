unit unAdvSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, StdCtrls, ExtCtrls;

type
  TbtAdvSettings = class(TForm)
    gb1Sensor: TGroupBox;
    gb2Sensor: TGroupBox;
    gbTSensor: TGroupBox;
    gbFuel: TGroupBox;
    btSave: TButton;
    lePoinsCount: TLabeledEdit;
    Label1: TLabel;
    udPointsCount: TUpDown;
    Button1: TButton;
    sgFuel: TStringGrid;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  btAdvSettings: TbtAdvSettings;

implementation

{$R *.dfm}

// Настройка тарировочной таблицы бака
procedure TbtAdvSettings.Button1Click(Sender: TObject);
begin
  sgFuel.RowCount := udPointsCount.Position + 1;
end;

end.
