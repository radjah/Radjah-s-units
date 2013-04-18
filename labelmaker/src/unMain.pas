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

{ === �������� ����� ��� ����� === }
procedure TfmMain.btMakeBlockClick(Sender: TObject);
var
  i: integer; // �������
  num: integer; // ������� �����
  WordApp, Doc: variant; // ������ Word
begin
  try
    // �������� ������� Word
    WordApp := CreateOleObject('Word.Application');
    WordApp.Visible := False;
    WordApp.Documents.Add(ExtractFilePath(Application.ExeName) +
      '\blocktpl.doc');
    // ��������� ������� �����
    num := StrToInt(leBlock.Text);
    for i := num to num + 45 do
    // ������ �������� �� �������� ������
    begin
      Doc := WordApp.ActiveDocument.Content;
      Doc.Find.ClearFormatting;
      Doc.Find.Execute(FindText := '#@' + IntToStr(i - num + 1) + '@#',
        ReplaceWith := IntToStr(i), Replace:= wdReplaceAll);
    end;
    WordApp.Visible := True;
  // ��������� ������
  except
    on E: EOleError do
    begin
      MessageBox(Self.Handle, pchar(E.Message), '������!',
        MB_OK or MB_ICONERROR);
      WordApp.Quit;
    end;
    on E: EConvertError do
    begin
      MessageBox(Self.Handle, pchar(E.Message), '������!',
        MB_OK or MB_ICONERROR);
      WordApp.Quit;
    end;
  end;
end;

procedure TfmMain.btMakeSensorClick(Sender: TObject);
var
  i: integer; // �������
  num: integer; // ������� �����
  WordApp, Doc: variant; // ������ Word
begin
  try
    // �������� ������� Word
    WordApp := CreateOleObject('Word.Application');
    WordApp.Visible := False;
    WordApp.Documents.Add(ExtractFilePath(Application.ExeName) +
      '\sensortpl.doc');
    // ��������� ������� �����
    num := StrToInt(leSensor.Text);
    for i := num to num + 60 do
    // ������ �������� �� �������� ������
    begin
      Doc := WordApp.ActiveDocument.Content;
      Doc.Find.ClearFormatting;
      Doc.Find.Execute(FindText := '#@' + IntToStr(i - num + 1) + '@#',
        ReplaceWith := IntToStr(i), Replace:= wdReplaceAll);
    end;
    WordApp.Visible := True;
  // ��������� ������
  except
    on E: EOleError do
    begin
      MessageBox(Self.Handle, pchar(E.Message), '������!',
        MB_OK or MB_ICONERROR);
      WordApp.Quit;
    end;
    on E: EConvertError do
    begin
      MessageBox(Self.Handle, pchar(E.Message), '������!',
        MB_OK or MB_ICONERROR);
      WordApp.Quit;
    end;
  end;

end;

end.
