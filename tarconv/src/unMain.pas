unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, shlobj, ExtCtrls;

type
  TfmMain = class(TForm)
    odXLSFile: TOpenDialog;
    btConver: TButton;
    leFolder: TLabeledEdit;
    Label1: TLabel;
    lePrefix: TLabeledEdit;
    leTarFile: TLabeledEdit;
    btTarFile: TButton;
    Label2: TLabel;
    btAdvSettings: TButton;
    Label3: TLabel;
    btConvert: TButton;
    procedure btConverClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.btConverClick(Sender: TObject);
var
  Dir: array [0 .. MAX_PATH] of char;
  BrInfo: BROWSEINFO;
  lpItemID: PItemIDList;
begin
  // Настраиваем отображения диалога выбора папки
  ZeroMemory(@BrInfo, sizeof(BrInfo));
  BrInfo.hwndOwner := Self.Handle;
  BrInfo.lpszTitle :=
    'Выберите папку, в которую будут записаны файлы настроек:';
  BrInfo.ulFlags := BIF_EDITBOX or BIF_RETURNONLYFSDIRS or
    BIF_RETURNFSANCESTORS;
  // Показать диалог выбора папки
  lpItemID := SHBrowseForFolder(BrInfo);
  // Если папка была выбрана, то начинаем обработку
  if lpItemID <> nil then
  begin
    SHGetPathFromIDList(lpItemID, Dir);
    GlobalFreePtr(lpItemID);
    // Материмся, если юзер выбрал системную папку
    if Dir = '' then
      ShowMessage('В выбранноую папку нельзя сохранять файлы!') else
    leFolder.Text:=Dir;
  end;
end;

end.
