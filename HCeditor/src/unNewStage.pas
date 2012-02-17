unit unNewStage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfmNewStage = class(TForm)
    sbPos: TScrollBox;
    eMaxPos: TEdit;
    udMaxPos: TUpDown;
    Label1: TLabel;
    btMaxPosSet: TButton;
    btCreate: TButton;
    LabeledEdit1: TLabeledEdit;
    procedure btMaxPosSetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    EditArr: array of TEdit;
    LabelArr: array of TLabel;
    UDArr: array of TUpDown;
  end;

var
  fmNewStage: TfmNewStage;

implementation

{$R *.dfm}

// Создание счетчиков в скроллбоксе
procedure TfmNewStage.btMaxPosSetClick(Sender: TObject);
var
  i: integer; // Счетчик
begin
  // Удаление старых
  if length(LabelArr) > 0 then
    for i := length(LabelArr)-1 downto 0 do
    begin
      UDArr[i].Free;
      EditArr[i].Free;
      LabelArr[i].Free;
    end;
  SetLength(EditArr, 0);
  SetLength(LabelArr, 0);
  SetLength(UDArr, 0);
  // Указываем длины массивов
  SetLength(EditArr, udMaxPos.Position + 1);
  ZeroMemory(EditArr, sizeof(EditArr));
  SetLength(LabelArr, udMaxPos.Position + 1);
  ZeroMemory(LabelArr, sizeof(LabelArr));
  SetLength(UDArr, udMaxPos.Position + 1);
  ZeroMemory(UDArr, sizeof(UDArr));
  // Создаем контроллы и размещаем на форме
  for i := 0 to udMaxPos.Position do
  begin
    // Создаем метку
    LabelArr[i] := TLabel.Create(sbPos);
    LabelArr[i].Caption := 'ПК=' + IntToStr(i);
    LabelArr[i].Left := 20;
    LabelArr[i].Top := 20 + 30 * i;
    LabelArr[i].Name := 'Label' + IntToStr(i);
    LabelArr[i].Parent := sbPos;
    // СОздаем Edit
    EditArr[i] := TEdit.Create(sbPos);
    EditArr[i].Text := '1';
    EditArr[i].Left := 60;
    EditArr[i].Top := 15 + 30 * i;
    EditArr[i].Width := 50;
    EditArr[i].Parent := sbPos;
    // Создаем счетчик
    UDArr[i] := TUpDown.Create(sbPos);
    UDArr[i].Min := 1;
    UDArr[i].Max := 1000;
    UDArr[i].Position := 1;
    UDArr[i].Parent := sbPos;
    UDArr[i].Associate := EditArr[i];
  end;

end;

end.
