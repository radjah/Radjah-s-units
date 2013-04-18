unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj, StdCtrls, ExtCtrls, wordaddons;

type
  TfmMain = class(TForm)
    gbBlock: TGroupBox;
    gbSensor: TGroupBox;
    leSensor: TLabeledEdit;
    leBlock: TLabeledEdit;
    btMakeBlock: TButton;
    btMakeSensor: TButton;
    procedure btMakeBlockClick(Sender: TObject);
    procedure btMakeSensorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

{ === Создание бирок для блока === }
procedure TfmMain.btMakeBlockClick(Sender: TObject);
var
  i: integer; // счетчик
  num: integer; // текущий номер
  WordApp, Doc: variant; // Объект Word
begin
  try
    // Создание объекта Word
    WordApp := CreateOleObject('Word.Application');
    WordApp.Visible := False;
    WordApp.Documents.Add(ExtractFilePath(Application.ExeName) +
      '\blocktpl.doc');
    // Получение первого номер
    num := StrToInt(leBlock.Text);
    for i := num to num + 45 do
    // Замена шаблонов на реальные номера
    begin
      Doc := WordApp.ActiveDocument.Content;
      Doc.Find.ClearFormatting;
      Doc.Find.Execute(FindText := '#@' + IntToStr(i - num + 1) + '@#',
        ReplaceWith := IntToStr(i), Replace:= wdReplaceAll);
    end;
    WordApp.Visible := True;
  // Обработка ошибок
  except
    on E: EOleError do
    begin
      MessageBox(Self.Handle, pchar(E.Message), 'Ошибка!',
        MB_OK or MB_ICONERROR);
      WordApp.Quit;
    end;
    on E: EConvertError do
    begin
      MessageBox(Self.Handle, pchar(E.Message), 'Ошибка!',
        MB_OK or MB_ICONERROR);
      WordApp.Quit;
    end;
  end;
end;

procedure TfmMain.btMakeSensorClick(Sender: TObject);
var
  i: integer; // счетчик
  num: integer; // текущий номер
  WordApp, Doc: variant; // Объект Word
begin
  try
    // Создание объекта Word
    WordApp := CreateOleObject('Word.Application');
    WordApp.Visible := False;
    WordApp.Documents.Add(ExtractFilePath(Application.ExeName) +
      '\sensortpl.doc');
    // Получение первого номер
    num := StrToInt(leSensor.Text);
    for i := num to num + 60 do
    // Замена шаблонов на реальные номера
    begin
      Doc := WordApp.ActiveDocument.Content;
      Doc.Find.ClearFormatting;
      Doc.Find.Execute(FindText := '#@' + IntToStr(i - num + 1) + '@#',
        ReplaceWith := IntToStr(i), Replace:= wdReplaceAll);
    end;
    WordApp.Visible := True;
  // Обработка ошибок
  except
    on E: EOleError do
    begin
      MessageBox(Self.Handle, pchar(E.Message), 'Ошибка!',
        MB_OK or MB_ICONERROR);
      WordApp.Quit;
    end;
    on E: EConvertError do
    begin
      MessageBox(Self.Handle, pchar(E.Message), 'Ошибка!',
        MB_OK or MB_ICONERROR);
      WordApp.Quit;
    end;
  end;

end;

end.
