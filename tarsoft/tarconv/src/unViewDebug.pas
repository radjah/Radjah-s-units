unit unViewDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmViewDebug = class(TForm)
    mFirst: TMemo;
    mSecond: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmViewDebug: TfmViewDebug;

implementation

{$R *.dfm}

end.
