unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractTable, ZDataset, ZAbstractConnection, ZConnection, StdCtrls,
  ZSqlUpdate;

type
  TfmMain = class(TForm)
    ZConnect: TZConnection;
    ztCycle: TZTable;
    dsCycle: TDataSource;
    dbgCycle: TDBGrid;
    btCreat: TButton;
    btEdit: TButton;
    btStageEditor: TButton;
    zqCommon: TZQuery;
    btDelete: TButton;
    zuCycle: TZUpdateSQL;
    zqCreateDB: TZQuery;
    procedure btStageEditorClick(Sender: TObject);
    procedure btCreatClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses unStageEditor, unCommonFunc;
{$R *.dfm}

// Отобразить окно редактора циклов
procedure TfmMain.btCreatClick(Sender: TObject);
var
  newname: string[128];
begin
  newname := InputBox('Создание нового цикла', 'Введите название цикла', '');
  if Length(newname) > 0 then
    ztCycle.AppendRecord([NULL, newname]);

end;

procedure TfmMain.btDeleteClick(Sender: TObject);
var
  str: string;
begin
  str := 'Удалить цикл "' + ztCycle.FieldByName('cname').AsWideString +
    '" и все его этапы?';
  if MessageBox(self.Handle, Pchar(str), 'Запрос', MB_YESNO OR MB_ICONQUESTION)
    = IDYES then
  begin
    zqCommon.Close;
    zqCommon.SQL.Clear;
    zqCommon.SQL.Add('Delete from cycle where cid=' + ztCycle.FieldByName('cid')
      .AsString);
    zqCommon.ExecSQL;
    ReopenDS([ztCycle]);
  end;
end;
{
  procedure TfmMain.btDeleteClick(Sender: TObject);
  var
  str: String;
  begin
  str := concat('Удалить цикл "', ztCycle.FieldByName('cname').AsString,
  '" и все его этапы?', #00);
  if MessageDlg(str, mtConfirmation, [mbYes, mbNo], 0,
  mbYes) = mrYes then
  ShowMessage('Ня!');
  end; }

procedure TfmMain.btStageEditorClick(Sender: TObject);
begin
  fmStageEditor.ShowModal;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  dbfile: TFileName;
begin
  dbfile:=ExtractFilePath(Application.ExeName)+'stages.sqlite';
{  if NOT (FileExists(dbfile)) then
  begin
    ZConnect.Database:=dbfile;
    zqCreateDB.ExecSQL;
    ZConnect.Connect;
//    zqCreateDB.ExecSQL;
    ztCycle.Open;
  end else
  begin
    ZConnect.Connect;
    ztCycle.Open;
  end;}
  ZConnect.Database:=dbfile;
  ZConnect.Connect;
  ztCycle.Open;
end;

end.
