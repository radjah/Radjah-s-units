unit unRename;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GIFImg;

type
  TfmRename = class(TForm)
    Image1: TImage;
    btRename: TButton;
    gbFull: TGroupBox;
    leFullA: TLabeledEdit;
    leFullB: TLabeledEdit;
    leFullC: TLabeledEdit;
    gbShort: TGroupBox;
    leShortA: TLabeledEdit;
    leShortB: TLabeledEdit;
    leShortC: TLabeledEdit;
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
  ShortC := trim(leShortC.Text);
  FullA := trim(leFullA.Text);
  FullB := trim(leFullB.Text);
  FullC := trim(leFullC.Text);
  fmMain.MakeVarLabels;
  Close;
end;

{ === Получение текущих значений === }
procedure TfmRename.FormShow(Sender: TObject);
begin
  leShortA.Text := ShortA;
  leShortB.Text := ShortB;
  leShortC.Text := ShortC;
  leFullA.Text :=FullA;
  leFullB.Text :=FullB;
  leFullC.Text :=FullC;
end;

end.
