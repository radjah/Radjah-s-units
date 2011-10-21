unit unRename;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GIFImg;

type
  TfmRename = class(TForm)
    btRename: TButton;
    gbFull: TGroupBox;
    leFullA: TLabeledEdit;
    leFullB: TLabeledEdit;
    gbShort: TGroupBox;
    leShortA: TLabeledEdit;
    leShortB: TLabeledEdit;
    Label1: TLabel;
    procedure btRenameClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRename: TfmRename;

implementation

uses
  unMain, MyFunctions;

{$R *.dfm}

{ === Задание названий === }
procedure TfmRename.btRenameClick(Sender: TObject);
begin
  ShortA := trim(leShortA.Text);
  ShortB := trim(leShortB.Text);
  FullA := trim(leFullA.Text);
  FullB := trim(leFullB.Text);
  fmMain.MakeVarLabels;
  Close;
end;

{ === Получение текущих значений === }
procedure TfmRename.FormShow(Sender: TObject);
begin
  leShortA.Text := ShortA;
  leShortB.Text := ShortB;
  leFullA.Text :=FullA;
  leFullB.Text :=FullB;
end;

end.
