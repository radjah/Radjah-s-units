unit unName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, hh;

type
  TfmName = class(TForm)
    btOK: TButton;
    btCancel: TButton;
    btHelp: TButton;
    gbString: TGroupBox;
    edName: TEdit;
    procedure btCancelClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmName: TfmName;

implementation

uses unCommonFunc;

{$R *.dfm}

procedure TfmName.btCancelClick(Sender: TObject);
begin
  ResultBool:=False;
  Close;
end;

procedure TfmName.btOKClick(Sender: TObject);
begin
  ResultName:=edName.Text;
  ResultBool:=True;
  Close;
end;

procedure TfmName.btHelpClick(Sender: TObject);
begin
  HtmlHelp(Self.Handle,'help\help.chm::/unName.dfm.html',HH_DISPLAY_TOPIC,0);
end;

end.
