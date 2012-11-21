unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, sBitBtn, jpeg, ExtCtrls;

type
  TfmAbout = class(TForm)
    imgA: TImage;
    Label1: TLabel;
    btClose: TsBitBtn;
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbout: TfmAbout;

implementation

{$R *.dfm}

procedure TfmAbout.btCloseClick(Sender: TObject);
begin
  Close;
end;

end.
