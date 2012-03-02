unit unNewDig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, hh;

type
  TfmNewDig = class(TForm)
    gbDig: TGroupBox;
    cbDig: TComboBox;
    btOK: TButton;
    btCancel: TButton;
    btHelp: TButton;
    procedure btCancelClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmNewDig: TfmNewDig;

implementation

uses unCommonFunc;

{$R *.dfm}

procedure TfmNewDig.btCancelClick(Sender: TObject);
begin
  ResultBool:=False;
  Close;
end;

procedure TfmNewDig.btOKClick(Sender: TObject);
begin
  try
    NewDig:=strtoint(cbDig.Text);
    ResultBool:=True;
    Close;
  except
    on E:EConvertError do ShowMessage('¬ведено не число или не целое.');
  end;
end;

procedure TfmNewDig.btHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unNewDig.dfm.html',HH_DISPLAY_TOPIC,0);
end;

end.
