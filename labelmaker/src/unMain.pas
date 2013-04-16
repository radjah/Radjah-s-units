unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj, StdCtrls, ExtCtrls;

type
  TfmMain = class(TForm)
    sdDoc: TSaveDialog;
    gbBlock: TGroupBox;
    gbSensor: TGroupBox;
    leSensor: TLabeledEdit;
    leBlock: TLabeledEdit;
    btMakeBlock: TButton;
    btMakeSensor: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

end.
